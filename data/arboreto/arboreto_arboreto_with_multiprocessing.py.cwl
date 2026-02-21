cwlVersion: v1.2
class: CommandLineTool
baseCommand: arboreto_arboreto_with_multiprocessing.py
label: arboreto_arboreto_with_multiprocessing.py
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains error logs related to a Singularity/Apptainer image build
  failure due to insufficient disk space.\n\nTool homepage: https://github.com/tmoerman/arboreto"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/arboreto:0.1.6--pyh7e72e81_1
stdout: arboreto_arboreto_with_multiprocessing.py.out
