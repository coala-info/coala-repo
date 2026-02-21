cwlVersion: v1.2
class: CommandLineTool
baseCommand: faststructure_distruct.py
label: faststructure_distruct.py
doc: "The provided text does not contain help information for the tool; it contains
  system error messages related to a container environment (Apptainer/Singularity)
  failing due to lack of disk space.\n\nTool homepage: https://github.com/rajanil/fastStructure"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/faststructure:1.0--py311h1f01909_6
stdout: faststructure_distruct.py.out
