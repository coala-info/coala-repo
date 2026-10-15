cwlVersion: v1.2
class: CommandLineTool
baseCommand: [/usr/local/bin/share/physlr-1.0.4-0/bin/physlr, filter-bed]
label: physlr_filter-bed
doc: "Select records of a BED file in the order given by a path file; a line of NA separates the paths.\n\nTool homepage: https://github.com/BirolLab/physlr"
inputs:
  - id: min_component_size
    type: ['null', int]
    doc: "skip paths with fewer than this many vertices [0]"
    inputBinding:
      position: 1
      prefix: --min-component-size
  - id: molecule_bed
    type: ['null', int]
    doc: "retain molecule splits in the filtered BED (0 or 1) [0]"
    inputBinding:
      position: 2
      prefix: --molecule-bed
  - id: verbose
    type: ['null', int]
    doc: "the level of verbosity: 0 silent, 1 periodic, 2 progress, 3 verbose [2]"
    inputBinding:
      position: 3
      prefix: -V
  - id: bed_file
    type: File
    doc: "BED file whose fourth column holds barcode (or molecule) names"
    inputBinding:
      position: 100
  - id: path_files
    type: File[]
    doc: "Path file(s) of the physical map"
    inputBinding:
      position: 101
outputs:
  - id: result
    type: File
    doc: "BED records in path order"
    outputBinding:
      glob: physlr_filter-bed.bed
stdout: physlr_filter-bed.bed
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: PYTHONPATH
        envValue: /usr/local/bin/share/physlr-1.0.4-0
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
