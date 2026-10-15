cwlVersion: v1.2
class: CommandLineTool
baseCommand: [/usr/local/bin/share/physlr-1.0.4-0/bin/physlr, map-mkt]
label: physlr_map-mkt
doc: "Map sequences to a physical map, orienting each hit with the Mann-Kendall trend test, and write the hits as BED.\n\nTool homepage: https://github.com/BirolLab/physlr"
inputs:
  - id: min_score
    type: ['null', int]
    doc: "remove mappings with score less than this [0]"
    inputBinding:
      position: 1
      prefix: -n
  - id: min_p_val
    type: ['null', float]
    doc: "minimum significance threshold (false positive rate) for the Mann-Kendall test [0.01]"
    inputBinding:
      position: 2
      prefix: --min_p_val
  - id: mkt_median_threshold
    type: ['null', int]
    doc: "maximum number of backbone positions before only medians are used in the Mann-Kendall test [50]"
    inputBinding:
      position: 3
      prefix: --mkt-median-threshold
  - id: mx_type
    type: ['null', string]
    doc: "type of minimizers used to map sequences to the backbone graph: unsplit or split [unsplit]"
    inputBinding:
      position: 4
      prefix: --mx-type
  - id: min_component_size
    type: ['null', int]
    doc: "ignore backbone paths with fewer than this many vertices [0]"
    inputBinding:
      position: 5
      prefix: --min-component-size
  - id: verbose
    type: ['null', int]
    doc: "the level of verbosity: 0 silent, 1 periodic, 2 progress, 3 verbose [2]"
    inputBinding:
      position: 6
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
    doc: "BED with the columns tid, start, end, query name, score and orientation"
    outputBinding:
      glob: physlr_map-mkt.bed
stdout: physlr_map-mkt.bed
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: PYTHONPATH
        envValue: /usr/local/bin/share/physlr-1.0.4-0
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
