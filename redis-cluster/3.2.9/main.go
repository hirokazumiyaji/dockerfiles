package main

import (
	"errors"
	"fmt"
	"os"
	"os/exec"
	"os/signal"
	"strconv"
	"strings"
	"sync"
	"syscall"
	"time"
)

type Node struct {
	Id          string
	HostAndPort string
	Flag        string
	Master      string
	PingSent    string
	PongRecv    string
	ConfigEpoch string
	LinkState   string
	Slot        string
}

func parseNode(s string) (*Node, error) {
	e := strings.Split(s, " ")
	if len(e) < 9 {
		return nil, errors.New("node parse error")
	}
	return &Node{
		Id:          e[0],
		HostAndPort: e[1],
		Flag:        e[2],
		Master:      e[3],
		PingSent:    e[4],
		PongRecv:    e[5],
		ConfigEpoch: e[6],
		LinkState:   e[7],
		Slot:        strings.Join(e[8:], " "),
	}, nil
}

func shutdown(cmds []*exec.Cmd) {
	var wg sync.WaitGroup
	for _, cmd := range cmds {
		wg.Add(1)
		go func(cmd *exec.Cmd) {
			cmd.Process.Kill()
			cmd.Wait()
			wg.Done()
		}(cmd)
	}
	wg.Wait()
}

func clusterSlot(info map[int][]int) error {
	for p, sr := range info {
		for s := sr[0]; s <= sr[1]; s++ {
			cmd := exec.Command("redis-cli", "-p", strconv.Itoa(p), "CLUSTER", "ADDSLOTS", strconv.Itoa(s))
			if err := cmd.Start(); err != nil {
				fmt.Println(err)
				return err
			}
			cmd.Wait()
		}
	}
	return nil
}

func parse(hostAndPort string) (string, string) {
	p := strings.Split(hostAndPort, ":")
	return p[0], p[1]
}

func clusterMeet(server1Host string, server1Port int, server2Host string, server2Port int) error {
	cmd := exec.Command("redis-cli", "-h", server1Host, "-p", strconv.Itoa(server1Port), "CLUSTER", "MEET", server2Host, strconv.Itoa(server2Port))
	err := cmd.Start()
	if err != nil {
		return err
	}
	cmd.Wait()
	return nil
}

func clusterNodes(host string, port int) ([]*Node, error) {
	nodes := make([]*Node, 0)
	cmd := exec.Command("redis-cli", "-h", host, "-p", strconv.Itoa(port), "CLUSTER", "NODES")
	output, err := cmd.CombinedOutput()
	if err != nil {
		return nodes, err
	}
	for _, line := range strings.Split(string(output), "\n") {
		n, err := parseNode(line)
		if err == nil {
			nodes = append(nodes, n)
		}
	}
	return nodes, nil
}

func clusterReplicate(masterHost string, masterPort int, slaveHost string, slavePort int) error {
	masterHostAndPort := fmt.Sprintf("%s:%d", masterHost, masterPort)
	var node *Node
	for i := 0; i < 5; i++ {
		ns, err := clusterNodes(slaveHost, slavePort)
		if err != nil {
			return err
		}
		for _, n := range ns {
			if n.HostAndPort == masterHostAndPort {
				node = n
			}
		}
		if node != nil {
			break
		}
		time.Sleep(5 * time.Second)
	}
	if node == nil {
		return errors.New("target node not found.")
	}

	cmd := exec.Command("redis-cli", "-h", slaveHost, "-p", strconv.Itoa(slavePort), "CLUSTER", "REPLICATE", node.Id)
	if err := cmd.Start(); err != nil {
		return err
	}
	cmd.Wait()
	return nil
}

func main() {
	fmt.Println("start redis cluster.")
	const (
		startPort = 7000
		endPort   = 7006
	)
	clusterInfo := map[int][]int{
		7000: []int{0, 5461},
		7001: []int{5462, 10922},
		7002: []int{10923, 16383},
	}
	fmt.Println("  start exec redis process.")
	cmds := make([]*exec.Cmd, 0, 6)
	for port := startPort; port < endPort; port++ {
		cmd := exec.Command("redis-server", fmt.Sprintf("/data/%d/redis.conf", port))
		if err := cmd.Start(); err != nil {
			fmt.Println(err)
			shutdown(cmds)
			return
		}
		cmds = append(cmds, cmd)
	}
	fmt.Println("  end exec redis process.")

	// wait process
	time.Sleep(5 * time.Second)

	fmt.Println("  start cluster add slots.")
	if err := clusterSlot(clusterInfo); err != nil {
		fmt.Println(err)
		shutdown(cmds)
	}
	fmt.Println("  end cluster add slots.")

	fmt.Println("  start cluster meet.")
	for port := startPort + 1; port <= endPort; port++ {
		if err := clusterMeet("127.0.0.1", 7000, "127.0.0.1", port); err != nil {
			fmt.Println(err)
			shutdown(cmds)
			return
		}
	}
	fmt.Println("  end cluster meet.")

	time.Sleep(5 * time.Second)

	fmt.Println("  start cluster replicate.")
	if err := clusterReplicate("127.0.0.1", 7000, "127.0.0.1", 7003); err != nil {
		fmt.Println(err)
		shutdown(cmds)
		return
	}

	if err := clusterReplicate("127.0.0.1", 7001, "127.0.0.1", 7004); err != nil {
		fmt.Println(err)
		shutdown(cmds)
		return
	}

	if err := clusterReplicate("127.0.0.1", 7002, "127.0.0.1", 7005); err != nil {
		fmt.Println(err)
		shutdown(cmds)
		return
	}
	fmt.Println("  end cluster replicate.")

	sc := make(chan os.Signal, 1)
	signal.Notify(
		sc,
		syscall.SIGHUP,
		syscall.SIGINT,
		syscall.SIGTERM,
		syscall.SIGQUIT,
	)

	loop(sc)

	fmt.Println(" shutdown start")
	shutdown(cmds)

	fmt.Println("shudown redis cluster.")
}

func loop(sc chan os.Signal) {
	for {
		select {
		case _ = <-sc:
			return
		}
	}
}
