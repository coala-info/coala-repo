cwlVersion: v1.2
class: CommandLineTool
baseCommand: inspector-correct.py
label: inspector_inspector-correct.py
doc: "Assembly error correction based on Inspector assembly evaluation\n\nTool homepage:
  https://github.com/ChongLab/Inspector"
inputs:
  - id: datatype
    type: string
    doc: Type of read used for Inspector evaluation. This option is required for
      structural error correction when performing local assembly with Flye. 
      (pacbio-raw, pacbio-hifi, nano-raw,pacbio-corr, nano-corr)
    inputBinding:
      position: 101
  - id: flyetimeout
    type:
      - 'null'
      - int
    doc: Maximal runtime for local assembly with Flye. Unit is second.
    default: 1200
    inputBinding:
      position: 101
      prefix: --flyetimeout
  - id: inspector_out
    type: Directory
    doc: Inspector evaluation directory. Original file names are required.
    inputBinding:
      position: 101
      prefix: --inspector
  - id: skip_baseerror
    type:
      - 'null'
      - boolean
    doc: Do not correct base errors.
    inputBinding:
      position: 101
      prefix: --skip_baseerror
  - id: skip_structural
    type:
      - 'null'
      - boolean
    doc: Do not correct structural errors. Local assembly will not be performed.
    inputBinding:
      position: 101
      prefix: --skip_structural
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: --thread
outputs:
  - id: outpath
    type:
      - 'null'
      - Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.outpath)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/inspector:1.3.1--hdfd78af_1
