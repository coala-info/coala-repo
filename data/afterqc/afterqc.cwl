cwlVersion: v1.2
class: CommandLineTool
baseCommand: afterqc
label: afterqc
doc: "The provided text does not contain help information for the tool 'afterqc'.
  It is a log of a failed container build/extraction process due to insufficient disk
  space ('no space left on device').\n\nTool homepage: https://github.com/OpenGene/AfterQC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/afterqc:0.9.7--py27_0
stdout: afterqc.out
