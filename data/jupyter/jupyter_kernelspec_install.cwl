cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jupyter
  - kernelspec
  - install
label: jupyter_kernelspec_install
doc: "Install a kernel specification directory.\n\nGiven a SOURCE DIRECTORY containing a kernel spec, jupyter will copy that\ndirectory into one of the Jupyter kernel directories. The default is to install\nkernelspecs for all users. `--user` can be specified to install a kernel only\nfor the current user.\n\nTool homepage: https://github.com/jupyter/jupyter_client"
inputs:
  - id: source_dir
    type: Directory
    doc: Directory containing the kernel specification (kernel.json)
    inputBinding:
      position: 10
  - id: debug
    type:
      - 'null'
      - boolean
    doc: set log level to logging.DEBUG (maximize logging output)
    inputBinding:
      position: 1
      prefix: --debug
  - id: replace
    type:
      - 'null'
      - boolean
    doc: Replace any existing kernel spec with this name.
    inputBinding:
      position: 1
      prefix: --replace
  - id: sys_prefix
    type:
      - 'null'
      - boolean
    doc: Install to Python's sys.prefix. Useful in conda/virtual environments.
    inputBinding:
      position: 1
      prefix: --sys-prefix
  - id: user
    type:
      - 'null'
      - boolean
    doc: Install to the per-user kernel registry
    inputBinding:
      position: 1
      prefix: --user
  - id: prefix
    type:
      - 'null'
      - string
    doc: Specify a prefix to install to, e.g. an env. The kernelspec will be installed in PREFIX/share/jupyter/kernels/
    inputBinding:
      position: 1
      prefix: --prefix=
      separate: false
  - id: config
    type:
      - 'null'
      - File
    doc: Full path of a config file.
    inputBinding:
      position: 1
      prefix: --config=
      separate: false
  - id: log_level
    type:
      - 'null'
      - string
    doc: Set the log level by value or name (0, 10, 20, 30, 40, 50, DEBUG, INFO, WARN, ERROR, CRITICAL).
    inputBinding:
      position: 1
      prefix: --log-level=
      separate: false
  - id: name
    type:
      - 'null'
      - string
    doc: Install the kernel spec with this name
    inputBinding:
      position: 1
      prefix: --name=
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Log message with the install location
  - id: prefix_kernels
    type:
      - 'null'
      - Directory
    doc: Kernel folder written under the given prefix
    outputBinding:
      glob: $(inputs.prefix)/share/jupyter/kernels
  - id: user_kernels
    type:
      - 'null'
      - Directory
    doc: Kernel folder written for the current user (--user)
    outputBinding:
      glob: .local/share/jupyter/kernels
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/jupyter:phenomenal-v387f29b6ca83_cv0.4.12
stdout: jupyter_kernelspec_install.out
stderr: jupyter_kernelspec_install.err
