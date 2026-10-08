cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgbio
label: fgbio_AnnotateBamWithUmis
doc: 'Annotates existing BAM files with UMIs (Unique Molecular Indices, aka Molecular
  IDs, Molecular barcodes) from separate FASTQ files. Takes an existing BAM file and
  either one FASTQ file with UMI reads or multiple FASTQs if there are multiple UMIs
  per template, matches the reads between the files based on read names, and produces
  an output BAM file where each record is annotated with an optional tag (specified
  by ''attribute'') that contains the read sequence of the UMI. Trailing read numbers
  (''/1'' or ''/2'') are removed from FASTQ read names, as is any text after whitespace,
  before matching. If multiple UMI segments are specified (see ''--read-structure'')
  across one or more FASTQs, they are delimited in the same order as FASTQs are specified
  on the command line. The delimiter is controlled by the ''--delimiter'' option.


  The ''--read-structure'' option may be used to specify which bases in the FASTQ
  contain UMI bases. Otherwise it is assumed the FASTQ contains only UMI bases.


  The ''--sorted'' option may be used to indicate that the FASTQ has the same reads
  and is sorted in the same order as the BAM file.


  At the end of execution, reports how many records were processed and how many were
  missing UMIs. If any read from the BAM file did not have a matching UMI read in
  the FASTQ file, the program will exit with a non-zero exit status. The ''--fail-fast''
  option may be specified to cause the program to terminate the first time it finds
  a records without a matching UMI.


  In order to avoid sorting the input files, the entire UMI fastq file(s) is read
  into memory. As a result the program needs to be run with memory proportional the
  size of the (uncompressed) fastq(s). Use the ''--sorted'' option to traverse the
  UMI fastq and BAM files assuming they are in the same order. More precisely, the
  UMI fastq file will be traversed first, reading in the next set of BAM reads with
  same read name as the UMI''s read name. Those BAM reads will be annotated. If no
  BAM reads exist for the UMI, no logging or error will be reported.


  Tool homepage: https://github.com/fulcrumgenomics/fgbio'
inputs:
  - id: async_io
    type:
      - 'null'
      - boolean
    doc: Use asynchronous I/O where possible, e.g. for SAM and BAM files.
    inputBinding:
      position: 1
      prefix: --async-io
  - id: attribute
    type:
      - 'null'
      - string
    doc: The BAM attribute to store UMI bases in.
    inputBinding:
      position: 101
      prefix: --attribute
  - id: compression
    type:
      - 'null'
      - int
    doc: Default GZIP compression level, BAM compression level.
    inputBinding:
      position: 1
      prefix: --compression
  - id: cram_ref_fasta
    type:
      - 'null'
      - File
    doc: Reference FASTA for CRAM encoding/decoding.
    inputBinding:
      position: 1
      prefix: --cram-ref-fasta
  - id: fail_fast
    type:
      - 'null'
      - boolean
    doc: If set, fail on the first missing UMI.
    inputBinding:
      position: 101
      prefix: --fail-fast
  - id: fastq
    type:
      type: array
      items: File
    doc: Input FASTQ(s) with UMI reads.
    inputBinding:
      position: 101
      prefix: --fastq
  - id: input_bam
    type: File
    doc: The input SAM or BAM file.
    inputBinding:
      position: 101
      prefix: --input
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Minimum severity log-level to emit. Options: Debug, Info, Warning, Error,
      Fatal.'
    inputBinding:
      position: 1
      prefix: --log-level
  - id: output_bam
    type: string
    doc: Output BAM file to write.
    inputBinding:
      position: 101
      prefix: --output
  - id: qual_attribute
    type:
      - 'null'
      - string
    doc: The BAM attribute to store UMI qualities in.
    inputBinding:
      position: 101
      prefix: --qual-attribute
  - id: read_structure
    type:
      - 'null'
      - type: array
        items: string
    doc: The read structure for the FASTQ, otherwise all bases will be used.
    inputBinding:
      position: 101
      prefix: --read-structure
  - id: sam_validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for SAM/BAM reading. Options: STRICT, LENIENT, SILENT.'
    inputBinding:
      position: 1
      prefix: --sam-validation-stringency
  - id: sorted
    type:
      - 'null'
      - boolean
    doc: Whether the FASTQ file is sorted in the same order as the BAM.
    inputBinding:
      position: 101
      prefix: --sorted
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: Directory to use for temporary files.
    inputBinding:
      position: 1
      prefix: --tmp-dir
arguments:
  - position: 50
    valueFrom: AnnotateBamWithUmis
outputs:
  - id: output_bam_out
    type: File
    doc: Output BAM file to write.
    outputBinding:
      glob: $(inputs.output_bam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
