cwlVersion: v1.2
class: CommandLineTool
baseCommand: kcftools
label: kcftools
doc: "The provided text does not contain help information for kcftools; it contains
  error messages related to a container runtime (Apptainer/Singularity) failing to
  build the image due to lack of disk space.\n\nTool homepage: https://github.com/sivasubramanics/kcftools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kcftools:0.4.0--hdfd78af_0
stdout: kcftools.out
