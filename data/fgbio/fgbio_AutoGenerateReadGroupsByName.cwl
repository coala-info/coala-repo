cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgbio
label: fgbio_AutoGenerateReadGroupsByName
doc: "Adds read groups to a BAM file for a single sample by parsing the read names.\n\
  \nWill add one or more read groups by parsing the read names. The read names should\
  \ be of the form:\n\n  <instrument>:<run number>:<flowcell ID>:<lane>:<tile>:<xpos>:<y-pos>\n\
  \nEach unique combination of '<instrument>:<run number>:<flowcell ID>:<lane>' will\
  \ be its own read group. The ID of the\nread group will be an integer and the platform\
  \ unit will be '<flowcell-id>.<lane>'.\n\nThe input is assumed to contain reads\
  \ for one sample and library. Therefore, the sample and library must be given and\n\
  will be applied to all read groups. Read groups will be replaced if present.\n\n\
  Two passes will be performed on the input: first to gather all the read groups,\
  \ and second to write the output BAM\nfile.\n\nTool homepage: https://github.com/fulcrumgenomics/fgbio"
inputs:
  - id: async_io
    type:
      - 'null'
      - boolean
    doc: Use asynchronous I/O where possible, e.g. for SAM and BAM files.
    inputBinding:
      position: 1
      prefix: --async-io
      separate: false
      valueFrom: $("=" + self)
  - id: comments
    type:
      - 'null'
      - string[]
    doc: Comment(s) to include in the merged output file's header.
    inputBinding:
      position: 101
      prefix: --comments
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
  - id: description
    type:
      - 'null'
      - string
    doc: Description inserted into the read groups
    inputBinding:
      position: 101
      prefix: --description
  - id: input_bam
    type: File
    doc: Input SAM or BAM file
    inputBinding:
      position: 101
      prefix: --input
  - id: library
    type: string
    doc: The library to insert into the read groups
    inputBinding:
      position: 101
      prefix: --library
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
    doc: Output SAM or BAM file
    inputBinding:
      position: 101
      prefix: --output
  - id: platform_model
    type:
      - 'null'
      - string
    doc: Platform model to insert into the groups (free-form text providing further
      details of the platform/technology used)
    inputBinding:
      position: 101
      prefix: --platform-model
  - id: predicted_insert_size
    type:
      - 'null'
      - int
    doc: eger Predicted median insert size, to insert into the read groups
    inputBinding:
      position: 101
      prefix: --predicted-insert-size
  - id: program_group
    type:
      - 'null'
      - string
    doc: Program group to insert into the read groups
    inputBinding:
      position: 101
      prefix: --program-group
  - id: run_date
    type:
      - 'null'
      - string
    doc: 'Date the run was produced (ISO 8601: ''YYYY-MM-DD'' ), to insert into the
      read groups'
    inputBinding:
      position: 101
      prefix: --run-date
  - id: sam_validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for SAM/BAM reading. Options: STRICT, LENIENT, SILENT.'
    inputBinding:
      position: 1
      prefix: --sam-validation-stringency
  - id: sample
    type: string
    doc: The sample to insert into the read groups
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
  - id: sort_order
    type:
      - 'null'
      - string
    doc: 'The sort order for the output sam/bam file. Options: Coordinate, Queryname,
      Random, RandomQuery, TemplateCoordinate, Unsorted, Unknown.'
    inputBinding:
      position: 101
      prefix: --sort-order
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
    valueFrom: AutoGenerateReadGroupsByName
outputs:
  - id: output_bam_out
    type: File
    doc: Output SAM or BAM file.
    outputBinding:
      glob: $(inputs.output_bam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
requirements:
  - class: InlineJavascriptRequirement
