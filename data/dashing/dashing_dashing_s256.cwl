cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dashing
label: dashing_dashing_s256
doc: "The provided text does not contain help information or argument definitions;
  it is an error log from a container runtime (Apptainer/Singularity) indicating a
  'no space left on device' failure during image extraction.\n\nTool homepage: https://github.com/dnbaker/dashing"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dashing:1.0--h5b0a936_3
stdout: dashing_dashing_s256.out
