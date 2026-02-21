cwlVersion: v1.2
class: CommandLineTool
baseCommand: sam_bcftools
label: sam_bcftools
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a log of a failed container build/fetch process.\n\nTool homepage:
  https://www.htslib.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sam:3.5--0
stdout: sam_bcftools.out
