cwlVersion: v1.2
class: CommandLineTool
baseCommand: [scorpio, haplotype]
label: scorpio_haplotype
doc: "Takes a set of constellations and writes haplotypes (either as strings or individual columns). Output is a summary file with a row per sample and columns recording haplotypes or haplotype barcodes\n\nTool homepage: https://github.com/cov-lineages/scorpio"
inputs:
  - id: input
    type: File
    doc: "Primary input file - an aligned FASTA"
    inputBinding:
      prefix: --input
  - id: ref_char
    type: ['null', string]
    doc: "Symbol to use to represent reference allele in barcode strings"
    inputBinding:
      prefix: --ref-char
  - id: output_counts
    type: ['null', boolean]
    doc: "Save a file per constellation with columns for the ref, alt, ambig and other counts as well as a True/False call for each sample"
    inputBinding:
      prefix: --output-counts
  - id: append_genotypes
    type: ['null', boolean]
    doc: "Output a column per variant site instead of a barcode string. If only a single constellation is being typed, this will be placed in the summary file, otherwise in a file per constellation"
    inputBinding:
      prefix: --append-genotypes
  - id: combination
    type: ['null', boolean]
    doc: "Combines the mutations for the specified constellations, and outputs a string across them all, with counts per found constellation"
    inputBinding:
      prefix: --combination
  - id: interspersion
    type: ['null', boolean]
    doc: "Evaluates an interspersion score (dev feature)"
    inputBinding:
      prefix: --interspersion
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
    doc: Haplotype summary and optional per-constellation files
    outputBinding:
      glob: ['*.csv', '*.log']
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scorpio:0.3.19--pyhdfd78af_0
