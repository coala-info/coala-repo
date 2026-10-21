cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rtg
  - sdfsubseq
label: rtg-tools_rtg_sdfsubseq
doc: 'Prints a subsequence of a given sequence in an SDF. Tool homepage: https://github.com/RealTimeGenomics/rtg-tools'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input
    type: Directory
    doc: 'input SDF'
    inputBinding:
      position: 101
      prefix: --input
  - id: sequence_id
    type:
      - 'null'
      - boolean
    doc: 'if set, use sequence id instead of sequence name in region (0-based)'
    inputBinding:
      position: 101
      prefix: --sequence-id
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: 'if set, output in FASTA format'
    inputBinding:
      position: 101
      prefix: --fasta
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: 'if set, output in FASTQ format'
    inputBinding:
      position: 101
      prefix: --fastq
  - id: reverse_complement
    type:
      - 'null'
      - boolean
    doc: 'if set, output in reverse complement'
    inputBinding:
      position: 101
      prefix: --reverse-complement
  - id: region
    type:
      type: array
      items: string
    doc: 'the range to display. The format is one of <sequence_name>, <sequence_name>:<start>-<end>, <sequence_name>:<pos>+<length> or <sequence_name>:<pos>~<padding>. Must be specified 1 or more times'
    inputBinding:
      position: 200
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
stdout: rtg-tools_rtg_sdfsubseq.out
