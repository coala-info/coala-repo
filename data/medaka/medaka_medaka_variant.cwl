cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - medaka
  - variant
label: medaka_medaka_variant
doc: "The provided text does not contain help information for the tool, but rather
  error logs from a container runtime (Singularity/Apptainer) indicating a failure
  to build the image due to lack of disk space.\n\nTool homepage: https://github.com/nanoporetech/medaka"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/medaka:2.2.0--py311h1d3aea1_0
stdout: medaka_medaka_variant.out
