cwlVersion: v1.2
class: CommandLineTool
baseCommand: rabbittclust
label: rabbittclust
doc: "The provided text does not contain help information or usage instructions for
  the tool; it contains error logs from a failed container build/fetch process.\n\n
  Tool homepage: https://github.com/RabbitBio/RabbitTClust"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rabbittclust:2.3.0--h43eeafb_0
stdout: rabbittclust.out
