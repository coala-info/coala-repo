cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - transseq.pl
label: phyloaln_transseq.pl
doc: "Translate nucleotide sequences in a file to amino acid sequences.\n\nTool homepage: https://github.com/huangyh45/PhyloAln"
inputs:
  - id: input_file
    type: File
    doc: "input nucleotide sequences file"
    inputBinding:
      position: 1
      prefix: "-i"
  - id: output_file_path
    type: string
    doc: "output amino acid sequences file"
    inputBinding:
      position: 2
      prefix: "-o"
  - id: genetic_code
    type:
      - 'null'
      - int
    doc: "genetic code (default=1, invertebrate mitochondrion=5)"
    inputBinding:
      position: 3
      prefix: "-g"
  - id: termination_symbol
    type:
      - 'null'
      - string
    doc: "symbol of termination (default='*')"
    inputBinding:
      position: 4
      prefix: "-t"
  - id: translate_incomplete_codons
    type:
      - 'null'
      - int
    doc: "if translate incomplete codons into 'X' (default=no; give 1 for yes)"
    inputBinding:
      position: 5
      prefix: "-c"
  - id: translate_all_six_orfs
    type:
      - 'null'
      - int
    doc: "if translate all six ORF (default=no; give 1 for yes)"
    inputBinding:
      position: 6
      prefix: "-a"
  - id: num_threads
    type:
      - 'null'
      - int
    doc: "num threads (default=1)"
    inputBinding:
      position: 7
      prefix: "-n"
  - id: log_file_name
    type:
      - 'null'
      - string
    doc: "log file name (default='transseq.log')"
    inputBinding:
      position: 8
      prefix: "-l"
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Translated amino acid sequences"
    outputBinding:
      glob: "$(inputs.output_file_path)"
  - id: log_file
    type:
      - 'null'
      - File
    doc: "Log file"
    outputBinding:
      glob: "$(inputs.log_file_name || \"transseq.log\")"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyloaln:1.1.0--hdfd78af_0
