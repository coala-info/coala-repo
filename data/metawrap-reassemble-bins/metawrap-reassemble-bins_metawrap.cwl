cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metawrap
  - reassemble_bins
label: metawrap-reassemble-bins_metawrap
doc: "Reassemble metagenomic bins to improve their quality using the metaWRAP pipeline.\n
  \nTool homepage: https://github.com/bxlab/metaWRAP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metawrap-reassemble-bins:1.3.0--hdfd78af_3
stdout: metawrap-reassemble-bins_metawrap.out
