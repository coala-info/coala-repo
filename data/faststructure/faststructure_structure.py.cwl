cwlVersion: v1.2
class: CommandLineTool
baseCommand: structure.py
label: faststructure_structure.py
doc: "The provided text does not contain help information for the tool. It contains
  error messages related to a container environment (Singularity/Apptainer) failing
  to pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/rajanil/fastStructure"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/faststructure:1.0--py311h1f01909_6
stdout: faststructure_structure.py.out
