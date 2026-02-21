cwlVersion: v1.2
class: CommandLineTool
baseCommand: ashleys-qc_ashleys.py
label: ashleys-qc_ashleys.py
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log reporting a failure to build a Singularity/Apptainer container
  due to insufficient disk space.\n\nTool homepage: https://github.com/friendsofstrandseq/ashleys-qc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ashleys-qc:0.2.1--pyh7cba7a3_0
stdout: ashleys-qc_ashleys.py.out
