cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cramtools
  - merge
label: cramtools_merge
doc: "The paths to the CRAM or BAM files to uncompress.\n\nTool homepage: https://github.com/enasequence/cramtools"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: The paths to the CRAM or BAM files to uncompress.
    inputBinding:
      position: 1
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Change log level: DEBUG, INFO, WARNING, ERROR.'
    inputBinding:
      position: 102
      prefix: --log-level
  - id: reference_fasta_file
    type:
      - 'null'
      - File
    doc: Path to the reference fasta file, it must be uncompressed and indexed (use
      'samtools faidx' for example).
    inputBinding:
      position: 102
      prefix: --reference-fasta-file
  - id: region
    type:
      - 'null'
      - string
    doc: 'Alignment slice specification, for example: chr1:65000-100000.'
    inputBinding:
      position: 102
      prefix: --region
  - id: sam_format
    type:
      - 'null'
      - boolean
    doc: Output in SAM rather than BAM format.
    inputBinding:
      position: 102
      prefix: --sam-format
  - id: sam_header
    type:
      - 'null'
      - boolean
    doc: Print SAM file header when output format is text SAM.
    inputBinding:
      position: 102
      prefix: --sam-header
  - id: validation_level
    type:
      - 'null'
      - string
    doc: 'Change validation stringency level: STRICT, LENIENT, SILENT.'
    inputBinding:
      position: 102
      prefix: --validation-level
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Path to the output BAM file. Omit for stdout.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cramtools:3.0.b127--0
