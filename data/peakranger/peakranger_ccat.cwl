cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - peakranger
  - ccat
label: peakranger_ccat
doc: "The provided text does not contain help information or usage instructions. It
  is a log of a fatal error during a container build/fetch process.\n\nTool homepage:
  https://github.com/drestion/peakranger"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peakranger:1.18--boost1.64_2
stdout: peakranger_ccat.out
