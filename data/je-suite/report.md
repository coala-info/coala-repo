# je-suite CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| je-suite_clip | PASS |  |
| je-suite_debarcode | PASS | single-end run works; paired-end two-barcode and extended barcode files crash with a Java NullPointerException in the tool |
| je-suite_demultiplex | PASS |  |
| je-suite_demultiplex-illu | PASS |  |
| je-suite_dropseq | PASS | real reads reused in the drop-seq layout; barcode and UMI moved into the read 2 header correctly |
| je-suite_markdupes | PASS |  |
| je-suite_retag | PASS |  |

## je-suite_clip

### Tool Description
Reads records in the supplied FASTQ file(s) according to specified read layouts (RL option) and writes output FASTQ file(s) according to supplied output layouts (OL option).

### Metadata
- **Docker Image**: quay.io/biocontainers/je-suite:2.0.RC--0
- **Homepage**: https://gbcs.embl.de/Je
- **Package**: https://anaconda.org/channels/bioconda/packages/je-suite/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: Jeclipper [options]

Reads records in the supplied FASTQ file(s) according to specified read layouts (RL option) and write output FASTQ file(s) according to supplied output layouts (OL option).

Version: 2.0.RC


Options:

--help
-h                            Displays options specific to this tool.

--stdhelp
-H                            Displays options specific to this tool AND options common to all Picard command line
                              tools.

--version                     Displays program version.

FASTQ=File
F=File                        Input fastq file (optionally gzipped)  Default value: null. This option must be specified
                              at least 1 times.

READ_LAYOUT=String
RL=String                     Describes the read layout(s) e.g. 'RL=<BARCODE1:6><SAMPLE:x>' of input fastq file(s). The
                              input fastq files and read layouts are mached up by order on the command line.
                              Read layouts are only needed for complex layouts but one must provide read layouts for
                              ALL or NONE of the input fastq files.
                              Read layouts are made of <UMIn:X>, <BARCODEn:X>, <SAMPLEn:X> blocks to describe blocks of
                              type UMI, BARCODE or SAMPLE with :
                                  * 'n' the unique block index (an index must be unique across all read layouts for
                              each index or each block type), use the same index to specify redundant blocks e.g. use
                              <BARCODE1:6> in two different layouts to specify that the barcode found in both reads are
                              the same
                                 * 'X' : either a number indicating the length of the UMI, BARCODE or SAMPLE block or a
                              negative number e.g. -2 to specify the last 2 bases should be ignored/clipped) or the
                              letter 'x' to specify to take the sequence till the end of read. Importantly, the 'x' or
                              negative length shotcut can only be used in the last block of a read layout (i.e.
                              <BARCODE1:x><SAMPLE1:20> is not allowed)

                                Default value: null. This option may be specified 0 or more times.

OUTPUT_LAYOUT=String
OL=String                     Describes the output file layout(s) using the slots defined in read layouts and ':' to
                              delimitate three parts e.g. 'OL=1::' :
                              	1.The number in the first part (i.e. from '1:' above) is the output file index and it
                              must be unique across all 'OL' inputs. Inferred from order in comamnd line when not given
                              	2.The second part (i.e. '' above) is the read header layout ; when writing multiple UMI
                              and BARCODE slots in output read headers, these are always separated with the RCHAR (':'
                              by defaults).
                              	3.The third part (i.e. '' above) is the read sequence layout.
                                Default value: null. This option may be specified 0 or more times.

WITH_QUALITY_IN_READNAME=Boolean
WQ=Boolean                    Should quality string also be injected in read names. Only applies to READBAR and UMI
                              described in the read name slot of output layout
                              If turned on, the quality string is translated into 2 digits number and a e.g. UMI will
                              look like
                              	 '...:ATGCAT333423212322:...' instead of '...:ATGCAT:...'
                              This option is particularly useful with the retag module that knows how to extract
                              quality numbers into BAM tags.  Default value: false. This option can be set to 'null' to
                              clear the default value. Possible values: {true, false}

ADD_LAYOUT_IDX_IN_OUTPUT_FILENAME=Boolean
OWID=Boolean                  Should the output layout number (output layout first slot) be injected in the filename ?
                              Only used in absence of explicit file names in the barcode file.
                                Default value: true. This option can be set to 'null' to clear the default value.
                              Possible values: {true, false}

ADD_HEADER_LAYOUT_IN_OUTPUT_FILENAME=Boolean
OWHL=Boolean                  Should the output layout used for the read name (output layout second slot,in short
                              format) be injected in the filename ? When true, each ouput file name contains e.g.
                              '_B1U1' for OL='1::'
                              Only used in absence of explicit file names in the barcode file.
                                Default value: false. This option can be set to 'null' to clear the default value.
                              Possible values: {true, false}

ADD_SEQUENCE_LAYOUT_IN_OUTPUT_FILENAME=Boolean
OWSL=Boolean                  Should the output layout used for the read sequence (output layout third slot, in short
                              format) be injected in the filename ?When true, each ouput file name contains e.g. '_S1'
                              for OL='1::'
                              Only used in absence of explicit file names in the barcode file.
                                Default value: false. This option can be set to 'null' to clear the default value.
                              Possible values: {true, false}

OUTPUT_DIR=File
O=File                        Output directory. By default, output files are written in running directory.
                                Default value: null.

FORCE=Boolean                 Allows to overwrite existing files (system rights still apply).
                                Default value: false. This option can be set to 'null' to clear the default value.
                              Possible values: {true, false}

GZIP_OUTPUTS=Boolean
GZ=Boolean                    Compress output files using gzip.
                                Default value: true. This option can be set to 'null' to clear the default value.
                              Possible values: {true, false}

READ_NAME_SEPARATOR_CHAR=String
SEP=String                    Separator character used to concatenate barcodes and umis in read header
                                Default value: :. This option can be set to 'null' to clear the default value.

QUALITY_FORMAT=FastqQualityFormat
V=FastqQualityFormat          A value describing how the quality values are encoded in the fastq files.  Either
                              'Solexa' for pre-pipeline 1.3 style scores (solexa scaling + 66), 'Illumina' for pipeline
                              1.3 and above (phred scaling + 64) or 'Standard' for phred scaled scores with a character
                              shift of 33.  If this value is not specified (or 'null' is given), the quality format is
                              assumed to be will the 'Standard' for phred scale.
                                Default value: null. Possible values: {Solexa, Illumina, Standard}

TEST_MODE_STOP_AFTER_PARSING=Boolean
TEST=Boolean                  test mode ie code execution stops right before read demultiplexing starts btu after
                              comamnd line validation  Default value: false. This option can be set to 'null' to clear
                              the default value. Possible values: {true, false}

FASTQ_FILE_EXTENSION=String   Change the default extension of created fastq files, eg 'fastqsanger'. By default uses
                              the file extension from input fastq file. If result file names are given in the barcode
                              file, this option is only used to adapt the unassigned file names. When using
                              compression, a .gz is always appended to file names and should not be specified in
                              FASTQ_FILE_EXTENSION i.e.
                              use FASTQ_FILE_EXTENSION=fastq and NOT FASTQ_FILE_EXTENSION=fastq.gz
                                Default value: null.

WRITER_FACTORY_USE_ASYNC_IO=Boolean
ASYNC=Boolean                 Use one thread per Fastq Writer.
                                Default value: true. This option can be set to 'null' to clear the default value.
                              Possible values: {true, false}[help] je clip: ok via je clip --help (--help=ok, -h=ok, -help=ok, (no args)=ok)
