cwlVersion: v1.2
class: CommandLineTool
baseCommand: [/usr/local/bin/share/physlr-1.0.4-0/bin/physlr, filter-overlap]
label: physlr_filter-overlap
doc: "Read a Physlr overlap graph and filter out the lowest-weight edges by a percentile.\n\nTool homepage: https://github.com/BirolLab/physlr"
inputs:
  - id: overlap_graph
    type: File
    doc: "Physlr overlap graph in TSV format (only the first file is read)"
    inputBinding:
      position: 100
  - id: minimizer_overlap
    type: ['null', float]
    doc: "percent of edges to remove [0]"
    inputBinding:
      position: 1
      prefix: --minimizer-overlap
  - id: verbose
    type: ['null', int]
    doc: "the level of verbosity: 0 silent, 1 periodic, 2 progress, 3 verbose [2]"
    inputBinding:
      position: 2
      prefix: -V
outputs:
  - id: result
    type: File
    doc: "The overlap graph with the lowest-weight edges removed"
    outputBinding:
      glob: physlr_filter-overlap.tsv
stdout: physlr_filter-overlap.tsv
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: PYTHONPATH
        envValue: /usr/local/bin/share/physlr-1.0.4-0
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
