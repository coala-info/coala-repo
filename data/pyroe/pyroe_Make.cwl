cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyroe
label: pyroe_Make
doc: "pyroe: error: argument command: invalid choice: 'Make' (choose from 'make-spliced+intronic',
  'make-splici', 'make-spliced+unspliced', 'make-spliceu', 'fetch-quant', 'id-to-name',
  'convert')\n\nTool homepage: https://github.com/COMBINE-lab/pyroe"
inputs:
  - id: command
    type: string
    doc: 'Subcommand to execute. Available choices: make-spliced+intronic, make-splici,
      make-spliced+unspliced, make-spliceu, fetch-quant, id-to-name, convert'
    inputBinding:
      position: 1
  - id: verbose
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyroe:0.9.3--pyhdfd78af_0
stdout: pyroe_Make.out
