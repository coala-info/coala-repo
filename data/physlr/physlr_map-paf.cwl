cwlVersion: v1.2
class: CommandLineTool
baseCommand: [/usr/local/bin/share/physlr-1.0.4-0/bin/physlr, map-paf]
label: physlr_map-paf
doc: "Map sequences to a physical map and write the hits in PAF format (minimizer coordinates).\n\nTool homepage: https://github.com/BirolLab/physlr"
inputs:
  - id: min_score
    type: ['null', int]
    doc: "remove mappings with score less than this [0]"
    inputBinding:
      position: 1
      prefix: -n
  - id: coef
    type: ['null', float]
    doc: "ignore minimizers that occur in Q3+c*(Q3-Q1) or more positions when setting the query interval [1.5]"
    inputBinding:
      position: 2
      prefix: --coef
  - id: mx_type
    type: ['null', string]
    doc: "type of minimizers used to map sequences to the backbone graph: unsplit or split [unsplit]"
    inputBinding:
      position: 3
      prefix: --mx-type
  - id: min_component_size
    type: ['null', int]
    doc: "ignore backbone paths with fewer than this many vertices [0]"
    inputBinding:
      position: 4
      prefix: --min-component-size
  - id: verbose
    type: ['null', int]
    doc: "the level of verbosity: 0 silent, 1 periodic, 2 progress, 3 verbose [2]"
    inputBinding:
      position: 5
      prefix: -V
  - id: target_paths
    type: File
    doc: "Backbone paths of the physical map (one path of space-separated vertex names per line)"
    inputBinding:
      position: 100
  - id: target_minimizers
    type: File
    doc: "Minimizers in TSV format: barcode, a tab, then space-separated minimizers (as written by physlr-indexlr) (the markers of the path vertices)"
    inputBinding:
      position: 101
  - id: query_minimizers
    type: File[]
    doc: "Minimizers of the query sequences in TSV format: name, a tab, then the ordered space-separated minimizers (physlr-indexlr output, with or without --pos)"
    inputBinding:
      position: 102
outputs:
  - id: result
    type: File
    doc: "PAF with 12 columns (query name, length, start, end, orientation, target, length, start, end, score, interval length, mapq)"
    outputBinding:
      glob: physlr_map-paf.paf
stdout: physlr_map-paf.paf
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: PYTHONPATH
        envValue: /usr/local/bin/share/physlr-1.0.4-0
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
