cwlVersion: v1.2
class: CommandLineTool
baseCommand: eukfinder read_prep
label: eukfinder_read_prep
doc: "Description\n\nTool homepage: https://github.com/RogerLab/Eukfinder"
inputs:
  - id: centrifuge_database
    type:
      - 'null'
      - Directory
    doc: path to centrifuge database
    inputBinding:
      position: 101
      prefix: --cdb
  - id: head_crop
    type: int
    doc: head trim
    inputBinding:
      position: 101
      prefix: --hcrop
  - id: host_genome
    type: File
    doc: host genome to get map out
    inputBinding:
      position: 101
      prefix: --hg
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
  - id: min_hit_length
    type: int
    doc: minimum hit length
    inputBinding:
      position: 101
      prefix: --mhlen
  - id: min_length
    type: int
    doc: "minimum length of read after trimming to be kept by\n                  \
      \      trimmomatic"
    inputBinding:
      position: 101
      prefix: --mlen
  - id: out_name
    type: string
    doc: output file basename
    inputBinding:
      position: 101
      prefix: --out_name
  - id: quality_encoding
    type:
      - 'null'
      - string
    doc: quality encoding for trimmomatic
    inputBinding:
      position: 101
      prefix: --qenc
  - id: quality_score
    type: int
    doc: quality score for trimming
    inputBinding:
      position: 101
      prefix: --qscore
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
      prefix: --wsize
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eukfinder:1.2.4--py36h503566f_0
stdout: eukfinder_read_prep.out
