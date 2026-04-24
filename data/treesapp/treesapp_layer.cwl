cwlVersion: v1.2
class: CommandLineTool
baseCommand: treesapp layer
label: treesapp_layer
doc: "This script adds extra feature annotations, such as Subgroup and Metabolic Pathway,
  to an existing classification table made by treesapp assign. A new column is bound
  to the table for each feature.\n\nTool homepage: https://github.com/hallamlab/TreeSAPP"
inputs:
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrites previously written output files and directories
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: refpkg_dir
    type:
      - 'null'
      - Directory
    doc: Path to the directory containing reference package pickle (.pkl) files.
    inputBinding:
      position: 101
      prefix: --refpkg_dir
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Prints a more verbose runtime log
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type: Directory
    doc: The TreeSAPP output directory.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treesapp:0.11.4--py39h2de1943_2
