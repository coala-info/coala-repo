cwlVersion: v1.2
class: CommandLineTool
baseCommand: vardict
label: vardict
doc: "The provided text is an error log from a container build process and does not
  contain help information or usage instructions for the tool 'vardict'.\n\nTool homepage:
  https://github.com/AstraZeneca-NGS/VarDict"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vardict:2019.06.04--pl526_0
stdout: vardict.out
