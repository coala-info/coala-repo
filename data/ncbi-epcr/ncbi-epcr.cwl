cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncbi-epcr
label: ncbi-epcr
doc: The provided text is a system error message from a container runtime (Apptainer/Singularity)
  indicating a failure to pull or build the container image due to insufficient disk
  space. It does not contain the help text or usage information for the ncbi-epcr
  tool.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ncbi-epcr:v2.3.12-1-7-deb_cv1
stdout: ncbi-epcr.out
