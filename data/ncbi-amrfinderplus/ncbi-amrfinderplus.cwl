cwlVersion: v1.2
class: CommandLineTool
baseCommand: amrfinder
label: ncbi-amrfinderplus
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  indicating a failure to pull the image due to insufficient disk space.\n\nTool homepage:
  https://github.com/ncbi/amr/wiki"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbi-amrfinderplus:4.2.7--hf69ffd2_0
stdout: ncbi-amrfinderplus.out
