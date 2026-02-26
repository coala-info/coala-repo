cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cvbio
  - FetchEnsemblGtf
label: cvbio_FetchEnsemblGtf
doc: "Fetch a GTF file from the Ensembl web server.\n\nTool homepage: https://github.com/clintval/cvbio"
inputs:
  - id: async_io
    type:
      - 'null'
      - boolean
    doc: Use asynchronous I/O where possible, e.g. for SAM and BAM files.
    default: false
    inputBinding:
      position: 101
      prefix: --async-io
  - id: build
    type:
      - 'null'
      - int
    doc: The genome build.
    default: 38
    inputBinding:
      position: 101
      prefix: --build
  - id: compression
    type:
      - 'null'
      - int
    doc: Default GZIP compression level, BAM compression level.
    default: 5
    inputBinding:
      position: 101
      prefix: --compression
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Minimum severity log-level to emit. Options: Debug, Info, Warning, Error,
      Fatal.'
    default: Info
    inputBinding:
      position: 101
      prefix: --log-level
  - id: release
    type:
      - 'null'
      - int
    doc: The Ensembl release.
    default: 96
    inputBinding:
      position: 101
      prefix: --release
  - id: sam_validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for SAM/BAM reading. Options: STRICT, LENIENT, SILENT.'
    inputBinding:
      position: 101
      prefix: --sam-validation-stringency
  - id: species
    type:
      - 'null'
      - string
    doc: The species.
    default: Homo sapiens
    inputBinding:
      position: 101
      prefix: --species
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Directory to use for temporary files.
    default: /tmp
    inputBinding:
      position: 101
      prefix: --tmp-dir
outputs:
  - id: output
    type: File
    doc: The output file path.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cvbio:3.0.0--0
