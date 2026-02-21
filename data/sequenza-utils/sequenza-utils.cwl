cwlVersion: v1.2
class: CommandLineTool
baseCommand: sequenza-utils
label: sequenza-utils
doc: "The provided text does not contain help information for sequenza-utils. It contains
  error logs related to a failed container build (Apptainer/Singularity) due to insufficient
  disk space ('no space left on device').\n\nTool homepage: http://sequenza-utils.readthedocs.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequenza-utils:3.0.0--py311h8ddd9a4_8
stdout: sequenza-utils.out
