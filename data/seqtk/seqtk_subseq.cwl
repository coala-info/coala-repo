cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqtk
  - subseq
label: seqtk_subseq
doc: "Extract subsequences from FASTA/FASTQ files using a BED file or a list of names\n
  \nTool homepage: https://github.com/lh3/seqtk"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA/FASTQ file
    inputBinding:
      position: 1
  - id: input_bed_or_list
    type: File
    doc: Input BED file or list of sequence names
    inputBinding:
      position: 2
  - id: line_length
    type:
      - 'null'
      - int
    doc: sequence line length
    default: 0
    inputBinding:
      position: 103
      prefix: -l
  - id: strand_aware
    type:
      - 'null'
      - boolean
    doc: strand aware
    inputBinding:
      position: 103
      prefix: -s
  - id: tab_delimited
    type:
      - 'null'
      - boolean
    doc: TAB delimited output
    inputBinding:
      position: 103
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqtk:1.5--h577a1d6_1
stdout: seqtk_subseq.out
