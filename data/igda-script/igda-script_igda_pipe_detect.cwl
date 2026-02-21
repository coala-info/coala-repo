cwlVersion: v1.2
class: CommandLineTool
baseCommand: igda_pipe_detect
label: igda-script_igda_pipe_detect
doc: "The provided text does not contain help information for the tool. It contains
  error logs related to a container runtime (Apptainer/Singularity) failing to pull
  or build the image due to insufficient disk space.\n\nTool homepage: https://github.com/zhixingfeng/shell"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
stdout: igda-script_igda_pipe_detect.out
