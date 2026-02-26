cwlVersion: v1.2
class: CommandLineTool
baseCommand: igvtools
label: igvtools_See
doc: "IGV Tools is a set of utilities for preprocessing and manipulating genomic data
  files.\n\nTool homepage: http://www.broadinstitute.org/igv/"
inputs:
  - id: input_file
    type: File
    doc: The input file to be processed
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igvtools:2.17.3--hdfd78af_0
stdout: igvtools_See.out
