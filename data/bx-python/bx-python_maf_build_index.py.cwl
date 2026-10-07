cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - maf_build_index.py
label: bx-python_maf_build_index.py
doc: "Build an index file for a set of MAF alignment blocks.\n\nTool homepage: https://github.com/bxlab/bx-python"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.maf_file)
inputs:
  - id: maf_file
    type: File
    doc: MAF alignment blocks file (staged in the working directory so that the 
      default index maf_file.index is written there)
    inputBinding:
      position: 1
  - id: index_file
    type:
      - 'null'
      - string
    doc: Index file to be created. If not provided, maf_file.index is used.
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
      itemSeparator: ','
outputs:
  - id: index
    type: File
    doc: MAF index file
    outputBinding:
      glob: "$(inputs.index_file ? inputs.index_file : inputs.maf_file.basename.replace(/\\.(bz2|lzo)$/, '') + '.index')"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bx-python:0.14.0--py312h5e9d817_0
