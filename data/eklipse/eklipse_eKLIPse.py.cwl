cwlVersion: v1.2
class: CommandLineTool
baseCommand: eklipse_eKLIPse.py
label: eklipse_eKLIPse.py
doc: "The provided text does not contain help information for the tool, but rather
  system error logs related to a container runtime (Apptainer/Singularity) failure
  due to insufficient disk space.\n\nTool homepage: https://github.com/dooguypapua/eKLIPse"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eklipse:1.8--hdfd78af_2
stdout: eklipse_eKLIPse.py.out
