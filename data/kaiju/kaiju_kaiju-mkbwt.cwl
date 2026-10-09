cwlVersion: v1.2
class: CommandLineTool
baseCommand: kaiju-mkbwt
label: kaiju_kaiju-mkbwt
doc: "Calculate the Burrows-Wheeler transform (BWT) and suffix array of a protein FASTA file; the first step of building a kaiju database.\n\nTool homepage: https://github.com/bioinformatics-centre/kaiju"
inputs:
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: "Name of output. Several files with different extensions are produced (if not given, input file name is used)."
    inputBinding:
      position: 1
      prefix: -o
  - id: alphabet
    type:
      - 'null'
      - string
    doc: "Alphabet used. Must end with the sequence terminator. Instead of alphabet you can specify DNA, RNA or protein, in which case the alphabet is ACGT, ACGU, or ACDEFGHIKLMNPQRSTVWYX (default: protein)"
    inputBinding:
      position: 2
      prefix: -a
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads (default: 2)"
    inputBinding:
      position: 3
      prefix: -n
  - id: length
    type:
      - 'null'
      - float
    doc: "Length of concatenated sequence in millions (one decimal, round up). Used when reading from stdin. If file name is given, length is estimated from file size and length needs not be specified."
    inputBinding:
      position: 4
      prefix: -l
  - id: checkpoint
    type:
      - 'null'
      - int
    doc: "Exponent for suffix array checkpoints. There is a checkpoint for every 2^e points. Value around 5 is a good compromise between speed and space (default: 5)"
    inputBinding:
      position: 5
      prefix: -e
  - id: case_sensitive
    type:
      - 'null'
      - boolean
    doc: "The sequence is read case sensitive"
    inputBinding:
      position: 6
      prefix: -c
  - id: rev_comp
    type:
      - 'null'
      - boolean
    doc: "Reverse complement sequence. Works only for DNA."
    inputBinding:
      position: 7
      prefix: -r
  - id: terminator
    type:
      - 'null'
      - string
    doc: "Terminating symbol (only used for debugging) (default: *)"
    inputBinding:
      position: 8
      prefix: -t
  - id: revsort
    type:
      - 'null'
      - boolean
    doc: "The termination symbols sorts as reverse sequences. This will make the BWT more compressible."
    inputBinding:
      position: 9
      prefix: -s
  - id: input_file
    type: File
    doc: "Name of an input FASTA file"
    inputBinding:
      position: 100
outputs:
  - id: index_files
    type:
      type: array
      items: File
    doc: "BWT and suffix array files (output_prefix.bwt, output_prefix.sa, ...)"
    outputBinding:
      glob: $(inputs.output_prefix).*
  - id: stdout
    type: stdout
    doc: Standard output (the result when no output file is given)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kaiju:1.10.1--h5ca1c30_3
stdout: kaiju_kaiju-mkbwt.out
