cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bioformats
  - flanknfilter
label: bioformats_flanknfilter
doc: "Given features from a BED or VCF file, check if they contain N's in their flanking
  regions of the specified length.\n\nTool homepage: https://github.com/gtamazian/bioformats"
inputs:
  - id: input_file
    type: File
    doc: an input file of features to be filtered
    inputBinding:
      position: 1
  - id: fasta_file
    type: File
    doc: a FASTA file of sequences the features are related to
    inputBinding:
      position: 2
  - id: length
    type:
      - 'null'
      - int
    doc: the flanking region length
    inputBinding:
      position: 103
      prefix: --length
  - id: strict
    type:
      - 'null'
      - boolean
    doc: require flanks to have exactly the specified length (it may be shorter if
      a feature is located near a sequence start or end)
    inputBinding:
      position: 103
      prefix: --strict
  - id: type
    type:
      - 'null'
      - string
    doc: the input file type (bed or vcf)
    inputBinding:
      position: 103
      prefix: --type
outputs:
  - id: output_file
    type: File
    doc: an output file of filtered features
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioformats:0.1.15--py27_0
