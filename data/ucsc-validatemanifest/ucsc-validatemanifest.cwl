cwlVersion: v1.2
class: CommandLineTool
baseCommand: validateManifest
label: ucsc-validatemanifest
doc: "Validate a manifest file to ensure it is correctly formatted and optionally
  check that files exist and match metadata.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: manifest_file
    type: File
    doc: The manifest file to validate.
    inputBinding:
      position: 1
  - id: extended
    type:
      - 'null'
      - boolean
    doc: Check that files exist and match md5sum and size specified in the 
      manifest.
    inputBinding:
      position: 102
      prefix: -extended
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-validatemanifest:482--h0b57e2e_0
stdout: ucsc-validatemanifest.out
