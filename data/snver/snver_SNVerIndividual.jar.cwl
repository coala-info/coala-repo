cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - java
  - -jar
  - SNVerIndividual.jar
label: snver_SNVerIndividual.jar
doc: "SNVer is a tool for variant calling. (Note: The provided text contains system
  error logs rather than help documentation, so no arguments could be extracted.)\n
  \nTool homepage: http://snver.sourceforge.net/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snver:0.5.3--0
stdout: snver_SNVerIndividual.jar.out
