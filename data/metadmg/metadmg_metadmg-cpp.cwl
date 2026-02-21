cwlVersion: v1.2
class: CommandLineTool
baseCommand: metadmg-cpp
label: metadmg_metadmg-cpp
doc: "MetaDMG: Ancient DNA damage estimation (Note: The provided help text contains
  only system error messages and no usage information).\n\nTool homepage: https://github.com/metaDMG-dev/metaDMG-cpp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metadmg:0.4.2--h2d82557_0
stdout: metadmg_metadmg-cpp.out
