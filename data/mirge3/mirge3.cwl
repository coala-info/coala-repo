cwlVersion: v1.2
class: CommandLineTool
baseCommand: mirge3
label: mirge3
doc: "miRge3 is a comprehensive small RNA-seq analysis pipeline. (Note: The provided
  text is a system error message and does not contain usage instructions or argument
  definitions.)\n\nTool homepage: https://github.com/mhalushka/miRge3.0/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirge3:0.1.4--pyh7cba7a3_1
stdout: mirge3.out
