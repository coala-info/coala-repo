cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metawrap
  - kraken
label: metawrap-kraken_metawrap
doc: "The provided text does not contain help information for the tool, but rather
  a system error log indicating a failure to build a Singularity/Apptainer container
  due to insufficient disk space.\n\nTool homepage: https://github.com/bxlab/metaWRAP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metawrap-kraken:1.3.0--hdfd78af_3
stdout: metawrap-kraken_metawrap.out
