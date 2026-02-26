cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqspec file
label: seqspec_file
doc: "List files present in seqspec file.\n\nTool homepage: https://github.com/sbooeshaghi/seqspec"
inputs:
  - id: yaml
    type: File
    doc: Sequencing specification yaml file
    inputBinding:
      position: 1
  - id: format
    type:
      - 'null'
      - string
    doc: Format, [paired, interleaved, index, list, json]
    default: paired
    inputBinding:
      position: 102
      prefix: --format
  - id: fullpath
    type:
      - 'null'
      - boolean
    doc: Use full path for local files
    inputBinding:
      position: 102
      prefix: --fullpath
  - id: ids
    type:
      - 'null'
      - string
    doc: Ids to list
    inputBinding:
      position: 102
      prefix: --ids
  - id: key
    type:
      - 'null'
      - string
    doc: Key, [file_id, filename, filetype, filesize, url, urltype, md5, all]
    default: file_id
    inputBinding:
      position: 102
      prefix: --key
  - id: modality
    type: string
    doc: Modality
    inputBinding:
      position: 102
      prefix: --modality
  - id: selector
    type:
      - 'null'
      - string
    doc: Selector for ID, [read, region, file, region-type]
    default: read
    inputBinding:
      position: 102
      prefix: --selector
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Path to output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqspec:0.4.0--pyhdfd78af_0
