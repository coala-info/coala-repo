cwlVersion: v1.2
class: CommandLineTool
baseCommand: tag_locuspocus
label: tag_locuspocus
doc: "Group features into loci based on overlap and proximity.\n\nTool homepage: https://github.com/standage/tag/"
inputs:
  - id: gff3_files
    type:
      type: array
      items: File
    doc: input files in GFF3 format
    inputBinding:
      position: 1
  - id: delta
    type:
      - 'null'
      - int
    doc: extend locus interval by Δ bp in each direction; by default, Δ=0
    inputBinding:
      position: 102
      prefix: --delta
  - id: min_bp
    type:
      - 'null'
      - int
    doc: only group features together in the same locus if they overlap by at 
      least N bp; by default N=25
    inputBinding:
      position: 102
      prefix: --min-bp
  - id: min_perc
    type:
      - 'null'
      - float
    doc: only group features together in the same locus if they overlap by a 
      fraction of at least P of their overall length; by default P=0.25 (25%)
    inputBinding:
      position: 102
      prefix: --min-perc
  - id: relax
    type:
      - 'null'
      - boolean
    doc: relax parsing stringency
    inputBinding:
      position: 102
      prefix: --relax
  - id: type
    type:
      - 'null'
      - string
    doc: apply locus parsing to features of type TYPE; by default, parsing is 
      applied to all top-level features regardless of type
    inputBinding:
      position: 102
      prefix: --type
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: write output in GFF3 to FILE; default is terminal (stdout)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tag:0.5.1--py_0
