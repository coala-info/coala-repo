cwlVersion: v1.2
class: CommandLineTool
baseCommand: chira_chira_quantify.py
label: chira_chira_quantify.py
doc: "The provided text does not contain help information; it is an error log indicating
  a failure to build or run a Singularity/Apptainer container due to lack of disk
  space.\n\nTool homepage: https://github.com/pavanvidem/chira/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chira:1.4.3--hdfd78af_2
stdout: chira_chira_quantify.py.out
