cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - expam
  - limit
label: expam_expam_limit
doc: "The provided text does not contain help information or usage instructions; it
  contains error logs related to a container runtime failure (no space left on device).\n
  \nTool homepage: https://github.com/seansolari/expam"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/expam:1.4.0.7--py39hbcbf7aa_0
stdout: expam_expam_limit.out
