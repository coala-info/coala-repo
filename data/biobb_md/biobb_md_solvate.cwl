cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_md_solvate
label: biobb_md_solvate
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a fatal error log from a container runtime (Singularity/Apptainer)
  indicating a 'no space left on device' failure during the image build process.\n
  \nTool homepage: https://github.com/bioexcel/biobb_md"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_md:3.7.2--pyhdfd78af_0
stdout: biobb_md_solvate.out
