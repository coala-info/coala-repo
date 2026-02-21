cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngsep
label: ngsep_NGSEPcore.jar
doc: "Next Generation Sequencing Experience Platform (NGSEP) core analysis tool.\n
  \nTool homepage: https://github.com/NGSEP/NGSEPcore"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngsep:4.0.1--0
stdout: ngsep_NGSEPcore.jar.out
