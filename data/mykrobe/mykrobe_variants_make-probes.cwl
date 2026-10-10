cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mykrobe
  - variants
  - make-probes
label: mykrobe_variants_make-probes
doc: "Make probes from a list of variants. Probes are written to stdout in FASTA format.\n\nTool homepage: https://github.com/Mykrobe-tools/mykrobe"
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
  - id: vcf
    type:
      - 'null'
      - File
    doc: Use variants defined in a VCF file
    inputBinding:
      position: 1
      prefix: --vcf
  - id: variants
    type:
      - 'null'
      - string
    doc: Variant in DNA positions e.g. A1234T
    inputBinding:
      position: 1
      prefix: --variants
  - id: text_file
    type:
      - 'null'
      - File
    doc: 'Text file containing variants as rows A1234T (in practice tab-separated rows: reference name, position, ref base, alt base, DNA, optional lineage)'
    inputBinding:
      position: 1
      prefix: --text_file
  - id: genbank
    type:
      - 'null'
      - File
    doc: Genbank file containing genes as features
    inputBinding:
      position: 1
      prefix: --genbank
  - id: kmer
    type:
      - 'null'
      - int
    doc: kmer length
    inputBinding:
      position: 1
      prefix: --kmer
  - id: no_backgrounds
    type:
      - 'null'
      - boolean
    doc: Build probe set against reference only ignoring nearby variants
    inputBinding:
      position: 1
      prefix: --no-backgrounds
  - id: lineage
    type:
      - 'null'
      - string
    doc: Write lineages to output file
    inputBinding:
      position: 1
      prefix: --lineage
outputs:
  - id: probes
    type: stdout
    doc: Probe set in FASTA format
  - id: lineage_file
    type:
      - 'null'
      - File
    doc: Lineages written with --lineage
    outputBinding:
      glob: $(inputs.lineage)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mykrobe:0.13.0--py38h59a8061_3
stdout: mykrobe_variants_make-probes.fa
