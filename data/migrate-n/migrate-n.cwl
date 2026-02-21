cwlVersion: v1.2
class: CommandLineTool
baseCommand: migrate-n
label: migrate-n
doc: "The provided text does not contain help information for migrate-n; it contains
  system error messages regarding a container runtime failure (no space left on device).\n
  \nTool homepage: http://popgen.sc.fsu.edu/Migrate/Migrate-n.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/migrate-n:3.6.11--haf0c795_7
stdout: migrate-n.out
