cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hs-blastn
  - index
label: hs-blastn_index
doc: "Build an FMD-index of a nucleotide database (FASTA) for hs-blastn align\n\nTool homepage: https://github.com/chenying2016/queries"
inputs:
  - id: database
    type: File
    doc: nucleotide database in FASTA format
    inputBinding:
      position: 1
outputs:
  - id: indexed_database
    type: File
    doc: database FASTA with its FMD-index files
    secondaryFiles:
      - .bwt
      - .header
      - .sa
      - .sequence
    outputBinding:
      glob: $(inputs.database.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.database)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hs-blastn:0.0.5--h9948957_6
