cwlVersion: v1.2
class: CommandLineTool
baseCommand: viral-ngs_MAFFT
label: viral-ngs_MAFFT
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a log of a failed container build process.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
stdout: viral-ngs_MAFFT.out
