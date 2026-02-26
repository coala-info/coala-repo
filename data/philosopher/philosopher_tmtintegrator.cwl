cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - philosopher
  - tmtintegrator
label: philosopher_tmtintegrator
doc: "Integrates TMT quantification results from Philosopher.\n\nTool homepage: https://github.com/Nesvilab/philosopher"
inputs:
  - id: memory
    type:
      - 'null'
      - int
    default: 8
    inputBinding:
      position: 101
      prefix: --memory
  - id: param
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --param
  - id: path
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --path
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
stdout: philosopher_tmtintegrator.out
