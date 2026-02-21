cwlVersion: v1.2
class: CommandLineTool
baseCommand: sistr
label: sistr_cmd_sistr
doc: "Salmonella In Silico Typing Resource (SISTR) command line tool\n\nTool homepage:
  https://github.com/phac-nml/sistr_cmd/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sistr_cmd:1.1.3--pyhdc42f0e_1
stdout: sistr_cmd_sistr.out
