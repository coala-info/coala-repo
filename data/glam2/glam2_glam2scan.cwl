cwlVersion: v1.2
class: CommandLineTool
baseCommand: glam2scan
label: glam2_glam2scan
doc: "Scan a sequence database with a GLAM2 motif\n\nTool homepage: https://github.com/LELEGOBOO/Glam2"
inputs:
  - id: alphabet
    type: string
    doc: "Alphabet: p = proteins, n = nucleotides, or an alphabet file"
    inputBinding:
      position: 10
  - id: motif
    type: File
    doc: "GLAM2 motif file (output of glam2)"
    inputBinding:
      position: 11
  - id: sequences
    type: File
    doc: "Sequence file in FASTA format"
    inputBinding:
      position: 12
  - id: num_alignments
    type:
      - 'null'
      - int
    doc: "number of alignments to report (25)"
    inputBinding:
      position: 1
      prefix: -n
  - id: both_strands
    type:
      - 'null'
      - boolean
    doc: "examine both strands - forward and reverse complement"
    inputBinding:
      position: 1
      prefix: "-2"
  - id: deletion_pseudocount
    type:
      - 'null'
      - float
    doc: "deletion pseudocount (0.1)"
    inputBinding:
      position: 1
      prefix: -D
  - id: no_deletion_pseudocount
    type:
      - 'null'
      - float
    doc: "no-deletion pseudocount (2.0)"
    inputBinding:
      position: 1
      prefix: -E
  - id: insertion_pseudocount
    type:
      - 'null'
      - float
    doc: "insertion pseudocount (0.02)"
    inputBinding:
      position: 1
      prefix: -I
  - id: no_insertion_pseudocount
    type:
      - 'null'
      - float
    doc: "no-insertion pseudocount (1.0)"
    inputBinding:
      position: 1
      prefix: -J
  - id: dirichlet_mixture_file
    type:
      - 'null'
      - File
    doc: "Dirichlet mixture file"
    inputBinding:
      position: 1
      prefix: -d
  - id: output_name
    type: string
    doc: "output file"
    default: glam2scan_out.txt
    inputBinding:
      position: 1
      prefix: -o
outputs:
  - id: output
    type: File
    doc: "Alignments of the motif to the sequences"
    outputBinding:
      glob: $(inputs.output_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/glam2:v1064-5-deb_cv1
