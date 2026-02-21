cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_md_pdb2gmx
label: biobb_md_pdb2gmx
doc: "The provided text is an error log from a container build process and does not
  contain help information or command-line arguments for the tool.\n\nTool homepage:
  https://github.com/bioexcel/biobb_md"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_md:3.7.2--pyhdfd78af_0
stdout: biobb_md_pdb2gmx.out
