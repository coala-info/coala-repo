cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fgbio
  - FastqToBam
label: fgbio_FastqToBam
doc: "Generates an unmapped BAM (or SAM or CRAM) file from fastq files. Takes in one
  or more fastq files (optionally gzipped), each representing a different sequencing
  read (e.g. R1, R2, I1 or I2) and can use a set of read structures to allocate bases
  in those reads to template reads, sample indices, unique molecular indices, cell
  barcodes, or to designate bases to be skipped over.\n\nTool homepage: https://github.com/fulcrumgenomics/fgbio"
inputs:
  - id: barcode
    type:
      - 'null'
      - string
    doc: Library or Sample barcode sequence.
    inputBinding:
      position: 101
      prefix: --barcode
  - id: cell_qual_tag
    type:
      - 'null'
      - string
    doc: Tag in which to store the cellular barcodes qualities.
    inputBinding:
      position: 101
      prefix: --cell-qual-tag
  - id: cell_tag
    type:
      - 'null'
      - string
    doc: Tag in which to store the cellular barcodes.
    default: CB
    inputBinding:
      position: 101
      prefix: --cell-tag
  - id: comment
    type:
      - 'null'
      - type: array
        items: string
    doc: Comment(s) to include in the output file's header.
    inputBinding:
      position: 101
      prefix: --comment
  - id: description
    type:
      - 'null'
      - string
    doc: Description of the read group.
    inputBinding:
      position: 101
      prefix: --description
  - id: extract_umis_from_read_names
    type:
      - 'null'
      - boolean
    doc: Extract UMI(s) from read names and prepend to UMIs from reads.
    default: false
    inputBinding:
      position: 101
      prefix: --extract-umis-from-read-names
  - id: input_fastq
    type:
      type: array
      items: File
    doc: Fastq files corresponding to each sequencing read (e.g. R1, I1, etc.).
    inputBinding:
      position: 101
      prefix: --input
  - id: library
    type:
      - 'null'
      - string
    doc: The name/ID of the sequenced library.
    inputBinding:
      position: 101
      prefix: --library
  - id: platform
    type:
      - 'null'
      - string
    doc: Sequencing Platform.
    default: illumina
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
    doc: Platform unit (e.g. '<flowcell-barcode>.<lane>.<sample-barcode>')
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
  - id: read_group_id
    type:
      - 'null'
      - string
    doc: Read group ID to use in the file header.
    default: A
    inputBinding:
      position: 101
      prefix: --read-group-id
  - id: read_structures
    type:
      - 'null'
      - type: array
        items: string
    doc: Read structures, one for each of the FASTQs.
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
  - id: sample
    type:
      - 'null'
      - string
    doc: The name of the sequenced sample.
    inputBinding:
      position: 101
      prefix: --sample
  - id: sequencing_center
    type:
      - 'null'
      - string
    doc: The sequencing center from which the data originated
    inputBinding:
      position: 101
      prefix: --sequencing-center
  - id: sort
    type:
      - 'null'
      - boolean
    doc: If true, queryname sort the BAM file, otherwise preserve input order.
    default: false
    inputBinding:
      position: 101
      prefix: --sort
  - id: store_sample_barcode_qualities
    type:
      - 'null'
      - boolean
    doc: Store the sample barcode qualities in the QT Tag.
    default: false
    inputBinding:
      position: 101
      prefix: --store-sample-barcode-qualities
  - id: umi_qual_tag
    type:
      - 'null'
      - string
    doc: Tag in which to store molecular barcode/UMI qualities.
    inputBinding:
      position: 101
      prefix: --umi-qual-tag
  - id: umi_tag
    type:
      - 'null'
      - string
    doc: Tag in which to store molecular barcodes/UMIs.
    default: RX
    inputBinding:
      position: 101
      prefix: --umi-tag
outputs:
  - id: output_bam
    type:
      - 'null'
      - File
    doc: The output SAM or BAM file to be written.
    outputBinding:
      glob: $(inputs.output_bam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
