cwlVersion: v1.2
class: CommandLineTool
baseCommand: go build
label: go_build
doc: "Builds the specified packages and their dependencies.\n\nTool homepage: https://github.com/avelino/awesome-go"
inputs:
  - id: build_flags
    type:
      - 'null'
      - type: array
        items: string
    doc: build flags
    inputBinding:
      position: 1
  - id: packages
    type:
      - 'null'
      - type: array
        items: string
    doc: packages to build
    inputBinding:
      position: 2
  - id: install
    type:
      - 'null'
      - boolean
    doc: install packages that are dependencies of the specified packages
    inputBinding:
      position: 103
      prefix: -i
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 104
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output file name
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/go:1.11.3
