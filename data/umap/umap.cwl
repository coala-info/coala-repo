cwlVersion: v1.2
class: CommandLineTool
baseCommand: umap
label: umap
doc: "Uniform Manifold Approximation and Projection (UMAP) for Dimension Reduction\n
  \nTool homepage: https://bitbucket.org/hoffmanlab/umap/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/umap:1.1.1--pyh1687a27_0
stdout: umap.out
