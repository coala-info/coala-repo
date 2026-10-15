cwlVersion: v1.2
class: CommandLineTool
baseCommand: [/usr/local/bin/share/physlr-1.0.4-0/bin/physlr, liftover-paf]
label: physlr_liftover-paf
doc: "Lift over the query coordinates of a PAF file from minimizer index to nucleotide position.\n\nTool homepage: https://github.com/BirolLab/physlr"
inputs:
  - id: verbose
    type: ['null', int]
    doc: "the level of verbosity: 0 silent, 1 periodic, 2 progress, 3 verbose [2]"
    inputBinding:
      position: 1
      prefix: -V
  - id: query_minimizers
    type: File
    doc: "Minimizers with positions of the query sequences in TSV format (physlr-indexlr --pos output)"
    inputBinding:
      position: 100
  - id: paf_files
    type: File[]
    doc: "PAF file(s) written by physlr map-paf"
    inputBinding:
      position: 101
outputs:
  - id: result
    type: File
    doc: "PAF file with query coordinates in nucleotides"
    outputBinding:
      glob: physlr_liftover-paf.paf
stdout: physlr_liftover-paf.paf
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: PYTHONPATH
        envValue: /usr/local/bin/share/physlr-1.0.4-0
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
