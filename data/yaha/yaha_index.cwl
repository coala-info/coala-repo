cwlVersion: v1.2
class: CommandLineTool
baseCommand: yaha
label: yaha_index
doc: "Create a YAHA index of a genome (FASTA or nib2 file). The index and the compressed
  genome (.nib2) are written beside the genome.\n\nTool homepage: https://github.com/GregoryFaust/yaha"
inputs:
  - id: genome_filename
    type: File
    doc: Genome file; can be a FASTA file, or a nib2 file (created by a previous yaha index operation)
    inputBinding:
      position: 1
      prefix: -g
  - id: max_hits
    type:
      - 'null'
      - int
    doc: Maximum number of hits per word kept in the index (65525)
    inputBinding:
      position: 2
      prefix: -H
  - id: word_len
    type:
      - 'null'
      - int
    doc: Word length (15); the index file size grows as 4^wordLen
    inputBinding:
      position: 3
      prefix: -L
  - id: skip_distance
    type:
      - 'null'
      - int
    doc: Skip-distance (1)
    inputBinding:
      position: 4
      prefix: -S
outputs:
  - id: index_file
    type: File
    doc: YAHA index file with the compressed genome (.nib2) as secondary file
    secondaryFiles:
      - pattern: ^.nib2
        required: true
    outputBinding:
      glob: $(inputs.genome_filename.nameroot).X*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.genome_filename)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yaha:0.1.83--h1b792b2_3
