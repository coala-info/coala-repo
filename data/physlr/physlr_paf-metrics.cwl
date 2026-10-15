cwlVersion: v1.2
class: CommandLineTool
baseCommand: [/usr/local/bin/share/physlr-1.0.4-0/bin/physlr, paf-metrics]
label: physlr_paf-metrics
doc: "Report assembly metrics (Max, NG25, NG50, NG75, Min, Count, Sum) of PAF files, using the query interval lengths.\n\nTool homepage: https://github.com/BirolLab/physlr"
inputs:
  - id: genome_size
    type: long
    doc: "the expected size used for computing NGxx, in the units of the PAF query coordinates (option -g, required)"
    inputBinding:
      position: 1
      prefix: -g
  - id: verbose
    type: ['null', int]
    doc: "the level of verbosity: 0 silent, 1 periodic, 2 progress, 3 verbose [2]"
    inputBinding:
      position: 2
      prefix: -V
  - id: paf_files
    type: File[]
    doc: "PAF file(s)"
    inputBinding:
      position: 100
outputs:
  - id: result
    type: File
    doc: "Table with the columns Max, NG25, NG50, NG75, Min, Count, Sum and File"
    outputBinding:
      glob: physlr_paf-metrics.tsv
stdout: physlr_paf-metrics.tsv
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: PYTHONPATH
        envValue: /usr/local/bin/share/physlr-1.0.4-0
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
