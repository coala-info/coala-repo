cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamscale
label: bamscale
doc: "The provided text does not contain help information for bamscale; it is a log
  of a failed container build/execution (Apptainer/Singularity) due to insufficient
  disk space.\n\nTool homepage: https://github.com/ncbi/BAMscale"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamscale:0.0.9--hf9495ce_0
stdout: bamscale.out
