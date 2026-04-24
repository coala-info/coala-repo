cwlVersion: v1.2
class: CommandLineTool
baseCommand: jupyter_console
label: jupyter_console
doc: "The Jupyter terminal-based Console.\n\nThis launches a Console application inside
  a terminal.\n\nThe Console supports various extra features beyond the traditional
  single-\nprocess Terminal IPython shell, such as connecting to an existing ipython\n\
  session, via:\n\n    jupyter console --existing\n\nwhere the previous session could
  have been created by another ipython console,\nan ipython qtconsole, or by opening
  an ipython notebook.\n\nTool homepage: https://github.com/jakevdp/PythonDataScienceHandbook"
inputs:
  - id: config_file
    type:
      - 'null'
      - string
    doc: Full path of a config file.
    inputBinding:
      position: 101
      prefix: --config
  - id: confirm_exit
    type:
      - 'null'
      - boolean
    doc: "Set to display confirmation dialog on exit. You can always use 'exit' or\n\
      'quit', to force a direct exit without any confirmation. This can also\nbe set
      in the config file by setting\n`c.JupyterConsoleApp.confirm_exit`."
    inputBinding:
      position: 101
      prefix: --confirm-exit
  - id: connection_file
    type:
      - 'null'
      - string
    doc: "JSON file in which to store connection info [default: kernel-<pid>.json]\n\
      This file will contain the IP, ports, and authentication key needed to\nconnect
      clients to this kernel. By default, this file will be created in the\nsecurity
      dir of the current profile, but can be specified by absolute path."
    inputBinding:
      position: 101
      prefix: -f
  - id: debug
    type:
      - 'null'
      - boolean
    doc: set log level to logging.DEBUG (maximize logging output)
    inputBinding:
      position: 101
      prefix: --debug
  - id: existing
    type:
      - 'null'
      - boolean
    doc: Connect to an existing kernel. If no argument specified, guess most 
      recent
    inputBinding:
      position: 101
      prefix: --existing
  - id: existing_kernel
    type:
      - 'null'
      - string
    doc: Connect to an already running kernel
    inputBinding:
      position: 101
      prefix: --existing
  - id: generate_config
    type:
      - 'null'
      - boolean
    doc: generate default config file
    inputBinding:
      position: 101
      prefix: --generate-config
  - id: hb
    type:
      - 'null'
      - int
    doc: 'set the heartbeat port [default: random]'
    inputBinding:
      position: 101
      prefix: --hb
  - id: iopub
    type:
      - 'null'
      - int
    doc: 'set the iopub (PUB) port [default: random]'
    inputBinding:
      position: 101
      prefix: --iopub
  - id: ip
    type:
      - 'null'
      - string
    doc: "Set the kernel's IP address [default localhost]. If the IP address is\n\
      something other than localhost, then Consoles on other machines will be able\n\
      to connect to the Kernel, so be careful!"
    inputBinding:
      position: 101
      prefix: --ip
  - id: kernel_name
    type:
      - 'null'
      - string
    doc: The name of the default kernel to start.
    inputBinding:
      position: 101
      prefix: --kernel
  - id: log_level
    type:
      - 'null'
      - int
    doc: "Set the log level by value or name.\nChoices: (0, 10, 20, 30, 40, 50, 'DEBUG',
      'INFO', 'WARN', 'ERROR', 'CRITICAL')"
    inputBinding:
      position: 101
      prefix: --log-level
  - id: no_confirm_exit
    type:
      - 'null'
      - boolean
    doc: "Don't prompt the user when exiting. This will terminate the kernel\nif it
      is owned by the frontend, and leave it alive if it is external.\nThis can also
      be set in the config file by setting\n`c.JupyterConsoleApp.confirm_exit`."
    inputBinding:
      position: 101
      prefix: --no-confirm-exit
  - id: no_simple_prompt
    type:
      - 'null'
      - boolean
    doc: Use a rich interactive prompt with prompt_toolkit
    inputBinding:
      position: 101
      prefix: --no-simple-prompt
  - id: shell
    type:
      - 'null'
      - int
    doc: 'set the shell (ROUTER) port [default: random]'
    inputBinding:
      position: 101
      prefix: --shell
  - id: simple_prompt
    type:
      - 'null'
      - boolean
    doc: Force simple minimal prompt using `raw_input`
    inputBinding:
      position: 101
      prefix: --simple-prompt
  - id: ssh
    type:
      - 'null'
      - string
    doc: The SSH server to use to connect to the kernel.
    inputBinding:
      position: 101
      prefix: --ssh
  - id: stdin
    type:
      - 'null'
      - int
    doc: 'set the stdin (ROUTER) port [default: random]'
    inputBinding:
      position: 101
      prefix: --stdin
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
stdout: jupyter_console.out
