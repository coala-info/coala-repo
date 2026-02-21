cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - crossfilt-split
label: crossfilt_crossfilt-split
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime (Singularity/Apptainer) indicating
  a failure to build the image due to insufficient disk space.\n\nTool homepage: https://github.com/kennethabarr/CrossFilt"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crossfilt:0.2.1--pyhdfd78af_0
stdout: crossfilt_crossfilt-split.out
