cwlVersion: v1.2
class: CommandLineTool
baseCommand: bactopia-variants
label: bactopia-variants_bactopia
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Singularity/Apptainer)
  indicating a failure to build or extract the OCI image due to insufficient disk
  space ('no space left on device').\n\nTool homepage: https://bactopia.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bactopia-variants:1.0.2--hdfd78af_0
stdout: bactopia-variants_bactopia.out
