cwlVersion: v1.2
class: CommandLineTool
baseCommand: shape_it
label: shape_it
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build or extract a container image due to insufficient disk
  space ('no space left on device').\n\nTool homepage: https://github.com/facebookarchive/Keyframes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shapeshifter-cli:1.0.0--py_0
stdout: shape_it.out
