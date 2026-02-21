cwlVersion: v1.2
class: CommandLineTool
baseCommand: chira_chira_extract.py
label: chira_chira_extract.py
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system error logs related to a failed container build (Apptainer/Singularity)
  due to insufficient disk space.\n\nTool homepage: https://github.com/pavanvidem/chira/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chira:1.4.3--hdfd78af_2
stdout: chira_chira_extract.py.out
