cwlVersion: v1.2
class: CommandLineTool
baseCommand: rainbow
label: bio-rainbow
doc: "No description available: The provided text contains system error messages rather
  than tool help text.\n\nTool homepage: https://github.com/ialbert/bio"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bio-rainbow:v2.0.4-1b1-deb_cv1
stdout: bio-rainbow.out
