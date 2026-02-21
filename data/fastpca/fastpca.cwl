cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastpca
label: fastpca
doc: "The provided text contains error messages from a container runtime (Apptainer/Singularity)
  and does not include the help documentation or usage instructions for the fastpca
  tool.\n\nTool homepage: https://github.com/lettis/FastPCA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastpca:0.9.1
stdout: fastpca.out
