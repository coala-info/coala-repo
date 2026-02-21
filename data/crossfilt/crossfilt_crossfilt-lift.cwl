cwlVersion: v1.2
class: CommandLineTool
baseCommand: crossfilt-lift
label: crossfilt_crossfilt-lift
doc: "The provided text contains error logs from a container runtime (Singularity/Apptainer)
  indicating a failure to build or run the image due to lack of disk space. It does
  not contain the help text or usage information for the tool itself.\n\nTool homepage:
  https://github.com/kennethabarr/CrossFilt"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crossfilt:0.2.1--pyhdfd78af_0
stdout: crossfilt_crossfilt-lift.out
