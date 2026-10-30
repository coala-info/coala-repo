cwlVersion: v1.2
class: CommandLineTool
baseCommand: wiggletools
label: wiggletools_fillIn
doc: "Values of the second track, filled with its default value over the regions of the first track (binary operator fillIn).\n\nTool homepage: https://github.com/Ensembl/WiggleTools"
requirements:
  - class: InlineJavascriptRequirement
arguments:
  - position: 1
    valueFrom: "$(inputs.write_bedgraph ? 'write_bg' : 'write')"
  - position: 2
    valueFrom: $(inputs.output_name)
  - position: 3
    valueFrom: fillIn
inputs:
  - id: regions
    type: File
    doc: Track whose regions are filled in.
    inputBinding:
      position: 4
  - id: data
    type: File
    doc: Track providing the values and the default value.
    inputBinding:
      position: 5
  - id: output_name
    type: string
    doc: Output file name (the 'write' operator; a wiggle file, or bedGraph with write_bedgraph).
    default: out.wig
  - id: write_bedgraph
    type: ['null', boolean]
    doc: Use the 'write_bg' operator, which writes bedGraph instead of wiggle.
outputs:
  - id: output_file
    type: File
    doc: The track written by the 'write' operator.
    outputBinding:
      glob: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wiggletools:1.2.11--h7118728_10
