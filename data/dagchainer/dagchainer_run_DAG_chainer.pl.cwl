cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_DAG_chainer.pl
label: dagchainer_run_DAG_chainer.pl
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to extract an image due to lack of disk space.\n\nTool homepage: https://github.com/kullrich/dagchainer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dagchainer:r120920--h9948957_5
stdout: dagchainer_run_DAG_chainer.pl.out
