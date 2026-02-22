cwlVersion: v1.2
class: CommandLineTool
baseCommand: bioconda-backup
label: bioconda-backup
doc: The provided text does not contain help information or a description of the
  tool; it consists of system error messages related to a failed container 
  execution (no space left on device).
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bioconda-backup:latest
stdout: bioconda-backup.out
