cwlVersion: v1.2
class: CommandLineTool
baseCommand: varscan
label: varscan_VarScan.jar
doc: "VarScan is a tool for variant detection in next-generation sequencing data.
  Note: The provided text contains environment logs and a fatal error message rather
  than command-line help documentation.\n\nTool homepage: http://dkoboldt.github.io/varscan/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varscan:2.4.6--hdfd78af_0
stdout: varscan_VarScan.jar.out
