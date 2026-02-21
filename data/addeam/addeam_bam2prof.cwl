cwlVersion: v1.2
class: CommandLineTool
baseCommand: addeam_bam2prof
label: addeam_bam2prof
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log from a container runtime (Apptainer/Singularity) indicating
  a failure to extract an image due to lack of disk space.\n\nTool homepage: https://github.com/LouisPwr/AdDeam"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/addeam:1.0.0--py313h1510ab2_0
stdout: addeam_bam2prof.out
