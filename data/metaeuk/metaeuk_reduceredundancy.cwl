cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metaeuk
  - reduceredundancy
label: metaeuk_reduceredundancy
doc: "By Eli Levy Karin <eli.levy.karin@gmail.com>\n\nTool homepage: https://github.com/soedinglab/metaeuk"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.called_exons_db)
inputs:
  - id: called_exons_db
    type: 'File[]'
    doc: Input called exons database. All files of the MetaEuk database (name, .index, .dbtype,
      .lookup, _h, ... or the split data parts), staged together in the working directory.
    inputBinding:
      position: 1
      valueFrom: |-
        ${ var names = self.map(function(f){return f.basename;}).filter(function(b){return /\.dbtype$/.test(b) && !/_h\.dbtype$/.test(b);}); return names[0].replace(/\.dbtype$/, ''); }
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
  - id: predictions_exons_db_path
    type: string
    doc: Output predictionsExonsDB
    inputBinding:
      position: 2
  - id: pred_to_call_path
    type: string
    doc: Output predToCall
    inputBinding:
      position: 3
outputs:
  - id: predictions_exons_db
    type: 'File[]'
    doc: Output predictions exons database. All files of the MetaEuk database (data, .index, .dbtype, ...).
    outputBinding:
      glob: "$(inputs.predictions_exons_db_path)*"
  - id: pred_to_call
    type: 'File[]'
    doc: Output prediction-to-call database. All files of the MetaEuk database (data, .index, .dbtype, ...).
    outputBinding:
      glob: "$(inputs.pred_to_call_path)*"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaeuk:7.bba0d80--pl5321hd6d6fdc_2
