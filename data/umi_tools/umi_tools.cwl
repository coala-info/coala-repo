cwlVersion: v1.2
class: CommandLineTool
baseCommand: umi_tools
label: umi_tools
doc: "The provided text does not contain CLI help information. It appears to be a
  log of a failed container build/fetch process (Singularity/Apptainer) for the umi-transfer
  image.\n\nTool homepage: https://github.com/CGATOxford/UMI-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/umi-transfer:1.6.0--hc1c3326_0
stdout: umi_tools.out
