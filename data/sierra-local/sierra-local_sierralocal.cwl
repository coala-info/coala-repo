cwlVersion: v1.2
class: CommandLineTool
baseCommand: sierra-local
label: sierra-local_sierralocal
doc: "Sierra-local is a tool for local execution of the Stanford HIVDB Sierra engine.
  (Note: The provided help text contains only container runtime logs and no usage
  information.)\n\nTool homepage: https://github.com/PoonLab/sierra-local"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sierra-local:0.4.3--py310hdfd78af_0
stdout: sierra-local_sierralocal.out
