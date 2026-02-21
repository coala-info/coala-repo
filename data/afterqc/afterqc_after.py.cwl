cwlVersion: v1.2
class: CommandLineTool
baseCommand: afterqc_after.py
label: afterqc_after.py
doc: "The provided text does not contain help information or usage instructions for
  afterqc_after.py. It contains error logs related to a failed Singularity/Apptainer
  image build due to insufficient disk space.\n\nTool homepage: https://github.com/OpenGene/AfterQC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/afterqc:0.9.7--py27_0
stdout: afterqc_after.py.out
