cwlVersion: v1.2
class: CommandLineTool
baseCommand: allelecodes_assignallelecodes_py3.6.py
label: allelecodes_assignallelecodes_py3.6.py
doc: "A tool for assigning allele codes. (Note: The provided input text contains system
  error messages regarding a container build failure and does not include the actual
  help documentation for the tool.)\n\nTool homepage: https://github.com/ncezid-biome/AlleleCodes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/allelecodes:2.1--py313hdfd78af_0
stdout: allelecodes_assignallelecodes_py3.6.py.out
