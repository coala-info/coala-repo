cwlVersion: v1.2
class: CommandLineTool
baseCommand: spingo_gcloud
label: spingo_gcloud
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a log of a failed container build or execution attempt.\n\nTool homepage:
  https://github.com/homedepot/spingo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spingo:1.3
stdout: spingo_gcloud.out
