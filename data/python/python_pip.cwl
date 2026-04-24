cwlVersion: v1.2
class: CommandLineTool
baseCommand: pip
label: python_pip
doc: "Manage the Python package index.\n\nTool homepage: https://github.com/vinta/awesome-python"
inputs:
  - id: command
    type: string
    doc: The command to run (e.g., install, download, uninstall)
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options for the command
    inputBinding:
      position: 2
  - id: cache_dir
    type:
      - 'null'
      - Directory
    doc: Store the cache data in <dir>.
    inputBinding:
      position: 103
      prefix: --cache-dir
  - id: cert
    type:
      - 'null'
      - File
    doc: Path to PEM-encoded CA certificate bundle. If provided, overrides the 
      default. See 'SSL Certificate Verification' in pip documentation for more 
      information.
    inputBinding:
      position: 103
      prefix: --cert
  - id: client_cert
    type:
      - 'null'
      - File
    doc: Path to SSL client certificate, a single file containing the private 
      key and the certificate in PEM format.
    inputBinding:
      position: 103
      prefix: --client-cert
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Let unhandled exceptions propagate outside the main subroutine, instead
      of logging them to stderr.
    inputBinding:
      position: 103
      prefix: --debug
  - id: disable_pip_version_check
    type:
      - 'null'
      - boolean
    doc: Don't periodically check PyPI to determine whether a new version of pip
      is available for download. Implied with --no-index.
    inputBinding:
      position: 103
      prefix: --disable-pip-version-check
  - id: exists_action
    type:
      - 'null'
      - string
    doc: 'Default action when a path already exists: (s)witch, (i)gnore, (w)ipe, (b)ackup,
      (a)bort.'
    inputBinding:
      position: 103
      prefix: --exists-action
  - id: isolated
    type:
      - 'null'
      - boolean
    doc: Run pip in an isolated mode, ignoring environment variables and user 
      configuration.
    inputBinding:
      position: 103
      prefix: --isolated
  - id: keyring_provider
    type:
      - 'null'
      - string
    doc: Enable the credential lookup via the keyring library if user input is 
      allowed. Specify which mechanism to use [auto, disabled, import, 
      subprocess].
    inputBinding:
      position: 103
      prefix: --keyring-provider
  - id: log
    type:
      - 'null'
      - File
    doc: Path to a verbose appending log.
    inputBinding:
      position: 103
      prefix: --log
  - id: no_cache_dir
    type:
      - 'null'
      - boolean
    doc: Disable the cache.
    inputBinding:
      position: 103
      prefix: --no-cache-dir
  - id: no_color
    type:
      - 'null'
      - boolean
    doc: Suppress colored output.
    inputBinding:
      position: 103
      prefix: --no-color
  - id: no_input
    type:
      - 'null'
      - boolean
    doc: Disable prompting for input.
    inputBinding:
      position: 103
      prefix: --no-input
  - id: no_python_version_warning
    type:
      - 'null'
      - boolean
    doc: Silence deprecation warnings for upcoming unsupported Pythons.
    inputBinding:
      position: 103
      prefix: --no-python-version-warning
  - id: proxy
    type:
      - 'null'
      - string
    doc: Specify a proxy in the form scheme://[user:passwd@]proxy.server:port.
    inputBinding:
      position: 103
      prefix: --proxy
  - id: python
    type:
      - 'null'
      - string
    doc: Run pip with the specified Python interpreter.
    inputBinding:
      position: 103
      prefix: --python
  - id: quiet
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Give less output. Option is additive, and can be used up to 3 times 
      (corresponding to WARNING, ERROR, and CRITICAL logging levels).
    inputBinding:
      position: 103
      prefix: --quiet
  - id: require_virtualenv
    type:
      - 'null'
      - boolean
    doc: Allow pip to only run in a virtual environment; exit with an error 
      otherwise.
    inputBinding:
      position: 103
      prefix: --require-virtualenv
  - id: retries
    type:
      - 'null'
      - int
    doc: Maximum number of retries each connection should attempt (default 5 
      times).
    inputBinding:
      position: 103
      prefix: --retries
  - id: timeout
    type:
      - 'null'
      - int
    doc: Set the socket timeout (default 15 seconds).
    inputBinding:
      position: 103
      prefix: --timeout
  - id: trusted_host
    type:
      - 'null'
      - type: array
        items: string
    doc: Mark this host or host:port pair as trusted, even though it does not 
      have valid or any HTTPS.
    inputBinding:
      position: 103
      prefix: --trusted-host
  - id: use_deprecated
    type:
      - 'null'
      - type: array
        items: string
    doc: Enable deprecated functionality, that will be removed in the future.
    inputBinding:
      position: 103
      prefix: --use-deprecated
  - id: use_feature
    type:
      - 'null'
      - type: array
        items: string
    doc: Enable new functionality, that may be backward incompatible.
    inputBinding:
      position: 103
      prefix: --use-feature
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Give more output. Option is additive, and can be used up to 3 times.
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/python:3.13
stdout: python_pip.out
