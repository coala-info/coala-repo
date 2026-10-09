cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - igvtools
  - formatexp
label: igvtools_formatexp
doc: "Center, scale and log2 normalize a .gct or .res expression file (log2, subtract median, divide by MAD).\n\nTool homepage: http://www.broadinstitute.org/igv/"
inputs:
  - id: input_file
    type: File
    doc: "Input .gct or .res file (not previously log-transformed, no negative numbers)"
    inputBinding:
      position: 10
  - id: output_name
    type: string
    doc: "Output file name"
    inputBinding:
      position: 11
outputs:
  - id: output_file
    type: File
    doc: "Normalized expression file"
    outputBinding:
      glob: $(inputs.output_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igvtools:2.17.3--hdfd78af_0
