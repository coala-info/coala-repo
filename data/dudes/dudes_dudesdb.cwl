cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dudes
  - dudesdb
label: dudes_dudesdb
doc: "The provided text does not contain help information for the tool. It appears
  to be an error log from a container runtime (Singularity/Apptainer) indicating a
  failure to build the image due to lack of disk space.\n\nTool homepage: https://github.com/pirovc/dudes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dudes:0.10.0--pyhdfd78af_0
stdout: dudes_dudesdb.out
