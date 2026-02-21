cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bam-read
label: transrate-tools_bam-read
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build or extract a Singularity/Apptainer container due
  to insufficient disk space.\n\nTool homepage: https://github.com/blahah/transrate-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/transrate-tools:v1.0.0-2-deb_cv1
stdout: transrate-tools_bam-read.out
