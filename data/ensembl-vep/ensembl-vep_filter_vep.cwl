cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - filter_vep
label: ensembl-vep_filter_vep
doc: "Filter the results of VEP (or any tab-delimited or VCF file with VEP annotations) on fields such as Consequence, SIFT, PolyPhen or allele frequency.\n\nTool homepage: https://www.ensembl.org/info/docs/tools/vep/index.html"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: "Specify the input file (i.e. the VEP results file). Input may be gzipped"
    inputBinding:
      position: 101
      prefix: --input_file
  - id: format
    type:
      - 'null'
      - string
    doc: "Specify input file format (vcf, or tab for any tab-delimited format, including default VEP output format)"
    inputBinding:
      position: 101
      prefix: --format
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: "Specify the output file to write to. If no output file is specified, the script writes to STDOUT"
    inputBinding:
      position: 101
      prefix: --output_file
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: "Force the script to overwrite the output file if it already exists"
    inputBinding:
      position: 101
      prefix: --force_overwrite
  - id: filter
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --filter
    doc: "Add filter, for example \"Consequence is missense_variant\". Multiple --filter flags may be used and are treated as logical ANDs"
    inputBinding:
      position: 101
  - id: list
    type:
      - 'null'
      - boolean
    doc: "List allowed fields from the input file"
    inputBinding:
      position: 101
      prefix: --list
  - id: count
    type:
      - 'null'
      - boolean
    doc: "Print only a count of matched lines"
    inputBinding:
      position: 101
      prefix: --count
  - id: only_matched
    type:
      - 'null'
      - boolean
    doc: "In VCF files, remove CSQ blocks that do not pass the filters"
    inputBinding:
      position: 101
      prefix: --only_matched
  - id: vcf_info_field
    type:
      - 'null'
      - string
    doc: "INFO key that holds the VEP annotations in VCF input (default CSQ)"
    inputBinding:
      position: 101
      prefix: --vcf_info_field
  - id: ontology
    type:
      - 'null'
      - boolean
    doc: "Use Sequence Ontology to match consequence terms; requires a database connection"
    inputBinding:
      position: 101
      prefix: --ontology
  - id: gz
    type:
      - 'null'
      - boolean
    doc: "Force the script to read the input file as gzipped"
    inputBinding:
      position: 101
      prefix: --gz
  - id: host
    type:
      - 'null'
      - string
    doc: "Database host (used with --ontology)"
    inputBinding:
      position: 101
      prefix: --host
  - id: port
    type:
      - 'null'
      - int
    doc: "Database port (used with --ontology)"
    inputBinding:
      position: 101
      prefix: --port
  - id: user
    type:
      - 'null'
      - string
    doc: "Database user (used with --ontology)"
    inputBinding:
      position: 101
      prefix: --user
  - id: password
    type:
      - 'null'
      - string
    doc: "Database password (used with --ontology)"
    inputBinding:
      position: 101
      prefix: --password
  - id: version
    type:
      - 'null'
      - int
    doc: "Ensembl database version (used with --ontology)"
    inputBinding:
      position: 101
      prefix: --version
outputs:
  - id: stdout
    type: stdout
    doc: Filtered lines (when no output file is given), or the count
  - id: output_file
    type:
      - 'null'
      - File
    doc: Filtered output file
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ensembl-vep:115.2--pl5321h2a3209d_1
stdout: ensembl-vep_filter_vep.out
