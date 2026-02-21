cwlVersion: v1.2
class: CommandLineTool
baseCommand: orthofisher
label: orthofisher
doc: "A tool for automated ortholog inference. (Note: The provided help text contains
  only system error messages and no usage information; therefore, no arguments could
  be extracted.)\n\nTool homepage: https://github.com/JLSteenwyk/orthofisher.git"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/orthofisher:1.1.1--pyhdfd78af_0
stdout: orthofisher.out
