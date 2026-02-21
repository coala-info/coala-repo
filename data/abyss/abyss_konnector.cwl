cwlVersion: v1.2
class: CommandLineTool
baseCommand: abyss-konnector
label: abyss_konnector
doc: "The provided text does not contain help information for abyss_konnector. It
  contains error logs related to a container runtime (Apptainer/Singularity) failure
  due to insufficient disk space.\n\nTool homepage: https://www.bcgsc.ca/platform/bioinfo/software/abyss"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/abyss:2.3.10--hf316886_2
stdout: abyss_konnector.out
