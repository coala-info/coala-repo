cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - je
  - clip
label: je-suite_clip
doc: "Reads records in the supplied FASTQ file(s) according to specified read layouts (RL option) and\
  \ writes output FASTQ file(s) according to supplied output layouts (OL option).\n\nTool homepage: https://gbcs.embl.de/Je"
inputs:
  - id: fastq
    type:
      type: array
      items: File
      inputBinding:
        prefix: FASTQ=
        separate: false
    doc: Input fastq file (optionally gzipped)
    inputBinding:
      position: 1
  - id: read_layout
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: READ_LAYOUT=
          separate: false
    doc: 'Describes the read layout(s) e.g. ''RL=<BARCODE1:6><SAMPLE:x>'' of input fastq file(s). The
      input fastq files and read layouts are mached up by order on the command line. Read layouts are
      only needed for complex layouts but one must provide read layouts for ALL or NONE of the input fastq
      files. Read layouts are made of <UMIn:X>, <BARCODEn:X>, <SAMPLEn:X> blocks to describe blocks of
      type UMI, BARCODE or SAMPLE with : * ''n'' the unique block index (an index must be unique across
      all read layouts for each index or each block type), use the same index to specify redundant blocks
      e.g. use <BARCODE1:6> in two different layouts to specify that the barcode found in both reads are
      the same * ''X'' : either a number indicating the length of the UMI, BARCODE or SAMPLE block or
      a negative number e.g. -2 to specify the last 2 bases should be ignored/clipped) or the letter ''x''
      to specify to take the sequence till the end of read. Importantly, the ''x'' or negative length
      shotcut can only be used in the last block of a read layout (i.e. <BARCODE1:x><SAMPLE1:20> is not
      allowed)'
    inputBinding:
      position: 2
  - id: output_layout
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: OUTPUT_LAYOUT=
          separate: false
    doc: 'Describes the output file layout(s) using the slots defined in read layouts and '':'' to delimitate
      three parts e.g. ''OL=1::'' : 1.The number in the first part (i.e. from ''1:'' above) is the output
      file index and it must be unique across all ''OL'' inputs. Inferred from order in comamnd line when
      not given 2.The second part (i.e. '''' above) is the read header layout ; when writing multiple
      UMI and BARCODE slots in output read headers, these are always separated with the RCHAR ('':'' by
      defaults). 3.The third part (i.e. '''' above) is the read sequence layout.'
    inputBinding:
      position: 3
  - id: with_quality_in_readname
    type:
      - 'null'
      - boolean
    doc: 'Should quality string also be injected in read names. Only applies to READBAR and UMI described
      in the read name slot of output layout If turned on, the quality string is translated into 2 digits
      number and a e.g. UMI will look like ''...:ATGCAT333423212322:...'' instead of ''...:ATGCAT:...''
      This option is particularly useful with the retag module that knows how to extract quality numbers
      into BAM tags. Possible values: {true, false}'
    inputBinding:
      position: 4
      valueFrom: ${ if (self === null || self === undefined) { return null; } return "WITH_QUALITY_IN_READNAME="
        + self; }
  - id: add_layout_idx_in_output_filename
    type:
      - 'null'
      - boolean
    doc: 'Should the output layout number (output layout first slot) be injected in the filename ? Only
      used in absence of explicit file names in the barcode file. Possible values: {true, false}'
    inputBinding:
      position: 5
      valueFrom: ${ if (self === null || self === undefined) { return null; } return "ADD_LAYOUT_IDX_IN_OUTPUT_FILENAME="
        + self; }
  - id: add_header_layout_in_output_filename
    type:
      - 'null'
      - boolean
    doc: 'Should the output layout used for the read name (output layout second slot,in short format)
      be injected in the filename ? When true, each ouput file name contains e.g. ''_B1U1'' for OL=''1::''
      Only used in absence of explicit file names in the barcode file. Possible values: {true, false}'
    inputBinding:
      position: 6
      valueFrom: ${ if (self === null || self === undefined) { return null; } return "ADD_HEADER_LAYOUT_IN_OUTPUT_FILENAME="
        + self; }
  - id: add_sequence_layout_in_output_filename
    type:
      - 'null'
      - boolean
    doc: 'Should the output layout used for the read sequence (output layout third slot, in short format)
      be injected in the filename ?When true, each ouput file name contains e.g. ''_S1'' for OL=''1::''
      Only used in absence of explicit file names in the barcode file. Possible values: {true, false}'
    inputBinding:
      position: 7
      valueFrom: ${ if (self === null || self === undefined) { return null; } return "ADD_SEQUENCE_LAYOUT_IN_OUTPUT_FILENAME="
        + self; }
  - id: output_dir
    type:
      - 'null'
      - string
    doc: Output directory. By default, output files are written in running directory. A new directory
      in the working directory; collected as output_directory.
    inputBinding:
      position: 8
      prefix: OUTPUT_DIR=
      separate: false
    default: je_out
  - id: force
    type:
      - 'null'
      - boolean
    doc: 'Allows to overwrite existing files (system rights still apply). Possible values: {true, false}'
    inputBinding:
      position: 9
      valueFrom: ${ if (self === null || self === undefined) { return null; } return "FORCE=" + self;
        }
  - id: gzip_outputs
    type:
      - 'null'
      - boolean
    doc: 'Compress output files using gzip. Possible values: {true, false}'
    inputBinding:
      position: 10
      valueFrom: ${ if (self === null || self === undefined) { return null; } return "GZIP_OUTPUTS=" +
        self; }
  - id: read_name_separator_char
    type:
      - 'null'
      - string
    doc: Separator character used to concatenate barcodes and umis in read header
    inputBinding:
      position: 11
      prefix: READ_NAME_SEPARATOR_CHAR=
      separate: false
  - id: quality_format
    type:
      - 'null'
      - string
    doc: 'A value describing how the quality values are encoded in the fastq files. Either ''Solexa''
      for pre-pipeline 1.3 style scores (solexa scaling + 66), ''Illumina'' for pipeline 1.3 and above
      (phred scaling + 64) or ''Standard'' for phred scaled scores with a character shift of 33. If this
      value is not specified (or ''null'' is given), the quality format is assumed to be will the ''Standard''
      for phred scale.Possible values: {Solexa, Illumina, Standard}'
    inputBinding:
      position: 12
      prefix: QUALITY_FORMAT=
      separate: false
  - id: fastq_file_extension
    type:
      - 'null'
      - string
    doc: Change the default extension of created fastq files, eg 'fastqsanger'. By default uses the file
      extension from input fastq file. If result file names are given in the barcode file, this option
      is only used to adapt the unassigned file names. When using compression, a .gz is always appended
      to file names and should not be specified in FASTQ_FILE_EXTENSION i.e. use FASTQ_FILE_EXTENSION=fastq
      and NOT FASTQ_FILE_EXTENSION=fastq.gz
    inputBinding:
      position: 13
      prefix: FASTQ_FILE_EXTENSION=
      separate: false
  - id: writer_factory_use_async_io
    type:
      - 'null'
      - boolean
    doc: 'Use one thread per Fastq Writer. Possible values: {true, false}[help] je clip: ok via je clip
      --help (--help=ok, -h=ok, -help=ok, (no args)=ok)'
    inputBinding:
      position: 14
      valueFrom: ${ if (self === null || self === undefined) { return null; } return "WRITER_FACTORY_USE_ASYNC_IO="
        + self; }
outputs:
  - id: output_directory
    type: Directory
    doc: Output directory with the result files
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/je-suite:2.0.RC--0
