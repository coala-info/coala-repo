cwlVersion: v1.2
class: CommandLineTool
baseCommand: basenji_map.py
label: basenji_basenji_map.py
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of system error logs related to a failed Apptainer/Singularity
  container build (no space left on device).\n\nTool homepage: https://github.com/calico/basenji"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/basenji:0.6--pyhdfd78af_0
stdout: basenji_basenji_map.py.out
