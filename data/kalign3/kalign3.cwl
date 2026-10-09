cwlVersion: v1.2
class: CommandLineTool
baseCommand: kalign
label: kalign3
doc: "Kalign 3: fast and accurate multiple sequence alignment of large data sets.\n\nTool homepage: https://github.com/TimoLassmann/kalign"
inputs:
  - id: input_file
    type: File
    doc: "Input sequence file (FASTA, MSF, Clustal and other formats); several input files can also be given as arguments"
    inputBinding:
      position: 1
      prefix: -i
  - id: output_path
    type:
      - 'null'
      - string
    doc: "Output alignment file (default: standard output)"
    inputBinding:
      position: 2
      prefix: -o
  - id: format
    type:
      - 'null'
      - string
    doc: "Output format: fasta, clustal, msf, phylip... (default: fasta)"
    inputBinding:
      position: 3
      prefix: --format
  - id: seq_type
    type:
      - 'null'
      - string
    doc: "Alignment type: protein, divergent (protein), rna, dna, internal (nucleotide); default is auto-detected"
    inputBinding:
      position: 4
      prefix: --type
  - id: gap_open
    type:
      - 'null'
      - float
    doc: "Gap open penalty"
    inputBinding:
      position: 5
      prefix: --gpo
  - id: gap_extension
    type:
      - 'null'
      - float
    doc: "Gap extension penalty"
    inputBinding:
      position: 6
      prefix: --gpe
  - id: terminal_gap_extension
    type:
      - 'null'
      - float
    doc: "Terminal gap extension penalty"
    inputBinding:
      position: 7
      prefix: --tgpe
  - id: nthreads
    type:
      - 'null'
      - int
    doc: "Number of threads (default: 4)"
    inputBinding:
      position: 8
      prefix: --nthreads
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Alignment written to the output file"
    outputBinding:
      glob: $(inputs.output_path)
  - id: stdout
    type: stdout
    doc: Standard output (the alignment when no output file is given)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kalign3:3.4.0--h503566f_2
stdout: kalign3.out
