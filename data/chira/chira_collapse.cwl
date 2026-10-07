cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chira_collapse.py
label: chira_collapse
doc: "Chimeric Read Annotator: collapse FASTQ reads to FASTA format\n\nTool homepage: https://github.com/pavanvidem/chira/"
inputs:
  - id: fastq
    type: File
    doc: "Input fastq file"
    inputBinding:
      position: 1
      prefix: --fastq
  - id: fasta
    type: string
    doc: "Output fasta file"
    default: "collapsed.fasta"
    inputBinding:
      position: 1
      prefix: --fasta
  - id: umi_len
    type:
      - 'null'
      - int
    doc: "Length of the UMI, if present. It is trimmed from the 5' end of each read and appended to the tag id (default: 0)"
    inputBinding:
      position: 1
      prefix: --umi_len
outputs:
  - id: collapsed_fasta
    type: File
    doc: "Collapsed reads in FASTA format"
    outputBinding:
      glob: $(inputs.fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chira:1.4.3--hdfd78af_2
