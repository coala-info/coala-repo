cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - famus
  - install
label: famus_famus-install
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help documentation or usage instructions for the tool. No arguments
  could be extracted.\n\nTool homepage: https://github.com/burstein-lab/famus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/famus:0.2.2--py312hdfd78af_0
stdout: famus_famus-install.out
