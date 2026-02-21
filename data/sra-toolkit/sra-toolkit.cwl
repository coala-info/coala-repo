cwlVersion: v1.2
class: CommandLineTool
baseCommand: sra-toolkit
label: sra-toolkit
doc: "The SRA Toolkit and SDK from NCBI is a collection of tools and libraries for
  using data from the Sequence Read Archive.\n\nTool homepage: https://github.com/inutano/sra_metadata_toolkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sra-toolkit:v2.9.3dfsg-1b1-deb_cv1
stdout: sra-toolkit.out
