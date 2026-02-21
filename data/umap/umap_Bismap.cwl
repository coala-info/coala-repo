cwlVersion: v1.2
class: CommandLineTool
baseCommand: umap_Bismap
label: umap_Bismap
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a log of a failed container build process.\n\nTool homepage: https://bitbucket.org/hoffmanlab/umap/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/umap:1.1.1--pyh1687a27_0
stdout: umap_Bismap.out
