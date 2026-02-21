cwlVersion: v1.2
class: CommandLineTool
baseCommand: ima3_IMfig.py
label: ima3_IMfig.py
doc: "The provided text contains container runtime error messages (Singularity/Apptainer)
  and does not include the help documentation or usage instructions for the tool.\n
  \nTool homepage: https://github.com/jodyhey/IMa3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ima3:1.13--h503566f_2
stdout: ima3_IMfig.py.out
