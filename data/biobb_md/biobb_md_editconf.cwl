cwlVersion: v1.2
class: CommandLineTool
baseCommand: editconf
label: biobb_md_editconf
doc: "The provided text does not contain help information for the tool. It appears
  to be an error log from a container runtime (Apptainer/Singularity) indicating a
  'no space left on device' failure during the image build process.\n\nTool homepage:
  https://github.com/bioexcel/biobb_md"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_md:3.7.2--pyhdfd78af_0
stdout: biobb_md_editconf.out
