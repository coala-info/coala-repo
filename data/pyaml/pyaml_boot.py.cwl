cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyaml_boot.py
label: pyaml_boot.py
doc: "The provided text does not contain help information or usage instructions for
  pyaml_boot.py. It appears to be a log from a container build process (Singularity/Apptainer)
  that encountered a fatal error.\n\nTool homepage: https://github.com/superna9999/pyamlboot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyaml:15.8.2--py35_0
stdout: pyaml_boot.py.out
