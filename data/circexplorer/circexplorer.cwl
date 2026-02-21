cwlVersion: v1.2
class: CommandLineTool
baseCommand: circexplorer
label: circexplorer
doc: "The provided text does not contain help information or usage instructions for
  the tool. It is an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build or extract the container image due to insufficient disk space
  ('no space left on device').\n\nTool homepage: https://github.com/YangLab/CIRCexplorer2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/circexplorer:1.1.10--py35_0
stdout: circexplorer.out
