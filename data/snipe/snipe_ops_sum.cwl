cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - snipe
  - ops
  - sum
label: snipe_ops_sum
doc: "Merge multiple signatures by summing their abundances.\n\nTool homepage: https://github.com/snipe-bio/snipe"
inputs:
  - id: sig_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Signature files (.zip or .sig) to combine
    inputBinding:
      position: 1
  - id: name
    type: string
    doc: Name for the output signature.
    inputBinding:
      position: 101
      prefix: --name
  - id: output_file_path
    type: string
    doc: Output file with .zip or .sig extension.
    inputBinding:
      position: 102
      prefix: --output-file
  - id: trim_below_median
    type:
      - 'null'
      - boolean
    doc: Trim hashes below the median abundance.
    inputBinding:
      position: 101
      prefix: --trim-below-median
  - id: max_abund
    type:
      - 'null'
      - int
    doc: Keep hashes with abundance <= this value.
    inputBinding:
      position: 101
      prefix: --max-abund
  - id: min_abund
    type:
      - 'null'
      - int
    doc: Keep hashes with abundance >= this value.
    inputBinding:
      position: 101
      prefix: --min-abund
  - id: trim_singletons
    type:
      - 'null'
      - boolean
    doc: Trim singletons from all input signatures.
    inputBinding:
      position: 101
      prefix: --trim-singletons
  - id: reset_abundance
    type:
      - 'null'
      - boolean
    doc: Reset abundance for all input signatures to 1.
    inputBinding:
      position: 101
      prefix: --reset-abundance
  - id: sigs_from_file
    type:
      - 'null'
      - File
    doc: File containing signature paths (one per line).
    inputBinding:
      position: 101
      prefix: --sigs-from-file
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
    doc: Overwrite the output file if it already exists.
    inputBinding:
      position: 101
      prefix: --force
outputs:
  - id: output_file
    type: File
    doc: Output signature file.
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snipe:0.1.6--pyhdfd78af_0