```

## je-suite_debarcode

### Tool Description
Demultiplexes fastq file(s) into user-defined output files, with optional handling of molecular barcodes.

### Metadata
- **Docker Image**: quay.io/biocontainers/je-suite:2.0.RC--0
- **Homepage**: https://gbcs.embl.de/Je
- **Package**: https://anaconda.org/channels/bioconda/packages/je-suite/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: DemultiplexCLI [options]

Usage: program [options...]

Version: 2.0.RC


Options:

--help
-h                            Displays options specific to this tool.

--stdhelp
-H                            Displays options specific to this tool AND options common to all Picard command line
                              tools.

--version                     Displays program version.

FASTQ=File
F=File                        Input fastq file (optionally gzipped)  Default value: null. This option must be specified
                              at least 1 times.

BARCODE_FILE=File
BF=File                       Barcode file (tsv) matching sample names to barcode combination.

                                 ### GENERAL Barcode File Format
                              In this format, the file structure is governed with headers:
                              	* the 'SAMPLE' column lists the sample names
                              	* the 'BARCODEn' columns list the matching BARCODE from the BARCODEn slot (where n is a
                              number, see RL option).
                              	    It is mandatory to have as many 'BARCODEn' columns as described BARCODE slots in
                              READ LAYOUTS. Here again, barcodes can be combined using the OR operator '|'
                              	* the optional 'OUTn' columns (where n is a number) list the output file names for this
                              sample and matching output number.

                                 ### SIMPLE Barcode File Format (for backward compatibility) ; please see the GENERAL
                              format described above
                              The file must have 2 columns with the sample in col1 and the corresponding barcode in
                              col2.
                              In this format, a simple BARCODE slot is expected in the ReadLayout and NO headers are
                              needed e.g. :
                              		sample1	GAGG
                              		sample2	CCAA
                              	The format accept the following shortcuts:
                              	1. If multiple barcodes map to the same sample, either lines can be duplicated e.g.
                              		sample1	ATAT
                              		sample1	GAGG
                              		sample2	CCAA
                              		sample2	TGTG
                              	Or barcodes can be combined using the OR operator '|' i.e. the file above can be
                              re-written like
                               		sample1	ATAT|GAGG
                              		sample2	CCAA|TGTG
                              	2. For the special situation of paired-end data in which barcodes differ at both ends
                              i.e. with BARCODE1 and BARCODE2 described for read one and two respectively, barcodes for
                              BARCODE1 and BARCODE2 can be distinguished using a ':' separator i.e.
                              		sample1	ATAT:GAGG
                              		sample2	CCAA:TGTG
                              	This above syntax means that sample 1 is encoded with ATAT barcode from BARCODE1 slot
                              AND GAGG barcode from BARCODE2 slot. Note that you can still combine barcodes using |
                              e.g.
                              		sample1	ATAT|GAGG:CCAA|TGTG
                              	3. Extended barcode file format : 3 (single-end) or 4 (paired-end) tab-delimited colums
                              	same as the simple barcode file format but the extra columns contains the file name(s)
                              to use to name output files. A unique extra column is expected for single-end while 2
                              extra columns are expected for paired-end. In case lines are duplicated (multiple
                              barcodes mapping the same sample), the same file name should be indicated in the third
                              (and fourth) column(s).
                              		sample1	ATAT	spl1_1.txt.gz	spl1_2.txt.gz
                              		sample1	GAGG	spl1_1.txt.gz	spl1_2.txt.gz
                              		sample2	CCAA	spl2_1.txt.gz	spl2_2.txt.gz
                              	Or
                              		sample1 	 ATAT|GAGG:CCAA|TGTG 	 spl1_1.txt.gz 	 spl1_2.txt.gz
                                Required.  Cannot be used in conjuction with option(s) USE_EMBASE (EM)

READ_LAYOUT=String
RL=String                     Describes the read layout(s) of input fastq file(s) e.g. RL='<BARCODE:6><SAMPLE:x>'
                              describes a read with a barcode in the first 6 bases followed by the sample sequence ('x'
                              means 'till the end', see below). You MUST single quote the pattern
                              (RL='<BARCODE:6><SAMPLE:x>') as '>' have special meaning in unix.The input fastq files
                              and read layouts are mached up by order on the command line.
                              Read layouts are only needed for complex layouts but one must provide read layouts for
                              ALL or NONE of the input fastq files.
                              ## READ LAYOUT FORMAT DESCRIPTION:/nRead layouts are made of <UMIn:X>, <BARCODEn:X>,
                              <SAMPLEn:X> blocks to describe blocks of type UMI, BARCODE or SAMPLE with :
                                  * 'n' the unique block index (an index must be unique across all read layouts for
                              each index or each block type), use the same index to specify redundant blocks e.g. use
                              <BARCODE1:6> in two different layouts to specify that the barcode found in both reads are
                              the same
                                 * 'X' : either a number indicating the length of the UMI, BARCODE or SAMPLE block or a
                              negative number e.g. -2 to specify the last 2 bases should be ignored/clipped) or the
                              letter 'x' to specify to take the sequence till the end of read. Importantly, the 'x' or
                              negative length shortcuts can *only* be used in the last block of a read layout (i.e.
                              <BARCODE1:x><SAMPLE1:20> is not allowed)
                              In addition, layouts can contain N or fixed bases like in 'NN<BARCODE1:6>NNNN<SAMPLE1:x>'
                              where the Ns tell Je to skip 2 and 4 bases before extracting the barcode & sample
                              sequence respectively.

                              ## OMIITING READ LAYOUT IN THE COMMAND LINE:/nWhen no read layout is provided, the
                              following defaults apply :
                                 * 1 input fastq: single end with layout <BARCODE1:X><SAMPLE1:x> where X is inferred
                              from barcode file
                                 * 2 input fastqs:
                                     - paired end with redundant barcode if barcode file describes a single BARCODE
                              i.e. <BARCODE1:X><SAMPLE1:x> and <BARCODE1:X><SAMPLE2:x>, where X is inferred from
                              barcode file
                                     - paired end with non redundant barcode if barcode file describes two BARCODE
                              column i.e. <BARCODE1:X><SAMPLE1:x> and <BARCODE2:Y><SAMPLE2:x>, where X and Y are
                              inferred from barcode file
                                     - single end with index file if barcode file describes a single BARCODE and second
                              fastq file has reads of length < 10 + barcode_length
                                 * 3 input fastqs:
                                     - paired end with an index file i.e. <SAMPLE1:x>, <SAMPLE2:x> and <BARCODE1:X>
                              when barcode file has a single BARCODE column (X is inferred from barcode file)
                                     - single end with two index files i.e. <SAMPLE1:x>, <BARCODE1:X> and <BARCODE2:Y>
                              when barcode file has two BARCODE columns (X,Y is inferred from barcode file)
                                 * 4 input fastqs: paired end with either
                                      - 2 non-redundant index files i.e. <SAMPLE1:x>, <SAMPLE2:x>, <BARCODE1:X>,
                              <BARCODE2:Y> if the barcode file has two BARCODE columns or a ATGC:GCTAGC syntax (X,Y
                              inferred from barcode file)
                                     - 2 redundant index files <SAMPLE1:x>, <SAMPLE2:x>, <BARCODE1:X> and <BARCODE1:X>
                              if the barcode file has a single BARCODE column (X inferred from barcode file)

                                Default value: null. This option may be specified 0 or more times.

OUTPUT_LAYOUT=String
OL=String                     Describes the output file layout(s) using the slots defined in read layouts (, , ) and
                              are made of three distinct parts separated with ':'.
                              In addition to , , ,  is used as a synonym to  to indicate that the real sequence  should
                              be written (as opposed to writting the barcode when usign ).
                              An output layout looks like '1::' where the three mandatory parts (':'-separated) are :
                              	- The number in the first part (i.e. from '1:' above) is the output file index and it
                              must be unique across all 'OL' inputs.
                              	- The second part (i.e. '' above) is the read header layout; when writing multiple UMI
                              and BARCODE slots in output read headers, these are always separated with the RCHAR (':'
                              by defaults).
                              	- The third part (i.e. '' above) is the read sequence layout. Note that here  and  are
                              fully synonyms as the real sequence (i.e READBAR) is always written

                              Important: You MUST single quote the pattern (OL='1::') as '>' have special meaning in
                              unix.An output file is created for each sample and each OL index. Output file names
                              default to samplename_outputfileindex with the original fastq file extensions

                              ## OMIITING OUTPUT LAYOUT IN THE COMMAND LINE:/n  When no OL is described, Je considers
                              an output file should be created for each input FASTQ (containing a SAMPLE slot) and for
                              each sample.
                               In this scenario:
                              	1. The output files only contain the SAMPLE slot unless CLIP is set to false
                              	2. The barcode(s) and sample names are injected in the output file names according to
                              the pattern 'FASTQFILENAMEn_SAMPLENAME_BARCODES.ORIGINALEXTENSIONS' )
                              	3. Unless ADD is set to false, all BARCODE and UMI slots (if any) are placed in the
                              fastq headers following their slot index i.e. BARCODE1:...:BARCODEn:UMI1:UMI2:...:UMIn
                              and are separated with ':'.
                              ## SHORT LAYOUT FORMAT
                              The output layout can be specified in a concise way using 'S','B', 'R' and 'U' for
                              SAMPLE, BARCODE, READBAR and UMI, respectively. In this format, the surounding '' are
                              also omitted. For example 'OL=1:B1U1U2:S1' is a synonym of 'OL=1::'  Default value: null.
                              This option may be specified 0 or more times.

WITH_QUALITY_IN_READNAME=Boolean
WQ=Boolean                    Set to True to keep Phred sequence qualities in output read names.
                              This option only applies to BARCODE, READBAR and UMI described in the read name slot of
                              output layout. For BARCODE, the equivalent READBAR quality is used. In case of redundant
                              slots, the best found quality is used.
                              The quality string is translated into 2 digits number representing the quality scores on
                              the Phred scale and a e.g. UMI will look like
                              	 '...:ATGCAT333023212322:...' instead of '...:ATGCAT:...'
                              This option is particularly useful with the retag module that knows how to extract
                              quality numbers into BAM tags.  Default value: false. This option can be set to 'null' to
                              clear the default value. Possible values: {true, false}

OUTPUT_DIR=File
O=File                        Output directory. By default, output files are written in running directory.
                                Default value: null.

KEEP_UNASSIGNED_READ=Boolean
UN=Boolean                    Should un-assigned reads be saved in files or simply ignored. File names are
                              automatically created or can be given using UF option.
                                Default value: true. This option can be set to 'null' to clear the default value.
                              Possible values: {true, false}

UNASSIGNED_FILE=String
UF=String                     Name of unassigned files in which to write unassigned reads. When provided, Je expects as
                              many UF files as input FASTQ files. UF options are matched up with FASTQ options
                              following the order they are defined on the command line.
                              Either a name (in which case the file will be created in the output dir) or full path.
                                Default value: null. This option may be specified 0 or more times.

ADD_LAYOUT_IDX_IN_OUTPUT_FILENAME=Boolean
OWID=Boolean                  Should the output layout number (output layout first slot) be injected in the filename ?
                              Only used in absence of explicit file names in the barcode file.
                                Default value: true. This option can be set to 'null' to clear the default value.
                              Possible values: {true, false}

ADD_HEADER_LAYOUT_IN_OUTPUT_FILENAME=Boolean
OWHL=Boolean                  Should the output layout used for the read name (output layout second slot,in short
                              format) be injected in the filename ? When true, each ouput file name contains e.g.
                              '_B1U1' for OL='1::'
                              Only used in absence of explicit file names in the barcode file.
                                Default value: false. This option can be set to 'null' to clear the default value.
                              Possible values: {true, false}

ADD_SEQUENCE_LAYOUT_IN_OUTPUT_FILENAME=Boolean
OWSL=Boolean                  Should the output layout used for the read sequence (output layout third slot, in short
                              format) be injected in the filename ?When true, each ouput file name contains e.g. '_S1'
                              for OL='1::'
                              Only used in absence of explicit file names in the barcode file.
                                Default value: false. This option can be set to 'null' to clear the default value.
                              Possible values: {true, false}

OUTPUT_FILE=String
OF=String                     Tells Je to write **all** assigned reads in the same output file(s) i.e. use this option
                              when you do NOT want to create per-sample demultiplexed files but rather want to keep all
                              reads in the same file while barcode information is gathered and injected in output
                              formats.
                               When provided, Je expects as many 'OF=' as output layouts ('OL=...') parameters or
                              'FASTQ=input' files when OL is not provided
                              . OF options are matched up with OL/FASTQ options following the order in which they are
                              defined on the command line.
                              OF expects either a name (in which case the file will be created in the output dir) or an
                              absolute path.
                                Default value: null. This option may be specified 0 or more times.

MAX_MISMATCHES=String
MM=String                     Maximum mismatches for a barcode to be considered a match. Either exactly one or multiple
                              values (with format MM=X:Y:Z).
                              When multiple values are provided, Je expects exactly one value for each BARCODE (with
                              distinct indices) described in the barcode file/read layouts.
                              Values (X,Y,Z) are matched up with the sorted list of BARCODES (i.e.  X for BARCODE1, Y
                              for BARCODE2 and Z for BARCODE3)
                                Default value: 1. This option can be set to 'null' to clear the default value.

MIN_MISMATCH_DELTA=String
MMD=String                    Minimum difference between the number of mismatches against the best and the second best
                              barcode. When MMD is not respected, the read remains unassigned.
                              Either exactly one or multiple values (with format MMD=X:Y:Z). When multiple values are
                              provided, Je expects exactly one value for each BARCODE (with distinct indices) described
                              in the barcode file/read layouts.
                              Values (X,Y,Z) are matched up with the sorted list of BARCODES (i.e.  X for BARCODE1, Y
                              for BARCODE2 and Z for BARCODE3)
                                Default value: 1. This option can be set to 'null' to clear the default value.

MIN_BASE_QUALITY=String
Q=String                      Minimum base quality during barcode matching: bases which quality is less than this
                              cutoff are always considered as a mismatch.Either exactly one or multiple values (with
                              format Q=X:Y:Z). When multiple values are provided, Je expects exactly one value for each
                              BARCODE (with distinct indices) described in the barcode file/read layouts.
                              Values (X,Y,Z) are matched up with the sorted list of BARCODES (i.e.  X for BARCODE1, Y
                              for BARCODE2 and Z for BARCODE3)
                                Default value: 10. This option can be set to 'null' to clear the default value.

STRICT=Boolean
S=Boolean                     When reads have redundant BARCODE slots, this option tells how to handle situation when
                              the read sequence do not resolve to the same sample.
                               When true, the read pair is always 'unassigned'.
                               When false, the read pair is assigned to the sample with the lowest overall mismatch sum
                                Default value: false. This option can be set to 'null' to clear the default value.
                              Possible values: {true, false}

FORCE=Boolean                 Allows to overwrite existing files (system rights still apply).
                                Default value: false. This option can be set to 'null' to clear the default value.
                              Possible values: {true, false}

GZIP_OUTPUTS=Boolean
GZ=Boolean                    Compress output files using gzip.
                                Default value: true. This option can be set to 'null' to clear the default value.
                              Possible values: {true, false}

CLIP=Boolean                  In absence of output layout, tell if barcode and UMI sequences should be clipped off read
                              sequence before writing to output file.
                               If false, reads are written without modification to output file.  Default value: true.
                              This option can be set to 'null' to clear the default value. Possible values: {true,
                              false}

ADD=Boolean                   In absence of output layout, tell if barcode and UMI sequences should be added at the end
                              of the read header.
                              BARCODE and UMI slots (in this order) are concatenated using the character defined by the
                              SEP option
                                Default value: true. This option can be set to 'null' to clear the default value.
                              Possible values: {true, false}

READ_NAME_SEPARATOR_CHAR=String
SEP=String                    Separator character used to concatenate barcodes and umis in read header
                                Default value: :. This option can be set to 'null' to clear the default value.

QUALITY_FORMAT=FastqQualityFormat
V=FastqQualityFormat          A value describing how the quality values are encoded in the fastq files.  Either
                              'Solexa' for pre-pipeline 1.3 style scores (solexa scaling + 66), 'Illumina' for pipeline
                              1.3 and above (phred scaling + 64) or 'Standard' for phred scaled scores with a character
                              shift of 33.  If this value is not specified (or 'null' is given), the quality format is
                              assumed to be will the 'Standard' for phred scale.
                                Default value: null. Possible values: {Solexa, Illumina, Standard}

METRICS_FILE_NAME=String
M=String                      File name where to write demultiplexing statistics. Either a name (in which case the file
                              will be created in the output dir) or an absolute path.
                                Default value: jemultiplexer_out_stats.txt. This option can be set to 'null' to clear
                              the default value.

BARCODE_DIAG_FILE=String
DIAG=String                   Name for a barcode match reporting file (not generated by default).Either a name (in
                              which case the file will be created in the output dir) or full path. This file will
                              contain a line per read set with the barcodes best matching the read subsequences or
                              'null' when no match is found according to matching parameters ; and the final selected
                              sample. This file is useful for debugging or further processing in case both ends are
                              barcoded.
                                Default value: null.

TEST_MODE_STOP_AFTER_PARSING=Boolean
TEST=Boolean                  test mode ie code execution stops right before read demultiplexing starts but after
                              command line validation  Default value: false. This option can be set to 'null' to clear
                              the default value. Possible values: {true, false}

FASTQ_FILE_EXTENSION=String   Change the default extension of created fastq files, eg 'fastqsanger'. By default uses
                              the file extension from input fastq file. If result file names are given in the barcode
                              file, this option is only used to adapt the unassigned file names. When using
                              compression, a .gz is always appended to file names and should not be specified in
                              FASTQ_FILE_EXTENSION i.e.
                              use FASTQ_FILE_EXTENSION=fastq and NOT FASTQ_FILE_EXTENSION=fastq.gz
                                Default value: null.

INPUT_FASTQ_COMPRESSION=Boolean
                              Indicates if the input fastq files are gzipped. Please use this option when file names
                              are compressed but lack the typical '.gz' extension.
                                Default value: null. Possible values: {true, false}

WRITER_FACTORY_USE_ASYNC_IO=Boolean
ASYNC=Boolean                 Use one thread per Fastq Writer.
                                Default value: true. This option can be set to 'null' to clear the default value.
                              Possible values: {true, false}

USE_EMBASE=Boolean
EM=Boolean                    Enables emBASE mode i.e fetch information from emBASE and place demultiplexed files
                              directly in emBASE repository structure.
                              This option is mutually exclusive with BARCODE_FILE.
                              Note : this option forces O=null GZ=true UN=true UF1=null UF2=null STATS_ONLY=false (all
                              other user options supported).
                                Default value: false. This option can be set to 'null' to clear the default value.
                              Possible values: {true, false}  Cannot be used in conjuction with option(s) BARCODE_FILE
                              (BF)[help] je debarcode: ok via je debarcode --help (--help=ok, -h=ok, -help=ok, (no args)=ok)
```

