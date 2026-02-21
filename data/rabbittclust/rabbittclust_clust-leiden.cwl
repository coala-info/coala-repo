cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rabbittclust
  - clust-leiden
label: rabbittclust_clust-leiden
doc: "RabbitTClust clustering using the Leiden algorithm. (Note: The provided text
  is a container execution error log and does not contain help information or argument
  definitions.)\n\nTool homepage: https://github.com/RabbitBio/RabbitTClust"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rabbittclust:2.3.0--h43eeafb_0
stdout: rabbittclust_clust-leiden.out
