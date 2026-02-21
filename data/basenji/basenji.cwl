cwlVersion: v1.2
class: CommandLineTool
baseCommand: basenji
label: basenji
doc: "The provided text does not contain help information for the tool 'basenji'.
  It appears to be a system error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build the image due to insufficient disk space ('no space
  left on device').\n\nTool homepage: https://github.com/calico/basenji"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/basenji:0.6--pyhdfd78af_0
stdout: basenji.out
