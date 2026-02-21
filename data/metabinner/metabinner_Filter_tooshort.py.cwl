cwlVersion: v1.2
class: CommandLineTool
baseCommand: metabinner_Filter_tooshort.py
label: metabinner_Filter_tooshort.py
doc: "A tool to filter sequences that are too short (Note: The provided help text
  contains only system error messages and no usage information).\n\nTool homepage:
  https://github.com/ziyewang/MetaBinner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabinner:1.4.4--hdfd78af_1
stdout: metabinner_Filter_tooshort.py.out