## je-suite_demultiplex

### Tool Description
Demultiplexes fastq file(s) with the Je 1.x implementation, with optional handling of molecular barcodes for further use in the markdupes module.

### Metadata
- **Docker Image**: quay.io/biocontainers/je-suite:2.0.RC--0
- **Homepage**: https://gbcs.embl.de/Je
- **Package**: https://anaconda.org/channels/bioconda/packages/je-suite/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: Jemultiplexer [options]

	Fastq files demultiplexer for in-line barcoded Illumina Fastq files.
	Input fastq files can be in gzip compressed (end in .gz).
	By default output files are gzipped and have names following the pattern
	'_<barcode[-barcode2...-barcodeN]>_[1|2].txt[.gz]' unless you gave file
	 names to use within the barcode description file.
Example:
	 je demultiplex F1=fastq_1.txt.gz BF=barcodes.bs O=/path/to/jemultiplexer-results/
Version: 2.0.RC


Options:

--help
-h                            Displays options specific to this tool.

--stdhelp
-H                            Displays options specific to this tool AND options common to all Picard command line
                              tools.

--version                     Displays program version.

FASTQ_FILE1=File
F1=File                       Input fastq file (optionally gzipped) for single end data, or first read in paired end
                              data.
                                Required.

FASTQ_FILE2=File
F2=File                       Input fastq file (optionally gzipped) for the second read of paired end data.
                                Default value: null.

BARCODE_FILE=File
BF=File                       Barcode file describing sequence list and sample names. Tab-delimited file with 2
                              columns, with the sample in col1 and the corresponding barcode in col2.
                              Simple barcode file format : 2 tab-delimited colums
                              	If multiple barcode map to the same sample, either line can be duplicated e.g.
                              		sample1	ATAT
                              		sample1	GAGG
                              		sample2	CCAA
                              		sample2	TGTG
                              	Or barcodes can be combined using the OR operator '|' i.e. the file above can be
                              re-written like
                               		sample1	ATAT|GAGG
                              		sample2	CCAA|TGTG
                              	Finally, for the special situation of paired-end data in which barcodes differ at both
                              ends (ie BPOS=BOTH BRED=false BM=BOTH , see BRED option description), barcodes for read_1
                              and read_2 can be distinguished using a ':' separator i.e.
                              		sample1	ATAT:GAGG
                              		sample2	CCAA:TGTG
                              	This above syntax means that sample 1 is encoded with ATAT barcode at read_1 AND GAGG
                              barcode at read_2. Note that you can still combine barcodes using | e.g.
                              		sample1	ATAT|GAGG:CCAA|TGTG
                              	would mean that sample 1 is mapped by the combination of barcode: ATAT OR GAGG at read_1
                              AND CCAA OR TGTG at read_2.
                              Extended barcode file format : 3 (single-end) or 4 (paired-end) tab-delimited colums
                              	same as the simple barcode file format but the extra columns contains the file name(s)
                              to use to name output files. A unique extra column is expected for single-end while 2
                              extra columns are expected for paired-end. In case, lines are duplicated (multiple
                              barcodesmapping the same sample), the same file name should be indicated in the third
                              (and fourth) column(s).
                              		sample1	ATAT	spl1_1.txt.gz	spl1_2.txt.gz
                              		sample1	GAGG	spl1_1.txt.gz	spl1_2.txt.gz
                              		sample2	CCAA	spl2_1.txt.gz	spl2_2.txt.gz
                              	Or
                              		sample1 	 ATAT|GAGG:CCAA|TGTG 	 spl1_1.txt.gz 	 spl1_2.txt.gz
                              Ns in barcode sequence are allowed and are used to flag positions that should be ignored
                              in sample matching
                              	 i.e. they will be clipped off the read sequence (like in iCLIP protocol).  Required.
                              Cannot be used in conjuction with option(s) USE_EMBASE (EM)

BARCODE_READ_POS=BarcodePosition
BPOS=BarcodePosition          For paired-end data, where to expect the barcode(s) :
                              	 * READ_1 (beginning of read from FASTQ_FILE_1),
                               	 * READ_2 (beginning of read from FASTQ_FILE_2),
                              	 * BOTH (beginning of both reads).
                              Automatically set to READ_1 in single end mode.
                                Default value: BOTH. This option can be set to 'null' to clear the default value.
                              Possible values: {READ_1, READ_2, BOTH, NONE}

BCLEN=String
LEN=String                    Length of the barcode sequences, optional. Taken from barcode file when not given.
                              In situations where BARCODE_READ_POS == BOTH AND REDUNDANT_BARCODES=false, two distinct
                              length can be provided using the syntax LEN=X:Z where X and Z are 2 integers representing
                              the barcode length for read_1 and read_2 respectively.
                                Default value: null.

