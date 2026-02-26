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
outputs:
  - id: forward_output
    type: File
    doc: First read output fastq
    outputBinding:
      glob: $(inputs.forward_output)
  - id: reverse_output
    type: File
    doc: Second read output fastq
    outputBinding:
      glob: $(inputs.reverse_output)
  - id: forward_discarded
    type:
      - 'null'
      - File
    doc: First read discarded fastq
    outputBinding:
      glob: $(inputs.forward_discarded)
  - id: reverse_discarded
    type:
      - 'null'
      - File
    doc: Second read discarded fastq
    outputBinding:
      glob: $(inputs.reverse_discarded)
  - id: merged_output
    type:
      - 'null'
      - File
    doc: Merged output fastq
    outputBinding:
      glob: $(inputs.merged_output)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/seqprep:v1.3.2-3-deb_cv1
