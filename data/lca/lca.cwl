cwlVersion: v1.2
class: CommandLineTool
baseCommand: lca
label: lca
doc: "The provided text contains error logs from a container runtime (Apptainer/Singularity)
  and does not provide help information or usage instructions for the 'lca' tool.\n
  \nTool homepage: https://github.com/hildebra/LCA/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lca:0.25--hdcf5f25_0
stdout: lca.out
