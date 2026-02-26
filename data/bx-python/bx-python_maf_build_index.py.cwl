cwlVersion: v1.2
class: CommandLineTool
baseCommand: maf_build_index.py
label: bx-python_maf_build_index.py
doc: "Build an index file for a set of MAF alignment blocks.\n\nTool homepage: https://github.com/bxlab/bx-python"
inputs:
  - id: maf_file
    type: File
    doc: MAF alignment blocks file
    inputBinding:
      position: 1
  - id: index_file
    type:
      - 'null'
      - File
    doc: Index file to be created. If not provided, maf_file.index is used.
    default: maf_file.index
    inputBinding:
      position: 2
  - id: species
    type:
      - 'null'
      - type: array
        items: string
    doc: only index the position of the block in the listed species
    inputBinding:
      position: 103
      prefix: --species
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bx-python:0.14.0--py312h5e9d817_0
stdout: bx-python_maf_build_index.py.out
