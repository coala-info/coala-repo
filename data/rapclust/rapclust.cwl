cwlVersion: v1.2
class: CommandLineTool
baseCommand: rapclust
label: rapclust
doc: "RapClust is a tool for clustering transcript sequences based on their pseudo-mapping
  or alignment information. (Note: The provided text is a container engine error log
  and does not contain usage information or argument definitions.)\n\nTool homepage:
  https://github.com/COMBINE-lab/RapClust"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rapclust:0.1.2--py35_0
stdout: rapclust.out
