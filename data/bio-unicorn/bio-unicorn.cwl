cwlVersion: v1.2
class: CommandLineTool
baseCommand: bio-unicorn
label: bio-unicorn
doc: "The provided text does not contain help information or usage instructions for
  bio-unicorn; it is a log of a failed container build process due to insufficient
  disk space.\n\nTool homepage: https://github.com/GeoGenetics/unicorn"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio-unicorn:2.0.0--h577a1d6_0
stdout: bio-unicorn.out
