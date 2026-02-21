cwlVersion: v1.2
class: CommandLineTool
baseCommand: estmapper_manage.py
label: estmapper_manage.py
doc: "Management script for ESTmapper. (Note: The provided help text contains only
  system error messages regarding container image conversion and disk space; no specific
  command-line arguments or usage instructions were found in the input.)\n\nTool homepage:
  https://github.com/estmapper/1234"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/estmapper:2008--py311pl5321hd8d945a_7
stdout: estmapper_manage.py.out
