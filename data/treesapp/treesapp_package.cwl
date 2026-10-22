cwlVersion: v1.2
class: CommandLineTool
baseCommand: [treesapp, package]
label: treesapp_package
doc: "Facilitate operations on reference packages: view, edit or rename attributes.\n\nTool homepage: https://github.com/hallamlab/TreeSAPP"
inputs:
  - id: subcommand
    type: string
    doc: "Operation to perform: view, edit or rename. `rename` must be followed only by prefix and the new value."
    inputBinding:
      position: 1
  - id: attributes
    type:
      type: array
      items: string
    doc: "One or more reference package attributes to view or edit (for example prefix, lineage_ids, num_seqs, tree)."
    inputBinding:
      position: 2
  - id: refpkg_path
    type:
      type: array
      items: File
    doc: "Path to the reference package pickle (.pkl) file(s)."
    inputBinding:
      position: 101
      prefix: --refpkg_path
  - id: taxa_map
    type:
      - 'null'
      - File
    doc: "A file mapping unique taxonomic labels to non-unique features (for example activity or pathway)."
    inputBinding:
      position: 101
      prefix: --taxa_map
  - id: reset
    type:
      - 'null'
      - boolean
    doc: "Reset the reference package attribute when editing."
    inputBinding:
      position: 101
      prefix: --reset
  - id: join
    type:
      - 'null'
      - boolean
    doc: "Join the input to the existing attribute. Applicable to: 'lineage_ids'."
    inputBinding:
      position: 101
      prefix: --join
  - id: output
    type:
      - 'null'
      - string
    doc: "Path to an output directory. Default is the current working directory."
    inputBinding:
      position: 101
      prefix: --output
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: "Overwrites previously written output files and directories"
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Prints a more verbose runtime log"
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: "Attribute values printed to the console"
  - id: output_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Edited or renamed reference package files"
    outputBinding:
      glob: ["*.pkl", "$(inputs.output)/*.pkl"]
stdout: treesapp_package.out
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treesapp:0.11.4--py39h2de1943_2
