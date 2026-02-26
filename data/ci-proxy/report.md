# ci-proxy CWL Generation Report

## ci-proxy

### Tool Description
Gunicorn 'Green Unicorn' is a Python WSGI HTTP Server for UNIX. Gunicorn is a pre-fork worker model. Gunicorn is typically run like this:

### Metadata
- **Docker Image**: biocontainers/ci-proxy:latest
- **Homepage**: https://github.com/cirosantilli/china-dictatorship
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ci-proxy/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/cirosantilli/china-dictatorship
- **Stars**: N/A
### Original Help Text
```text
usage: gunicorn [OPTIONS] [APP_MODULE]

optional arguments:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  --reload              Restart workers when code changes. [False]
  --error-logfile FILE, --log-file FILE
                        The Error log file to write to. [-]
  --log-syslog-prefix SYSLOG_PREFIX
                        Makes Gunicorn use the parameter as program-name in
                        the syslog entries. [None]
  -g GROUP, --group GROUP
                        Switch worker process to run as this group. [1000]
  --paste STRING, --paster STRING
                        Load a PasteDeploy config file. The argument may
                        contain a ``#`` [None]
  --certfile FILE       SSL certificate file [None]
  --spew                Install a trace function that spews every line
                        executed by the server. [False]
  --worker-tmp-dir DIR  A directory to use for the worker heartbeat temporary
                        file. [None]
  --log-syslog          Send *Gunicorn* logs to syslog. [False]
  --ca-certs FILE       CA certificates file [None]
  -e ENV, --env ENV     Set environment variables in the execution
                        environment. [[]]
  --limit-request-field_size INT
                        Limit the allowed size of an HTTP request header
                        field. [8190]
  --access-logformat STRING
                        The access log format. [%(h)s %(l)s %(u)s %(t)s
                        "%(r)s" %(s)s %(b)s "%(f)s" "%(a)s"]
  --max-requests INT    The maximum number of requests a worker will process
                        before restarting. [0]
  --log-level LEVEL     The granularity of Error log outputs. [info]
  --ssl-version SSL_VERSION
                        SSL version to use. [_SSLMethod.PROTOCOL_TLS]
  --log-syslog-facility SYSLOG_FACILITY
                        Syslog facility name [user]
  --keyfile FILE        SSL key file [None]
  --check-config        Check the configuration and exit. The exit status is 0
                        if the [False]
  --print-config        Print the configuration settings as fully resolved.
                        Implies :ref:`check-config`. [False]
  --dogstatsd-tags DOGSTATSD_TAGS
                        A comma-delimited list of datadog statsd (dogstatsd)
                        tags to append to []
  --limit-request-line INT
                        The maximum size of HTTP request line in bytes. [4094]
  --do-handshake-on-connect
                        Whether to perform SSL handshake on socket connect
                        (see stdlib ssl module's) [False]
  -w INT, --workers INT
                        The number of worker processes for handling requests.
                        [1]
  --statsd-prefix STATSD_PREFIX
                        Prefix to use when emitting statsd metrics (a trailing
                        ``.`` is added, []
  --access-logfile FILE
                        The Access log file to write to. [None]
  --chdir CHDIR         Change directory to specified directory before loading
                        apps. [/opt/biocontainers]
  --log-config FILE     The log config file to use. [None]
  -b ADDRESS, --bind ADDRESS
                        The socket to bind. [['127.0.0.1:8000']]
  -t INT, --timeout INT
                        Workers silent for more than this many seconds are
                        killed and restarted. [30]
  --pythonpath STRING   A comma-separated list of directories to add to the
                        Python path. [None]
  --limit-request-fields INT
                        Limit the number of HTTP headers fields in a request.
                        [100]
  --preload             Load application code before the worker processes are
                        forked. [False]
  --no-sendfile         Disables the use of ``sendfile()``. [None]
  --proxy-protocol      Enable detect PROXY protocol (PROXY mode). [False]
  --graceful-timeout INT
                        Timeout for graceful workers restart. [30]
  -D, --daemon          Daemonize the Gunicorn process. [False]
  --cert-reqs CERT_REQS
                        Whether client certificate is required (see stdlib ssl
                        module's) [0]
  --threads INT         The number of worker threads for handling requests.
                        [1]
  --ciphers CIPHERS     SSL Cipher suite to use, in the format of an OpenSSL
                        cipher list. [None]
  -k STRING, --worker-class STRING
                        The type of workers to use. [sync]
  --max-requests-jitter INT
                        The maximum jitter to add to the *max_requests*
                        setting. [0]
  --capture-output      Redirect stdout/stderr to specified file in
                        :ref:`errorlog`. [False]
  --proxy-allow-from PROXY_ALLOW_IPS
                        Front-end's IPs from which allowed accept proxy
                        requests (comma separate). [127.0.0.1]
  -n STRING, --name STRING
                        A base to use with setproctitle for process naming.
                        [None]
  --logger-class STRING
                        The logger you want to use to log events in Gunicorn.
                        [gunicorn.glogging.Logger]
  --log-syslog-to SYSLOG_ADDR
                        Address to send syslog messages. [udp://localhost:514]
  -R, --enable-stdio-inheritance
                        Enable stdio inheritance. [False]
  --statsd-host STATSD_ADDR
                        ``host:port`` of the statsd server to log to. [None]
  --backlog INT         The maximum number of pending connections. [2048]
  --reuse-port          Set the ``SO_REUSEPORT`` flag on the listening socket.
                        [False]
  -p FILE, --pid FILE   A filename to use for the PID file. [None]
  --forwarded-allow-ips STRING
                        Front-end's IPs from which allowed to handle set
                        secure headers. [127.0.0.1]
  --strip-header-spaces
                        Strip spaces present between the header name and the
                        the ``:``. [False]
  -c CONFIG, --config CONFIG
                        The Gunicorn config file. [./gunicorn.conf.py]
  --keep-alive INT      The number of seconds to wait for requests on a Keep-
                        Alive connection. [2]
  --reload-extra-file FILES
                        Extends :ref:`reload` option to also watch and reload
                        on additional files [[]]
  -u USER, --user USER  Switch worker processes to run as this user. [1000]
  -m INT, --umask INT   A bit mask for the file mode on files written by
                        Gunicorn. [0]
  --initgroups          If true, set the worker process's group access list
                        with all of the [False]
  --suppress-ragged-eofs
                        Suppress ragged EOFs (see stdlib ssl module's) [True]
  --paste-global CONF   Set a PasteDeploy global config variable in
                        ``key=value`` form. [[]]
  --disable-redirect-access-to-syslog
                        Disable redirect access logs to syslog. [False]
  --worker-connections INT
                        The maximum number of simultaneous clients. [1000]
  --reload-engine STRING
                        The implementation that should be used to power
                        :ref:`reload`. [auto]
```


