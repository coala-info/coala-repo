cwlVersion: v1.2
class: CommandLineTool
baseCommand: sincei_scBulkCoverage
label: sincei_scBulkCoverage
doc: "The provided text does not contain help information for the tool, but appears
  to be a set of system logs and a fatal error message from a container runtime (Singularity/Apptainer)
  while attempting to fetch the tool's image.\n\nTool homepage: https://github.com/bhardwaj-lab/sincei"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sincei:0.5.2--pyhdfd78af_0
stdout: sincei_scBulkCoverage.out
