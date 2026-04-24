cwlVersion: v1.2
class: CommandLineTool
baseCommand: clone_filter
label: stacks_clone_filter
doc: "You must specify an input file of a directory path to a set of input files.\n\
  \nTool homepage: https://catchenlab.life.illinois.edu/stacks/"
inputs:
  - id: capture_discarded
    type:
      - 'null'
      - boolean
    doc: capture discarded reads to a file.
    inputBinding:
      position: 101
      prefix: -D
  - id: index_index
    type:
      - 'null'
      - boolean
    doc: random oligo is provded in FASTQ header (Illumina i5 and i7 read).
    inputBinding:
      position: 101
      prefix: --index-index
  - id: index_inline
    type:
      - 'null'
      - boolean
    doc: random oligo occurs in FASTQ header (Illumina i5 or i7 read) and is 
      inline with sequence on single-end read (if single read data) or 
      paired-end read (if paired data).
    inputBinding:
      position: 101
      prefix: --index-inline
  - id: index_null
    type:
      - 'null'
      - boolean
    doc: random oligo is provded in FASTQ header (Illumina i5 or i7 read).
    inputBinding:
      position: 101
      prefix: --index-null
  - id: inline_index
    type:
      - 'null'
      - boolean
    doc: random oligo is inline with sequence on single-end read and second 
      oligo occurs in FASTQ header.
    inputBinding:
      position: 101
      prefix: --inline-index
  - id: inline_inline
    type:
      - 'null'
      - boolean
    doc: random oligo is inline with sequence, occurs on single and paired-end 
      read.
    inputBinding:
      position: 101
      prefix: --inline-inline
  - id: inline_null
    type:
      - 'null'
      - boolean
    doc: random oligo is inline with sequence, occurs only on single-end read 
      (default).
    inputBinding:
      position: 101
      prefix: --inline-null
  - id: input_dir
    type:
      - 'null'
      - Directory
    doc: path to a directory of files.
    inputBinding:
      position: 101
      prefix: -p
  - id: input_file
    type:
      - 'null'
      - File
    doc: path to the input file if processing single-end sequences.
    inputBinding:
      position: 101
      prefix: -f
  - id: input_type
    type:
      - 'null'
      - string
    doc: input file type, either 'bustard', 'fastq', 'fasta', 'gzfasta', or 
      'gzfastq'
    inputBinding:
      position: 101
      prefix: -i
  - id: null_index
    type:
      - 'null'
      - boolean
    doc: random oligo is provded in FASTQ header (Illumina i7 read if both i5 
      and i7 read are provided).
    inputBinding:
      position: 101
      prefix: --null-index
  - id: null_inline
    type:
      - 'null'
      - boolean
    doc: random oligo is inline with sequence, occurs only on the paired-end 
      read.
    inputBinding:
      position: 101
      prefix: --null-inline
  - id: oligo_len_1
    type:
      - 'null'
      - int
    doc: length of the single-end oligo sequence in data set.
    inputBinding:
      position: 101
      prefix: --oligo-len-1
  - id: oligo_len_2
    type:
      - 'null'
      - int
    doc: length of the paired-end oligo sequence in data set.
    inputBinding:
      position: 101
      prefix: --oligo-len-2
  - id: output_type
    type:
      - 'null'
      - string
    doc: output type, either 'fastq', 'fasta', 'gzfasta', or 'gzfastq' (default 
      same as input type).
    inputBinding:
      position: 101
      prefix: -y
  - id: pair_1
    type:
      - 'null'
      - File
    doc: first input file in a set of paired-end sequences.
    inputBinding:
      position: 101
      prefix: '-1'
  - id: pair_2
    type:
      - 'null'
      - File
    doc: second input file in a set of paired-end sequences.
    inputBinding:
      position: 101
      prefix: '-2'
  - id: paired_input_dir
    type:
      - 'null'
      - boolean
    doc: files contained within directory specified by '-p' are paired.
    inputBinding:
      position: 101
      prefix: -P
  - id: retain_oligo
    type:
      - 'null'
      - boolean
    doc: do not trim off the random oligo sequence (if oligo is inline).
    inputBinding:
      position: 101
      prefix: --retain-oligo
outputs:
  - id: output_dir
    type: Directory
    doc: path to output the processed files.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stacks:2.68--h077b44d_3
