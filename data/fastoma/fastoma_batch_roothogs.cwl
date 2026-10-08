cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastoma-batch-roothogs
label: fastoma_batch_roothogs
doc: "Analyse roothog families and create batches for analysis.\n\nTool homepage: https://github.com/DessimozLab/FastOMA"
inputs:
  - id: input_roothogs
    type: Directory
    doc: Folder where input roothogs are stored
    inputBinding:
      position: 1
      prefix: --input-roothogs
  - id: out_big
    type: string
    doc: Folder where the big single family hogs should be stored
    inputBinding:
      position: 2
      prefix: --out-big
  - id: out_rest
    type: string
    doc: Folder where the remaining families should be stored in batch subfolder structure.
    inputBinding:
      position: 3
      prefix: --out-rest
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase verbosity
    inputBinding:
      position: 4
      prefix: -v
outputs:
  - id: big_folder
    type:
      - 'null'
      - Directory
    doc: Folder with the big single family hogs.
    outputBinding:
      glob: $(inputs.out_big)
  - id: rest_folder
    type:
      - 'null'
      - Directory
    doc: Folder with the remaining families in batches.
    outputBinding:
      glob: $(inputs.out_rest)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastoma:0.5.1--pyhdfd78af_0
stdout: fastoma_batch_roothogs.out
