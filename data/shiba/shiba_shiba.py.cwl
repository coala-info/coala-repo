cwlVersion: v1.2
class: CommandLineTool
baseCommand: shiba_shiba.py
label: shiba_shiba.py
doc: "The provided text does not contain help information or usage instructions for
  shiba_shiba.py. It appears to be a log of a failed container build process (Apptainer/Singularity)
  due to insufficient disk space.\n\nTool homepage: https://github.com/Sika-Zheng-Lab/Shiba"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shiba:0.8.1--py312hdfd78af_0
stdout: shiba_shiba.py.out
