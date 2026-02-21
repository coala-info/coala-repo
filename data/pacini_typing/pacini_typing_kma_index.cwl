cwlVersion: v1.2
class: CommandLineTool
baseCommand: pacini_typing_kma_index
label: pacini_typing_kma_index
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build the container image due to lack of disk space. It
  does not contain help information or argument definitions for the tool.\n\nTool
  homepage: https://github.com/RIVM-bioinformatics/Pacini-typing"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pacini_typing:2.0.2--pyhdfd78af_0
stdout: pacini_typing_kma_index.out
