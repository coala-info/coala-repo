cwlVersion: v1.2
class: CommandLineTool
baseCommand: prophyle_compile
label: prophyle_compile
doc: "Compile prophyle database\n\nTool homepage: https://github.com/karel-brinda/prophyle"
inputs:
  - id: advanced_configuration
    type:
      - 'null'
      - type: array
        items: string
    doc: advanced configuration (a JSON dictionary)
    inputBinding:
      position: 101
      prefix: -c
  - id: clean_files
    type:
      - 'null'
      - boolean
    doc: clean files instead of compiling
    inputBinding:
      position: 101
      prefix: -C
  - id: force_recompilation
    type:
      - 'null'
      - boolean
    doc: force recompilation
    inputBinding:
      position: 101
      prefix: -F
  - id: run_parallel
    type:
      - 'null'
      - boolean
    doc: run compilation in parallel
    inputBinding:
      position: 101
      prefix: -P
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prophyle:0.3.3.2--py39h746d604_3
stdout: prophyle_compile.out
