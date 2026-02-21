cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - flextaxd
  - create
label: flextaxd_flextaxd-create
doc: "The provided text does not contain help information for the tool, but appears
  to be a system error log from a container runtime (Singularity/Apptainer) indicating
  a 'no space left on device' failure during image building.\n\nTool homepage: https://github.com/FOI-Bioinformatics/flextaxd"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flextaxd:0.4.4--pyhdfd78af_0
stdout: flextaxd_flextaxd-create.out
