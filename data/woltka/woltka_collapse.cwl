cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - woltka
  - collapse
label: woltka_collapse
doc: "Collapse a profile by feature mapping and/or hierarchy.\n\nTool homepage: https://github.com/qiyunzhu/woltka"
inputs:
  - id: divide
    type:
      - 'null'
      - boolean
    doc: Count each target feature as 1/k (k is the number of targets mapped to 
      a source). Otherwise, count as one.
    inputBinding:
      position: 101
      prefix: --divide
  - id: field
    type:
      - 'null'
      - int
    doc: Collapse x-th field of stratified features. For example, "A|a" has 
      fields 1 ("A") and 2 ("a").
    inputBinding:
      position: 101
      prefix: --field
  - id: input_file
    type: File
    doc: Path to input profile.
    inputBinding:
      position: 101
      prefix: --input
  - id: map_file
    type:
      - 'null'
      - File
    doc: Mapping of source features to target features. Supports many-to-many 
      relationships.
    inputBinding:
      position: 101
      prefix: --map
  - id: names_path
    type:
      - 'null'
      - File
    doc: Names of target features to append to the output profile.
    inputBinding:
      position: 101
      prefix: --names
  - id: nested
    type:
      - 'null'
      - boolean
    doc: Fields are nested (each field is a child of the previous field). For 
      example, "A_1" represents "1" of "A".
    inputBinding:
      position: 101
      prefix: --nested
  - id: sep
    type:
      - 'null'
      - string
    doc: 'Field separator for nested features (default: "_") or otherwise (default:
      "|").'
    inputBinding:
      position: 101
      prefix: --sep
outputs:
  - id: output_file
    type: File
    doc: Path to output profile.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/woltka:0.1.7--pyhdfd78af_0
