cwlVersion: v1.2
class: CommandLineTool
baseCommand: sourmash_storage
label: sourmash_storage
doc: "Storage utilities\n\nTool homepage: https://github.com/sourmash-bio/sourmash"
inputs:
  - id: convert
    type:
      - 'null'
      - boolean
    doc: convert an SBT to use a different back end.
    inputBinding:
      position: 101
      prefix: sourmash_storage_convert
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
stdout: sourmash_storage.out
