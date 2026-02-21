cwlVersion: v1.2
class: CommandLineTool
baseCommand: alignment_build
label: alignment_build
doc: "A tool for building or fetching alignment container images (Note: The provided
  text is an execution log indicating a failed SIF build from an OCI/Docker source
  rather than standard help documentation).\n\nTool homepage: https://github.com/eseraygun/python-alignment"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alignment:1.0.10--pyh5e36f6f_0
stdout: alignment_build.out
