cwlVersion: v1.2
class: CommandLineTool
baseCommand: [/usr/local/bin/share/physlr-1.0.4-0/bin/physlr, bed-to-path]
label: physlr_bed-to-path
doc: "Convert BED mappings to scaffold paths: queries are ordered and oriented on the physical map.\n\nTool homepage: https://github.com/BirolLab/physlr"
inputs:
  - id: min_score
    type: ['null', int]
    doc: "remove mappings with score less than this [0]"
    inputBinding:
      position: 1
      prefix: -n
  - id: verbose
    type: ['null', int]
    doc: "the level of verbosity: 0 silent, 1 periodic, 2 progress, 3 verbose [2]"
    inputBinding:
      position: 2
      prefix: -V
  - id: bed_files
    type: File[]
    doc: "BED (5 or 6 columns) or PAF file(s) of mappings"
    inputBinding:
      position: 100
outputs:
  - id: result
    type: File
    doc: "Paths, one scaffold per line; each query name carries its orientation (+, - or .) as a suffix"
    outputBinding:
      glob: physlr_bed-to-path.path
stdout: physlr_bed-to-path.path
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: PYTHONPATH
        envValue: /usr/local/bin/share/physlr-1.0.4-0
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
