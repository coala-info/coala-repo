cwlVersion: v1.2
class: CommandLineTool
baseCommand: odgi flatten
label: odgi_flatten
doc: "Generate linearizations of a graph.\n\nTool homepage: https://github.com/vgteam/odgi"
inputs:
  - id: idx
    type: File
    doc: Load the succinct variation graph in ODGI format from this *FILE*. The 
      file name usually ends with *.og*. It also accepts GFAv1, but the 
      on-the-fly conversion to the ODGI format requires additional time!
    inputBinding:
      position: 101
      prefix: --idx
  - id: name_seq
    type:
      - 'null'
      - string
    doc: 'The name to use for the concatenated graph sequence (default: input file
      name which was specified via -i, --idx=[FILE]).'
    inputBinding:
      position: 101
      prefix: --name-seq
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Write the current progress to stderr.
    inputBinding:
      position: 101
      prefix: --progress
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel operations.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: fasta
    type:
      - 'null'
      - File
    doc: Write the concatenated node sequences (also known as pangenome 
      sequence) in FASTA format to FILE.
    outputBinding:
      glob: $(inputs.fasta)
  - id: bed
    type:
      - 'null'
      - File
    doc: Write the mapping between graph paths and the linearized FASTA sequence
      in BED format to FILE.
    outputBinding:
      glob: $(inputs.bed)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
