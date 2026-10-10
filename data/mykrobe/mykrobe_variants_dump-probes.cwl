cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mykrobe
  - variants
  - dump-probes
label: mykrobe_variants_dump-probes
doc: "Dump a probe set of variant alleles from VCFs stored in the database (a MongoDB
  server is required). Probes are written to stdout in FASTA format.\n\nTool homepage: https://github.com/Mykrobe-tools/mykrobe"
inputs:
  - id: reference_filepath
    type: File
    doc: reference_filepath
    inputBinding:
      position: 2
  - id: db_name
    type:
      - 'null'
      - string
    doc: db_name
    inputBinding:
      position: 1
      prefix: --db_name
  - id: db_uri
    type:
      - 'null'
      - string
    doc: 'e.g.: mongodb://admin:qwerty@localhost/db_name'
    inputBinding:
      position: 1
      prefix: --db_uri
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force override any skeleton files
    inputBinding:
      position: 1
      prefix: --force
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Only output warnings/errors to stderr
    inputBinding:
      position: 1
      prefix: --quiet
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Output debugging information to stderr
    inputBinding:
      position: 1
      prefix: --debug
  - id: kmer
    type:
      - 'null'
      - int
    doc: kmer length
    inputBinding:
      position: 1
      prefix: --kmer
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 1
      prefix: --verbose
outputs:
  - id: probes
    type: stdout
    doc: Probe set in FASTA format
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mykrobe:0.13.0--py38h59a8061_3
stdout: mykrobe_variants_dump-probes.fa
