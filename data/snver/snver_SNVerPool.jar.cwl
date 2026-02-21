cwlVersion: v1.2
class: CommandLineTool
baseCommand: snver_SNVerPool.jar
label: snver_SNVerPool.jar
doc: "SNVerPool is a tool for variant calling in pooled sequencing data. (Note: The
  provided input text contains container environment logs and a fatal error message
  rather than the tool's help documentation; therefore, no arguments could be extracted.)\n
  \nTool homepage: http://snver.sourceforge.net/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snver:0.5.3--0
stdout: snver_SNVerPool.jar.out
