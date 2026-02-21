cwlVersion: v1.2
class: CommandLineTool
baseCommand: cell2cell
label: cell2cell
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a system error log from a container runtime (Singularity/Apptainer)
  indicating a failure to build or extract the container image due to insufficient
  disk space ('no space left on device').\n\nTool homepage: https://github.com/earmingol/cell2cell"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cell2cell:0.8.4--pyhdfd78af_0
stdout: cell2cell.out
