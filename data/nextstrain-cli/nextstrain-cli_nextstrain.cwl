cwlVersion: v1.2
class: CommandLineTool
baseCommand: nextstrain
label: nextstrain-cli_nextstrain
doc: "Nextstrain command-line interface (CLI)\n\nThe `nextstrain` program and its
  subcommands aim to provide a consistent way\nto run and visualize pathogen builds
  and access Nextstrain components like\nAugur and Auspice across computing platforms
  such as Docker, Conda,\nSingularity, and AWS Batch.\n\nTool homepage: https://docs.nextstrain.org/projects/cli/"
inputs:
  - id: command
    type: string
    doc: The subcommand to run (e.g., run, build, view, deploy, remote, shell, 
      update, setup, check-setup, login, logout, whoami, version, init-shell, 
      authorization, debugger)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextstrain-cli:10.4.2--pyhdfd78af_0
stdout: nextstrain-cli_nextstrain.out