BARCODE_FOR_SAMPLE_MATCHING=BarcodePosition
BM=BarcodePosition            Indicates which barcode(s) should be used for sample lookup
                              Automatically set to READ_1 in single end mode.
                              For paired-end data and when BARCODE_READ_POS == BOTH, which barcode should be used to
                              resolve sample :
                              	- use BM=READ_1 (beginning of read from FASTQ_FILE_1) if only this read should be used
                              for sample matching,
                              	- use BM=READ_2 (beginning of read from FASTQ_FILE_2) if only this read should be used
                              for sample matching,
                              	- use BM=BOTH (beginning of both reads) if both should be used
                              When BM=BOTH, the behaviour is different based on the value of REDUNDANT_BARCODES :
                              		If REDUNDANT_BARCODES=true, the two barcodes are considered to map to the same sample
                              and 'Je demultiplex' uses the two barcodes according to the STRICT value.
                              		If REDUNDANT_BARCODES=false, the barcode file should map a couple of barcode to each
                              sample (e.g. sample1 => AGAGTG:TTGATA) and 'Je demultiplex' needs both barcodes to find
                              the relevant sample. Note that this is the only situation in which all barcode matching
                              options (MM, MMD, Q) accept different values for both barcodes in the form X:Z where X
                              and Z are 2 integers.
                                Default value: BOTH. This option can be set to 'null' to clear the default value.
                              Possible values: {READ_1, READ_2, BOTH, NONE}

REDUNDANT_BARCODES=Boolean
BRED=Boolean                  This option only applies for paired-end data with BARCODE_READ_POS set to 'BOTH'
                              Indicates if both read's barcodes encode redundant information or if barcodes are
                              supposed to be identical at both ends (or to resolve to the same sample when a pool of
                              barcodes is used per sample).
                               	When REDUNDANT_BARCODES=false, the 2 barcodes potentially encode
                               different information. For example, only one of the barcodes encodes the sample identity
                              while
                              the second barcode might be a random barcode (UMI) to tell apart PCR artefacts from real
                              duplicates.
                              Another example is when both barcodes should be used in a combined fashion to resolve the
                              sample.
                              In the first example, you should use BPOS=BOTH BRED=false BM=READ_1.
                              In the second example, you should have BPOS=BOTH BRED=false BM=BOTH.
                              Note that with BPOS=BOTH BRED=true BM=BOTH, the behavior would be different as
                              'demultiplex' would then check the STRICT option to perform sample resolution.
                              Importantly, when BARCODE_READ_POS (BPOS) == BOTH AND REDUNDANT_BARCODES=false, BLEN,
                              barcode matching options (MM, MMD, Q) and read trimming/clipping options (XT, ZT) accept
                              different values for both barcodes in the form X:Z where X and Z are 2 integers.
                                Default value: true. This option can be set to 'null' to clear the default value.
                              Possible values: {true, false}

STRICT=Boolean
S=Boolean                     For paired-end data and when two distinct barcodes/indices are used to encode samples,
                               this option tells if both barcodes should resolve to the same sample.
                               When true and if only one of the two reads has a barcode match, the read pair is
                              'unassigned'.
                               When false and if only one of the two reads has a barcode match, the read pair is
                              assigned to the
                               corresponding sample
                              When reads resolve to different samples, the read pair is always 'unassigned'.
                                Default value: false. This option can be set to 'null' to clear the default value.
                              Possible values: {true, false}

MAX_MISMATCHES=String
MM=String                     Maximum mismatches for a barcode to be considered a match. In situations where both
                              barcodes are used for sample matching i.e. BPOS=BOTH BM=BOTH (or 2 INDEX_FILE given), two
                              distinct
                               values can be given here using the syntax MM=X:Z where X and Z are 2 integers to use for
                              read_1 and read_2 respectively.
                              MM=null is like MM=0
                                Default value: 1. This option can be set to 'null' to clear the default value.

MIN_MISMATCH_DELTA=String
MMD=String                    Minimum difference between the number of mismatches against the best and the second best
                              barcode. When MMD is not respected, the read remains unassigned.
                              When two distinct barcodes are used for sample matching (dual encoding), two distinct
                              values can be given using the syntax MMD=X:Z where X and Z are 2 integers to use for
                              first (e.g. from read_1 or index_1)
                              MMD=null is like MMD=0
                                Default value: 1. This option can be set to 'null' to clear the default value.

MIN_BASE_QUALITY=String
Q=String                      Minimum base quality during barcode matching: bases which quality is less than this
                              cutoff are always considered as a mismatch.When two distinct barcodes are used for sample
                              matching (dual encoding), two distinct values can be given using the syntax Q=X:Z where X
                              and Z are 2 integers to use for first (e.g. from read_1 or index_1) and second barcode
                              (e.g. from read_2 or index_2) respectively.
                              Q=null is like Q=0.
                                Default value: 10. This option can be set to 'null' to clear the default value.

XTRIMLEN=String
XT=String                     Optional extra number of base to be trimmed right after the barcode (only used if
                              CLIP_BARCODE=true).
                              When running paired-end, two distinct values can be given using the syntax XT=X:Z where X
                              and Z are 2 integers to use for read_1 and read_2 respectively. Note that even when
                              BPOS=READ_1 or BPOS=READ_2, a X:Y synthax can be given to trim the read w/o barcode as to
                              end up with reads of the same length (note that this can also be operated using ZT). If a
                              unique value is given, e.g. XT=1, while running paired-end the following rule applies :
                               	(1) BPOS=READ_1 or BPOS=READ_2, no trim is applied at the read w/o barcode
                              	(2) BPOS=BOTH, the value is used for both reads.
                              Note that XT=null is like XT=0.
                                Default value: 0. This option can be set to 'null' to clear the default value.

ZTRIMLEN=String
ZT=String                     Optional extra number of bases to be trimmed from the read end i.e. 3' end.
                              When running paired-end, two distinct values can be given here using the syntax ZT=X:Z
                              where X and Z are 2 integers to use for read_1 and read_2 respectively. Note that even
                              when BPOS=READ_1 or BPOS=READ_2, a X:Y synthax can be given to trim the read w/o barcode
                              as to end up with reads of the same length (note that this can also be operated using
                              XT). Note that if a single value is passed, the value always applies to both reads in
                              paired-end mode without further consideration.
                              ZT=null is like ZT=0.
                                Default value: 0. This option can be set to 'null' to clear the default value.

CLIP_BARCODE=Boolean
C=Boolean                     Clip barcode sequence from read sequence, as well as XTRIMLEN (and ZTRIMLEN) bases if
                              applicable, before writing to output file.
                               If false, reads are written without modification to output file.
                              Apply to both barcodes when BPOS=BOTH.
                                Default value: true. This option can be set to 'null' to clear the default value.
                              Possible values: {true, false}

ADD_BARCODE_TO_HEADER=Boolean
ADD=Boolean                   Add barcode at the end of the read header. Apply to both barcodes when BPOS=BOTH.
                              	If true, the string ':barcode' is added at the end of the read header with a ':' added
                              only if current read header does not end with ':'.
                              	If both reads of the pair have a barcode (i.e. BARCODE_READ_POS == BOTH), thenthe second
                              read also has its own matched barcode written. Else, the read without a barcode receives
                              the barcode from the barcoded read.
                              	For example :
                              		'@D3FCO8P1:178:C1WLBACXX:7:1101:1836:1965 2:N:0:'
                              	becomes
                              		'@D3FCO8P1:178:C1WLBACXX:7:1101:1836:1965 2:N:0:BARCODE'

                              	When barcodes containing random positions, i.e. 'N', (for example like 	in the iCLIP
                              protocol) or are UMIs, the added sequence is the sequence clipped from the read and NOT
                              the matched barcode.
                                Default value: true. This option can be set to 'null' to clear the default value.
                              Possible values: {true, false}

ENSURE_IDENTICAL_HEADER_NAMES=Boolean
SAME_HEADERS=Boolean          Makes sure that headers of both reads of a pair are identical, using the following read
                              header pattern (for both reads of a pair) :
                              		'@D3FCO8P1:178:C1WLBACXX:7:1101:1836:1965 SAMPLEBARCODE_READ1:SAMPLEBARCODE_READ2(if
                              applicable)':CLIPPED_SEQ_FROMREAD1:CLIPPED_SEQ_FROMREAD2This option only makes sense in
                              paired end mode and ADD=true. Some (if not all) mappers will indeed complain when the
                              read headers are not identical. When molecular barcodes are present in reads (either as
                              additional barcodes or as degenerate barcodes ie with 'N') and the RCHAR is used, you
                              will end with (problematic) read headers like this :
                              		HISEQ:44:C6KC0ANXX:5:1101:1491:1994:1:N:0:TAGAACAC:TGGAGTAG
                              		HISEQ:44:C6KC0ANXX:5:1101:1491:1994:3:N:0:TAGAACAC:CGTTGTAT
                              SAME_HEADERS=true will instead generates the following identical header for both reads :
                              		HISEQ:44:C6KC0ANXX:5:1101:1491:1994:TAGAACAC:TGGAGTAG:CGTTGTAT
                              	Note that we also clipped the useless '1:N:0' and '3:N:0' has they will also result in
                              generating different headers.
                              		 Important : this option will force RCHAR=: UNLESS you specify RCHAR=null ; in which
                              case a space will be preserved ie :
                              		HISEQ:44:C6KC0ANXX:5:1101:1491:1994 TAGAACAC:TGGAGTAG:CGTTGTAT
                                Default value: true. This option can be set to 'null' to clear the default value.
                              Possible values: {true, false}

READ_NAME_REPLACE_CHAR=String
RCHAR=String                  Replace spaces in read name/header using provided character. This is particularly handy
                              when you need to retain	 ADDed barcode in read name/header during mapping (everything
                              after space in read name is usually clipped in BAM files).	For example, with RCHAR=':' :
                              		'@D3FCO8P1:178:C1WLBACXX:7:1101:1836:1965 2:N:0:'
                              	becomes
                              		'@D3FCO8P1:178:C1WLBACXX:7:1101:1836:1965:2:N:0:BARCODE'
                                Default value: null.

QUALITY_FORMAT=FastqQualityFormat
V=FastqQualityFormat          A value describing how the quality values are encoded in the fastq.  Either 'Solexa' for
                              pre-pipeline 1.3 style scores (solexa scaling + 66), 'Illumina' for pipeline 1.3 and
                              above (phred scaling + 64) or 'Standard' for phred scaled scores with a character shift
                              of 33.  If this value is not specified (or 'null' is given), the quality format will be
                              detected.
                                Default value: Standard. This option can be set to 'null' to clear the default value.
                              Possible values: {Solexa, Illumina, Standard}

OUTPUT_DIR=File
O=File                        Output directory. By default, output files are written in running directory.
                                Default value: null.

KEEP_UNASSIGNED_READ=Boolean
UN=Boolean                    Should un-assigned reads be saved in files or simply ignored. File names are
                              automatically created or can be given using UF1 & UF2 options.
                                Default value: true. This option can be set to 'null' to clear the default value.
                              Possible values: {true, false}

UNASSIGNED_FILE_NAME_1=String
UF1=String                    Name of the file in which to write unassigned reads from FILE1.Either a name (in which
                              case the file will be created in the output dir) or full path.
                                Default value: unassigned_1.txt. This option can be set to 'null' to clear the default
                              value.

