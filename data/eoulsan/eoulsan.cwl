cwlVersion: v1.2
class: CommandLineTool
baseCommand: eoulsan
label: eoulsan
doc: "Eoulsan is a transcriptomics analysis pipeline. Note: The provided help text
  contains only system error messages and no usage information.\n\nTool homepage:
  http://www.tools.genomique.biologie.ens.fr/eoulsan/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eoulsan:2.5--hdfd78af_0
stdout: eoulsan.out
