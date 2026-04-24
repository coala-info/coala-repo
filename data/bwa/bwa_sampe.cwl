cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwa
  - sampe
label: bwa_sampe
doc: "Generate alignments in the SAM format given paired-end reads.\n\nTool homepage:
  https://github.com/lh3/bwa"
inputs:
  - id: prefix
    type: string
    doc: Prefix of the BWA index
    inputBinding:
      position: 1
  - id: sai_file1
    type: File
    doc: SAI file for the first read
    inputBinding:
      position: 2
  - id: sai_file2
    type: File
    doc: SAI file for the second read
    inputBinding:
      position: 3
  - id: fastq_file1
    type: File
    doc: FASTQ file for the first read
    inputBinding:
      position: 4
  - id: fastq_file2
    type: File
    doc: FASTQ file for the second read
    inputBinding:
      position: 5
  - id: chimeric_rate
    type:
      - 'null'
      - float
    doc: prior of chimeric rate (lower bound)
    inputBinding:
      position: 106
      prefix: -c
  - id: disable_insert_size_estimate
    type:
      - 'null'
      - boolean
    doc: disable insert size estimate (force -s)
    inputBinding:
      position: 106
      prefix: -A
  - id: disable_sw
    type:
      - 'null'
      - boolean
    doc: disable Smith-Waterman for the unmapped mate
    inputBinding:
      position: 106
      prefix: -s
  - id: max_hits_discordant
    type:
      - 'null'
      - int
    doc: maximum hits to output for discordant pairs
    inputBinding:
      position: 106
      prefix: -N
  - id: max_hits_paired
    type:
      - 'null'
      - int
    doc: maximum hits to output for paired reads
    inputBinding:
      position: 106
      prefix: -n
  - id: max_insert_size
    type:
      - 'null'
      - int
    doc: maximum insert size
    inputBinding:
      position: 106
      prefix: -a
  - id: max_occurrences
    type:
      - 'null'
      - int
    doc: maximum occurrences for one end
    inputBinding:
      position: 106
      prefix: -o
  - id: preload_index
    type:
      - 'null'
      - boolean
    doc: preload index into memory (for base-space reads only)
    inputBinding:
      position: 106
      prefix: -P
  - id: read_group
    type:
      - 'null'
      - string
    doc: read group header line such as '@RG\tID:foo\tSM:bar'
    inputBinding:
      position: 106
      prefix: -r
outputs:
  - id: output_sam
    type:
      - 'null'
      - File
    doc: sam file to output results to
    outputBinding:
      glob: $(inputs.output_sam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwa:0.7.19--h577a1d6_1
