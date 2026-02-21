cwlVersion: v1.2
class: CommandLineTool
baseCommand: narfmap_dragen-os
label: narfmap_dragen-os
doc: "The provided text is an error log indicating a failure to build or run the container
  image (no space left on device) and does not contain help information or argument
  definitions.\n\nTool homepage: https://github.com/Emiller88/NARFMAP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/narfmap:1.4.2--h5ca1c30_4
stdout: narfmap_dragen-os.out
