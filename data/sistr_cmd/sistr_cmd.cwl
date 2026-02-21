cwlVersion: v1.2
class: CommandLineTool
baseCommand: sistr_cmd
label: sistr_cmd
doc: "SISTR (Salmonella In Silico Typing Resource) command line tool\n\nTool homepage:
  https://github.com/phac-nml/sistr_cmd/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sistr_cmd:1.1.3--pyhdc42f0e_1
stdout: sistr_cmd.out
