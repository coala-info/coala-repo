cwlVersion: v1.2
class: CommandLineTool
baseCommand: pvacseq
label: pvacseq
doc: "The provided text is a container engine log (Singularity/Apptainer) and does
  not contain the help text or usage instructions for the pvacseq tool. As a result,
  no arguments could be extracted.\n\nTool homepage: https://github.com/griffithlab/pVAC-Seq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pvacseq:4.0.10--py36_0
stdout: pvacseq.out
