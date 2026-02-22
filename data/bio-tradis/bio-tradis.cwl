cwlVersion: v1.2
class: CommandLineTool
baseCommand: bio-tradis
label: bio-tradis
doc: "No description available from the provided text. The input contains system error
  messages regarding disk space rather than help text.\n\nTool homepage: https://github.com/ialbert/bio"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bio-tradis:v1.4.1dfsg-1-deb_cv1
stdout: bio-tradis.out
