cwlVersion: v1.2
class: CommandLineTool
baseCommand: gunicorn
label: ci-proxy
doc: "Gunicorn 'Green Unicorn' is a Python WSGI HTTP Server. For UNIX only.\n\nTool
  homepage: https://github.com/cirosantilli/china-dictatorship"
inputs:
  - id: app_module
    type:
      - 'null'
      - string
    doc: The WSGI application to run
    inputBinding:
      position: 1
  - id: access_logfile
    type:
      - 'null'
      - File
    doc: The Access log file to write to.
    default: None
    inputBinding:
      position: 102
      prefix: --access-logfile
  - id: access_logformat
    type:
      - 'null'
      - string
    doc: The access log format.
    default: '%(h)s %(l)s %(u)s %(t)s "% (r)s" %(s)s %(b)s "%(f)s" "%(a)s"'
    inputBinding:
      position: 102
      prefix: --access-logformat
  - id: backlog
    type:
      - 'null'
      - int
    doc: The maximum number of pending connections.
    default: 2048
    inputBinding:
      position: 102
      prefix: --backlog
  - id: bind
    type:
      - 'null'
      - string
    doc: The socket to bind.
    default: "['127.0.0.1:8000']"
    inputBinding:
      position: 102
      prefix: --bind
  - id: capture_output
    type:
      - 'null'
      - boolean
    doc: Redirect stdout/stderr to specified file in :ref:`errorlog`.
    default: false
    inputBinding:
      position: 102
      prefix: --capture-output
  - id: cert_reqs
    type:
      - 'null'
      - string
    doc: Whether client certificate is required (see stdlib ssl module's)
    default: '0'
    inputBinding:
      position: 102
      prefix: --cert-reqs
  - id: certfile
    type:
      - 'null'
      - File
    doc: SSL certificate file
    default: None
    inputBinding:
      position: 102
      prefix: --certfile
  - id: chdir
    type:
      - 'null'
      - Directory
    doc: Change directory to specified directory before loading apps.
    default: /opt/biocontainers
    inputBinding:
      position: 102
      prefix: --chdir
  - id: check_config
    type:
      - 'null'
      - boolean
    doc: Check the configuration and exit. The exit status is 0 if the
    default: false
    inputBinding:
      position: 102
      prefix: --check-config
  - id: ciphers
    type:
      - 'null'
      - string
    doc: SSL Cipher suite to use, in the format of an OpenSSL cipher list.
    default: None
    inputBinding:
      position: 102
      prefix: --ciphers
  - id: config
    type:
      - 'null'
      - File
    doc: The Gunicorn config file.
    default: ./gunicorn.conf.py
    inputBinding:
      position: 102
      prefix: --config
  - id: daemon
    type:
      - 'null'
      - boolean
    doc: Daemonize the Gunicorn process.
    default: false
    inputBinding:
      position: 102
      prefix: --daemon
  - id: disable_redirect_access_to_syslog
    type:
      - 'null'
      - boolean
    doc: Disable redirect access logs to syslog.
    default: false
    inputBinding:
      position: 102
      prefix: --disable-redirect-access-to-syslog
  - id: do_handshake_on_connect
    type:
      - 'null'
      - boolean
    doc: Whether to perform SSL handshake on socket connect (see stdlib ssl 
      module's)
    default: false
    inputBinding:
      position: 102
      prefix: --do-handshake-on-connect
  - id: dogstatsd_tags
    type:
      - 'null'
      - string
    doc: A comma-delimited list of datadog statsd (dogstatsd) tags to append to
    default: '[]'
    inputBinding:
      position: 102
      prefix: --dogstatsd-tags
  - id: enable_stdio_inheritance
    type:
      - 'null'
      - boolean
    doc: Enable stdio inheritance.
    default: false
    inputBinding:
      position: 102
      prefix: --enable-stdio-inheritance
  - id: env
    type:
      - 'null'
      - type: array
        items: string
    doc: Set environment variables in the execution environment.
    default: '[]'
    inputBinding:
      position: 102
      prefix: --env
  - id: error_logfile
    type:
      - 'null'
      - File
    doc: The Error log file to write to.
    default: '-'
    inputBinding:
      position: 102
      prefix: --error-logfile
  - id: forwarded_allow_ips
    type:
      - 'null'
      - string
    doc: Front-end's IPs from which allowed to handle set secure headers.
    default: 127.0.0.1
    inputBinding:
      position: 102
      prefix: --forwarded-allow-ips
  - id: graceful_timeout
    type:
      - 'null'
      - int
    doc: Timeout for graceful workers restart.
    default: 30
    inputBinding:
      position: 102
      prefix: --graceful-timeout
  - id: group
    type:
      - 'null'
      - string
    doc: Switch worker process to run as this group.
    default: '1000'
    inputBinding:
      position: 102
      prefix: --group
  - id: initgroups
    type:
      - 'null'
      - boolean
    doc: If true, set the worker process's group access list with all of the
    default: false
    inputBinding:
      position: 102
      prefix: --initgroups
  - id: keep_alive
    type:
      - 'null'
      - int
    doc: The number of seconds to wait for requests on a Keep- Alive connection.
    default: 2
    inputBinding:
      position: 102
      prefix: --keep-alive
  - id: keyfile
    type:
      - 'null'
      - File
    doc: SSL key file
    default: None
    inputBinding:
      position: 102
      prefix: --keyfile
  - id: limit_request_field_size
    type:
      - 'null'
      - int
    doc: Limit the allowed size of an HTTP request header field.
    default: 8190
    inputBinding:
      position: 102
      prefix: --limit-request-field_size
  - id: limit_request_fields
    type:
      - 'null'
      - int
    doc: Limit the number of HTTP headers fields in a request.
    default: 100
    inputBinding:
      position: 102
      prefix: --limit-request-fields
  - id: limit_request_line
    type:
      - 'null'
      - int
    doc: The maximum size of HTTP request line in bytes.
    default: 4094
    inputBinding:
      position: 102
      prefix: --limit-request-line
  - id: log_config
    type:
      - 'null'
      - File
    doc: The log config file to use.
    default: None
    inputBinding:
      position: 102
      prefix: --log-config
  - id: log_file
    type:
      - 'null'
      - File
    doc: The Error log file to write to.
    default: '-'
    inputBinding:
      position: 102
      prefix: --log-file
  - id: log_level
    type:
      - 'null'
      - string
    doc: The granularity of Error log outputs.
    default: info
    inputBinding:
      position: 102
      prefix: --log-level
  - id: log_syslog
    type:
      - 'null'
      - boolean
    doc: Send *Gunicorn* logs to syslog.
    default: false
    inputBinding:
      position: 102
      prefix: --log-syslog
  - id: log_syslog_facility
    type:
      - 'null'
      - string
    doc: Syslog facility name
    default: user
    inputBinding:
      position: 102
      prefix: --log-syslog-facility
  - id: log_syslog_prefix
    type:
      - 'null'
      - string
    doc: Makes Gunicorn use the parameter as program-name in the syslog entries.
    default: None
    inputBinding:
      position: 102
      prefix: --log-syslog-prefix
  - id: log_syslog_to
    type:
      - 'null'
      - string
    doc: Address to send syslog messages.
    default: udp://localhost:514
    inputBinding:
      position: 102
      prefix: --log-syslog-to
  - id: logger_class
    type:
      - 'null'
      - string
    doc: The logger you want to use to log events in Gunicorn.
    default: gunicorn.glogging.Logger
    inputBinding:
      position: 102
      prefix: --logger-class
  - id: max_requests
    type:
      - 'null'
      - int
    doc: The maximum number of requests a worker will process before restarting.
    default: 0
    inputBinding:
      position: 102
      prefix: --max-requests
  - id: max_requests_jitter
    type:
      - 'null'
      - int
    doc: The maximum jitter to add to the *max_requests* setting.
    default: 0
    inputBinding:
      position: 102
      prefix: --max-requests-jitter
  - id: name
    type:
      - 'null'
      - string
    doc: A base to use with setproctitle for process naming.
    default: None
    inputBinding:
      position: 102
      prefix: --name
  - id: no_sendfile
    type:
      - 'null'
      - boolean
    doc: Disables the use of ``sendfile()``.
    default: false
    inputBinding:
      position: 102
      prefix: --no-sendfile
  - id: paste
    type:
      - 'null'
      - string
    doc: Load a PasteDeploy config file. The argument may contain a ``#``
    default: None
    inputBinding:
      position: 102
      prefix: --paster
  - id: paste_global
    type:
      - 'null'
      - type: array
        items: string
    doc: Set a PasteDeploy global config variable in ``key=value`` form.
    default: '[]'
    inputBinding:
      position: 102
      prefix: --paste-global
  - id: pid
    type:
      - 'null'
      - File
    doc: A filename to use for the PID file.
    default: None
    inputBinding:
      position: 102
      prefix: --pid
  - id: preload
    type:
      - 'null'
      - boolean
    doc: Load application code before the worker processes are forked.
    default: false
    inputBinding:
      position: 102
      prefix: --preload
  - id: print_config
    type:
      - 'null'
      - boolean
    doc: Print the configuration settings as fully resolved. Implies 
      :ref:`check-config`.
    default: false
    inputBinding:
      position: 102
      prefix: --print-config
  - id: proxy_allow_from
    type:
      - 'null'
      - string
    doc: Front-end's IPs from which allowed accept proxy requests (comma 
      separate).
    default: 127.0.0.1
    inputBinding:
      position: 102
      prefix: --proxy-allow-from
  - id: proxy_protocol
    type:
      - 'null'
      - boolean
    doc: Enable detect PROXY protocol (PROXY mode).
    default: false
    inputBinding:
      position: 102
      prefix: --proxy-protocol
  - id: pythonpath
    type:
      - 'null'
      - string
    doc: A comma-separated list of directories to add to the Python path.
    default: None
    inputBinding:
      position: 102
      prefix: --pythonpath
  - id: reload
    type:
      - 'null'
      - boolean
    doc: Restart workers when code changes.
    default: false
    inputBinding:
      position: 102
      prefix: --reload
  - id: reload_engine
    type:
      - 'null'
      - string
    doc: The implementation that should be used to power :ref:`reload`.
    default: auto
    inputBinding:
      position: 102
      prefix: --reload-engine
  - id: reload_extra_file
    type:
      - 'null'
      - type: array
        items: File
    doc: Extends :ref:`reload` option to also watch and reload on additional 
      files
    default: '[]'
    inputBinding:
      position: 102
      prefix: --reload-extra-file
  - id: reuse_port
    type:
      - 'null'
      - boolean
    doc: Set the ``SO_REUSEPORT`` flag on the listening socket.
    default: false
    inputBinding:
      position: 102
      prefix: --reuse-port
  - id: spew
    type:
      - 'null'
      - boolean
    doc: Install a trace function that spews every line executed by the server.
    default: false
    inputBinding:
      position: 102
      prefix: --spew
  - id: ssl_version
    type:
      - 'null'
      - string
    doc: SSL version to use.
    default: _SSLMethod.PROTOCOL_TLS
    inputBinding:
      position: 102
      prefix: --ssl-version
  - id: statsd_host
    type:
      - 'null'
      - string
    doc: '``host:port`` of the statsd server to log to.'
    default: None
    inputBinding:
      position: 102
      prefix: --statsd-host
  - id: statsd_prefix
    type:
      - 'null'
      - string
    doc: Prefix to use when emitting statsd metrics (a trailing ``.`` is added,
    default: '[]'
    inputBinding:
      position: 102
      prefix: --statsd-prefix
  - id: strip_header_spaces
    type:
      - 'null'
      - boolean
    doc: Strip spaces present between the header name and the the ``:``.
    default: false
    inputBinding:
      position: 102
      prefix: --strip-header-spaces
  - id: suppress_ragged_eofs
    type:
      - 'null'
      - boolean
    doc: Suppress ragged EOFs (see stdlib ssl module's)
    default: true
    inputBinding:
      position: 102
      prefix: --suppress-ragged-eofs
  - id: threads
    type:
      - 'null'
      - int
    doc: The number of worker threads for handling requests.
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: timeout
    type:
      - 'null'
      - int
    doc: Workers silent for more than this many seconds are killed and 
      restarted.
    default: 30
    inputBinding:
      position: 102
      prefix: --timeout
  - id: umask
    type:
      - 'null'
      - int
    doc: A bit mask for the file mode on files written by Gunicorn.
    default: 0
    inputBinding:
      position: 102
      prefix: --umask
  - id: user
    type:
      - 'null'
      - string
    doc: Switch worker processes to run as this user.
    default: '1000'
    inputBinding:
      position: 102
      prefix: --user
  - id: worker_class
    type:
      - 'null'
      - string
    doc: The type of workers to use.
    default: sync
    inputBinding:
      position: 102
      prefix: --worker-class
  - id: worker_connections
    type:
      - 'null'
      - int
    doc: The maximum number of simultaneous clients.
    default: 1000
    inputBinding:
      position: 102
      prefix: --worker-connections
  - id: worker_tmp_dir
    type:
      - 'null'
      - Directory
    doc: A directory to use for the worker heartbeat temporary file.
    default: None
    inputBinding:
      position: 102
      prefix: --worker-tmp-dir
  - id: workers
    type:
      - 'null'
      - int
    doc: The number of worker processes for handling requests.
    default: 1
    inputBinding:
      position: 102
      prefix: --workers
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ci-proxy:latest
stdout: ci-proxy.out
