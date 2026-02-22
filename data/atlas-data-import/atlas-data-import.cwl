cwlVersion: v1.2
class: CommandLineTool
baseCommand: atlas-data-import
label: atlas-data-import
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a system error log related to a container runtime (Singularity/Docker)
  failure due to insufficient disk space.\n\nTool homepage: https://github.com/ebi-gene-expression-group/atlas-data-import"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atlas-data-import:0.1.1--hdfd78af_0
stdout: atlas-data-import.out
