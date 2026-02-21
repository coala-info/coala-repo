cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rabbittclust
  - clust-greedy
label: rabbittclust_clust-greedy
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Apptainer/Singularity) failing
  to fetch or build the container image.\n\nTool homepage: https://github.com/RabbitBio/RabbitTClust"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rabbittclust:2.3.0--h43eeafb_0
stdout: rabbittclust_clust-greedy.out
