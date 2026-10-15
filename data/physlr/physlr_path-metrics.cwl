cwlVersion: v1.2
class: CommandLineTool
baseCommand: [/usr/local/bin/share/physlr-1.0.4-0/bin/physlr, path-metrics]
label: physlr_path-metrics
doc: "Report assembly metrics (Max, NG25, NG50, NG75, Min, number of paths and nodes) of path files.\n\nTool homepage: https://github.com/BirolLab/physlr"
inputs:
  - id: expected_molecules
    type: int
    doc: "the expected number of molecules in the assembly, for computing NGxx (required)"
    inputBinding:
      position: 1
      prefix: -g
  - id: min_component_size
    type: ['null', int]
    doc: "ignore paths with fewer than this many vertices [0]"
    inputBinding:
      position: 2
      prefix: --min-component-size
  - id: verbose
    type: ['null', int]
    doc: "the level of verbosity: 0 silent, 1 periodic, 2 progress, 3 verbose [2]"
    inputBinding:
      position: 3
      prefix: -V
  - id: path_files
    type: File[]
    doc: "Path file(s)"
    inputBinding:
      position: 100
outputs:
  - id: result
    type: File
    doc: "Table with the columns Max, NG25, NG50, NG75, Min, Paths, Nodes and File"
    outputBinding:
      glob: physlr_path-metrics.tsv
stdout: physlr_path-metrics.tsv
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: PYTHONPATH
        envValue: /usr/local/bin/share/physlr-1.0.4-0
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