UNASSIGNED_FILE_NAME_2=String
UF2=String                    Name of the file in which to write unassigned reads from FILE2.Either a name (in which
                              case the file will be created in the output dir) or full path.
                                Default value: unassigned_2.txt. This option can be set to 'null' to clear the default
                              value.

METRICS_FILE_NAME=String
M=String                      File name where to write demultiplexing statistics. Either a name (in which case the file
                              will be created in the output dir) or an absolute path.
                                Default value: jemultiplexer_out_stats.txt. This option can be set to 'null' to clear
                              the default value.

BARCODE_DIAG_FILE=String
DIAG=String                   Name for a barcode match reporting file (not generated by default).Either a name (in
                              which case the file will be created in the output dir) or full path. This file will
                              contain a line per read pair with the barcode best matching the read subsequence or
                              'null' when no match is found according to matching parameters ; and the final selected
                              sample. This file is useful for debugging or further processing in case both ends are
                              barcoded.
                              N.B: this file will have a size of about one of the fastq input files.  Default value:
                              null.

FORCE=Boolean                 Allows to overwrite existing files (system rights still apply).
                                Default value: false. This option can be set to 'null' to clear the default value.
                              Possible values: {true, false}

GZIP_OUTPUTS=Boolean
GZ=Boolean                    Compress output files using gzip.
                                Default value: true. This option can be set to 'null' to clear the default value.
                              Possible values: {true, false}

FASTQ_FILE_EXTENSION=String   Change the default extension of created fastq files, eg 'fastqsanger'. By default uses
                              the file extension from input fastq file. If result file names are given in the barcode
                              file, this option is only used to adapt the unassigned file names. When using
                              compression, a .gz is always appended to file names and should not be specified in
                              FASTQ_FILE_EXTENSION i.e.
                              use FASTQ_FILE_EXTENSION=fastq and NOT FASTQ_FILE_EXTENSION=fastq.gz
                                Default value: null.

WRITER_FACTORY_USE_ASYNC_IO=Boolean
ASYNC=Boolean                 Use one thread per Fastq Writer.
                                Default value: true. This option can be set to 'null' to clear the default value.
                              Possible values: {true, false}

STATS_ONLY=Boolean            Only produces metric and diagnostic reports i.e. no output fastq file produced.
                                Default value: false. This option can be set to 'null' to clear the default value.
                              Possible values: {true, false}

USE_EMBASE=Boolean
EM=Boolean                    Enables emBASE mode i.e fetch information from emBASE and place demultiplexed files
                              directly in emBASE repository structure.
                              This option is mutually exclusive with BARCODE_FILE.
                              Note : this option forces O=null GZ=true UN=true UF1=null UF2=null STATS_ONLY=false (all
                              other user options supported).
                                Default value: false. This option can be set to 'null' to clear the default value.
                              Possible values: {true, false}  Cannot be used in conjuction with option(s) BARCODE_FILE
                              (BF)[help] je demultiplex: ok via je demultiplex --help (--help=ok, -h=ok, -help=ok, (no args)=ok)
