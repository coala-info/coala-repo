cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncbi-util-legacy
label: ncbi-util-legacy
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help documentation or usage information for the tool.\n\nTool
  homepage: ftp://ftp.ncbi.nih.gov/toolbox/ncbi_tools/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbi-util-legacy:6.1--ha14ba45_0
stdout: ncbi-util-legacy.out
