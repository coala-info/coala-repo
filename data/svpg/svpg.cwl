cwlVersion: v1.2
class: CommandLineTool
baseCommand: svpg
label: svpg
doc: "Structural Variant Phenotype Graph (SVPG) - Tool for prioritizing structural
  variants.\n\nTool homepage: https://github.com/coopsor/SVPG"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svpg:1.4.1--pyhdfd78af_0
stdout: svpg.out