```

## je-suite_demultiplex-illu

### Tool Description
Demultiplexes fastq file(s) using Illumina index files with the Je 1.x implementation, with optional handling of molecular barcodes.

### Metadata
- **Docker Image**: quay.io/biocontainers/je-suite:2.0.RC--0
- **Homepage**: https://gbcs.embl.de/Je
- **Package**: https://anaconda.org/channels/bioconda/packages/je-suite/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: JemultiplexerIllumina [options]

	Fastq files demultiplexer for Illumina Fastq files using Illumina Index files.
	Fastq files (reads and index) can be in gzip compressed (end in .gz).
	By default output files are gzipped and have names following the pattern
	'_<barcode[-barcode2...-barcodeN]>_[1|2].txt[.gz]' unless you gave file
	 names to use within the barcode description file.
Example :
	 je demultiplex-illu F1=fastq_1.txt.gz I1=index_1.txt.gz BF=barcodes.bs O=~/Desktop/test-jemultiplexer2/
Version: 2.0.RC


Options:

--help
-h                            Displays options specific to this tool.

--stdhelp
-H                            Displays options specific to this tool AND options common to all Picard command line
                              tools.

--version                     Displays program version.

FASTQ_FILE1=File
F1=File                       Input fastq file (optionally gzipped) for single end data, or first read in paired end
                              data.
                                Required.

FASTQ_FILE2=File
F2=File                       Input fastq file (optionally gzipped) for the second read of paired end data.
                                Default value: null.

INDEX_FILE1=File
I1=File                       Fastq file for index 1 (barcode) reads, optionally gzipped.
                                Required.

INDEX_FILE2=File
I2=File                       Fastq file for index 2 (barcode) reads, optionally gzipped.
                              A INDEX_FILE1 MUST be provided when INDEX_FILE2 is given. This situation corresponds to
                              Illumina dual indexing.
                                Default value: null.

BARCODE_FILE=File
BF=File                       Barcode file describing sequence list and sample names. Tab-delimited file with 2
                              columns, with the sample in col1 and the corresponding barcode in col2.
                              Simple barcode file format : 2 tab-delimited colums
                              	If multiple barcode map to the same sample, either line can be duplicated e.g.
                              		sample1	ATAT
                              		sample1	GAGG
                              		sample2	CCAA
                              		sample2	TGTG
                              	Or barcodes can be combined using the OR operator '|' i.e. the file above can be
                              re-written like
                               		sample1	ATAT|GAGG
                              		sample2	CCAA|TGTG
                              	Finally, for the special situation of paired-end data in which barcodes differ at both
                              ends (ie BPOS=BOTH BRED=false BM=BOTH , see BRED option description), barcodes for read_1
                              and read_2 can be distinguished using a ':' separator i.e.
                              		sample1	ATAT:GAGG
                              		sample2	CCAA:TGTG
                              	This above syntax means that sample 1 is encoded with ATAT barcode at read_1 AND GAGG
                              barcode at read_2. Note that you can still combine barcodes using | e.g.
                              		sample1	ATAT|GAGG:CCAA|TGTG
                              	would mean that sample 1 is mapped by the combination of barcode: ATAT OR GAGG at read_1
                              AND CCAA OR TGTG at read_2.
                              Extended barcode file format : 3 (single-end) or 4 (paired-end) tab-delimited colums
                              	same as the simple barcode file format but the extra columns contains the file name(s)
                              to use to name output files. A unique extra column is expected for single-end while 2
                              extra columns are expected for paired-end. In case, lines are duplicated (multiple
                              barcodesmapping the same sample), the same file name should be indicated in the third
                              (and fourth) column(s).
                              		sample1	ATAT	spl1_1.txt.gz	spl1_2.txt.gz
                              		sample1	GAGG	spl1_1.txt.gz	spl1_2.txt.gz
                              		sample2	CCAA	spl2_1.txt.gz	spl2_2.txt.gz
                              	Or
                              		sample1 	 ATAT|GAGG:CCAA|TGTG 	 spl1_1.txt.gz 	 spl1_2.txt.gz
                              Ns in barcode sequence are allowed and are used to flag positions that should be ignored
                              in sample matching
                              	 i.e. they will be clipped off the read sequence (like in iCLIP protocol).  Required.
                              Cannot be used in conjuction with option(s) USE_EMBASE (EM)

BARCODE_READ_POS=BarcodePosition
BPOS=BarcodePosition          Indicates the location of additional barcodes present in the read(s). Setting this option
                              implies setting the LEN option.
                              	Importantly, these additional barcodes must not encode sample identity information but
                              used for
                              	e.g. molecular barcoding (UMIs) or for any purpose other than sample identity encoding.
                              Default value: BOTH. This option can be set to 'null' to clear the default value.
                              Possible values: {READ_1, READ_2, BOTH, NONE}

BCLEN=String
LEN=String                    Length of the additional barcodes present in the read(s) as indicated by the BPOS option.
                              Two distinct length can be provided using the syntax LEN=X:Z where X and Z are 2 integers
                              representing the barcode length for read_1 and read_2 respectively.
                              Only relevant when BPOS != NONE.  Default value: null.

REDUNDANT_BARCODES=Boolean
BRED=Boolean                  This option only applies for paired-end data with *both* INDEX_FILE1 and INDEX_FILE2
                              provided.
                              Indicates if both index barcodes encode redundant information i.e. if both barcodes are
                              supposed to be identical (or resolve to the same sample when a pool of barcodes is used
                              per sample).
                               	When BRED=true, the STRICT option guides the sample lookup behavior	When BRED=false,
                              barcodes are combined prior to sample lookup.
                                Default value: true. This option can be set to 'null' to clear the default value.
                              Possible values: {true, false}

STRICT=Boolean
S=Boolean                     For paired-end data and when two distinct barcodes/indices are used to encode samples,
                               this option tells if both barcodes should resolve to the same sample.
                               When true and if only one of the two reads has a barcode match, the read pair is
                              'unassigned'.
                               When false and if only one of the two reads has a barcode match, the read pair is
                              assigned to the
                               corresponding sample
                              When reads resolve to different samples, the read pair is always 'unassigned'.
                                Default value: false. This option can be set to 'null' to clear the default value.
                              Possible values: {true, false}

MAX_MISMATCHES=String
MM=String                     Maximum mismatches for a barcode to be considered a match. In situations where both
                              barcodes are used for sample matching i.e. BPOS=BOTH BM=BOTH (or 2 INDEX_FILE given), two
                              distinct
                               values can be given here using the syntax MM=X:Z where X and Z are 2 integers to use for
                              read_1 and read_2 respectively.
                              MM=null is like MM=0
                                Default value: 1. This option can be set to 'null' to clear the default value.

MIN_MISMATCH_DELTA=String
MMD=String                    Minimum difference between the number of mismatches against the best and the second best
                              barcode. When MMD is not respected, the read remains unassigned.
                              When two distinct barcodes are used for sample matching (dual encoding), two distinct
                              values can be given using the syntax MMD=X:Z where X and Z are 2 integers to use for
                              first (e.g. from read_1 or index_1)
                              MMD=null is like MMD=0
                                Default value: 1. This option can be set to 'null' to clear the default value.

MIN_BASE_QUALITY=String
Q=String                      Minimum base quality during barcode matching: bases which quality is less than this
                              cutoff are always considered as a mismatch.When two distinct barcodes are used for sample
                              matching (dual encoding), two distinct values can be given using the syntax Q=X:Z where X
                              and Z are 2 integers to use for first (e.g. from read_1 or index_1) and second barcode
                              (e.g. from read_2 or index_2) respectively.
                              Q=null is like Q=0.
                                Default value: 10. This option can be set to 'null' to clear the default value.

XTRIMLEN=String
XT=String                     Optional extra number of base to be trimmed right after the barcode (only used if
                              CLIP_BARCODE=true).
                              When running paired-end, two distinct values can be given using the syntax XT=X:Z where X
                              and Z are 2 integers to use for read_1 and read_2 respectively. Note that even when
                              BPOS=READ_1 or BPOS=READ_2, a X:Y synthax can be given to trim the read w/o barcode as to
                              end up with reads of the same length (note that this can also be operated using ZT). If a
                              unique value is given, e.g. XT=1, while running paired-end the following rule applies :
                               	(1) BPOS=READ_1 or BPOS=READ_2, no trim is applied at the read w/o barcode
                              	(2) BPOS=BOTH, the value is used for both reads.
                              Note that XT=null is like XT=0.
                                Default value: 0. This option can be set to 'null' to clear the default value.

ZTRIMLEN=String
ZT=String                     Optional extra number of bases to be trimmed from the read end i.e. 3' end.
                              When running paired-end, two distinct values can be given here using the syntax ZT=X:Z
                              where X and Z are 2 integers to use for read_1 and read_2 respectively. Note that even
                              when BPOS=READ_1 or BPOS=READ_2, a X:Y synthax can be given to trim the read w/o barcode
                              as to end up with reads of the same length (note that this can also be operated using
                              XT). Note that if a single value is passed, the value always applies to both reads in
                              paired-end mode without further consideration.
                              ZT=null is like ZT=0.
                                Default value: 0. This option can be set to 'null' to clear the default value.

CLIP_BARCODE=Boolean
C=Boolean                     Clip barcode sequence from read sequence, as well as XTRIMLEN (and ZTRIMLEN) bases if
                              applicable, before writing to output file.
                               If false, reads are written without modification to output file.
                              Apply to both barcodes when BPOS=BOTH.
                                Default value: true. This option can be set to 'null' to clear the default value.
                              Possible values: {true, false}

ADD_BARCODE_TO_HEADER=Boolean
ADD=Boolean                   Add matched barcode at the end of the read header. Applies to both index when INDEX_FILE2
                              is also provided.
                              	First the sample encoding barcodes from I1 (and I2 when relevant) are added to the read
                              headers like
                              		'@D3FCO8P1:178:C1WLBACXX:7:1101:1836:1965 2:N:0:I1_BARCODE:I2_BARCODE'
                              	Then, if BPOS!=NONE, the additional barcodes (UMIs) clipped from the read(s) are added
                              to their own header, like
                              		'@D3FCO8P1:178:C1WLBACXX:7:1101:1836:1965
                              2:N:0:I1_BARCODE:I2_BARCODE:CLIPPED_SEQ_FROMREAD'
                                Default value: true. This option can be set to 'null' to clear the default value.
                              Possible values: {true, false}

ENSURE_IDENTICAL_HEADER_NAMES=Boolean
SAME_HEADERS=Boolean          Makes sure that headers of both reads of a pair are identical, using the following read
                              header pattern (for both reads of a pair) :
                              		'@D3FCO8P1:178:C1WLBACXX:7:1101:1836:1965 I1_BARCODE:I2_BARCODE(if
                              applicable)':CLIPPED_SEQ_FROMREAD1:CLIPPED_SEQ_FROMREAD2
                              This option only makes sense in paired end mode and ADD=true. Some (if not all) mappers
                              will indeed complain when the read headers are not identical. When molecular barcodes are
                              present in reads and the RCHAR is used, you will end with (problematic) read headers like
                              this :
                              		HISEQ:44:C6KC0ANXX:5:1101:1491:1994:1:N:0:TAGAACAC:TGGAGTAG
                              		HISEQ:44:C6KC0ANXX:5:1101:1491:1994:3:N:0:TAGAACAC:CGTTGTAT
                              SAME_HEADERS=true will instead genetates the following identical header for both reads :
                              		HISEQ:44:C6KC0ANXX:5:1101:1491:1994:TAGAACAC:TGGAGTAG:CGTTGTAT
                              Note that we also clipped the useless '1:N:0' and '3:N:0' has they will also result in
                              generating different headers
                              	 Important : this option will force RCHAR=: UNLESS you specify RCHAR=null ; in which
                              case a space will be preserved ie :
                              		HISEQ:44:C6KC0ANXX:5:1101:1491:1994 TAGAACAC:TGGAGTAG:CGTTGTAT
                                Default value: true. This option can be set to 'null' to clear the default value.
                              Possible values: {true, false}

READ_NAME_REPLACE_CHAR=String
RCHAR=String                  Replace spaces in read name/header using provided character. This is particularly handy
                              when you need to retain	 ADDed barcode in read name/header during mapping (everything
                              after space in read name is usually clipped in BAM files).	For example, with RCHAR=':' :
                              		'@D3FCO8P1:178:C1WLBACXX:7:1101:1836:1965 2:N:0:'
                              	becomes
                              		'@D3FCO8P1:178:C1WLBACXX:7:1101:1836:1965:2:N:0:BARCODE'
                                Default value: null.

QUALITY_FORMAT=FastqQualityFormat
V=FastqQualityFormat          A value describing how the quality values are encoded in the fastq.  Either 'Solexa' for
                              pre-pipeline 1.3 style scores (solexa scaling + 66), 'Illumina' for pipeline 1.3 and
                              above (phred scaling + 64) or 'Standard' for phred scaled scores with a character shift
                              of 33.  If this value is not specified (or 'null' is given), the quality format will be
                              detected.
                                Default value: Standard. This option can be set to 'null' to clear the default value.
                              Possible values: {Solexa, Illumina, Standard}

OUTPUT_DIR=File
O=File                        Output directory. By default, output files are written in running directory.
                                Default value: null.

KEEP_UNASSIGNED_READ=Boolean
UN=Boolean                    Should un-assigned reads be saved in files or simply ignored. File names are
                              automatically created or can be given using UF1 & UF2 options.
                                Default value: true. This option can be set to 'null' to clear the default value.
                              Possible values: {true, false}

UNASSIGNED_FILE_NAME_1=String
UF1=String                    Name of the file in which to write unassigned reads from FILE1.Either a name (in which
                              case the file will be created in the output dir) or full path.
                                Default value: unassigned_1.txt. This option can be set to 'null' to clear the default
                              value.

UNASSIGNED_FILE_NAME_2=String
UF2=String                    Name of the file in which to write unassigned reads from FILE2.Either a name (in which
                              case the file will be created in the output dir) or full path.
                                Default value: unassigned_2.txt. This option can be set to 'null' to clear the default
                              value.

METRICS_FILE_NAME=String
M=String                      File name where to write demultiplexing statistics. Either a name (in which case the file
                              will be created in the output dir) or an absolute path.
                                Default value: jemultiplexer_out_stats.txt. This option can be set to 'null' to clear
                              the default value.

BARCODE_DIAG_FILE=String
DIAG=String                   Name for a barcode match reporting file (not generated by default).Either a name (in
                              which case the file will be created in the output dir) or full path. This file will
                              contain a line per read pair with the barcode best matching the read subsequence or
                              'null' when no match is found according to matching parameters ; and the final selected
                              sample. This file is useful for debugging or further processing in case both ends are
                              barcoded.
                              N.B: this file will have a size of about one of the fastq input files.  Default value:
                              null.

FORCE=Boolean                 Allows to overwrite existing files (system rights still apply).
                                Default value: false. This option can be set to 'null' to clear the default value.
                              Possible values: {true, false}

GZIP_OUTPUTS=Boolean
GZ=Boolean                    Compress output files using gzip.
                                Default value: true. This option can be set to 'null' to clear the default value.
                              Possible values: {true, false}

FASTQ_FILE_EXTENSION=String   Change the default extension of created fastq files, eg 'fastqsanger'. By default uses
                              the file extension from input fastq file. If result file names are given in the barcode
                              file, this option is only used to adapt the unassigned file names. When using
                              compression, a .gz is always appended to file names and should not be specified in
                              FASTQ_FILE_EXTENSION i.e.
                              use FASTQ_FILE_EXTENSION=fastq and NOT FASTQ_FILE_EXTENSION=fastq.gz
                                Default value: null.

WRITER_FACTORY_USE_ASYNC_IO=Boolean
ASYNC=Boolean                 Use one thread per Fastq Writer.
                                Default value: true. This option can be set to 'null' to clear the default value.
                              Possible values: {true, false}

STATS_ONLY=Boolean            Only produces metric and diagnostic reports i.e. no output fastq file produced.
                                Default value: false. This option can be set to 'null' to clear the default value.
                              Possible values: {true, false}

USE_EMBASE=Boolean
EM=Boolean                    Enables emBASE mode i.e fetch information from emBASE and place demultiplexed files
                              directly in emBASE repository structure.
                              This option is mutually exclusive with BARCODE_FILE.
                              Note : this option forces O=null GZ=true UN=true UF1=null UF2=null STATS_ONLY=false (all
                              other user options supported).
                                Default value: false. This option can be set to 'null' to clear the default value.
                              Possible values: {true, false}  Cannot be used in conjuction with option(s) BARCODE_FILE
                              (BF)[help] je demultiplex-illu: ok via je demultiplex-illu --help (--help=ok, -h=ok, -help=ok, (no args)=ok)
```

## je-suite_markdupes

### Tool Description
Examines aligned records in the supplied SAM or BAM file to locate duplicate molecules, taking into account molecular barcodes (UMIs) found in the read name.

### Metadata
- **Docker Image**: quay.io/biocontainers/je-suite:2.0.RC--0
- **Homepage**: https://gbcs.embl.de/Je
- **Package**: https://anaconda.org/channels/bioconda/packages/je-suite/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: MarkDuplicatesWithMolecularCode [options]

Examines aligned records in the supplied SAM or BAM file to locate duplicate molecules taking into account molecular barcodes (Unique Molecular Identifiers or UMIs) found in read header. All records are then either written to the output file with the duplicate records flagged or trashed.
Example :
	 je markdupes INPUT=file_with_dupes.bam OUTPUT=result.bam MM=1
Version: 2.0.RC


Options:

--help
-h                            Displays options specific to this tool.

--stdhelp
-H                            Displays options specific to this tool AND options common to all Picard command line
                              tools.

--version                     Displays program version.

INPUT=String
I=String                      One or more input SAM or BAM files to analyze. Must be coordinate sorted.  Default value:
                              null. This option may be specified 0 or more times.

OUTPUT=File
O=File                        The output file to write marked records to  Required.

