cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaeuk reduceredundancy
label: metaeuk_reduceredundancy
doc: "By Eli Levy Karin <eli.levy.karin@gmail.com>\n\nTool homepage: https://github.com/soedinglab/metaeuk"
inputs:
  - id: called_exons_db
    type: File
    doc: Input calledExonsDB
    inputBinding:
      position: 1
  - id: compressed
    type:
      - 'null'
      - int
    doc: Write compressed output
    inputBinding:
      position: 102
      prefix: --compressed
  - id: overlap
    type:
      - 'null'
      - int
    doc: allow predictions to overlap another on the same strand. when not 
      allowed (default), only the prediction with better E-value will be 
      retained [0,1]
    inputBinding:
      position: 102
      prefix: --overlap
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU-cores used (all by default)
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbosity_level
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info'
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: predictions_exons_db
    type: File
    doc: Output predictionsExonsDB
    outputBinding:
      glob: '*.out'
  - id: pred_to_call
    type: File
    doc: Output predToCall
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaeuk:7.bba0d80--pl5321hd6d6fdc_2
