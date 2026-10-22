cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - snipe
  - ops
  - guided-merge
label: snipe_ops_guided-merge
doc: "Guide signature merging by groups.\n\nTool homepage: https://github.com/snipe-bio/snipe"
inputs:
  - id: table
    type: File
    doc: Tabular file (CSV or TSV) with two columns, signature path and experiment
      name. Signatures with the same experiment name are summed.
    inputBinding:
      position: 101
      prefix: --table
  - id: signatures
    type:
      - 'null'
      - type: array
        items: File
    doc: The signature files named in the table. They are staged into the working
      directory so that the paths in the table resolve.
  - id: output_dir
    type: string
    doc: Directory to save merged signature files.
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: reset_abundance
    type:
      - 'null'
      - boolean
    doc: Reset abundance for all input signatures to 1.
    inputBinding:
      position: 101
      prefix: --reset-abundance
  - id: trim_singletons
    type:
      - 'null'
      - boolean
    doc: Trim singletons from all input signatures.
    inputBinding:
      position: 101
      prefix: --trim-singletons
  - id: min_abund
    type:
      - 'null'
      - int
    doc: Keep hashes with abundance >= this value.
    inputBinding:
      position: 101
      prefix: --min-abund
  - id: max_abund
    type:
      - 'null'
      - int
    doc: Keep hashes with abundance <= this value.
    inputBinding:
      position: 101
      prefix: --max-abund
  - id: trim_below_median
    type:
      - 'null'
      - boolean
    doc: Trim hashes below the median abundance.
    inputBinding:
      position: 101
      prefix: --trim-below-median
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable debugging and detailed logging.
    inputBinding:
      position: 101
      prefix: --debug
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing files in the output directory.
    inputBinding:
      position: 101
      prefix: --force
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of cores to use for processing experiments in parallel.
    inputBinding:
      position: 101
      prefix: --cores
outputs:
  - id: output_dir_out
    type: Directory
    doc: Directory with one merged signature per experiment ({experiment_name}.zip).
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.signatures)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snipe:0.1.6--pyhdfd78af_0