MISMATCHES=Integer
MM=Integer                    Number of MisMatches (inclusive) to still consider two Unique Molecular Identifiers
                              (UMIs) identical i.e. this option buffers for sequencing errors.Indeed, in case of a
                              sequencing error, 2 duplicate reads would not be considered duplicates anymore.Note that
                              N are not considered mismatches during comparison ie ATTNGG and NTTANG are seen as the
                              same barcode and these two reads would be flagged duplicates.This option takes a single
                              value even when several barcodes are present (see SLOTS). Note that when declaring
                              several barcodes (see SLOTS) AND providing a predefined set of barcodes (see BC option),
                              the MM value is applicable in each lookup. When a predefined set of barcodes is NOT
                              given, the different barcodes (SLOTS) are concatenated first and the MM value is
                              therefore considered *overall* as the concatenated code is seen as a unique code.
                              MM=null is like MM=0
                              Use the minimum Hamming distance of the original barcode set (if applicable).  Required.

MAX_NUMBER_OF_N=Integer
MAX_N=Integer                 Maximum number of Ns a molecular code can contain (inclusive). Above this value, reads
                              are placed in a UNDEF group.More precisely, these 'too degenarate' codes will not :
                              	 * be compared to the list of predefined codes [predefined code list situation ie BC
                              option given] nor
                              	 * be considered as a potential independent code [no predefined code list situation ie
                              BC option not given]
                              Default value is the MISMATCHES number.
                               Note that when declaring several barcodes (see SLOTS) AND providing a predefined set of
                              barcodes (see BC option), the MAX_N value is applicable to each barcode. When a
                              predefined set of barcodes is NOT given, the different barcodes (SLOTS) are concatenated
                              first and the MAX_N value is therefore considered *overall*.  Default value: null.

