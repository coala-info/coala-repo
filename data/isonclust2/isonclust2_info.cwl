cwlVersion: v1.2
class: CommandLineTool
baseCommand: [isONclust2, info]
label: isonclust2_info
doc: "Print information about a serialized batch.\n\nTool homepage: https://github.com/nanoporetech/isonclust2"
inputs:
  - id: batch
    type: File
    doc: Input serialized batch.
    inputBinding:
      position: 1
outputs:
  - id: batch_info
    type: stderr
    doc: Batch summary (number of sequences, clusters and minimizers), which the tool prints on standard error.
stderr: isonclust2_info.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isonclust2:2.3--hc9558a2_0
