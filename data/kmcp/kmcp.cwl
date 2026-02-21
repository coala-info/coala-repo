cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmcp
label: kmcp
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help text or usage instructions for the tool 'kmcp'. As
  a result, no arguments or descriptions could be extracted.\n\nTool homepage: https://github.com/shenwei356/kmcp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmcp:0.9.4--h9ee0642_1
stdout: kmcp.out
