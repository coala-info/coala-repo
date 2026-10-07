cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - consplice
  - constraint
  - score-vcf
label: consplice_constraint_score-vcf
doc: "Add ConSplice scores to a vcf file.\n\nTool homepage: https://github.com/mikecormier/ConSplice"
inputs:
  - id: consplice_file
    type: File
    doc: 'The path to the 0-based ConSplice score file in bed format.'
    inputBinding:
      position: 1
      prefix: --consplice-file
    secondaryFiles:
      - pattern: .tbi
        required: false
  - id: vcf_file
    type: File
    doc: 'The path to the vcf file to add ConSplice scores to.'
    inputBinding:
      position: 1
      prefix: --vcf-file
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .csi
        required: false
  - id: out_file
    type: string
    doc: 'The path and/or the name of the output file to create (an extension is added when missing).'
    inputBinding:
      position: 1
      prefix: --out-file
  - id: out_type
    type:
      - 'null'
      - string
    doc: 'The output file type: ''vcf'', ''vcfgz'', ''bcf'' or ''bcfgz''. Default = ''vcf''.'
    inputBinding:
      position: 1
      prefix: --out-type
  - id: consplice_col
    type:
      - 'null'
      - string
    doc: 'The name of the ConSplice score column in the ConSplice file. Default = ConSplice_Percentile.'
    inputBinding:
      position: 1
      prefix: --consplice-col
outputs:
  - id: output
    type: File
    doc: 'The scored vcf/bcf file.'
    outputBinding:
      glob: $(inputs.out_file)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/consplice:0.0.6--pyh5e36f6f_0
