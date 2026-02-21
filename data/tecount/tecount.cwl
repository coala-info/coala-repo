cwlVersion: v1.2
class: CommandLineTool
baseCommand: tecount
label: tecount
doc: "The provided text does not contain help information for the tool 'tecount'.
  It contains error logs related to a failed container image build/fetch process (Apptainer/Singularity).\n
  \nTool homepage: https://github.com/bodegalab/tecount"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tecount:1.0.1--pyhdfd78af_0
stdout: tecount.out
