cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fgbio
  - DemuxFastqs
label: fgbio_DemuxFastqs
doc: "Performs sample demultiplexing on FASTQs.\n\nPlease see https://github.com/fulcrumgenomics/fqtk
  for a faster and supported replacement\n\nThe sample barcode for each sample in
  the sample sheet will be compared against the sample barcode bases extracted from\n\
  the FASTQs, to assign each read to a sample. Reads that do not match any sample
  within the given error tolerance will\nbe placed in the 'unmatched' file.\n\nThe
  type of output is specified with the '--output-type' option, and can be BAM ('--output-type
  Bam'), gzipped FASTQ\n('--output-type Fastq'), or both ('--output-type BamAndFastq').\n\
  \nFor BAM output, the output directory will contain one BAM file per sample in the
  sample sheet or metadata CSV file, \nplus a BAM for reads that could not be assigned
  to a sample given the criteria. The output file names will be the\nconcatenation
  of sample id, sample name, and sample barcode bases (expected not observed), delimited
  by '-'. A metrics\nfile will also be output providing analogous information to the
  metric described SampleBarcodeMetric\n(http://fulcrumgenomics.github.io/fgbio/metrics/latest/#samplebarcodemetric).\n\
  \nFor gzipped FASTQ output, one or more gzipped FASTQs per sample in the sample
  sheet or metadata CSV file will be\nwritten to the output directory. For paired
  end data, the output will have the suffix '_R1.fastq.gz' and '_R2.fastq.gz'\nfor
  read one and read two respectively. The sample barcode and molecular barcodes (concatenated)
  will be appended to\nthe read name and delimited by a colon. If the '--illumina-standards'
  option is given, then the output read names and\nfile names will follow the Illumina
  standards described here\n(https://help.basespace.illumina.com/articles/tutorials/upload-data-using-web-uploader/).\n\
  \nThe output base qualities will be standardized to Sanger/SAM format.\n\nFASTQs
  and associated read structures for each sub-read should be given:\n\n  * a single
  fragment read should have one FASTQ and one read structure\n  * paired end reads
  should have two FASTQs and two read structures\n  * a dual-index sample with paired
  end reads should have four FASTQs and four read structures given: two for the two\n\
  \    index reads, and two for the template reads.\n\nIf multiple FASTQs are present
  for each sub-read, then the FASTQs for each sub-read should be concatenated together\n\
  prior to running this tool (ex. 'cat s_R1_L001.fq.gz s_R1_L002.fq.gz > s_R1.fq.gz').\n\
  \nRead structures (https://github.com/fulcrumgenomics/fgbio/wiki/Read-Structures)
  are made up of '<number><operator>'\npairs much like the 'CIGAR' string in BAM files.
  Four kinds of operators are supported by this tool:\n\n  1. 'T' identifies a template
  read\n  2. 'B' identifies a sample barcode read\n  3. 'M' identifies a unique molecular
  index read\n  4. 'S' identifies a set of bases that should be skipped or ignored\n\
  \nThe last '<number><operator>' pair may be specified using a '+' sign instead of
  number to denote \"all remaining bases\".\nThis is useful if, e.g., fastqs have
  been trimmed and contain reads of varying length. Both reads must have template\n\
  bases. Any molecular identifiers will be concatenated using the '-' delimiter and
  placed in the given SAM record tag\n('RX' by default). Similarly, the sample barcode
  bases from the given read will be placed in the 'BC' tag.\n\nMetadata about the
  samples should be given in either an Illumina Experiment Manager sample sheet or
  a metadata CSV\nfile. Formats are described in detail below.\n\nThe read structures
  will be used to extract the observed sample barcode, template bases, and molecular
  identifiers from\neach read. The observed sample barcode will be matched to the
  sample barcodes extracted from the bases in the sample\nmetadata and associated
  read structures.\n\nSample Sheet\n------------\n\nThe read group's sample id, sample
  name, and library id all correspond to the similarly named values in the sample\n\
  sheet. Library id will be the sample id if not found, and the platform unit will
  be the sample name concatenated with\nthe sample barcode bases delimited by a '.'.\n\
  \nThe sample section of the sample sheet should contain information related to each
  sample with the following columns:\n\n  * Sample_ID: The sample identifier unique
  to the sample in the sample sheet.\n  * Sample_Name: The sample name.\n  * Library_ID:
  The library Identifier. The combination sample name and library identifier should
  be unique across the\n    samples in the sample sheet.\n  * Description: The description
  of the sample, which will be placed in the description field in the output BAM's
  read\n    group. This column may be omitted.\n  * Sample_Barcode: The sample barcode
  bases unique to each sample. The name of the column containing the sample\n    barcode
  can be changed using the '--column-for-sample-barcode' option. If the sample barcode
  is present across\n    multiple reads (ex. dual-index, or inline in both reads of
  a pair), then the expected barcode bases from each read\n    should be concatenated
  in the same order as the order of the reads' FASTQs and read structures given to
  this tool.\n\nMetadata CSV\n------------\n\nIn lieu of a sample sheet, a simple
  CSV file may be provided with the necessary metadata. This file should contain the\n\
  same columns as described above for the sample sheet ('Sample_ID', 'Sample_Name',
  'Library_ID', and 'Description').\n\nExample Command Line\n--------------------\n\
  \nAs an example, if the sequencing run was 2x100bp (paired end) with two 8bp index
  reads both reading a sample barcode, \nas well as an in-line 8bp sample barcode
  in read one, the command line would be\n\n  --inputs r1.fq i1.fq i2.fq r2.fq --read-structures
  8B92T 8B 8B 100T \\\n      --metadata SampleSheet.csv --metrics metrics.txt --output
  output_folder\n\nOutput Standards\n----------------\n\nThe following options affect
  the output format:\n\n  1. If '--omit-fastq-read-numbers' is specified, then trailing
  /1 and /2 for R1 and R2 respectively, will not be\n     appended to e FASTQ read
  name. By default they will be appended.\n  2. If '--include-sample-barcodes-in-fastq'
  is specified, then sample barcode will replace the last field in the first\n   \
  \  comment in the FASTQ header, e.g. replace 'NNNNNN' in the header '@Instrument:RunID:FlowCellID:Lane:X:Y\n\
  \     1:N:0:NNNNNN'\n  3. If '--illumina-file-names' is specified, the output files
  will be named according to the Illumina FASTQ file\n     naming conventions:\n\n\
  a. The file extension will be '_R1_001.fastq.gz' for read one, and '_R2_001.fastq.gz'
  for read two (if paired end). b.\nThe per-sample output prefix will be '<SampleName>_S<SampleOrdinal>_L<LaneNumber>'
  (without angle brackets).\n\nOptions (1) and (2) require the input FASTQ read names
  to contain the following elements:\n\n'@<instrument>:<run number>:<flowcell ID>:<lane>:<tile>:<x-pos>:<y-pos>
  <read>:<is filtered>:<control number>:<index>'\n\nSee the Illumina FASTQ conventions
  for more details.\n(https://support.illumina.com/help/BaseSpace_OLH_009008/Content/Source/Informatics/BS/FASTQFiles_Intro_swBS.htm)\n\
  \nUse the following options to upload to Illumina BaseSpace:\n\n'--omit-fastq-read-numbers=true
  --include-sample-barcodes-in-fastq=false --illumina-file-names=true'\n\nSee the
  Illumina BaseSpace standards described here\n(https://help.basespace.illumina.com/articles/tutorials/upload-data-using-web-uploader/).\n\
  \nTo output with recent Illumina conventions (circa 2021) that match 'bcl2fastq'
  and 'BCLconvert', use:\n\n'--omit-fastq-read-numbers=true --include-sample-barcodes-in-fastq=true
  --illumina-file-names=true'\n\nBy default all input reads are output. If your input
  FASTQs contain reads that do not pass filter (as defined by the\nY/N filter flag
  in the FASTQ comment) these can be filtered out during demultiplexing using the
  '--omit-failing-reads'\noption.\n\nTo output only reads that are not control reads,
  as encoded in the '<control number>' field in the header comment, use\nthe '--omit-control-reads'
  flag\n\nTool homepage: https://github.com/fulcrumgenomics/fgbio"
inputs:
  - id: column_for_sample_barcode
    type:
      - 'null'
      - string
    doc: The column name in the sample sheet or metadata CSV for the sample 
      barcode.
    inputBinding:
      position: 101
      prefix: --column-for-sample-barcode
  - id: comments
    type:
      - 'null'
      - type: array
        items: string
    doc: Comment(s) to include in the merged output file's header.
    inputBinding:
      position: 101
      prefix: --comments
  - id: illumina_file_names
    type:
      - 'null'
      - boolean
    doc: Name the output files according to the Illumina file name standards.
    inputBinding:
      position: 101
      prefix: --illumina-file-names
  - id: include_all_bases_in_fastqs
    type:
      - 'null'
      - boolean
    doc: Output all bases (i.e. all sample barcode, molecular barcode, skipped, 
      and template bases) for every read with template bases (ex. read one and 
      read two) as defined by the corresponding read structure(s).
    inputBinding:
      position: 101
      prefix: --include-all-bases-in-fastqs
  - id: include_sample_barcodes_in_fastq
    type:
      - 'null'
      - boolean
    doc: Insert the sample barcode into the FASTQ header.
    inputBinding:
      position: 101
      prefix: --include-sample-barcodes-in-fastq
  - id: inputs
    type:
      type: array
      items: File
    doc: One or more input fastq files each corresponding to a sub-read (ex. 
      index-read, read-one, read-two, fragment).
    inputBinding:
      position: 101
      prefix: --inputs
  - id: mask_bases_below_quality
    type:
      - 'null'
      - int
    doc: Mask bases with a quality score below the specified threshold as Ns
    inputBinding:
      position: 101
      prefix: --mask-bases-below-quality
  - id: max_mismatches
    type:
      - 'null'
      - int
    doc: Maximum mismatches for a barcode to be considered a match.
    inputBinding:
      position: 101
      prefix: --max-mismatches
  - id: max_no_calls
    type:
      - 'null'
      - int
    doc: Maximum allowable number of no-calls in a barcode read before it is 
      considered unmatchable.
    inputBinding:
      position: 101
      prefix: --max-no-calls
  - id: metadata
    type: File
    doc: A file containing the metadata about the samples.
    inputBinding:
      position: 101
      prefix: --metadata
  - id: metrics
    type:
      - 'null'
      - File
    doc: The file to which per-barcode metrics are written. If none given, a 
      file named 'demux_barcode_metrics.txt' will be written to the output 
      directory.
    inputBinding:
      position: 101
      prefix: --metrics
  - id: min_mismatch_delta
    type:
      - 'null'
      - int
    doc: Minimum difference between number of mismatches in the best and second 
      best barcodes for a barcode to be considered a match.
    inputBinding:
      position: 101
      prefix: --min-mismatch-delta
  - id: omit_control_reads
    type:
      - 'null'
      - boolean
    doc: Do not keep reads identified as control if true, otherwise keep all 
      reads. Control reads are determined from the comment in the FASTQ header.
    inputBinding:
      position: 101
      prefix: --omit-control-reads
  - id: omit_failing_reads
    type:
      - 'null'
      - boolean
    doc: Keep only passing filter reads if true, otherwise keep all reads. 
      Passing filter reads are determined from the comment in the FASTQ header.
    inputBinding:
      position: 101
      prefix: --omit-failing-reads
  - id: omit_fastq_read_numbers
    type:
      - 'null'
      - boolean
    doc: Do not include trailing /1 or /2 for R1 and R2 in the FASTQ read name.
    inputBinding:
      position: 101
      prefix: --omit-fastq-read-numbers
  - id: output
    type: Directory
    doc: The output directory in which to place sample BAMs.
    inputBinding:
      position: 101
      prefix: --output
  - id: output_type
    type:
      - 'null'
      - string
    doc: The type of outputs to produce.
    inputBinding:
      position: 101
      prefix: --output-type
  - id: platform
    type:
      - 'null'
      - string
    doc: Platform to insert into the read group header of BAMs (e.g Illumina)
    inputBinding:
      position: 101
      prefix: --platform
  - id: platform_model
    type:
      - 'null'
      - string
    doc: Platform model to insert into the group header (ex. miseq, hiseq2500, 
      hiseqX)
    inputBinding:
      position: 101
      prefix: --platform-model
  - id: platform_unit
    type:
      - 'null'
      - string
    doc: The platform unit (typically 
      '<flowcell-barcode>-<sample-barcode>.<lane>')
    inputBinding:
      position: 101
      prefix: --platform-unit
  - id: predicted_insert_size
    type:
      - 'null'
      - int
    doc: Predicted median insert size, to insert into the read group header
    inputBinding:
      position: 101
      prefix: --predicted-insert-size
  - id: quality_format
    type:
      - 'null'
      - string
    doc: A value describing how the quality values are encoded in the FASTQ. 
      Either Solexa for pre-pipeline 1.3 style scores (solexa scaling + 66), 
      Illumina for pipeline 1.3 and above (phred scaling + 64) or Standard for 
      phred scaled scores with a character shift of 33. If this value is not 
      specified, the quality format will be detected automatically.
    inputBinding:
      position: 101
      prefix: --quality-format
  - id: read_structures
    type:
      type: array
      items: string
    doc: The read structure for each of the FASTQs.
    inputBinding:
      position: 101
      prefix: --read-structures
  - id: run_date
    type:
      - 'null'
      - string
    doc: Date the run was produced, to insert into the read group header
    inputBinding:
      position: 101
      prefix: --run-date
  - id: sequencing_center
    type:
      - 'null'
      - string
    doc: The sequencing center from which the data originated
    inputBinding:
      position: 101
      prefix: --sequencing-center
  - id: sort_order
    type:
      - 'null'
      - string
    doc: The sort order for the output sam/bam file (typically unsorted or 
      queryname).
    inputBinding:
      position: 101
      prefix: --sort-order
  - id: threads
    type:
      - 'null'
      - int
    doc: 'The number of threads to use while de-multiplexing. The performance does
      not increase linearly with the # of threads and seems not to improve beyond
      2-4 threads.'
    inputBinding:
      position: 101
      prefix: --threads
  - id: umi_tag
    type:
      - 'null'
      - string
    doc: The SAM tag for any molecular barcode. If multiple molecular barcodes 
      are specified, they will be concatenated and stored here.
    inputBinding:
      position: 101
      prefix: --umi-tag
  - id: unmatched
    type:
      - 'null'
      - string
    doc: Output BAM file name for the unmatched records.
    inputBinding:
      position: 101
      prefix: --unmatched
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
stdout: fgbio_DemuxFastqs.out
