cwlVersion: v1.2
class: CommandLineTool
baseCommand: vpt
label: vpt
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help text or usage information for the 'vpt' tool. As a result,
  no arguments could be extracted.\n\nTool homepage: https://github.com/Vizgen/vizgen-postprocessing"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
stdout: vpt.out
