cwlVersion: v1.2
class: CommandLineTool
baseCommand: cyvcf2
label: cyvcf2
doc: "The provided text does not contain help information for cyvcf2; it is an error
  log from a container runtime (Apptainer/Singularity) indicating a failure to build
  or extract the image due to lack of disk space.\n\nTool homepage: https://github.com/brentp/cyvcf2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cyvcf2:0.31.4--py310h4de444c_1
stdout: cyvcf2.out
