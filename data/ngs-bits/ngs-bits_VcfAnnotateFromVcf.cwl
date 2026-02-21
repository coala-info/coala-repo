cwlVersion: v1.2
class: CommandLineTool
baseCommand: VcfAnnotateFromVcf
label: ngs-bits_VcfAnnotateFromVcf
doc: "Note: The provided text is an error message indicating a system failure (no
  space left on device) and does not contain the actual help text or usage information
  for the tool.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_09--py313h572c47f_0
stdout: ngs-bits_VcfAnnotateFromVcf.out
