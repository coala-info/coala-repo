cwlVersion: v1.2
class: CommandLineTool
baseCommand: gnali
label: gnali
doc: "Given a list of genes to test, gNALI finds all potential loss of function variants
  of those genes.\n\nTool homepage: https://github.com/phac-nml/gnali"
inputs:
  - id: additional_filters
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional filters. To use multiple, separate them by spaces. Please 
      enclose each in quotes (ex. "AC>3")
    inputBinding:
      position: 101
      prefix: --additional_filters
  - id: config
    type:
      - 'null'
      - File
    doc: Use a custom config file. To get started, check out the 
      --config_template commands
    inputBinding:
      position: 101
      prefix: --config
  - id: config_template_grch37
    type:
      - 'null'
      - boolean
    doc: Create a fillable template for a config for a database using the GRCh37
      assembly
    inputBinding:
      position: 101
      prefix: --config_template_grch37
  - id: config_template_grch38
    type:
      - 'null'
      - boolean
    doc: Create a fillable template for a config for a database using the GRCh38
      assembly
    inputBinding:
      position: 101
      prefix: --config_template_grch38
  - id: database
    type:
      - 'null'
      - string
    doc: "Database to query. Options: ['gnomadv2.1.1', 'gnomadv3.1.1']"
    inputBinding:
      position: 101
      prefix: --database
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force existing output folder to be overwritten
    inputBinding:
      position: 101
      prefix: --force
  - id: generate_vcf
    type:
      - 'null'
      - boolean
    doc: Generate vcf file for filtered variants
    inputBinding:
      position: 101
      prefix: --vcf
  - id: get_pop_freqs
    type:
      - 'null'
      - boolean
    doc: Get population frequencies (in detailed output file)
    inputBinding:
      position: 101
      prefix: --pop_freqs
  - id: input_file
    type:
      - 'null'
      - File
    doc: 'File of genes to test. Accepted formats: csv, txt'
    inputBinding:
      position: 101
      prefix: --input_file
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Name of output directory.
    inputBinding:
      position: 101
      prefix: --output_dir
  - id: predefined_filters
    type:
      - 'null'
      - type: array
        items: string
    doc: "Predefined filters. To use multiple, separate them by spaces. Options: {'gnomadv2.1.1':
      {'homozygous-controls': 'controls_nhomalt>0', 'heterozygous-controls': 'controls_nhomalt=0',
      'homozygous': 'nhomalt>0'}, 'gnomadv3.1.1': {'homozygous': 'nhomalt>0'}}"
    inputBinding:
      position: 101
      prefix: --predefined_filters
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: increase verbosity
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gnali:1.1.0--pyhdfd78af_0
stdout: gnali.out
