cwlVersion: v1.2
class: CommandLineTool
baseCommand: dx
label: dxpy_dx
doc: "DNAnexus Command-Line Client, API v1.0.0, client v0.400.1\ndx is a command-line
  client for interacting with the DNAnexus platform.  You\ncan log in, navigate, upload,
  organize and share your data, launch analyses,\nand more.  For a quick tour of what
  the tool can do, see\n\n  https://documentation.dnanexus.com/getting-started/tutorials/cli-quickstart#quickstart-for-cli\n\
  \nFor a breakdown of dx commands by category, run \"dx help\".\n\ndx exits with
  exit code 3 if invalid input is provided or an invalid operation\nis requested,
  and exit code 1 if an internal error is encountered.  The latter\nusually indicate
  bugs in dx; please report them at\n\n  https://github.com/dnanexus/dx-toolkit/issues\n\
  \nTool homepage: https://github.com/dnanexus/dx-toolkit"
inputs:
  - id: command
    type: string
    doc: The dx command to execute
    inputBinding:
      position: 1
  - id: env_help
    type:
      - 'null'
      - boolean
    doc: Display help message for overriding environment variables
    inputBinding:
      position: 102
      prefix: --env-help
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dxpy:0.400.1--pyhdfd78af_0
stdout: dxpy_dx.out
