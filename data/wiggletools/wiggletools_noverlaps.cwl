cwlVersion: v1.2
class: CommandLineTool
baseCommand: wiggletools
label: wiggletools_noverlaps
doc: "Values of the second track that do not overlap regions of the first track (binary operator noverlaps).\n\nTool homepage: https://github.com/Ensembl/WiggleTools"
requirements:
  - class: InlineJavascriptRequirement
arguments:
  - position: 1
    valueFrom: "$(inputs.write_bedgraph ? 'write_bg' : 'write')"
  - position: 2
    valueFrom: $(inputs.output_name)
  - position: 3
    valueFrom: noverlaps
inputs:
  - id: regions
    type: File
    doc: Track whose intervals define the regions to exclude (for example BED).
    inputBinding:
      position: 4
  - id: data
    type: File
    doc: Track whose values are kept outside the regions.
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
