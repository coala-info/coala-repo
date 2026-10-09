cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - je
  - demultiplex-illu
label: je-suite_demultiplex-illu
doc: "Demultiplexes fastq file(s) using Illumina index files with the Je 1.x implementation, with optional\
  \ handling of molecular barcodes.\n\nTool homepage: https://gbcs.embl.de/Je"
inputs:
  - id: fastq_file1
    type: File
    doc: Input fastq file (optionally gzipped) for single end data, or first read in paired end data.
    inputBinding:
      position: 1
      prefix: FASTQ_FILE1=
      separate: false
  - id: fastq_file2
    type:
      - 'null'
      - File
    doc: Input fastq file (optionally gzipped) for the second read of paired end data.
    inputBinding:
      position: 2
      prefix: FASTQ_FILE2=
      separate: false
  - id: index_file1
    type: File
    doc: Fastq file for index 1 (barcode) reads, optionally gzipped.
    inputBinding:
      position: 3
      prefix: INDEX_FILE1=
      separate: false
  - id: index_file2
    type:
      - 'null'
      - File
    doc: Fastq file for index 2 (barcode) reads, optionally gzipped. A INDEX_FILE1 MUST be provided when
      INDEX_FILE2 is given. This situation corresponds to Illumina dual indexing.
    inputBinding:
      position: 4
      prefix: INDEX_FILE2=
      separate: false
  - id: barcode_file
    type:
      - 'null'
      - File
    doc: 'Barcode file describing sequence list and sample names. Tab-delimited file with 2 columns, with
      the sample in col1 and the corresponding barcode in col2. Simple barcode file format : 2 tab-delimited
      colums If multiple barcode map to the same sample, either line can be duplicated e.g. sample1 ATAT
      sample1 GAGG sample2 CCAA sample2 TGTG Or barcodes can be combined using the OR operator ''|'' i.e.
      the file above can be re-written like sample1 ATAT|GAGG sample2 CCAA|TGTG Finally, for the special
      situation of paired-end data in which barcodes differ at both ends (ie BPOS=BOTH BRED=false BM=BOTH
      , see BRED option description), barcodes for read_1 and read_2 can be distinguished using a '':''
      separator i.e. sample1 ATAT:GAGG sample2 CCAA:TGTG This above syntax means that sample 1 is encoded
      with ATAT barcode at read_1 AND GAGG barcode at read_2. Note that you can still combine barcodes
      using | e.g. sample1 ATAT|GAGG:CCAA|TGTG would mean that sample 1 is mapped by the combination of
      barcode: ATAT OR GAGG at read_1 AND CCAA OR TGTG at read_2. Extended barcode file format : 3 (single-end)
      or 4 (paired-end) tab-delimited colums same as the simple barcode file format but the extra columns
      contains the file name(s) to use to name output files. A unique extra column is expected for single-end
      while 2 extra columns are expected for paired-end. In case, lines are duplicated (multiple barcodesmapping
      the same sample), the same file name should be indicated in the third (and fourth) column(s). sample1
      ATAT spl1_1.txt.gz spl1_2.txt.gz sample1 GAGG spl1_1.txt.gz spl1_2.txt.gz sample2 CCAA spl2_1.txt.gz
      spl2_2.txt.gz Or sample1 ATAT|GAGG:CCAA|TGTG spl1_1.txt.gz spl1_2.txt.gz Ns in barcode sequence
      are allowed and are used to flag positions that should be ignored in sample matching i.e. they will
      be clipped off the read sequence (like in iCLIP protocol). Required. Cannot be used in conjuction
      with option(s) USE_EMBASE (EM)'
    inputBinding:
      position: 5
      prefix: BARCODE_FILE=
      separate: false
  - id: barcode_read_pos
    type:
      - 'null'
      - string
    doc: 'Indicates the location of additional barcodes present in the read(s). Setting this option implies
      setting the LEN option. Importantly, these additional barcodes must not encode sample identity information
      but used for e.g. molecular barcoding (UMIs) or for any purpose other than sample identity encoding.
      Possible values: {READ_1, READ_2, BOTH, NONE}'
    inputBinding:
      position: 6
      prefix: BARCODE_READ_POS=
      separate: false
  - id: bclen
    type:
      - 'null'
      - string
    doc: Length of the additional barcodes present in the read(s) as indicated by the BPOS option. Two
      distinct length can be provided using the syntax LEN=X:Z where X and Z are 2 integers representing
      the barcode length for read_1 and read_2 respectively. Only relevant when BPOS != NONE.
    inputBinding:
      position: 7
      prefix: BCLEN=
      separate: false
  - id: redundant_barcodes
    type:
      - 'null'
      - boolean
    doc: 'This option only applies for paired-end data with *both* INDEX_FILE1 and INDEX_FILE2 provided.
      Indicates if both index barcodes encode redundant information i.e. if both barcodes are supposed
      to be identical (or resolve to the same sample when a pool of barcodes is used per sample). When
      BRED=true, the STRICT option guides the sample lookup behavior When BRED=false, barcodes are combined
      prior to sample lookup. Possible values: {true, false}'
    inputBinding:
      position: 8
      valueFrom: ${ if (self === null || self === undefined) { return null; } return "REDUNDANT_BARCODES="
        + self; }
  - id: strict
    type:
      - 'null'
      - boolean
    doc: 'For paired-end data and when two distinct barcodes/indices are used to encode samples, this
      option tells if both barcodes should resolve to the same sample. When true and if only one of the
      two reads has a barcode match, the read pair is ''unassigned''. When false and if only one of the
      two reads has a barcode match, the read pair is assigned to the corresponding sample When reads
      resolve to different samples, the read pair is always ''unassigned''. Possible values: {true, false}'
    inputBinding:
      position: 9
      valueFrom: ${ if (self === null || self === undefined) { return null; } return "STRICT=" + self;
        }
  - id: max_mismatches
    type:
      - 'null'
      - string
    doc: Maximum mismatches for a barcode to be considered a match. In situations where both barcodes
      are used for sample matching i.e. BPOS=BOTH BM=BOTH (or 2 INDEX_FILE given), two distinct values
      can be given here using the syntax MM=X:Z where X and Z are 2 integers to use for read_1 and read_2
      respectively. MM=null is like MM=0
    inputBinding:
      position: 10
      prefix: MAX_MISMATCHES=
      separate: false
  - id: min_mismatch_delta
    type:
      - 'null'
      - string
    doc: Minimum difference between the number of mismatches against the best and the second best barcode.
      When MMD is not respected, the read remains unassigned. When two distinct barcodes are used for
      sample matching (dual encoding), two distinct values can be given using the syntax MMD=X:Z where
      X and Z are 2 integers to use for first (e.g. from read_1 or index_1) MMD=null is like MMD=0
    inputBinding:
      position: 11
      prefix: MIN_MISMATCH_DELTA=
      separate: false
  - id: min_base_quality
    type:
      - 'null'
      - string
    doc: 'Minimum base quality during barcode matching: bases which quality is less than this cutoff are
      always considered as a mismatch.When two distinct barcodes are used for sample matching (dual encoding),
      two distinct values can be given using the syntax Q=X:Z where X and Z are 2 integers to use for
      first (e.g. from read_1 or index_1) and second barcode (e.g. from read_2 or index_2) respectively.
      Q=null is like Q=0.'
    inputBinding:
      position: 12
      prefix: MIN_BASE_QUALITY=
      separate: false
  - id: xtrimlen
    type:
      - 'null'
      - string
    doc: 'Optional extra number of base to be trimmed right after the barcode (only used if CLIP_BARCODE=true).
      When running paired-end, two distinct values can be given using the syntax XT=X:Z where X and Z
      are 2 integers to use for read_1 and read_2 respectively. Note that even when BPOS=READ_1 or BPOS=READ_2,
      a X:Y synthax can be given to trim the read w/o barcode as to end up with reads of the same length
      (note that this can also be operated using ZT). If a unique value is given, e.g. XT=1, while running
      paired-end the following rule applies : (1) BPOS=READ_1 or BPOS=READ_2, no trim is applied at the
      read w/o barcode (2) BPOS=BOTH, the value is used for both reads. Note that XT=null is like XT=0.'
    inputBinding:
      position: 13
      prefix: XTRIMLEN=
      separate: false
  - id: ztrimlen
    type:
      - 'null'
      - string
    doc: Optional extra number of bases to be trimmed from the read end i.e. 3' end. When running paired-end,
      two distinct values can be given here using the syntax ZT=X:Z where X and Z are 2 integers to use
      for read_1 and read_2 respectively. Note that even when BPOS=READ_1 or BPOS=READ_2, a X:Y synthax
      can be given to trim the read w/o barcode as to end up with reads of the same length (note that
      this can also be operated using XT). Note that if a single value is passed, the value always applies
      to both reads in paired-end mode without further consideration. ZT=null is like ZT=0.
    inputBinding:
      position: 14
      prefix: ZTRIMLEN=
      separate: false
  - id: clip_barcode
    type:
      - 'null'
      - boolean
    doc: 'Clip barcode sequence from read sequence, as well as XTRIMLEN (and ZTRIMLEN) bases if applicable,
      before writing to output file. If false, reads are written without modification to output file.
      Apply to both barcodes when BPOS=BOTH. Possible values: {true, false}'
    inputBinding:
      position: 15
      valueFrom: ${ if (self === null || self === undefined) { return null; } return "CLIP_BARCODE=" +
        self; }
  - id: add_barcode_to_header
    type:
      - 'null'
      - boolean
    doc: 'Add matched barcode at the end of the read header. Applies to both index when INDEX_FILE2 is
      also provided. First the sample encoding barcodes from I1 (and I2 when relevant) are added to the
      read headers like ''@D3FCO8P1:178:C1WLBACXX:7:1101:1836:1965 2:N:0:I1_BARCODE:I2_BARCODE'' Then,
      if BPOS!=NONE, the additional barcodes (UMIs) clipped from the read(s) are added to their own header,
      like ''@D3FCO8P1:178:C1WLBACXX:7:1101:1836:1965 2:N:0:I1_BARCODE:I2_BARCODE:CLIPPED_SEQ_FROMREAD''
      Possible values: {true, false}'
    inputBinding:
      position: 16
      valueFrom: ${ if (self === null || self === undefined) { return null; } return "ADD_BARCODE_TO_HEADER="
        + self; }
  - id: ensure_identical_header_names
    type:
      - 'null'
      - boolean
    doc: 'Makes sure that headers of both reads of a pair are identical, using the following read header
      pattern (for both reads of a pair) : ''@D3FCO8P1:178:C1WLBACXX:7:1101:1836:1965 I1_BARCODE:I2_BARCODE(if
      applicable)'':CLIPPED_SEQ_FROMREAD1:CLIPPED_SEQ_FROMREAD2 This option only makes sense in paired
      end mode and ADD=true. Some (if not all) mappers will indeed complain when the read headers are
      not identical. When molecular barcodes are present in reads and the RCHAR is used, you will end
      with (problematic) read headers like this : HISEQ:44:C6KC0ANXX:5:1101:1491:1994:1:N:0:TAGAACAC:TGGAGTAG
      HISEQ:44:C6KC0ANXX:5:1101:1491:1994:3:N:0:TAGAACAC:CGTTGTAT SAME_HEADERS=true will instead genetates
      the following identical header for both reads : HISEQ:44:C6KC0ANXX:5:1101:1491:1994:TAGAACAC:TGGAGTAG:CGTTGTAT
      Note that we also clipped the useless ''1:N:0'' and ''3:N:0'' has they will also result in generating
      different headers Important : this option will force RCHAR=: UNLESS you specify RCHAR=null ; in
      which case a space will be preserved ie : HISEQ:44:C6KC0ANXX:5:1101:1491:1994 TAGAACAC:TGGAGTAG:CGTTGTAT
      Possible values: {true, false}'
    inputBinding:
      position: 17
      valueFrom: ${ if (self === null || self === undefined) { return null; } return "ENSURE_IDENTICAL_HEADER_NAMES="
        + self; }
  - id: read_name_replace_char
    type:
      - 'null'
      - string
    doc: 'Replace spaces in read name/header using provided character. This is particularly handy when
      you need to retain ADDed barcode in read name/header during mapping (everything after space in read
      name is usually clipped in BAM files). For example, with RCHAR='':'' : ''@D3FCO8P1:178:C1WLBACXX:7:1101:1836:1965
      2:N:0:'' becomes ''@D3FCO8P1:178:C1WLBACXX:7:1101:1836:1965:2:N:0:BARCODE'''
    inputBinding:
      position: 18
      prefix: READ_NAME_REPLACE_CHAR=
      separate: false
  - id: quality_format
    type:
      - 'null'
      - string
    doc: 'A value describing how the quality values are encoded in the fastq. Either ''Solexa'' for pre-pipeline
      1.3 style scores (solexa scaling + 66), ''Illumina'' for pipeline 1.3 and above (phred scaling +
      64) or ''Standard'' for phred scaled scores with a character shift of 33. If this value is not specified
      (or ''null'' is given), the quality format will be detected. Possible values: {Solexa, Illumina,
      Standard}'
    inputBinding:
      position: 19
      prefix: QUALITY_FORMAT=
      separate: false
  - id: output_dir
    type:
      - 'null'
      - string
    doc: Output directory. By default, output files are written in running directory. A new directory
      in the working directory; collected as output_directory.
    inputBinding:
      position: 20
      prefix: OUTPUT_DIR=
      separate: false
    default: je_out
  - id: keep_unassigned_read
    type:
      - 'null'
      - boolean
    doc: 'Should un-assigned reads be saved in files or simply ignored. File names are automatically created
      or can be given using UF1 & UF2 options. Possible values: {true, false}'
    inputBinding:
      position: 21
      valueFrom: ${ if (self === null || self === undefined) { return null; } return "KEEP_UNASSIGNED_READ="
        + self; }
  - id: unassigned_file_name_1
    type:
      - 'null'
      - string
    doc: Name of the file in which to write unassigned reads from FILE1.Either a name (in which case the
      file will be created in the output dir) or full path.
    inputBinding:
      position: 22
      prefix: UNASSIGNED_FILE_NAME_1=
      separate: false
  - id: unassigned_file_name_2
    type:
      - 'null'
      - string
    doc: Name of the file in which to write unassigned reads from FILE2.Either a name (in which case the
      file will be created in the output dir) or full path.
    inputBinding:
      position: 23
      prefix: UNASSIGNED_FILE_NAME_2=
      separate: false
  - id: metrics_file_name
    type:
      - 'null'
      - string
    doc: File name where to write demultiplexing statistics. Either a name (in which case the file will
      be created in the output dir) or an absolute path.
    inputBinding:
      position: 24
      prefix: METRICS_FILE_NAME=
      separate: false
  - id: barcode_diag_file
    type:
      - 'null'
      - string
    doc: 'Name for a barcode match reporting file (not generated by default).Either a name (in which case
      the file will be created in the output dir) or full path. This file will contain a line per read
      pair with the barcode best matching the read subsequence or ''null'' when no match is found according
      to matching parameters ; and the final selected sample. This file is useful for debugging or further
      processing in case both ends are barcoded. N.B: this file will have a size of about one of the fastq
      input files.'
    inputBinding:
      position: 25
      prefix: BARCODE_DIAG_FILE=
      separate: false
  - id: force
    type:
      - 'null'
      - boolean
    doc: 'Allows to overwrite existing files (system rights still apply). Possible values: {true, false}'
    inputBinding:
      position: 26
      valueFrom: ${ if (self === null || self === undefined) { return null; } return "FORCE=" + self;
        }
  - id: gzip_outputs
    type:
      - 'null'
      - boolean
    doc: 'Compress output files using gzip. Possible values: {true, false}'
    inputBinding:
      position: 27
      valueFrom: ${ if (self === null || self === undefined) { return null; } return "GZIP_OUTPUTS=" +
        self; }
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
      position: 28
      prefix: FASTQ_FILE_EXTENSION=
      separate: false
  - id: writer_factory_use_async_io
    type:
      - 'null'
      - boolean
    doc: 'Use one thread per Fastq Writer. Possible values: {true, false}'
    inputBinding:
      position: 29
      valueFrom: ${ if (self === null || self === undefined) { return null; } return "WRITER_FACTORY_USE_ASYNC_IO="
        + self; }
  - id: stats_only
    type:
      - 'null'
      - boolean
    doc: 'Only produces metric and diagnostic reports i.e. no output fastq file produced. Possible values:
      {true, false}'
    inputBinding:
      position: 30
      valueFrom: ${ if (self === null || self === undefined) { return null; } return "STATS_ONLY=" + self;
        }
  - id: use_embase
    type:
      - 'null'
      - boolean
    doc: 'Enables emBASE mode i.e fetch information from emBASE and place demultiplexed files directly
      in emBASE repository structure. This option is mutually exclusive with BARCODE_FILE. Note : this
      option forces O=null GZ=true UN=true UF1=null UF2=null STATS_ONLY=false (all other user options
      supported). Possible values: {true, false} Cannot be used in conjuction with option(s) BARCODE_FILE
      (BF)[help] je demultiplex-illu: ok via je demultiplex-illu --help (--help=ok, -h=ok, -help=ok, (no
      args)=ok)'
    inputBinding:
      position: 31
      valueFrom: ${ if (self === null || self === undefined) { return null; } return "USE_EMBASE=" + self;
        }
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