## Metadata
- **Skill**: generated

## ci-proxy

### Tool Description
Gunicorn 'Green Unicorn' is a Python WSGI HTTP Server. For UNIX only.

### Metadata
- **Docker Image**: biocontainers/ci-proxy:latest
- **Homepage**: https://github.com/cirosantilli/china-dictatorship
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
usage: gunicorn [OPTIONS] [APP_MODULE]

optional arguments:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  -k STRING, --worker-class STRING
                        The type of workers to use. [sync]
  -b ADDRESS, --bind ADDRESS
                        The socket to bind. [['127.0.0.1:8000']]
  -R, --enable-stdio-inheritance
                        Enable stdio inheritance. [False]
  --ciphers CIPHERS     SSL Cipher suite to use, in the format of an OpenSSL
                        cipher list. [None]
  -w INT, --workers INT
                        The number of worker processes for handling requests.
                        [1]
  --reuse-port          Set the ``SO_REUSEPORT`` flag on the listening socket.
                        [False]
  -D, --daemon          Daemonize the Gunicorn process. [False]
  --graceful-timeout INT
                        Timeout for graceful workers restart. [30]
  --access-logfile FILE
                        The Access log file to write to. [None]
  --disable-redirect-access-to-syslog
                        Disable redirect access logs to syslog. [False]
  --dogstatsd-tags DOGSTATSD_TAGS
                        A comma-delimited list of datadog statsd (dogstatsd)
                        tags to append to []
  --statsd-prefix STATSD_PREFIX
                        Prefix to use when emitting statsd metrics (a trailing
                        ``.`` is added, []
  -t INT, --timeout INT
                        Workers silent for more than this many seconds are
                        killed and restarted. [30]
  --certfile FILE       SSL certificate file [None]
  --cert-reqs CERT_REQS
                        Whether client certificate is required (see stdlib ssl
                        module's) [0]
  --suppress-ragged-eofs
                        Suppress ragged EOFs (see stdlib ssl module's) [True]
  -p FILE, --pid FILE   A filename to use for the PID file. [None]
  -m INT, --umask INT   A bit mask for the file mode on files written by
                        Gunicorn. [0]
  --paste STRING, --paster STRING
                        Load a PasteDeploy config file. The argument may
                        contain a ``#`` [None]
  --reload-extra-file FILES
                        Extends :ref:`reload` option to also watch and reload
                        on additional files [[]]
  --proxy-protocol      Enable detect PROXY protocol (PROXY mode). [False]
  --ssl-version SSL_VERSION
                        SSL version to use. [_SSLMethod.PROTOCOL_TLS]
  --chdir CHDIR         Change directory to specified directory before loading
                        apps. [/opt/biocontainers]
  --strip-header-spaces
                        Strip spaces present between the header name and the
                        the ``:``. [False]
  --spew                Install a trace function that spews every line
                        executed by the server. [False]
  --error-logfile FILE, --log-file FILE
                        The Error log file to write to. [-]
  --log-syslog          Send *Gunicorn* logs to syslog. [False]
  --limit-request-line INT
                        The maximum size of HTTP request line in bytes. [4094]
  -e ENV, --env ENV     Set environment variables in the execution
                        environment. [[]]
  --proxy-allow-from PROXY_ALLOW_IPS
                        Front-end's IPs from which allowed accept proxy
                        requests (comma separate). [127.0.0.1]
  --capture-output      Redirect stdout/stderr to specified file in
                        :ref:`errorlog`. [False]
  --log-syslog-prefix SYSLOG_PREFIX
                        Makes Gunicorn use the parameter as program-name in
                        the syslog entries. [None]
  --check-config        Check the configuration and exit. The exit status is 0
                        if the [False]
  --do-handshake-on-connect
                        Whether to perform SSL handshake on socket connect
                        (see stdlib ssl module's) [False]
  --max-requests-jitter INT
                        The maximum jitter to add to the *max_requests*
                        setting. [0]
  -n STRING, --name STRING
                        A base to use with setproctitle for process naming.
                        [None]
  --keep-alive INT      The number of seconds to wait for requests on a Keep-
                        Alive connection. [2]
  --log-config FILE     The log config file to use. [None]
  --forwarded-allow-ips STRING
                        Front-end's IPs from which allowed to handle set
                        secure headers. [127.0.0.1]
  --logger-class STRING
                        The logger you want to use to log events in Gunicorn.
                        [gunicorn.glogging.Logger]
  --reload              Restart workers when code changes. [False]
  --access-logformat STRING
                        The access log format. [%(h)s %(l)s %(u)s %(t)s
                        "%(r)s" %(s)s %(b)s "%(f)s" "%(a)s"]
  --no-sendfile         Disables the use of ``sendfile()``. [None]
  --max-requests INT    The maximum number of requests a worker will process
                        before restarting. [0]
  --statsd-host STATSD_ADDR
                        ``host:port`` of the statsd server to log to. [None]
  --worker-connections INT
                        The maximum number of simultaneous clients. [1000]
  --keyfile FILE        SSL key file [None]
  -g GROUP, --group GROUP
                        Switch worker process to run as this group. [1000]
  --reload-engine STRING
                        The implementation that should be used to power
                        :ref:`reload`. [auto]
  --print-config        Print the configuration settings as fully resolved.
                        Implies :ref:`check-config`. [False]
  --limit-request-field_size INT
                        Limit the allowed size of an HTTP request header
                        field. [8190]
  --initgroups          If true, set the worker process's group access list
                        with all of the [False]
  --log-syslog-facility SYSLOG_FACILITY
                        Syslog facility name [user]
  --ca-certs FILE       CA certificates file [None]
  -u USER, --user USER  Switch worker processes to run as this user. [1000]
  --backlog INT         The maximum number of pending connections. [2048]
  --threads INT         The number of worker threads for handling requests.
                        [1]
  --worker-tmp-dir DIR  A directory to use for the worker heartbeat temporary
                        file. [None]
  --pythonpath STRING   A comma-separated list of directories to add to the
                        Python path. [None]
  --preload             Load application code before the worker processes are
                        forked. [False]
  -c CONFIG, --config CONFIG
                        The Gunicorn config file. [./gunicorn.conf.py]
  --limit-request-fields INT
                        Limit the number of HTTP headers fields in a request.
                        [100]
  --log-level LEVEL     The granularity of Error log outputs. [info]
  --paste-global CONF   Set a PasteDeploy global config variable in
                        ``key=value`` form. [[]]
  --log-syslog-to SYSLOG_ADDR
                        Address to send syslog messages. [udp://localhost:514]
```

