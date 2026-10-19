cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ribo
  - select
label: riboseed_ribo_select
doc: "Identify and cluster rRNA regions from a genbank file; returns a text file with the clusters.\n\nTool homepage: https://github.com/nickp60/riboSeed"
inputs:
  - id: genbank_genome
    type: File
    doc: "Genbank file (WITH SEQUENCE)"
    inputBinding:
      position: 1
  - id: feature
    type:
      - 'null'
      - string
    doc: "Feature, rRNA or RRNA; default: rRNA"
    inputBinding:
      position: 101
      prefix: '--feature'
  - id: specific_features
    type:
      - 'null'
      - string
    doc: "colon:separated -- specific features; default: 16S:23S:5S"
    inputBinding:
      position: 101
      prefix: '--specific_features'
  - id: clobber
    type:
      - 'null'
      - boolean
    doc: "overwrite previous output files: default: False"
    inputBinding:
      position: 101
      prefix: '--clobber'
  - id: clusters
    type:
      - 'null'
      - string
    doc: "number of rDNA clusters; if submitting multiple records, must be a colon:separated list whose length matches number of genbank records. Default is inferred from specific feature with fewest hits"
    inputBinding:
      position: 101
      prefix: '--clusters'
  - id: verbosity
    type:
      - 'null'
      - int
    doc: "Logger writes debug to file in output dir; this sets verbosity level sent to stderr. 1 = debug(), 2 = info(), 3 = warning(), 4 = error() and 5 = critical(); default: 2"
    inputBinding:
      position: 101
      prefix: '--verbosity'
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Enable debug messages"
    inputBinding:
      position: 101
      prefix: '--debug'
  - id: output
    type: string
    doc: "output directory"
    inputBinding:
      position: 102
      prefix: '--output'
outputs:
  - id: output_dir
    type: Directory
    doc: "Output directory"
    outputBinding:
      glob: $(inputs.output)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/riboseed:0.4.90--py_0
stdout: riboseed_ribo_select.out
