cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgbio
label: fgbio_GenerateRegionsFromFasta
doc: "Generates a list of 'freebayes'/'bamtools' region specifiers.\n\nNote: this\
  \ fgbio command ignores its --output option and always prints the regions to standard\
  \ output, so this wrapper does not pass --output and collects standard output.\n\
  \nTool homepage: https://github.com/fulcrumgenomics/fgbio"
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
  - id: input_fasta
    secondaryFiles:
      - pattern: .fai
        required: false
      - pattern: ^.dict
        required: true
    type: File
    doc: The input FASTA.
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
  - id: region_size
    type:
      - 'null'
      - int
    doc: 'The size of the regions to output. [Default: 100000].'
    inputBinding:
      position: 101
      prefix: --region-size
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
    valueFrom: GenerateRegionsFromFasta
outputs:
  - id: regions
    type: stdout
    doc: The list of region specifiers (standard output).
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
stdout: regions.txt
requirements:
  - class: InlineJavascriptRequirement
