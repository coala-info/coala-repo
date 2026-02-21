cwlVersion: v1.2
class: CommandLineTool
baseCommand: VcfAnnotateFromBed
label: ngs-bits_VcfAnnotateFromBed
doc: "The provided text does not contain help information for the tool. It contains
  error messages related to a container runtime (Apptainer/Singularity) failing to
  pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_09--py313h572c47f_0
stdout: ngs-bits_VcfAnnotateFromBed.out
