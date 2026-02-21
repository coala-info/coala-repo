cwlVersion: v1.2
class: CommandLineTool
baseCommand: SamToFastq
label: dropseq_tools_SamToFastq
doc: "The provided text does not contain help information for the tool. It contains
  system error messages regarding a failure to build a SIF container due to insufficient
  disk space.\n\nTool homepage: http://mccarrolllab.com/dropseq/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dropseq_tools:3.0.2--hdfd78af_0
stdout: dropseq_tools_SamToFastq.out
