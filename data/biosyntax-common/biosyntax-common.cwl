cwlVersion: v1.2
class: CommandLineTool
baseCommand: biosyntax-common
label: biosyntax-common
doc: The provided text is an error log from a container runtime 
  (Singularity/Apptainer) and does not contain help information or argument 
  definitions for the tool.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/biosyntax-common:v1.0.0b-1-deb_cv1
stdout: biosyntax-common.out
