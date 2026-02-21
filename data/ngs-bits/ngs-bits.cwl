cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngs-bits
label: ngs-bits
doc: "The provided text does not contain help information. It is an error log indicating
  a failure to build or run a Singularity/Apptainer container due to insufficient
  disk space ('no space left on device').\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_09--py313h572c47f_0
stdout: ngs-bits.out
