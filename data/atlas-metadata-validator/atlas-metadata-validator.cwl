cwlVersion: v1.2
class: CommandLineTool
baseCommand: atlas-metadata-validator
label: atlas-metadata-validator
doc: "A tool for validating metadata files for the Expression Atlas. Note: The provided
  help text contains system error messages regarding disk space and container extraction
  rather than command-line usage instructions.\n\nTool homepage: https://github.com/ebi-gene-expression-group/atlas-metadata-validator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/atlas-metadata-validator:1.6.1--pyhdfd78af_0
stdout: atlas-metadata-validator.out
