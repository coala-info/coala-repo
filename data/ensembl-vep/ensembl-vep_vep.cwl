cwlVersion: v1.2
class: CommandLineTool
baseCommand: ./vep
label: ensembl-vep_vep
doc: "ENSEMBL VARIANT EFFECT PREDICTOR\n\nTool homepage: https://www.ensembl.org/info/docs/tools/vep/index.html"
inputs:
  - id: cache
    type:
      - 'null'
      - boolean
    doc: Use cache
    inputBinding:
      position: 101
  - id: database
    type:
      - 'null'
      - boolean
    doc: Use database
    inputBinding:
      position: 101
  - id: everything
    type:
      - 'null'
      - boolean
    doc: Shortcut switch to turn on commonly used options. See web documentation
      for details
    default: false
    inputBinding:
      position: 101
      prefix: --everything
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: Force overwriting of output file
    inputBinding:
      position: 101
      prefix: --force_overwrite
  - id: fork
    type:
      - 'null'
      - int
    doc: Use forking to improve script runtime
    inputBinding:
      position: 101
      prefix: --fork
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input file
    inputBinding:
      position: 101
      prefix: --input_file
  - id: offline
    type:
      - 'null'
      - boolean
    doc: Run in offline mode
    inputBinding:
      position: 101
  - id: species
    type:
      - 'null'
      - string
    doc: Species to use
    default: human
    inputBinding:
      position: 101
      prefix: --species
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ensembl-vep:115.2--pl5321h2a3209d_1
