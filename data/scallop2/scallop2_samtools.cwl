cwlVersion: v1.2
class: CommandLineTool
baseCommand: scallop2_samtools
label: scallop2_samtools
doc: "The provided text is an error log from a container execution environment (Apptainer/Singularity)
  and does not contain help information or usage instructions for the tool.\n\nTool
  homepage: https://github.com/Shao-Group/scallop2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scallop2:1.1.2--h5ca1c30_8
stdout: scallop2_samtools.out
