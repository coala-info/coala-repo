cwlVersion: v1.2
class: CommandLineTool
baseCommand: juicebox_scripts_juicebox_assembly_converter.py
label: juicebox_scripts_juicebox_assembly_converter.py
doc: "A script for converting Juicebox assembly files. (Note: The provided help text
  contained only system error messages and no usage information.)\n\nTool homepage:
  https://github.com/phasegenomics/juicebox_scripts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/juicebox_scripts:0.1.0gita7ae991--hdfd78af_0
stdout: juicebox_scripts_juicebox_assembly_converter.py.out
