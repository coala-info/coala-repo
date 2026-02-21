cwlVersion: v1.2
class: CommandLineTool
baseCommand: formatdb
label: ncbi-util-legacy_formatdb
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failure
  due to insufficient disk space.\n\nTool homepage: ftp://ftp.ncbi.nih.gov/toolbox/ncbi_tools/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbi-util-legacy:6.1--ha14ba45_0
stdout: ncbi-util-legacy_formatdb.out
