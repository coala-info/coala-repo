cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - je
  - debarcode
label: je-suite_debarcode
doc: "Demultiplexes fastq file(s) into user-defined output files, with optional handling of molecular\
  \ barcodes.\n\nTool homepage: https://gbcs.embl.de/Je"
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
  - id: barcode_file
    type:
      - 'null'
      - File
    doc: 'Barcode file (tsv) matching sample names to barcode combination. ### GENERAL Barcode File Format
      In this format, the file structure is governed with headers: * the ''SAMPLE'' column lists the sample
      names * the ''BARCODEn'' columns list the matching BARCODE from the BARCODEn slot (where n is a
      number, see RL option). It is mandatory to have as many ''BARCODEn'' columns as described BARCODE
      slots in READ LAYOUTS. Here again, barcodes can be combined using the OR operator ''|'' * the optional
      ''OUTn'' columns (where n is a number) list the output file names for this sample and matching output
      number. ### SIMPLE Barcode File Format (for backward compatibility) ; please see the GENERAL format
      described above The file must have 2 columns with the sample in col1 and the corresponding barcode
      in col2. In this format, a simple BARCODE slot is expected in the ReadLayout and NO headers are
      needed e.g. : sample1 GAGG sample2 CCAA The format accept the following shortcuts: 1. If multiple
      barcodes map to the same sample, either lines can be duplicated e.g. sample1 ATAT sample1 GAGG sample2
      CCAA sample2 TGTG Or barcodes can be combined using the OR operator ''|'' i.e. the file above can
      be re-written like sample1 ATAT|GAGG sample2 CCAA|TGTG 2. For the special situation of paired-end
      data in which barcodes differ at both ends i.e. with BARCODE1 and BARCODE2 described for read one
      and two respectively, barcodes for BARCODE1 and BARCODE2 can be distinguished using a '':'' separator
      i.e. sample1 ATAT:GAGG sample2 CCAA:TGTG This above syntax means that sample 1 is encoded with ATAT
      barcode from BARCODE1 slot AND GAGG barcode from BARCODE2 slot. Note that you can still combine
      barcodes using | e.g. sample1 ATAT|GAGG:CCAA|TGTG 3. Extended barcode file format : 3 (single-end)
      or 4 (paired-end) tab-delimited colums same as the simple barcode file format but the extra columns
      contains the file name(s) to use to name output files. A unique extra column is expected for single-end
      while 2 extra columns are expected for paired-end. In case lines are duplicated (multiple barcodes
      mapping the same sample), the same file name should be indicated in the third (and fourth) column(s).
      sample1 ATAT spl1_1.txt.gz spl1_2.txt.gz sample1 GAGG spl1_1.txt.gz spl1_2.txt.gz sample2 CCAA spl2_1.txt.gz
      spl2_2.txt.gz Or sample1 ATAT|GAGG:CCAA|TGTG spl1_1.txt.gz spl1_2.txt.gz Required. Cannot be used
      in conjuction with option(s) USE_EMBASE (EM)'
    inputBinding:
      position: 2
      prefix: BARCODE_FILE=
      separate: false
  - id: read_layout
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: READ_LAYOUT=
          separate: false
    doc: 'Describes the read layout(s) of input fastq file(s) e.g. RL=''<BARCODE:6><SAMPLE:x>'' describes
      a read with a barcode in the first 6 bases followed by the sample sequence (''x'' means ''till the
      end'', see below). You MUST single quote the pattern (RL=''<BARCODE:6><SAMPLE:x>'') as ''>'' have
      special meaning in unix.The input fastq files and read layouts are mached up by order on the command
      line. Read layouts are only needed for complex layouts but one must provide read layouts for ALL
      or NONE of the input fastq files. ## READ LAYOUT FORMAT DESCRIPTION:/nRead layouts are made of <UMIn:X>,
      <BARCODEn:X>, <SAMPLEn:X> blocks to describe blocks of type UMI, BARCODE or SAMPLE with : * ''n''
      the unique block index (an index must be unique across all read layouts for each index or each block
      type), use the same index to specify redundant blocks e.g. use <BARCODE1:6> in two different layouts
      to specify that the barcode found in both reads are the same * ''X'' : either a number indicating
      the length of the UMI, BARCODE or SAMPLE block or a negative number e.g. -2 to specify the last
      2 bases should be ignored/clipped) or the letter ''x'' to specify to take the sequence till the
      end of read. Importantly, the ''x'' or negative length shortcuts can *only* be used in the last
      block of a read layout (i.e. <BARCODE1:x><SAMPLE1:20> is not allowed) In addition, layouts can contain
      N or fixed bases like in ''NN<BARCODE1:6>NNNN<SAMPLE1:x>'' where the Ns tell Je to skip 2 and 4
      bases before extracting the barcode & sample sequence respectively. ## OMIITING READ LAYOUT IN THE
      COMMAND LINE:/nWhen no read layout is provided, the following defaults apply : * 1 input fastq:
      single end with layout <BARCODE1:X><SAMPLE1:x> where X is inferred from barcode file * 2 input fastqs:
      - paired end with redundant barcode if barcode file describes a single BARCODE i.e. <BARCODE1:X><SAMPLE1:x>
      and <BARCODE1:X><SAMPLE2:x>, where X is inferred from barcode file - paired end with non redundant
      barcode if barcode file describes two BARCODE column i.e. <BARCODE1:X><SAMPLE1:x> and <BARCODE2:Y><SAMPLE2:x>,
      where X and Y are inferred from barcode file - single end with index file if barcode file describes
      a single BARCODE and second fastq file has reads of length < 10 + barcode_length * 3 input fastqs:
      - paired end with an index file i.e. <SAMPLE1:x>, <SAMPLE2:x> and <BARCODE1:X> when barcode file
      has a single BARCODE column (X is inferred from barcode file) - single end with two index files
      i.e. <SAMPLE1:x>, <BARCODE1:X> and <BARCODE2:Y> when barcode file has two BARCODE columns (X,Y is
      inferred from barcode file) * 4 input fastqs: paired end with either - 2 non-redundant index files
      i.e. <SAMPLE1:x>, <SAMPLE2:x>, <BARCODE1:X>, <BARCODE2:Y> if the barcode file has two BARCODE columns
      or a ATGC:GCTAGC syntax (X,Y inferred from barcode file) - 2 redundant index files <SAMPLE1:x>,
      <SAMPLE2:x>, <BARCODE1:X> and <BARCODE1:X> if the barcode file has a single BARCODE column (X inferred
      from barcode file)'
    inputBinding:
      position: 3
  - id: output_layout
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: OUTPUT_LAYOUT=
          separate: false
    doc: 'Describes the output file layout(s) using the slots defined in read layouts (, , ) and are made
      of three distinct parts separated with '':''. In addition to , , , is used as a synonym to to indicate
      that the real sequence should be written (as opposed to writting the barcode when usign ). An output
      layout looks like ''1::'' where the three mandatory parts ('':''-separated) are : - The number in
      the first part (i.e. from ''1:'' above) is the output file index and it must be unique across all
      ''OL'' inputs. - The second part (i.e. '''' above) is the read header layout; when writing multiple
      UMI and BARCODE slots in output read headers, these are always separated with the RCHAR ('':'' by
      defaults). - The third part (i.e. '''' above) is the read sequence layout. Note that here and are
      fully synonyms as the real sequence (i.e READBAR) is always written Important: You MUST single quote
      the pattern (OL=''1::'') as ''>'' have special meaning in unix.An output file is created for each
      sample and each OL index. Output file names default to samplename_outputfileindex with the original
      fastq file extensions ## OMIITING OUTPUT LAYOUT IN THE COMMAND LINE:/n When no OL is described,
      Je considers an output file should be created for each input FASTQ (containing a SAMPLE slot) and
      for each sample. In this scenario: 1. The output files only contain the SAMPLE slot unless CLIP
      is set to false 2. The barcode(s) and sample names are injected in the output file names according
      to the pattern ''FASTQFILENAMEn_SAMPLENAME_BARCODES.ORIGINALEXTENSIONS'' ) 3. Unless ADD is set
      to false, all BARCODE and UMI slots (if any) are placed in the fastq headers following their slot
      index i.e. BARCODE1:...:BARCODEn:UMI1:UMI2:...:UMIn and are separated with '':''. ## SHORT LAYOUT
      FORMAT The output layout can be specified in a concise way using ''S'',''B'', ''R'' and ''U'' for
      SAMPLE, BARCODE, READBAR and UMI, respectively. In this format, the surounding '''' are also omitted.
      For example ''OL=1:B1U1U2:S1'' is a synonym of ''OL=1::'''
    inputBinding:
      position: 4
  - id: with_quality_in_readname
    type:
      - 'null'
      - boolean
    doc: 'Set to True to keep Phred sequence qualities in output read names. This option only applies
      to BARCODE, READBAR and UMI described in the read name slot of output layout. For BARCODE, the equivalent
      READBAR quality is used. In case of redundant slots, the best found quality is used. The quality
      string is translated into 2 digits number representing the quality scores on the Phred scale and
      a e.g. UMI will look like ''...:ATGCAT333023212322:...'' instead of ''...:ATGCAT:...'' This option
      is particularly useful with the retag module that knows how to extract quality numbers into BAM
      tags. Possible values: {true, false}'
    inputBinding:
      position: 5
      valueFrom: ${ if (self === null || self === undefined) { return null; } return "WITH_QUALITY_IN_READNAME="
        + self; }
  - id: output_dir
    type:
      - 'null'
      - string
    doc: Output directory. By default, output files are written in running directory. A new directory
      in the working directory; collected as output_directory.
    inputBinding:
      position: 6
      prefix: OUTPUT_DIR=
      separate: false
    default: je_out
  - id: keep_unassigned_read
    type:
      - 'null'
      - boolean
    doc: 'Should un-assigned reads be saved in files or simply ignored. File names are automatically created
      or can be given using UF option. Possible values: {true, false}'
    inputBinding:
      position: 7
      valueFrom: ${ if (self === null || self === undefined) { return null; } return "KEEP_UNASSIGNED_READ="
        + self; }
  - id: unassigned_file
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: UNASSIGNED_FILE=
          separate: false
    doc: Name of unassigned files in which to write unassigned reads. When provided, Je expects as many
      UF files as input FASTQ files. UF options are matched up with FASTQ options following the order
      they are defined on the command line. Either a name (in which case the file will be created in the
      output dir) or full path.
    inputBinding:
      position: 8
  - id: add_layout_idx_in_output_filename
    type:
      - 'null'
      - boolean
    doc: 'Should the output layout number (output layout first slot) be injected in the filename ? Only
      used in absence of explicit file names in the barcode file. Possible values: {true, false}'
    inputBinding:
      position: 9
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
      position: 10
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
      position: 11
      valueFrom: ${ if (self === null || self === undefined) { return null; } return "ADD_SEQUENCE_LAYOUT_IN_OUTPUT_FILENAME="
        + self; }
  - id: output_file
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: OUTPUT_FILE=
          separate: false
    doc: Tells Je to write **all** assigned reads in the same output file(s) i.e. use this option when
      you do NOT want to create per-sample demultiplexed files but rather want to keep all reads in the
      same file while barcode information is gathered and injected in output formats. When provided, Je
      expects as many 'OF=' as output layouts ('OL=...') parameters or 'FASTQ=input' files when OL is
      not provided . OF options are matched up with OL/FASTQ options following the order in which they
      are defined on the command line. OF expects either a name (in which case the file will be created
      in the output dir) or an absolute path.
    inputBinding:
      position: 12
  - id: max_mismatches
    type:
      - 'null'
      - string
    doc: Maximum mismatches for a barcode to be considered a match. Either exactly one or multiple values
      (with format MM=X:Y:Z). When multiple values are provided, Je expects exactly one value for each
      BARCODE (with distinct indices) described in the barcode file/read layouts. Values (X,Y,Z) are matched
      up with the sorted list of BARCODES (i.e. X for BARCODE1, Y for BARCODE2 and Z for BARCODE3)
    inputBinding:
      position: 13
      prefix: MAX_MISMATCHES=
      separate: false
  - id: min_mismatch_delta
    type:
      - 'null'
      - string
    doc: Minimum difference between the number of mismatches against the best and the second best barcode.
      When MMD is not respected, the read remains unassigned. Either exactly one or multiple values (with
      format MMD=X:Y:Z). When multiple values are provided, Je expects exactly one value for each BARCODE
      (with distinct indices) described in the barcode file/read layouts. Values (X,Y,Z) are matched up
      with the sorted list of BARCODES (i.e. X for BARCODE1, Y for BARCODE2 and Z for BARCODE3)
    inputBinding:
      position: 14
      prefix: MIN_MISMATCH_DELTA=
      separate: false
  - id: min_base_quality
    type:
      - 'null'
      - string
    doc: 'Minimum base quality during barcode matching: bases which quality is less than this cutoff are
      always considered as a mismatch.Either exactly one or multiple values (with format Q=X:Y:Z). When
      multiple values are provided, Je expects exactly one value for each BARCODE (with distinct indices)
      described in the barcode file/read layouts. Values (X,Y,Z) are matched up with the sorted list of
      BARCODES (i.e. X for BARCODE1, Y for BARCODE2 and Z for BARCODE3)'
    inputBinding:
      position: 15
      prefix: MIN_BASE_QUALITY=
      separate: false
  - id: strict
    type:
      - 'null'
      - boolean
    doc: 'When reads have redundant BARCODE slots, this option tells how to handle situation when the
      read sequence do not resolve to the same sample. When true, the read pair is always ''unassigned''.
      When false, the read pair is assigned to the sample with the lowest overall mismatch sum Possible
      values: {true, false}'
    inputBinding:
      position: 16
      valueFrom: ${ if (self === null || self === undefined) { return null; } return "STRICT=" + self;
        }
  - id: force
    type:
      - 'null'
      - boolean
    doc: 'Allows to overwrite existing files (system rights still apply). Possible values: {true, false}'
    inputBinding:
      position: 17
      valueFrom: ${ if (self === null || self === undefined) { return null; } return "FORCE=" + self;
        }
  - id: gzip_outputs
    type:
      - 'null'
      - boolean
    doc: 'Compress output files using gzip. Possible values: {true, false}'
    inputBinding:
      position: 18
      valueFrom: ${ if (self === null || self === undefined) { return null; } return "GZIP_OUTPUTS=" +
        self; }
  - id: clip
    type:
      - 'null'
      - boolean
    doc: 'In absence of output layout, tell if barcode and UMI sequences should be clipped off read sequence
      before writing to output file. If false, reads are written without modification to output file.
      Possible values: {true, false}'
    inputBinding:
      position: 19
      valueFrom: ${ if (self === null || self === undefined) { return null; } return "CLIP=" + self; }
  - id: add
    type:
      - 'null'
      - boolean
    doc: 'In absence of output layout, tell if barcode and UMI sequences should be added at the end of
      the read header. BARCODE and UMI slots (in this order) are concatenated using the character defined
      by the SEP option Possible values: {true, false}'
    inputBinding:
      position: 20
      valueFrom: ${ if (self === null || self === undefined) { return null; } return "ADD=" + self; }
  - id: read_name_separator_char
    type:
      - 'null'
      - string
    doc: Separator character used to concatenate barcodes and umis in read header
    inputBinding:
      position: 21
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
      position: 22
      prefix: QUALITY_FORMAT=
      separate: false
  - id: metrics_file_name
    type:
      - 'null'
      - string
    doc: File name where to write demultiplexing statistics. Either a name (in which case the file will
      be created in the output dir) or an absolute path.
    inputBinding:
      position: 23
      prefix: METRICS_FILE_NAME=
      separate: false
  - id: barcode_diag_file
    type:
      - 'null'
      - string
    doc: Name for a barcode match reporting file (not generated by default).Either a name (in which case
      the file will be created in the output dir) or full path. This file will contain a line per read
      set with the barcodes best matching the read subsequences or 'null' when no match is found according
      to matching parameters ; and the final selected sample. This file is useful for debugging or further
      processing in case both ends are barcoded.
    inputBinding:
      position: 24
      prefix: BARCODE_DIAG_FILE=
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
      position: 25
      prefix: FASTQ_FILE_EXTENSION=
      separate: false
  - id: input_fastq_compression
    type:
      - 'null'
      - boolean
    doc: 'Indicates if the input fastq files are gzipped. Please use this option when file names are compressed
      but lack the typical ''.gz'' extension.Possible values: {true, false}'
    inputBinding:
      position: 26
      valueFrom: ${ if (self === null || self === undefined) { return null; } return "INPUT_FASTQ_COMPRESSION="
        + self; }
  - id: writer_factory_use_async_io
    type:
      - 'null'
      - boolean
    doc: 'Use one thread per Fastq Writer. Possible values: {true, false}'
    inputBinding:
      position: 27
      valueFrom: ${ if (self === null || self === undefined) { return null; } return "WRITER_FACTORY_USE_ASYNC_IO="
        + self; }
  - id: use_embase
    type:
      - 'null'
      - boolean
    doc: 'Enables emBASE mode i.e fetch information from emBASE and place demultiplexed files directly
      in emBASE repository structure. This option is mutually exclusive with BARCODE_FILE. Note : this
      option forces O=null GZ=true UN=true UF1=null UF2=null STATS_ONLY=false (all other user options
      supported). Possible values: {true, false} Cannot be used in conjuction with option(s) BARCODE_FILE
      (BF)[help] je debarcode: ok via je debarcode --help (--help=ok, -h=ok, -help=ok, (no args)=ok)'
    inputBinding:
      position: 28
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
