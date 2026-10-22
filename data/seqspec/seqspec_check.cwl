cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqspec
  - check
label: seqspec_check
doc: "Validate seqspec file against the specification schema.\n\nTool homepage: https://github.com/sbooeshaghi/seqspec"
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
  - id: skip
    type:
      - 'null'
      - string
    doc: Skip checks (igvf or igvf_onlist_skip)
    inputBinding:
      position: 102
      prefix: --skip
  - id: output_path
    type: string
    doc: Path to output file
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Path to output file
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
