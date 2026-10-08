cwlVersion: v1.2
class: CommandLineTool
baseCommand: splitrim
label: gottcha_splitrim
doc: "Splits single-end FASTQ reads at low-quality bases and trims the fragments
  to a fixed or minimum length (the split-trimming step of GOTTCHA).\n\nTool homepage:
  https://github.com/poeli/GOTTCHA"
inputs:
  - id: in_file
    type: File
    doc: Name of the FASTQ file containing all the single-end reads
    inputBinding:
      position: 1
      prefix: --inFile=
      separate: false
  - id: min_l
    type:
      - 'null'
      - int
    doc: Minimum length for a trimmed read to be considered valid [default 0]
    inputBinding:
      position: 2
      prefix: --minL=
      separate: false
  - id: fix_l
    type:
      - 'null'
      - int
    doc: Fixed length to which each trimmed read will be cut down to [default 
      disabled]
    inputBinding:
      position: 3
      prefix: --fixL=
      separate: false
  - id: recycle
    type:
      - 'null'
      - boolean
    doc: When --fixL is specified and a read length is not a multiple of fixL, 
      append the remaining bases to the last fragment of length fixL
    inputBinding:
      position: 4
      prefix: --recycle
  - id: ascii
    type:
      - 'null'
      - int
    doc: ASCII encoding (33 or 64) [default 33]
    inputBinding:
      position: 5
      prefix: --ascii=
      separate: false
  - id: min_q
    type:
      - 'null'
      - int
    doc: Minimum quality for a read to be considered valid (0-41) [default 10]
    inputBinding:
      position: 6
      prefix: --minQ=
      separate: false
  - id: threads
    type:
      - 'null'
      - int
    doc: No. of threads to use (disabled in this version) [default 1]
    inputBinding:
      position: 7
      prefix: --threads=
      separate: false
  - id: out_path
    type: string
    doc: Location output files will be placed
    default: splitrim_out
    inputBinding:
      position: 8
      prefix: --outPath=
      separate: false
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix of output files
    inputBinding:
      position: 9
      prefix: --prefix=
      separate: false
  - id: out_encoding
    type:
      - 'null'
      - int
    doc: ASCII encoding of the output (33 or 64) [default mirrors input]
    inputBinding:
      position: 10
      prefix: --outEncoding=
      separate: false
  - id: stats
    type:
      - 'null'
      - string
    doc: Basic read statistics output file name [default uses basename from 
      --inFile]
    inputBinding:
      position: 11
      prefix: --stats=
      separate: false
  - id: histo
    type:
      - 'null'
      - string
    doc: Post-trim read length histogram file name [default uses basename from 
      --inFile]
    inputBinding:
      position: 12
      prefix: --histo=
      separate: false
  - id: sort_len_asc
    type:
      - 'null'
      - boolean
    doc: Sort read length frequency table in ascending order
    inputBinding:
      position: 13
      prefix: --sortLenAsc
  - id: sort_len_desc
    type:
      - 'null'
      - boolean
    doc: Sort read length frequency table in descending order
    inputBinding:
      position: 14
      prefix: --sortLenDesc
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbosity level
    inputBinding:
      position: 15
      prefix: --verbose
outputs:
  - id: out_dir
    type: Directory
    doc: Directory with the split-trimmed FASTQ, statistics and histogram files
    outputBinding:
      glob: $(inputs.out_path)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gottcha:1.0--pl526_2
stdout: gottcha_splitrim.out
