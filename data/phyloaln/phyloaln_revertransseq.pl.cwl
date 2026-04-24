cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl /usr/local/bin/revertransseq.pl
label: phyloaln_revertransseq.pl
doc: "Used the aligned translated sequences in a file as blueprint to aligned nucleotide
  sequences, which means reverse-translation.\n\nTool homepage: https://github.com/huangyh45/PhyloAln"
inputs:
  - id: blueprint_file
    type:
      - 'null'
      - File
    doc: aligned amino acid sequences file translated by input file as blueprint
    inputBinding:
      position: 101
      prefix: -b
  - id: genetic_code
    type:
      - 'null'
      - int
    doc: genetic code(default=1, invertebrate mitochondrion=5)
    inputBinding:
      position: 101
      prefix: -g
  - id: input_file
    type:
      - 'null'
      - type: array
        items: File
    doc: input nucleotide sequences file or files(separated by ',')
    inputBinding:
      position: 101
      prefix: -i
  - id: log_file
    type:
      - 'null'
      - File
    doc: log file(default='revertransseq.log')
    inputBinding:
      position: 101
      prefix: -l
  - id: num_threads
    type:
      - 'null'
      - int
    doc: num threads(default=1)
    inputBinding:
      position: 101
      prefix: -n
  - id: termination_symbol
    type:
      - 'null'
      - string
    doc: symbol of termination in blueprint(default='*')
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output aligned nucleotide sequences file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyloaln:1.1.0--hdfd78af_0
