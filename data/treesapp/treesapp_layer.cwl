cwlVersion: v1.2
class: CommandLineTool
baseCommand: [treesapp, layer]
label: treesapp_layer
doc: "Adds extra feature annotations, such as Subgroup and Metabolic Pathway, to an existing classification table made by treesapp assign.\n\nTool homepage: https://github.com/hallamlab/TreeSAPP"
inputs:
  - id: treesapp_output
    type: Directory
    doc: "The TreeSAPP output directory (staged writable; the classification table is updated)."
    inputBinding:
      position: 101
      prefix: --treesapp_output
      valueFrom: $(inputs.treesapp_output.basename)
  - id: refpkg_dir
    type:
      - 'null'
      - Directory
    doc: "Path to the directory containing reference package pickle (.pkl) files. [ DEFAULT = treesapp/data/ ]"
    inputBinding:
      position: 101
      prefix: --refpkg_dir
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
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: "TreeSAPP output directory with the layered classification table"
    outputBinding:
      glob: $(inputs.treesapp_output.basename)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.treesapp_output)
        writable: true
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treesapp:0.11.4--py39h2de1943_2
