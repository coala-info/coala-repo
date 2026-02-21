cwlVersion: v1.2
class: CommandLineTool
baseCommand: starcode-umi
label: starcode_starcode-umi
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a failed container build process.\n\nTool
  homepage: https://github.com/gui11aume/starcode"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/starcode:1.4--h7b50bb2_7
stdout: starcode_starcode-umi.out
