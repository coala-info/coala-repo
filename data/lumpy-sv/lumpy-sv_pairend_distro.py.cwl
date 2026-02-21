cwlVersion: v1.2
class: CommandLineTool
baseCommand: lumpy-sv_pairend_distro.py
label: lumpy-sv_pairend_distro.py
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Singularity/Apptainer) failure
  due to insufficient disk space.\n\nTool homepage: https://github.com/arq5x/lumpy-sv"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lumpy-sv:0.3.1--3
stdout: lumpy-sv_pairend_distro.py.out
