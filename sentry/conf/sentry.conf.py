from sentry.conf.server import *

import os
import os.path

CONF_ROOT = os.path.dirname(__file__)

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'sentry',
        'USER': os.environ.get('MYSQL_USER', 'root'),
        'PASSWORD': os.environ.get('MYSQL_PASSWORD', ''),
        'HOST': os.environ.get('MYSQL_HOST', ''),
        'PORT': os.environ.get('MYSQL_PORT', ''),
    }
}

SENTRY_USE_BIG_INTS = True

###########
## Redis ##
###########
SENTRY_REDIS_OPTIONS = {
    'hosts': {
        0: {
            'host': os.environ.get('REDIS_HOST', '127.0.0.1'),
            'port': os.environ.get('REDIS_PORT', '6379'),
            'db': '0',
        }
    }
}

###########
## Cache ##
###########
SENTRY_CACHE = 'sentry.cache.redis.RedisCache'
CACHES = {
    'default': {
        'BACKEND': 'redis_cache.RedisCache',
        'LOCATION': '{}:{}'.format(os.environ.get('CACHE_HOST', '127.0.0.1'), os.environ.get('CACHE_PORT', '6379')),
        'OPTIONS': {
            'DB': '1',
            'PARSER_CLASS': 'redis.connection.HiredisParser',
        },
    },
}

###########
## Queue ##
###########
CELERY_ALWAYS_EAGER = False
BROKER_URL = 'redis://{}:{}/{}'.format(
    os.environ.get('BROKER_REDIS_HOST', '127.0.0.1'),
    os.environ.get('BROKER_REDIS_PORT', '6379'),
    os.environ.get('BROKER_REDIS_DB', '10'))

#################
## Rate Limits ##
#################
SENTRY_RATELIMITER = 'sentry.ratelimits.redis.RedisRateLimiter'

####################
## Update Buffers ##
####################
SENTRY_BUFFER = 'sentry.buffer.redis.RedisBuffer'

############
## Quotas ##
############
SENTRY_QUOTAS = 'sentry.quotas.redis.RedisQuota'

##########
## TSDB ##
##########
SENTRY_TSDB = 'sentry.tsdb.redis.RedisTSDB'

##################
## File storage ##
##################
SENTRY_FILESTORE = 'django.core.files.storage.FileSystemStorage'
SENTRY_FILESTORE_OPTIONS = {
    'location': '/tmp/sentry-files',
}

################
## Web Server ##
################
ALLOWED_HOSTS = [os.environ.get('ALLOWED_HOST', '127.0.0.1')]
SENTRY_URL_PREFIX = os.environ.get('SENTRY_URL_PREFIX', '127.0.0.1:9000')

if os.environ.get('SENTRY_IS_SECURE'):
    SECURE_PROXY_SSL_HEADER = ('HTTP_X_FORWARDED_PROTO', 'https')

SENTRY_WEB_HOST = os.environ.get('SENTRY_WEB_HOST', '0.0.0.0')
SENTRY_WEB_PORT = os.environ.get('SENTRY_WEB_PORT', 9000)
SENTRY_WEB_OPTIONS = {
}
if os.environ.get('SENTRY_WEB_WORKDERS'):
    SENTRY_WEB_OPTIONS.update({
        'workers': os.environ.get('SENTRY_WEB_WORKERS'),
    })
if os.environ.get('SENTRY_IS_SECURE'):
    SENTRY_WEB_OPTIONS.update({
        'secure_scheme_headers': {'X-FORWARDED-PROTO': 'https'},
    })

###########
## etc. ##
###########

# If this file ever becomes compromised, it's important to regenerate your SECRET_KEY
# Changing this value will result in all current sessions being invalidated
SECRET_KEY = '2rP+p0tduaoX5Doshg5jXgOXXk7KdXZzFDpRzDqgg8rhNAkrATyYZw=='

# http://code.google.com/apis/accounts/docs/OAuth2.html#Registering
GOOGLE_OAUTH2_CLIENT_ID = os.environ.get('GOOGLE_OATUH2_CLIENT_ID', '')
GOOGLE_OAUTH2_CLIENT_SECRET = os.environ.get('GOOGLE_OAUTH2_CLIENT_SECRET', '')
