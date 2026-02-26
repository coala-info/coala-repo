cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - igvtools
  - formatexp
label: igvtools_formatexp
doc: "Formats an expression data file for use in IGV.\n\nTool homepage: http://www.broadinstitute.org/igv/"
inputs:
  - id: input_file
    type: File
    doc: The input expression data file.
    inputBinding:
      position: 1
  - id: genome
    type: string
    doc: The genome ID (e.g., hg19, mm10).
    inputBinding:
      position: 2
outputs:
  - id: output_file
    type: File
    doc: The output file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igvtools:2.17.3--hdfd78af_0
