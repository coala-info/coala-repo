cwlVersion: v1.2
class: CommandLineTool
baseCommand: chia-rep_commands.py
label: chia-rep_commands.py
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a system error log related to a failed Singularity/Apptainer
  image build (no space left on device).\n\nTool homepage: https://github.com/c0ver/chia_rep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chia-rep:3.1.1--py310h068649b_3
stdout: chia-rep_commands.py.out
