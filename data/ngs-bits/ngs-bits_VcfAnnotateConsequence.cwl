cwlVersion: v1.2
class: CommandLineTool
baseCommand: VcfAnnotateConsequence
label: ngs-bits_VcfAnnotateConsequence
doc: "Note: The provided text is a container runtime error log and does not contain
  help information for the tool. No arguments could be extracted.\n\nTool homepage:
  https://github.com/imgag/ngs-bits"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_09--py313h572c47f_0
stdout: ngs-bits_VcfAnnotateConsequence.out
