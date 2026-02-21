cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hybpiper
  - recovery_heatmap
label: hybpiper_hybpiper recovery_heatmap
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error message regarding a container runtime (Singularity/Apptainer)
  failing to build an image due to insufficient disk space.\n\nTool homepage: https://github.com/mossmatters/HybPiper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hybpiper:2.3.4--pyhdfd78af_0
stdout: hybpiper_hybpiper recovery_heatmap.out
