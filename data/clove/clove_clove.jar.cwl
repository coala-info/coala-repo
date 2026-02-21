cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - java
  - -jar
  - clove_clove.jar
label: clove_clove.jar
doc: "CLOVE (Characterization of LOw-frequency Variants in Evolution) is a tool for
  identifying and characterizing low-frequency variants.\n\nTool homepage: https://github.com/PapenfussLab/clove"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clove:0.17--py36_0
stdout: clove_clove.jar.out
