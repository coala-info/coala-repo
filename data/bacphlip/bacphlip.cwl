cwlVersion: v1.2
class: CommandLineTool
baseCommand: bacphlip
label: bacphlip
doc: "BACPHLIP is a tool for identifying prophages in bacterial genomes.\n\nTool homepage:
  https://github.com/adamhockenberry/bacphlip"
inputs:
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: Whether to overwrite all existing files that will be created if they 
      exist.
    default: false
    inputBinding:
      position: 101
      prefix: --force_overwrite
  - id: input_file
    type: File
    doc: Should be a valid path to a single genome (nucleotide) FASTA file 
      containing only 1 record/contig.
    inputBinding:
      position: 101
      prefix: --input_file
  - id: local_hmmsearch
    type:
      - 'null'
      - File
    doc: By default, BACPHLIP assumes a system install of "hmmsearch". Use this 
      flag to provide a custom path to a local install of hmmsearch if 
      necessary.
    inputBinding:
      position: 101
      prefix: --local_hmmsearch
  - id: multi_fasta
    type:
      - 'null'
      - boolean
    doc: By default, BACPHLIP assumes that the input file contains one genome 
      (nucleotide) sequence record. Users providing a multi_fasta input file 
      must use this flag. Note that each record should be uniquely named and 
      should contain complete genomes for different phages. BACPHLIP should not 
      be run on incomplete / fragmented genomes spanning mulitple records.
    inputBinding:
      position: 101
      prefix: --multi_fasta
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bacphlip:0.9.6--py_0
stdout: bacphlip.out
