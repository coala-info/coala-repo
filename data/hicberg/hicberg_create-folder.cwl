cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hicberg
  - create-folder
label: hicberg_create-folder
doc: 'Create a folder to save results. Folder will be set as <output>/<name>.


  Tool homepage: https://github.com/sebgra/hicberg'
inputs:
  - id: output_dir
    type:
      - 'null'
      - string
    doc: Existing parent folder in which the result folder is created. If not set,
      the current directory is used.
    inputBinding:
      position: 101
      prefix: --output
  - id: name
    type:
      - 'null'
      - string
    doc: Name of the result folder to create. If not set, 'sample' is used.
    inputBinding:
      position: 102
      prefix: --name
  - id: force
    type:
      - 'null'
      - boolean
    doc: Set if previous analysis files are deleted.
    inputBinding:
      position: 103
      prefix: --force
outputs:
  - id: result_folder
    type: Directory
    doc: The created result folder (index, alignments, statistics, contacts and plots
      sub-folders).
    outputBinding:
      glob: '${ var n = inputs.name || ''sample''; return inputs.output_dir ? inputs.output_dir
        + ''/'' + n : n; }'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicberg:1.0.1--py312hcf36b3e_0
