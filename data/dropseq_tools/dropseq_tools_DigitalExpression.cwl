cwlVersion: v1.2
class: CommandLineTool
baseCommand: DigitalExpression
label: dropseq_tools_DigitalExpression
doc: "The provided text does not contain help information for the tool. It contains
  error messages related to a container runtime (Singularity/Apptainer) failing to
  build a SIF format image due to insufficient disk space.\n\nTool homepage: http://mccarrolllab.com/dropseq/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dropseq_tools:3.0.2--hdfd78af_0
stdout: dropseq_tools_DigitalExpression.out
