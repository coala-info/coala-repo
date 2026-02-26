cwlVersion: v1.2
class: CommandLineTool
baseCommand: eukfinder read_prep_env
label: eukfinder_read_prep_env
doc: "Prepare environment for eukfinder\n\nTool homepage: https://github.com/RogerLab/Eukfinder"
inputs:
  - id: cdb
    type: Directory
    doc: path to centrifuge database
    inputBinding:
      position: 101
      prefix: --cdb
  - id: centrifuge_database
    type: Directory
    doc: path to centrifuge database
    inputBinding:
      position: 101
      prefix: --centrifuge-database
  - id: hcrop
    type: int
    doc: head trim
    inputBinding:
      position: 101
      prefix: --hcrop
  - id: head_crop
    type: int
    doc: head trim
    inputBinding:
      position: 101
      prefix: --head-crop
  - id: illumina_clip
    type: File
    doc: adaptor file
    inputBinding:
      position: 101
      prefix: --illumina-clip
  - id: leading_trim
    type: int
    doc: leading trim
    inputBinding:
      position: 101
      prefix: --leading-trim
  - id: mhlen
    type: int
    doc: minimum hit length
    inputBinding:
      position: 101
      prefix: --mhlen
  - id: min_hit_length
    type: int
    doc: minimum hit length
    inputBinding:
      position: 101
      prefix: --min-hit-length
  - id: min_length
    type: int
    doc: minimum length of read after trimming to be kept by trimmomatic
    inputBinding:
      position: 101
      prefix: --min-length
  - id: mlen
    type: int
    doc: minimum length of read after trimming to be kept by trimmomatic
    inputBinding:
      position: 101
      prefix: --mlen
  - id: out_name
    type: string
    doc: output file basename
    inputBinding:
      position: 101
      prefix: --out_name
  - id: qenc
    type:
      - 'null'
      - string
    doc: quality encoding for trimmomatic
    inputBinding:
      position: 101
      prefix: --qenc
  - id: qscore
    type: int
    doc: quality score for trimming
    inputBinding:
      position: 101
      prefix: --qscore
  - id: quality_encoding
    type:
      - 'null'
      - string
    doc: quality encoding for trimmomatic
    inputBinding:
      position: 101
      prefix: --quality-encoding
  - id: quality_score
    type: int
    doc: quality score for trimming
    inputBinding:
      position: 101
      prefix: --quality-score
  - id: r1
    type: File
    doc: left reads
    inputBinding:
      position: 101
      prefix: --r1
  - id: r2
    type: File
    doc: right reads
    inputBinding:
      position: 101
      prefix: --r2
  - id: reads_r1
    type: File
    doc: left reads
    inputBinding:
      position: 101
      prefix: --reads-r1
  - id: reads_r2
    type: File
    doc: right reads
    inputBinding:
      position: 101
      prefix: --reads-r2
  - id: threads
    type: int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: trail_trim
    type: int
    doc: trail trim
    inputBinding:
      position: 101
      prefix: --trail-trim
  - id: window_size
    type: int
    doc: sliding window size
    inputBinding:
      position: 101
      prefix: --window-size
  - id: wsize
    type: int
    doc: sliding window size
    inputBinding:
      position: 101
      prefix: --wsize
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eukfinder:1.2.4--py36h503566f_0
stdout: eukfinder_read_prep_env.out
