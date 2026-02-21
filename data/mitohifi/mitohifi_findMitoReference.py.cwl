cwlVersion: v1.2
class: CommandLineTool
baseCommand: mitohifi_findMitoReference.py
label: mitohifi_findMitoReference.py
doc: "A tool to find mitochondrial reference sequences. (Note: The provided input
  text contains container runtime error messages rather than the tool's help documentation,
  so no arguments could be extracted.)\n\nTool homepage: https://github.com/marcelauliano/MitoHiFi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mitohifi:2.2_cv1
stdout: mitohifi_findMitoReference.py.out
