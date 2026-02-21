cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyamlboot
label: pyaml_pyamlboot
doc: "The provided text appears to be a container build log rather than CLI help text.
  As a result, no command-line arguments, flags, or usage instructions could be extracted.\n
  \nTool homepage: https://github.com/superna9999/pyamlboot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyaml:15.8.2--py35_0
stdout: pyaml_pyamlboot.out
