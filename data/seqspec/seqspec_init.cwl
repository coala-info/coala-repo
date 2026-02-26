cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqspec init
label: seqspec_init
doc: "Generate a new *empty* seqspec draft (meta-Regions only).\n\nTool homepage:
  https://github.com/sbooeshaghi/seqspec"
inputs:
  - id: date
    type:
      - 'null'
      - string
    doc: Date (YYYY-MM-DD)
    inputBinding:
      position: 101
      prefix: --date
  - id: description
    type:
      - 'null'
      - string
    doc: Short description
    inputBinding:
      position: 101
      prefix: --description
  - id: doi
    type:
      - 'null'
      - string
    doc: DOI of the assay
    inputBinding:
      position: 101
      prefix: --doi
  - id: modalities
    type: string
    doc: Comma-separated list of modalities (e.g. rna,atac)
    inputBinding:
      position: 101
      prefix: --modalities
  - id: name
    type: string
    doc: Assay name
    inputBinding:
      position: 101
      prefix: --name
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output YAML (default stdout)
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqspec:0.4.0--pyhdfd78af_0
