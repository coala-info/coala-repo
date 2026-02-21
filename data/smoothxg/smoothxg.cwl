cwlVersion: v1.2
class: CommandLineTool
baseCommand: smoothxg
label: smoothxg
doc: "The provided text is an error log from a container environment (Apptainer/Singularity)
  and does not contain the help text or usage information for the smoothxg tool. As
  a result, no arguments could be extracted.\n\nTool homepage: https://github.com/pangenome/smoothxg"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smoothxg:0.8.2--h2fa790d_1
stdout: smoothxg.out
