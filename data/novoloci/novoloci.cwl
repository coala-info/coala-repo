cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl NOVOLoci0.5.pl
label: novoloci
doc: "NOVOLoci tool for processing genomic data.\n\nTool homepage: https://github.com/ndierckx/NOVOLoci"
inputs:
  - id: config_file
    type: File
    doc: Configuration file
    inputBinding:
      position: 101
      prefix: -c
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/novoloci:0.5--hdfd78af_0
stdout: novoloci.out
