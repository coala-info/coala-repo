cwlVersion: v1.2
class: CommandLineTool
baseCommand: BamToFastq
label: ngs-bits_BamToFastq
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Singularity/Apptainer) indicating
  a failure to pull or build the container image due to insufficient disk space.\n
  \nTool homepage: https://github.com/imgag/ngs-bits"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_09--py313h572c47f_0
stdout: ngs-bits_BamToFastq.out
