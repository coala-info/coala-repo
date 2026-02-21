cwlVersion: v1.2
class: CommandLineTool
baseCommand: metamlst
label: metamlst
doc: "The provided text contains system error logs related to a container runtime
  (Apptainer/Singularity) and does not contain the actual help documentation or usage
  instructions for the metamlst tool.\n\nTool homepage: https://github.com/SegataLab/metamlst"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metamlst:1.2.3--hdfd78af_0
stdout: metamlst.out
