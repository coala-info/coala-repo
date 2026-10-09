cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - je
  - dropseq
label: je-suite_dropseq
doc: "Reformats Drop-seq files into a single fastq file: clips the cell barcode and UMI from read 1 and\
  \ adds them to the header of read 2.\n\nTool homepage: https://gbcs.embl.de/Je"
inputs:
  - id: fastq_file1
    type: File
    doc: Input fastq file (optionally gzipped) for first read. This read contains the cell barcode followed
      by the UMI. Quality encoding must be Phred+33 (Standard).
    inputBinding:
      position: 1
      prefix: FASTQ_FILE1=
      separate: false
  - id: fastq_file2
    type: File
    doc: Input fastq file (optionally gzipped) for the second read. Quality encoding must be Phred+33
      (Standard).
    inputBinding:
      position: 2
      prefix: FASTQ_FILE2=
      separate: false
  - id: bclen
    type: int
    doc: Length of the cell barcode sequence in read 1.
    inputBinding:
      position: 3
      prefix: BCLEN=
      separate: false
  - id: with_quality_in_readname
    type:
      - 'null'
      - boolean
    doc: 'Should quality string of barcode and UMI also be injected in read names. If true, the quality
      string is translated into 2 digits number and a e.g. UMI will look like ''...:ATGCAT333423212322:...''
      instead of ''...:ATGCAT:...'' This option is particularly useful with the retag module that knows
      how to extract quality numbers into BAM tags. Possible values: {true, false}'
    inputBinding:
      position: 4
      valueFrom: ${ if (self === null || self === undefined) { return null; } return "WITH_QUALITY_IN_READNAME="
        + self; }
  - id: uclen
    type: int
    doc: Length of the UMI sequence in read 1 found right after the cell barcode.
    inputBinding:
      position: 5
      prefix: UCLEN=
      separate: false
  - id: max_n
    type:
      - 'null'
      - int
    doc: Maximum number of N's in the cell barcode sequence. If the cell barcode has this number or more
      N in the sequence, the read is ignored.
    inputBinding:
      position: 6
      prefix: MAX_N=
      separate: false
  - id: read_name_replace_char
    type:
      - 'null'
      - string
    doc: 'Replace spaces in read name/header using provided character. This is needed when you need to
      retain ADDed barcode in read name/header during mapping as everything after space in read name is
      usually clipped in BAM files. For example, with RCHAR='':'' : ''@D3FCO8P1:178:C1WLBACXX:7:1101:1836:1965
      1:N:0:'' becomes ''@D3FCO8P1:178:C1WLBACXX:7:1101:1836:1965:1:N:0:BARCODE'''
    inputBinding:
      position: 7
      prefix: READ_NAME_REPLACE_CHAR=
      separate: false
  - id: result_filename_1
    type: string
    doc: Result file name with headers modified. Can either be a name (in which case the file will be
      created in the output dir) or a full path.
    inputBinding:
      position: 8
      prefix: RESULT_FILENAME_1=
      separate: false
  - id: force
    type:
      - 'null'
      - boolean
    doc: 'Allows overwriting existing files. Possible values: {true, false}'
    inputBinding:
      position: 9
      valueFrom: ${ if (self === null || self === undefined) { return null; } return "FORCE=" + self;
        }
  - id: gzip_outputs
    type:
      - 'null'
      - boolean
    doc: 'Compress output using gzip and append a .gz extension to the result filename if necessary. Possible
      values: {true, false}'
    inputBinding:
      position: 10
      valueFrom: ${ if (self === null || self === undefined) { return null; } return "GZIP_OUTPUTS=" +
        self; }
outputs:
  - id: result_filename_1_file
    type: File
    doc: Output file written to the path given in result_filename_1
    outputBinding:
      glob: $(inputs.result_filename_1)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/je-suite:2.0.RC--0
