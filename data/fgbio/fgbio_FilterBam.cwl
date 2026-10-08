cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgbio
label: fgbio_FilterBam
doc: 'Filters reads out of a BAM file. Removes reads that may not be useful in downstream
  processing or visualization. By default will remove unmapped reads, reads with MAPQ=0,
  reads marked as secondary alignments, reads marked as duplicates, and if a set of
  Intervals are provided, reads that do not overlap any of the intervals.


  If ''--min-insert-size'' or ''--min-mapped-bases'' is specified, unmapped reads
  will also be removed even if ''--remove-unmapped-reads'' is false.


  NOTE: this will usually produce a BAM file in which some mate-pairs are orphaned
  (i.e. read 1 or read 2 is included, but not both), but does not update any flag
  fields.


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
  - id: input_bam
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
    type: File
    doc: Input BAM file.
    inputBinding:
      position: 101
      prefix: --input
  - id: intervals
    type:
      - 'null'
      - File
    doc: Optionally remove reads not overlapping intervals.
    inputBinding:
      position: 101
      prefix: --intervals
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Minimum severity log-level to emit. Options: Debug, Info, Warning, Error,
      Fatal.'
    inputBinding:
      position: 1
      prefix: --log-level
  - id: max_insert_size
    type:
      - 'null'
      - int
    doc: Remove all reads with insert size > this value.
    inputBinding:
      position: 101
      prefix: --max-insert-size
  - id: min_insert_size
    type:
      - 'null'
      - int
    doc: Remove all reads with insert size < this value.
    inputBinding:
      position: 101
      prefix: --min-insert-size
  - id: min_map_q
    type:
      - 'null'
      - int
    doc: Remove all mapped reads with MAPQ lower than this number.
    inputBinding:
      position: 101
      prefix: --min-map-q
  - id: min_mapped_bases
    type:
      - 'null'
      - int
    doc: Remove reads with fewer than this many mapped bases.
    inputBinding:
      position: 101
      prefix: --min-mapped-bases
  - id: output_bam
    type: string
    doc: Output BAM file.
    inputBinding:
      position: 101
      prefix: --output
  - id: rejects_bam
    type:
      - 'null'
      - string
    doc: Optional output SAM or BAM file to write reads not kept.
    inputBinding:
      position: 101
      prefix: --rejects
  - id: remove_duplicates
    type:
      - 'null'
      - boolean
    doc: If true remove all reads that are marked as duplicates.
    inputBinding:
      position: 101
      prefix: --remove-duplicates
      separate: false
      valueFrom: $("=" + self)
  - id: remove_secondary_alignments
    type:
      - 'null'
      - boolean
    doc: Remove all reads marked as secondary alignments.
    inputBinding:
      position: 101
      prefix: --remove-secondary-alignments
      separate: false
      valueFrom: $("=" + self)
  - id: remove_single_end_mappings
    type:
      - 'null'
      - boolean
    doc: Removes non-PE reads and any read whose mate pair is unmapped.
    inputBinding:
      position: 101
      prefix: --remove-single-end-mappings
  - id: remove_unmapped_reads
    type:
      - 'null'
      - boolean
    doc: Remove all unmapped reads.
    inputBinding:
      position: 101
      prefix: --remove-unmapped-reads
      separate: false
      valueFrom: $("=" + self)
  - id: sam_validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for SAM/BAM reading. Options: STRICT, LENIENT, SILENT.'
    inputBinding:
      position: 1
      prefix: --sam-validation-stringency
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
    valueFrom: FilterBam
outputs:
  - id: output_bam_out
    type: File
    doc: Output BAM file.
    outputBinding:
      glob: $(inputs.output_bam)
  - id: rejects_bam_out
    type:
      - 'null'
      - File
    doc: Optional output SAM or BAM file to write reads not kept.
    outputBinding:
      glob: $(inputs.rejects_bam)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
