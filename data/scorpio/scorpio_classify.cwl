cwlVersion: v1.2
class: CommandLineTool
baseCommand: [scorpio, classify]
label: scorpio_classify
doc: "Takes a set of lineage-defining constellations with rules and classifies sequences by them. Output is a summary file with a row per sample recording its constellation classification\n\nTool homepage: https://github.com/cov-lineages/scorpio"
inputs:
  - id: input
    type: File
    doc: "Primary input file - an aligned FASTA"
    inputBinding:
      prefix: --input
  - id: output_counts
    type: ['null', boolean]
    doc: "Save a file per constellation with columns for the ref, alt, ambig and other counts as well as a True/False call for each sample"
    inputBinding:
      prefix: --output-counts
  - id: call_all
    type: ['null', boolean]
    doc: "Allow multiple classifications and output these as a pipe separated list in the summary file"
    inputBinding:
      prefix: --call-all
  - id: long
    type: ['null', boolean]
    doc: "Write out summary file in long format, including the counts for the winning constellation"
    inputBinding:
      prefix: --long
  - id: list_incompatible
    type: ['null', boolean]
    doc: "Adds column to the summary file listing incompatible lineages for the winning constellation as listed in the constellation JSON"
    inputBinding:
      prefix: --list-incompatible
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
  - id: output_files
    type: File[]
    doc: Classification summary and optional per-constellation count files
    outputBinding:
      glob: ['*.csv', '*.log']
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scorpio:0.3.19--pyhdfd78af_0