SLOTS=Integer
SLOTS=Integer                 Where to find the UMIs (and only the UMIs) in the read name once read name has been
                              tokenized using the SPLIT character (e.g. ':').
                              By default, the UMI is considered to be found at the end of the read header i.e. after
                              the last ':'. Use this option to indicate other or additional UMI positions (e.g.
                              multiple UMIs present in read header.
                              IMPORTANT : counting starts at 1 and negative numbers can be used to start counting from
                              the end.
                              For example, consider the following read name that lists 3 different barcodes in the end
                              :
                              	 HISEQ:44:C6KC0ANXX:8:2112:20670:79594:CGATGTTT:GATCCTAG:AAGGTACG
                              	 to indicate that the three barcodes are molecular codes, use
                              		SLOTS=-1 SLOTS=-2 SLOTS=-3
                              	 if only the 2 last ones should be considered (the third one being a sample encoding
                              barcode), use
                              		SLOTS=-1 SLOTS=-2	 N.B.: UMI usage can be deactivate by explicitely setting SLOTS=null
                              in the command line
                                Default value: null. This option may be specified 0 or more times.

BARCODE_FILE=File
BC=File                       Pre-defined list of UMIs that can be expected. Format: one column text file, one barcode
                              per line. All UMIs MUST have the same length.   Default value: null.

METRICS_FILE=File
M=File                        File to write duplication metrics to  Required.

REMOVE_DUPLICATES=Boolean     If true do not write duplicates to the output file instead of writing them with
                              appropriate flags set.  Default value: false. This option can be set to 'null' to clear
                              the default value. Possible values: {true, false}

ASSUME_SORTED=Boolean
AS=Boolean                    If true, assume that the input file is coordinate sorted even if the header says
                              otherwise. Deprecated, used ASSUME_SORT_ORDER=coordinate instead.  Default value: false.
                              This option can be set to 'null' to clear the default value. Possible values: {true,
                              false}  Cannot be used in conjuction with option(s) ASSUME_SORT_ORDER (ASO)

TRIM_HEADERS=Boolean
T=Boolean                     Should barcode information be removed from read names in the output BAM ? This is usefull
                              to save storage space.
                                Default value: false. This option can be set to 'null' to clear the default value.
                              Possible values: {true, false}

TSLOTS=Integer
TSLOTS=Integer                Where to find *all* barcode(s) (i.e. sample encoding and UMIs) in the read name once has
                              been tokenized using the SPLIT character (e.g. ':').
                              This option is only considered when TRIM_HEADERS=true. When TSLOTS is ommited while
                              TRIM_HEADERS=true, the values of SLOTS apply.
                              IMPORTANT : counting starts at 1 and negative numbers can be used to start counting from
                              the end.
                              See SLOT help for examples.  Default value: null. This option may be specified 0 or more
                              times.

SPLIT_CHAR=String
SPLIT=String                  Character to use to split up the read header line, default is ':'.  Default value: :.
                              This option can be set to 'null' to clear the default value.

ASSUME_SORT_ORDER=SortOrder
ASO=SortOrder                 If not null, assume that the input file has this order even if the header says otherwise.
                              Default value: null. Possible values: {unsorted, queryname, coordinate, duplicate,
                              unknown}  Cannot be used in conjuction with option(s) ASSUME_SORTED (AS)

DUPLICATE_SCORING_STRATEGY=ScoringStrategy
DS=ScoringStrategy            The scoring strategy for choosing the non-duplicate among candidates.  Default value:
                              SUM_OF_BASE_QUALITIES. This option can be set to 'null' to clear the default value.
                              Possible values: {SUM_OF_BASE_QUALITIES, TOTAL_MAPPED_REFERENCE_LENGTH, RANDOM}

PROGRAM_RECORD_ID=String
PG=String                     The program record ID for the @PG record(s) created by this program. Set to null to
                              disable PG record creation.  This string may have a suffix appended to avoid collision
                              with other program record IDs.  Default value: MarkDuplicates. This option can be set to
                              'null' to clear the default value.

PROGRAM_GROUP_VERSION=String
PG_VERSION=String             Value of VN tag of PG record to be created. If not specified, the version will be
                              detected automatically.  Default value: null.

PROGRAM_GROUP_COMMAND_LINE=String
PG_COMMAND=String             Value of CL tag of PG record to be created. If not supplied the command line will be
                              detected automatically.  Default value: null.

PROGRAM_GROUP_NAME=String
PG_NAME=String                Value of PN tag of PG record to be created.  Default value:
                              MarkDuplicatesWithMolecularCode. This option can be set to 'null' to clear the default
                              value.

COMMENT=String
CO=String                     Comment(s) to include in the output file's header.  Default value: null. This option may
                              be specified 0 or more times.

READ_NAME_REGEX=String        Regular expression that can be used to parse read names in the incoming SAM file. Read
                              names are parsed to extract three variables: tile/region, x coordinate and y coordinate.
                              These values are used to estimate the rate of optical duplication in order to give a more
                              accurate estimated library size. Set this option to null to disable optical duplicate
                              detection, e.g. for RNA-seq or other data where duplicate sets are extremely large and
                              estimating library complexity is not an aim. Note that without optical duplicate counts,
                              library size estimation will be inaccurate. The regular expression should contain three
                              capture groups for the three variables, in order. It must match the entire read name.
                              Note that if the default regex is specified, a regex match is not actually done, but
                              instead the read name  is split on colon character. For 5 element names, the 3rd, 4th and
                              5th elements are assumed to be tile, x and y values. For 7 element names (CASAVA 1.8),
                              the 5th, 6th, and 7th elements are assumed to be tile, x and y values.  Default value:
                              <optimized capture of last three ':' separated fields as numeric values>. This option can
                              be set to 'null' to clear the default value.

OPTICAL_DUPLICATE_PIXEL_DISTANCE=Integer
                              The maximum offset between two duplicate clusters in order to consider them optical
                              duplicates. The default is appropriate for unpatterned versions of the Illumina platform.
                              For the patterned flowcell models, 2500 is moreappropriate. For other platforms and
                              models, users should experiment to find what works best.  Default value: 100. This option
                              can be set to 'null' to clear the default value.

MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=Integer
MAX_FILE_HANDLES=Integer      Maximum number of file handles to keep open when spilling read ends to disk. Set this
                              number a little lower than the per-process maximum number of file that may be open. This
                              number can be found by executing the 'ulimit -n' command on a Unix system.  Default
                              value: 8000. This option can be set to 'null' to clear the default value.

SORTING_COLLECTION_SIZE_RATIO=Double
                              This number, plus the maximum RAM available to the JVM, determine the memory footprint
                              used by some of the sorting collections.  If you are running out of memory, try reducing
                              this number.  Default value: 0.25. This option can be set to 'null' to clear the default
                              value.[help] je markdupes: ok via je markdupes --help (--help=ok, -h=ok, -help=ok, (no args)=ok)
```

## je-suite_dropseq

### Tool Description
Reformats Drop-seq files into a single fastq file: clips the cell barcode and UMI from read 1 and adds them to the header of read 2.

### Metadata
- **Docker Image**: quay.io/biocontainers/je-suite:2.0.RC--0
- **Homepage**: https://gbcs.embl.de/Je
- **Package**: https://anaconda.org/channels/bioconda/packages/je-suite/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: Jedropseq [options]

Reformat Drop-seq files into a single fastq file. DROP-seq produces 2 fastq files : one (F1) contains the cell barcode (usually 12 bp, LEN) followed by a UMI (usually 8bp, ULEN) while the second (F2) contains the RNA sequence. The output file is similar to F2 but holds the parsed barcode and UMI in read names.
Input fastq file(s) can be in gzip compressed format (end in .gz). See help for a detailled description of all options.

Example:
	je dropseq F1=file.fastq.gz F2=file.fastq.gz LEN=12 ULEN=8 O=/path/to/resultdir/out.fastq.gz

Version: 2.0.RC


Options:

--help
-h                            Displays options specific to this tool.

--stdhelp
-H                            Displays options specific to this tool AND options common to all Picard command line
                              tools.

--version                     Displays program version.

FASTQ_FILE1=File
F1=File                       Input fastq file (optionally gzipped) for first read. This read contains the cell barcode
                              followed by the UMI. Quality encoding must be Phred+33 (Standard).  Required.

FASTQ_FILE2=File
F2=File                       Input fastq file (optionally gzipped) for the second read. Quality encoding must be
                              Phred+33 (Standard).  Required.

BCLEN=Integer
LEN=Integer                   Length of the cell barcode sequence in read 1.
                                Required.

WITH_QUALITY_IN_READNAME=Boolean
WQ=Boolean                    Should quality string of barcode and UMI also be injected in read names.
                              If true, the quality string is translated into 2 digits number and a e.g. UMI will look
                              like
                              	 '...:ATGCAT333423212322:...' instead of '...:ATGCAT:...'
                              This option is particularly useful with the retag module that knows how to extract
                              quality numbers into BAM tags.  Default value: false. This option can be set to 'null' to
                              clear the default value. Possible values: {true, false}

UCLEN=Integer
ULEN=Integer                  Length of the UMI sequence in read 1 found right after the cell barcode.
                                Required.

MAX_N=Integer
N=Integer                     Maximum number of N's in the cell barcode sequence. If the cell barcode has this number
                              or more N in the sequence, the read is ignored.
                                Default value: 6. This option can be set to 'null' to clear the default value.

READ_NAME_REPLACE_CHAR=String
RCHAR=String                  Replace spaces in read name/header using provided character.
                              This is needed when you need to retain ADDed barcode in read name/header during mapping
                              as everything after space in read name is usually clipped in BAM files.
                              For example, with RCHAR=':' :
                              		'@D3FCO8P1:178:C1WLBACXX:7:1101:1836:1965 1:N:0:'
                              	becomes
                              		'@D3FCO8P1:178:C1WLBACXX:7:1101:1836:1965:1:N:0:BARCODE'
                                Default value: :. This option can be set to 'null' to clear the default value.

RESULT_FILENAME_1=String
O=String                      Result file name with headers modified.

                              Can either be a name (in which case the file will be created in the output dir) or a full
                              path.
                                Required.

FORCE=Boolean                 Allows overwriting existing files.
                                Default value: false. This option can be set to 'null' to clear the default value.
                              Possible values: {true, false}

GZIP_OUTPUTS=Boolean
GZ=Boolean                    Compress output using gzip and append a .gz extension to the result filename if necessary.
                                Default value: true. This option can be set to 'null' to clear the default value.
                              Possible values: {true, false}
```

## je-suite_retag

### Tool Description
Extracts barcode and UMI sequence(s) embedded in read names and tags reads with the proper BAM tag.

### Metadata
- **Docker Image**: quay.io/biocontainers/je-suite:2.0.RC--0
- **Homepage**: https://gbcs.embl.de/Je
- **Package**: https://anaconda.org/channels/bioconda/packages/je-suite/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: TagFromReadName [options]

Extracts barcode and UMI sequence(s) embedded in read names and tag reads with proper BAM tag.
Version: 2.0.RC


Options:

--help
-h                            Displays options specific to this tool.

--stdhelp
-H                            Displays options specific to this tool AND options common to all Picard command line
                              tools.

--version                     Displays program version.

INPUT=File
I=File                        Input SAM/BAM file  Required.

OUTPUT=File
O=File                        Output SAM/BAM file  Required.

BC_SLOT=Integer               Where to find the BARCODE(s) in the read name once read name has been tokenized using the
                              SPLIT character (e.g. ':').
                              This option can be specified multiple time when multiple BARCODES are present in read
                              header.
                              Counting starts at 1 and negative numbers can be used to start counting from the end
                              (last token is '-1').
                              BARCODE(s) extracted from read name are used to assemble a 'BC:Z:GATCCTAG' tag (BC is
                              default, see BC_TAG).
                              Following SAM specifications, in the case of multiple barcodes, all the barcodes are
                              concatenated using
                              a hyphen ('-') between the barcodes. The order of concatenation follows the order of
                              BC_SLOT in the command line.
                              For example, consider the following read name that lists 3 different barcodes in the end
                              :
                              	 HISEQ:44:C6KC0ANXX:8:2112:20670:79594:CGATGTTT:GATCCTAG:AAGGTACG
                              	 to indicate that the three slots contain barcodes, use
                              		 BC_SLOT=-1 BC_SLOT=-2 BC_SLOT=-3 ; which will result as BC:Z:AAGGTACG-GATCCTAG-CGATGTTT
                              	 if only the 2 last ones should be considered, use
                              		 BC_SLOT=-1 BC_SLOT=-2 ; which will result as BC:Z:AAGGTACG-GATCCTAG	 Note that BC_SLOT
                              order matters as :
                              		 BC_SLOT=-2 BC_SLOT=-1 ; would result as BC:Z:GATCCTAG-AAGGTACG  Default value: null.
                              This option may be specified 0 or more times.

UMI_SLOT=Integer              Where to find the UMI(s) in the read name once read name has been tokenized using the
                              SPLIT character (e.g. ':').
                              This option can be specified multiple time when multiple UMIs are present in read header.
                              Counting starts at 1 and negative numbers can be used to start counting from the end
                              (last token is '-1').
                              UMI(s) extracted from read name are used to assemble both a RX and OX tag e.g.
                              'RX:Z:GATCCTAG' tag.
                              Following SAM specifications, in the case of multiple UMIs, all the UMIs are concatenated
                              using
                              a hyphen ('-'). The order of concatenation follows the order of UMI_SLOT in the command
                              line.
                              For example, consider the following read name that lists 3 different sequence codes in
                              the end :
                              	 HISEQ:44:C6KC0ANXX:8:2112:20670:79594:CGATGTTT:GATCCTAG:AAGGTACG
                              	 to indicate that the 2 last slots contain UMIs, use
                              		 UMI_SLOT=-1 UMI_SLOT=-2 ; which will result as RX:Z:AAGGTACG-GATCCTAG	 Note that
                              UMI_SLOT order matters as :
                              		 UMI_SLOT=-2 UMI_SLOT=-1 ; would result as RX:Z:GATCCTAG-AAGGTACG  Default value: null.
                              This option may be specified 0 or more times.

CLUSTERED_CODES_FILE=File
CC=File                       Group of barcodes (clusters) for on-the-fly correction of the BARCODEs. This file
                              contains mapping between the barcodes sequences
                              as originally found in the FASTQ reads (and in the read name of the input BAM) and the
                              corrected sample barcode
                              sequences (e.g. as identified by clustering with mismatches using tools like starcode or
                              vsearch )
                              that should be written in the BC tag in place of the original sequence.
                              If provided, the BARCODE sequence(s) extracted from read name are converted to the 'real'
                              barcodes according
                              to the mapping described in this file. If the sequence is not found in the supplied
                              mapping file, the read is either
                              trashed or kept (according to option KEEP_UNASSIGNED_BARCODES), in which case the value
                              defined by UNASSIGNED_BARCODE_VALUE
                              is used.
                              Format: two column text file, one cluster per line with the real barcode in the first
                              line and the comma separated
                              list of codes in the second column i.e. :
                              		 ACTGTAC 	ACTCTAC,TCTGTAC,ACTGTAG
                              All the codes MUST have the same length  Default value: null.

KEEP_UNASSIGNED_BARCODES=Boolean
KUP=Boolean                   Should read be keep when no mapping was defined for the orginal barcode sequence in
                              provided CLUSTERED_CODES_FILE.
                              If false, the read is not written in output file.  Default value: true. This option can
                              be set to 'null' to clear the default value. Possible values: {true, false}

UNASSIGNED_BARCODE_VALUE=String
UBV=String                    Value to use for the BARCODE tag when CLUSTERED_CODES_FILE was provided and no mapping
                              was defined for the orginal barcode sequence.  Default value: NA. This option can be set
                              to 'null' to clear the default value.

TRIM_HEADERS=Boolean
T=Boolean                     Should barcode/UMIs information be removed from read names in the output BAM ?   Default
                              value: false. This option can be set to 'null' to clear the default value. Possible
                              values: {true, false}

TSLOTS=Integer
TSLOTS=Integer                Where to find *all* barcode(s) and UMIs in the read name once has been tokenized using
                              the SPLIT character (e.g. ':').
                              This option is only considered when TRIM_HEADERS=true and should only be used when
                              UMI_SLOT and BC_SLOT do not
                              describe all the slots that should be trimmed. When TSLOTS is ommited while
                              TRIM_HEADERS=true, the values
                              of UMI_SLOT and BC_SLOT apply.
                              IMPORTANT : counting starts at 1 and negative numbers can be used to start counting from
                              the end.
                              See UMI_SLOT help for examples.  Default value: null. This option may be specified 0 or
                              more times.

SPLIT_CHAR=String
SPLIT=String                  Character to use to split up the read header line, default is ':'.  Default value: :.
                              This option can be set to 'null' to clear the default value.

BC_TAG=String                 SAM Tag to use to store barcode(s) sequences extracted from barcode slots (BC by
                              default). Do not change unless you have good reasons to.  Default value: BC. This option
                              can be set to 'null' to clear the default value.

QT_TAG=String                 SAM Tag to use to store barcode(s) quality score extracted from barcode slots (QT by
                              default). Do not change unless you have good reasons to.  Default value: QT. This option
                              can be set to 'null' to clear the default value.

WITH_RX=Boolean               Should the RX (and QX when relevant) SAM Tag(s) be used to store UMI(s) sequence (and
                              quality) extracted from UMI slots. Set to FALSE if you don't want these tags to be set.
                              Default value: true. This option can be set to 'null' to clear the default value.
                              Possible values: {true, false}

WITH_OX=Boolean               Should the OX (and BZ when relevant) SAM Tag(s) be used to store UMI(s) sequence (and
                              quality) extracted from UMI slots. Set to FALSE if you don't want these tags to be set.
                              Default value: true. This option can be set to 'null' to clear the default value.
                              Possible values: {true, false}

UMI_SEQ_TAG=String            SAM Tag to use to store original UMI(s) sequence extracted from UMI slots (instead of RX
                              / OX)  Default value: null.

UMI_QUAL_TAG=String           SAM Tag to use to store original UMI(s) sequence extracted from UMI slots (instead of QX
                              / BZ)  Default value: null.

ADD_RG=Boolean
ARG=Boolean                   Should a read group be created for each barcode. This option is only considered when
                              providing a CLUSTERED_CODES_FILE.  Default value: false. This option can be set to 'null'
                              to clear the default value. Possible values: {true, false}

RGPL=String                   Read Group platform (e.g. illumina, solid) ; only considered when RG=true  Default value:
                              null.

RGPG=String                   Read Group program group; only considered when RG=true  Default value: null.

PROGRAM_RECORD_ID=String
PG=String                     The program record ID for the @PG record(s) created by this program. Set to null to
                              disable PG record creation.  This string may have a suffix appended to avoid collision
                              with other program record IDs.  Default value: TagFromReadName. This option can be set to
                              'null' to clear the default value.

PROGRAM_GROUP_VERSION=String
PG_VERSION=String             Value of VN tag of PG record to be created. If not specified, the version will be
                              detected automatically.  Default value: null.

PROGRAM_GROUP_COMMAND_LINE=String
PG_COMMAND=String             Value of CL tag of PG record to be created. If not supplied the command line will be
                              detected automatically.  Default value: null.

PROGRAM_GROUP_NAME=String
PG_NAME=String                Value of PN tag of PG record to be created.  Default value: TagFromReadName. This option
                              can be set to 'null' to clear the default value.

COMMENT=String
CO=String                     Comment(s) to include in the output file's header.  Default value: null. This option may
                              be specified 0 or more times.[help] je retag: ok via je retag --help (--help=ok, -h=ok, -help=ok, (no args)=ok)
```
