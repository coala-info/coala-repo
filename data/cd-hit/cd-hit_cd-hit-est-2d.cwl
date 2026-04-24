cwlVersion: v1.2
class: CommandLineTool
baseCommand: cd-hit-est-2d
label: cd-hit_cd-hit-est-2d
doc: "Compare two nucleotide datasets (db1 and db2) and identify sequences in db2
  that are similar to db1.\n\nTool homepage: https://github.com/weizhongli/cdhit"
inputs:
  - id: alignment_coverage_control
    type:
      - 'null'
      - float
    doc: Alignment coverage for the longer sequence
    inputBinding:
      position: 101
      prefix: -aL
  - id: alignment_coverage_shorter
    type:
      - 'null'
      - float
    doc: Alignment coverage for the shorter sequence
    inputBinding:
      position: 101
      prefix: -aS
  - id: global_identity
    type:
      - 'null'
      - int
    doc: Use global sequence identity, default 1 (yes)
    inputBinding:
      position: 101
      prefix: -G
  - id: input_file_1
    type: File
    doc: Input filename for sequence database 1 in fasta format
    inputBinding:
      position: 101
      prefix: -i
  - id: input_file_2
    type: File
    doc: Input filename for sequence database 2 in fasta format
    inputBinding:
      position: 101
      prefix: -i2
  - id: length_difference_cutoff
    type:
      - 'null'
      - int
    doc: Length difference cutoff, default 999999
    inputBinding:
      position: 101
      prefix: -S
  - id: length_difference_cutoff_fraction
    type:
      - 'null'
      - float
    doc: Length difference cutoff fraction, default 0.0
    inputBinding:
      position: 101
      prefix: -s
  - id: memory_limit
    type:
      - 'null'
      - int
    doc: Memory limit (in MB) for the program, default 400; 0 for unlimited
    inputBinding:
      position: 101
      prefix: -M
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads, default 1; with 0, all CPUs will be used
    inputBinding:
      position: 101
      prefix: -T
  - id: threshold
    type:
      - 'null'
      - float
    doc: Sequence identity threshold, default 0.9
    inputBinding:
      position: 101
      prefix: -c
  - id: word_length
    type:
      - 'null'
      - int
    doc: Word length, default 10 for threshold 0.95-1.0, 8 for 0.9-0.95, 7 for 0.88-0.9
    inputBinding:
      position: 101
      prefix: -n
outputs:
  - id: output_file
    type: File
    doc: Output filename
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cd-hit:4.8.1--h5ca1c30_13
