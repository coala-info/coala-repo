cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cramtools
  - fixheader
label: cramtools_fixheader
doc: "Fix headers in CRAM files, including MD5 calculation and URI injection for reference
  sequences.\n\nTool homepage: https://github.com/enasequence/cramtools"
inputs:
  - id: confirm_md5
    type:
      - 'null'
      - boolean
    doc: Calculate MD5 for sequences mentioned in the header. Requires --reference-fasta-file
      option.
    inputBinding:
      position: 101
      prefix: --confirm-md5
  - id: inject_uri
    type:
      - 'null'
      - boolean
    doc: Inject URI for all reference sequences in the header.
    inputBinding:
      position: 101
      prefix: --inject-uri
  - id: input_cram_file
    type:
      - 'null'
      - File
    doc: The path to the CRAM file.
    inputBinding:
      position: 101
      prefix: --input-cram-file
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Change log level: DEBUG, INFO, WARNING, ERROR.'
    inputBinding:
      position: 101
      prefix: --log-level
  - id: reference_fasta_file
    type:
      - 'null'
      - File
    doc: Path to the reference fasta file, it must be uncompressed and indexed (use
      'samtools faidx' for example).
    inputBinding:
      position: 101
      prefix: --reference-fasta-file
  - id: uri_pattern
    type:
      - 'null'
      - string
    doc: String formatting pattern for sequence URI to be injected.
    inputBinding:
      position: 101
      prefix: --uri-pattern
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cramtools:3.0.b127--0
stdout: cramtools_fixheader.out
