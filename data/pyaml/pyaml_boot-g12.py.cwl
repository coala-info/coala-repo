cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyaml_boot-g12.py
label: pyaml_boot-g12.py
doc: "The provided text appears to be an error log from a container runtime (Apptainer/Singularity)
  rather than help text for the tool. No usage information or arguments could be extracted.\n
  \nTool homepage: https://github.com/superna9999/pyamlboot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyaml:15.8.2--py35_0
stdout: pyaml_boot-g12.py.out
