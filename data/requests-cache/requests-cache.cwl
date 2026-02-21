cwlVersion: v1.2
class: CommandLineTool
baseCommand: requests-cache
label: requests-cache
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container build process.\n\nTool homepage: https://github.com/graphql/dataloader"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/requests-cache:0.4.10--py35_0
stdout: requests-cache.out
