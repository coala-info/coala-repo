cwlVersion: v1.2
class: CommandLineTool
baseCommand: kinsimriboswitch
label: kinsimriboswitch
doc: "Kinetic simulation of riboswitches. (Note: The provided input text contains
  container runtime error messages rather than command-line help documentation; therefore,
  no arguments could be extracted.)\n\nTool homepage: http://www.bioinf.uni-leipzig.de/~felix/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kinsimriboswitch:0.3--pl526r341ha0399c4_0
stdout: kinsimriboswitch.out
