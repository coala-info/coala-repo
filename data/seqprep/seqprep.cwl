cwlVersion: v1.2
class: CommandLineTool
baseCommand: SeqPrep
label: seqprep
doc: "SeqPrep is a program to merge paired end reads and strip adapters. It looks
  for an adapter sequence and/or an overlap between the two reads of a pair and uses
  this information to merge the reads or strip the adapter.\n\nTool homepage: https://github.com/jstjohn/SeqPrep"
inputs:
  - id: forward_adapter
    type:
      - 'null'
      - string
    doc: Forward adapter sequence
    inputBinding:
      position: 101
      prefix: -A
  - id: forward_fastq
    type: File
    doc: First read input fastq
    inputBinding:
      position: 101
      prefix: -f
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length of read to keep
    inputBinding:
      position: 101
      prefix: -L
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: Minimum overlap required to merge two reads
    inputBinding:
      position: 101
      prefix: -O
  - id: quality_cutoff
    type:
      - 'null'
      - int
    doc: Quality score cutoff
    inputBinding:
      position: 101
      prefix: -q
  - id: reverse_adapter
    type:
      - 'null'
      - string
    doc: Reverse adapter sequence
    inputBinding:
      position: 101
      prefix: -B
  - id: reverse_fastq
    type: File
    doc: Second read input fastq
    inputBinding:
      position: 101
      prefix: -r
  - id: forward_discarded_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `forward_discarded_path`
    inputBinding:
      position: 102
      prefix: --forward-discarded
  - id: forward_output_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `forward_output_path`
    inputBinding:
      position: 103
      prefix: --forward-output
  - id: merged_output_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `merged_output_path`
    inputBinding:
      position: 104
      prefix: --merged-output
  - id: reverse_discarded_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `reverse_discarded_path`
    inputBinding:
      position: 105
      prefix: --reverse-discarded
  - id: reverse_output_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `reverse_output_path`
    inputBinding:
      position: 106
      prefix: --reverse-output
outputs:
  - id: forward_output
    type: File
    doc: First read output fastq
    outputBinding:
      glob: $(inputs.forward_output_path)
  - id: reverse_output
    type: File
    doc: Second read output fastq
    outputBinding:
      glob: $(inputs.reverse_output_path)
  - id: forward_discarded
    type:
      - 'null'
      - File
    doc: First read discarded fastq
    outputBinding:
      glob: $(inputs.forward_discarded_path)
  - id: reverse_discarded
    type:
      - 'null'
      - File
    doc: Second read discarded fastq
    outputBinding:
      glob: $(inputs.reverse_discarded_path)
  - id: merged_output
    type:
      - 'null'
      - File
    doc: Merged output fastq
    outputBinding:
      glob: $(inputs.merged_output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/seqprep:v1.3.2-3-deb_cv1
