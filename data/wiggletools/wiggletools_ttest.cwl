cwlVersion: v1.2
class: CommandLineTool
baseCommand: wiggletools
label: wiggletools_ttest
doc: "Student t-test between two sets of tracks at each position (set comparison ttest).\n\nTool homepage: https://github.com/Ensembl/WiggleTools"
requirements:
  - class: InlineJavascriptRequirement
arguments:
  - position: 1
    valueFrom: "$(inputs.write_bedgraph ? 'write_bg' : 'write')"
  - position: 2
    valueFrom: $(inputs.output_name)
  - position: 3
    valueFrom: ttest
  - position: 5
    valueFrom: ':'
inputs:
  - id: group1_files
    type: File[]
    doc: First set of tracks (at least 3 files for ttest; the sets are separated by ':').
    inputBinding:
      position: 4
  - id: group2_files
    type: File[]
    doc: Second set of tracks.
    inputBinding:
      position: 6
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
