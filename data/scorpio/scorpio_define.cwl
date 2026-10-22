cwlVersion: v1.2
class: CommandLineTool
baseCommand: [scorpio, define]
label: scorpio_define
doc: "Takes a CSV column of per sample mutations, and a column defining groups and extracts group-defining mutations\n\nTool homepage: https://github.com/cov-lineages/scorpio"
inputs:
  - id: input
    type: File
    doc: "Primary input file - a CSV"
    inputBinding:
      prefix: --input
  - id: in_groups
    type: ['null', File]
    doc: "CSV of containing sequence_name and a column defining groups"
    inputBinding:
      prefix: --in-groups
  - id: group_column
    type: ['null', string]
    doc: "Column name defining the groups"
    inputBinding:
      prefix: --group-column
  - id: index_column
    type: ['null', string]
    doc: "Taxon column name"
    inputBinding:
      prefix: --index-column
  - id: subset
    type:
      - 'null'
      - type: array
        items: string
    doc: "Names of a subset of groups to define"
    inputBinding:
      prefix: --subset
  - id: threshold_common
    type: ['null', double]
    doc: "Frequency of a variant within group to be considered common"
    inputBinding:
      prefix: --threshold-common
  - id: threshold_intermediate
    type: ['null', double]
    doc: "Frequency of a variant within group to be reported as intermediate"
    inputBinding:
      prefix: --threshold-intermediate
  - id: outgroups
    type: ['null', File]
    doc: "Two column CSV with group, and pipe separated list of outgroup sequence_names for that list. Assumes outgroups will be in main input CSV"
    inputBinding:
      prefix: --outgroups
  - id: outgroup_json
    type: ['null', File]
    doc: "A single JSON constellation file defining an outgroup for all sequences"
    inputBinding:
      prefix: --outgroup-json
  - id: protein
    type: ['null', boolean]
    doc: "Translates definition coordinates to proteins where possible"
    inputBinding:
      prefix: --protein
  - id: nucleotide
    type: ['null', boolean]
    doc: "Do not translate to amino acid coordinates"
    inputBinding:
      prefix: --nucleotide
  - id: output
    type: ['null', string]
    doc: "Output file or path"
    inputBinding:
      prefix: --output
  - id: prefix
    type: ['null', string]
    doc: "Output prefix. Default: scorpio"
    inputBinding:
      prefix: --prefix
  - id: log_file
    type: ['null', string]
    doc: "Log file to use (otherwise uses stdout)"
    inputBinding:
      prefix: --log-file
  - id: constellations
    type:
      - 'null'
      - type: array
        items: File
    doc: "One or more JSON (or CSV) files specifying variants"
    inputBinding:
      prefix: --constellations
  - id: names
    type:
      - 'null'
      - type: array
        items: string
    doc: "Names of constellations to include"
    inputBinding:
      prefix: --names
  - id: label
    type: ['null', string]
    doc: "Use alternative label specified in JSON where possible"
    inputBinding:
      prefix: --label
  - id: pangolin
    type: ['null', boolean]
    doc: "Uses `mrca_lineage` as label and excludes constellations/data directory for robustness"
    inputBinding:
      prefix: --pangolin
  - id: mutations
    type:
      - 'null'
      - type: array
        items: string
    doc: "Extra mutations to type"
    inputBinding:
      prefix: --mutations
  - id: reference_json
    type: ['null', File]
    doc: "JSON file containing keys \"genome\" with reference sequence and \"proteins\", \"features\" or \"genes\" with features of interest and their coordinates"
    inputBinding:
      prefix: --reference-json
  - id: verbose
    type: ['null', boolean]
    doc: "Print lots of stuff to screen"
    inputBinding:
      prefix: --verbose
  - id: dry_run
    type: ['null', boolean]
    doc: "Quit after checking constellations and variants are AOK"
    inputBinding:
      prefix: --dry-run
  - id: threads
    type: ['null', int]
    doc: "Number of threads"
    inputBinding:
      prefix: --threads
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory with one constellation JSON per group (the --prefix directory, default scorpio)
    outputBinding:
      glob: "$(inputs.prefix ? inputs.prefix : 'scorpio')"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scorpio:0.3.19--pyhdfd78af_0
requirements:
  - class: InlineJavascriptRequirement
