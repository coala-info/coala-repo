cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgbio
label: fgbio_SetMateInformation
doc: 'Adds and/or fixes mate information on paired-end reads. Sets the MQ (mate mapping
  quality), ''MC'' (mate cigar string), ensures all mate-related flag fields are set
  correctly, and that the mate reference and mate start position are correct.


  Supplementary records are handled correctly (updated with their mate''s non-supplemental
  attributes). Secondary alignments are passed through but are not updated.


  The input file must be query-name sorted or query-name grouped (i.e. all records
  from the same query sequence must be adjacent in the file, though the ordering between
  queries is unspecified).


  Tool homepage: https://github.com/fulcrumgenomics/fgbio'
inputs:
  - id: allow_missing_mates
    type:
      - 'null'
      - boolean
    doc: If specified, do not fail when reads marked as paired are missing their mate
      pairs.
    inputBinding:
      position: 101
      prefix: --allow-missing-mates
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
    type: File
    doc: Input SAM/BAM/CRAM file.
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
    doc: Output SAM/BAM/CRAM file.
    inputBinding:
      position: 101
      prefix: --output
  - id: ref_fasta
    secondaryFiles:
      - pattern: .fai
        required: false
      - pattern: ^.dict
        required: false
    type:
      - 'null'
      - File
    doc: Reference fasta, only needed if writing CRAM.
    inputBinding:
      position: 101
      prefix: --ref
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
    valueFrom: SetMateInformation
outputs:
  - id: output_bam_out
    type: File
    doc: Output SAM/BAM/CRAM file.
    outputBinding:
      glob: $(inputs.output_bam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
