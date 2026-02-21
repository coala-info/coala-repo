cwlVersion: v1.2
class: CommandLineTool
baseCommand: protal
label: protal
doc: "The provided text contains error logs from a container runtime (Apptainer/Singularity)
  and does not include the help text or usage information for the 'protal' tool. As
  a result, no arguments could be extracted.\n\nTool homepage: https://github.com/4less/protal"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protal:0.2.0a--h5ca1c30_0
stdout: protal.out
