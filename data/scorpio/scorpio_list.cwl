cwlVersion: v1.2
class: CommandLineTool
baseCommand: [scorpio, list]
label: scorpio_list
doc: "Lists the constellations installed that would be typed/classified with the provided input options\n\nTool homepage: https://github.com/cov-lineages/scorpio"
inputs:
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
  - id: stdout
    type: stdout
    doc: List of constellations
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scorpio:0.3.19--pyhdfd78af_0
stdout: scorpio_list.out
