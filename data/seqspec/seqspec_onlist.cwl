cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqspec
  - onlist
label: seqspec_onlist
doc: "Get onlist file for specific region. Onlist is a list of permissible sequences
  for a region.\n\nTool homepage: https://github.com/sbooeshaghi/seqspec"
inputs:
  - id: local_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Local files named in the spec (for example onlist files), staged next to
      the spec so that relative paths resolve
  - id: yaml
    type: File
    doc: Sequencing specification yaml file
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: format
    type:
      - 'null'
      - string
    doc: Format for combining multiple onlists (product, multi)
    inputBinding:
      position: 102
      prefix: --format
  - id: id
    type:
      - 'null'
      - string
    doc: ID to search for
    inputBinding:
      position: 102
      prefix: --id
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
    doc: Selector for ID, [read, region, region-type]
    inputBinding:
      position: 102
      prefix: --selector
  - id: output_path
    type: string
    doc: Path to output file (required for download/join operations)
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Path to output file (required for download/join operations)
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing: |
      ${ return [inputs.yaml].concat(inputs.local_files ? inputs.local_files : []); }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqspec:0.4.0--pyhdfd78af_0
