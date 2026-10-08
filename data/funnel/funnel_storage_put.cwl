cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - funnel
  - storage
  - put
label: funnel_storage_put
doc: "Put the local file to the given URL.\n\nTool homepage: https://ohsu-comp-bio.github.io/funnel/"
inputs:
  - id: input_file
    type: File
    doc: Local file to upload
    inputBinding:
      position: 1
  - id: url
    type: string
    doc: Destination URL (a local path, or a remote URL such as s3://, gs://)
    inputBinding:
      position: 2
      valueFrom: "$(self.indexOf('://') < 0 && self.charAt(0) != '/' ? runtime.outdir + '/' + self : self)"
  - id: config
    type:
      - 'null'
      - File
    doc: Config File
    inputBinding:
      position: 0
      prefix: --config
outputs:
  - id: uploaded_file
    type:
      - 'null'
      - File
    doc: The stored object when the URL is a local path
    outputBinding:
      glob: $(inputs.url)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/funnel:0.9.0--0
