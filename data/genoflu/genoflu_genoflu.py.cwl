cwlVersion: v1.2
class: CommandLineTool
baseCommand: genoflu_genoflu.py
label: genoflu_genoflu.py
doc: "A tool for Influenza virus subtyping and nomenclature (Note: The provided help
  text contains only system error logs and no usage information).\n\nTool homepage:
  https://github.com/USDA-VS/GenoFLU"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genoflu:1.06--hdfd78af_0
stdout: genoflu_genoflu.py.out
