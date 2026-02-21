cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rabbittclust
  - clust-mst
label: rabbittclust_clust-mst
doc: "Clustering tool (Note: The provided help text contains only container runtime
  errors and no usage information.)\n\nTool homepage: https://github.com/RabbitBio/RabbitTClust"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rabbittclust:2.3.0--h43eeafb_0
stdout: rabbittclust_clust-mst.out
