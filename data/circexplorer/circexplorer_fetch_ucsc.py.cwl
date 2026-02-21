cwlVersion: v1.2
class: CommandLineTool
baseCommand: circexplorer_fetch_ucsc.py
label: circexplorer_fetch_ucsc.py
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a system error log indicating a failure to build a Singularity/Apptainer
  container due to insufficient disk space ('no space left on device').\n\nTool homepage:
  https://github.com/YangLab/CIRCexplorer2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/circexplorer:1.1.10--py35_0
stdout: circexplorer_fetch_ucsc.py.out
