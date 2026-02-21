cwlVersion: v1.2
class: CommandLineTool
baseCommand: run-dbcan_dbcan_build
label: run-dbcan_dbcan_build
doc: "The provided text does not contain help information for the tool, but appears
  to be a container runtime error log.\n\nTool homepage: https://github.com/linnabrown/run_dbcan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/run-dbcan:2.0.11--pyh3252c3a_0
stdout: run-dbcan_dbcan_build.out
