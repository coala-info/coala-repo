cwlVersion: v1.2
class: CommandLineTool
baseCommand: eukcc folder
label: eukcc_folder
doc: "eukcc folder: error: the following arguments are required: binfolder\n\nTool
  homepage: https://github.com/Finn-Lab/EukCC/"
inputs:
  - id: binfolder
    type: Directory
    doc: binfolder
    inputBinding:
      position: 1
  - id: db
    type:
      - 'null'
      - string
    doc: db
    inputBinding:
      position: 102
      prefix: --db
  - id: improve_percent
    type:
      - 'null'
      - float
    doc: improve_percent
    inputBinding:
      position: 102
      prefix: --improve_percent
  - id: improve_ratio
    type:
      - 'null'
      - float
    doc: improve_ratio
    inputBinding:
      position: 102
      prefix: --improve_ratio
  - id: links
    type:
      - 'null'
      - string
    doc: links
    inputBinding:
      position: 102
      prefix: --links
  - id: marker_prevalence
    type:
      - 'null'
      - float
    doc: marker_prevalence
    inputBinding:
      position: 102
      prefix: --marker_prevalence
  - id: min_links
    type:
      - 'null'
      - int
    doc: min_links
    inputBinding:
      position: 102
      prefix: --min_links
  - id: n_combine
    type:
      - 'null'
      - int
    doc: n_combine
    inputBinding:
      position: 102
      prefix: --n_combine
  - id: prefix
    type:
      - 'null'
      - string
    doc: prefix
    inputBinding:
      position: 102
      prefix: --prefix
  - id: suffix
    type:
      - 'null'
      - string
    doc: suffix
    inputBinding:
      position: 102
      prefix: --suffix
  - id: threads
    type:
      - 'null'
      - int
    doc: threads
    inputBinding:
      position: 102
      prefix: --threads
  - id: threads_epa
    type:
      - 'null'
      - int
    doc: threads_epa
    inputBinding:
      position: 102
      prefix: --threads_epa
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: out
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eukcc:2.1.3--pyhdfd78af_0
