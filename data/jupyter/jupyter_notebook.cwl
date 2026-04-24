cwlVersion: v1.2
class: CommandLineTool
baseCommand: jupyter_notebook
label: jupyter_notebook
doc: "The Jupyter HTML Notebook.\n\nThis launches a Tornado based HTML Notebook Server
  that serves up an\nHTML5/Javascript Notebook client.\n\nTool homepage: https://github.com/jakevdp/PythonDataScienceHandbook"
inputs:
  - id: browser
    type:
      - 'null'
      - string
    doc: "Specify what command to use to invoke a web browser when opening the\n \
      \   notebook. If not specified, the default browser will be determined by the\n\
      \    `webbrowser` standard library module, which allows setting of the BROWSER\n\
      \    environment variable to override it."
    inputBinding:
      position: 101
      prefix: --browser
  - id: certfile
    type:
      - 'null'
      - File
    doc: The full path to an SSL/TLS certificate file.
    inputBinding:
      position: 101
      prefix: --certfile
  - id: client_ca
    type:
      - 'null'
      - File
    doc: "The full path to a certificate authority certificate for SSL/TLS client\n\
      \    authentication."
    inputBinding:
      position: 101
      prefix: --client-ca
  - id: config_file
    type:
      - 'null'
      - File
    doc: Full path of a config file.
    inputBinding:
      position: 101
      prefix: --config
  - id: debug
    type:
      - 'null'
      - boolean
    doc: set log level to logging.DEBUG (maximize logging output)
    inputBinding:
      position: 101
      prefix: --debug
  - id: generate_config
    type:
      - 'null'
      - boolean
    doc: generate default config file
    inputBinding:
      position: 101
      prefix: --generate-config
  - id: ip
    type:
      - 'null'
      - string
    doc: The IP address the notebook server will listen on.
    inputBinding:
      position: 101
      prefix: --ip
  - id: keyfile
    type:
      - 'null'
      - File
    doc: The full path to a private key file for usage with SSL/TLS.
    inputBinding:
      position: 101
      prefix: --keyfile
  - id: log_level
    type:
      - 'null'
      - int
    doc: "Set the log level by value or name.\n    Choices: (0, 10, 20, 30, 40, 50,
      'DEBUG', 'INFO', 'WARN', 'ERROR', 'CRITICAL')"
    inputBinding:
      position: 101
      prefix: --log-level
  - id: no_browser
    type:
      - 'null'
      - boolean
    doc: Don't open the notebook in a browser after startup.
    inputBinding:
      position: 101
      prefix: --no-browser
  - id: no_mathjax
    type:
      - 'null'
      - boolean
    doc: "Disable MathJax\n\nMathJax is the javascript library Jupyter uses to render
      math/LaTeX. It is\nvery large, so you may want to disable it if you have a slow
      internet\nconnection, or for offline use of the notebook.\n\nWhen disabled,
      equations etc. will appear as their untransformed TeX source."
    inputBinding:
      position: 101
      prefix: --no-mathjax
  - id: no_script
    type:
      - 'null'
      - boolean
    doc: DEPRECATED, IGNORED
    inputBinding:
      position: 101
      prefix: --no-script
  - id: notebook_dir
    type:
      - 'null'
      - Directory
    doc: The directory to use for notebooks and kernels.
    inputBinding:
      position: 101
      prefix: --notebook-dir
  - id: port
    type:
      - 'null'
      - int
    doc: The port the notebook server will listen on.
    inputBinding:
      position: 101
      prefix: --port
  - id: port_retries
    type:
      - 'null'
      - int
    doc: "The number of additional ports to try if the specified port is not\n   \
      \ available."
    inputBinding:
      position: 101
      prefix: --port-retries
  - id: pylab
    type:
      - 'null'
      - string
    doc: 'DISABLED: use %pylab or %matplotlib in the notebook to enable matplotlib.'
    inputBinding:
      position: 101
      prefix: --pylab
  - id: pylab_flag
    type:
      - 'null'
      - boolean
    doc: 'DISABLED: use %pylab or %matplotlib in the notebook to enable matplotlib.'
    inputBinding:
      position: 101
      prefix: --pylab
  - id: script
    type:
      - 'null'
      - boolean
    doc: DEPRECATED, IGNORED
    inputBinding:
      position: 101
      prefix: --script
  - id: transport
    type:
      - 'null'
      - string
    doc: "Choices: ['tcp', 'ipc']"
    inputBinding:
      position: 101
      prefix: --transport
  - id: yes
    type:
      - 'null'
      - boolean
    doc: Answer yes to any questions instead of prompting.
    inputBinding:
      position: 101
      prefix: -y
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/jupyter:phenomenal-v387f29b6ca83_cv0.4.12
stdout: jupyter_notebook.out
