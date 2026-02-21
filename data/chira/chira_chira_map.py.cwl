cwlVersion: v1.2
class: CommandLineTool
baseCommand: chira_chira_map.py
label: chira_chira_map.py
doc: "The provided text does not contain help information or usage instructions. It
  contains system error messages related to a container build failure (no space left
  on device).\n\nTool homepage: https://github.com/pavanvidem/chira/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chira:1.4.3--hdfd78af_2
stdout: chira_chira_map.py.out
