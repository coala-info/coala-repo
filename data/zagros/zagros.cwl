cwlVersion: v1.2
class: CommandLineTool
baseCommand: zagros
label: zagros
doc: "Zagros is a tool for identifying RNA-protein interaction sites from CLIP-seq
  data. (Note: The provided text appears to be a container build log error rather
  than help text; no arguments could be extracted from the input.)\n\nTool homepage:
  https://github.com/Aryvyo/Zagros"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zagros:1.0.0--ha24e720_10
stdout: zagros.out
