cwlVersion: v1.2
class: CommandLineTool
baseCommand: nimnexus
label: nimnexus
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to build the SIF format due to lack of disk space.\n\nTool homepage: https://github.com/avsecz/nimnexus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nimnexus:0.1.1--hb763d49_0
stdout: nimnexus.out
