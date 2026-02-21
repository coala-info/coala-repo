cwlVersion: v1.2
class: CommandLineTool
baseCommand: libssw_pyssw.py
label: libssw_pyssw.py
doc: "A Python wrapper for the SIMD Smith-Waterman (SSW) library. (Note: The provided
  text contains system error messages regarding container image conversion and disk
  space, rather than tool usage instructions.)\n\nTool homepage: https://github.com/mengyao/Complete-Striped-Smith-Waterman-Library"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/libssw:1.2.5--h5ca1c30_0
stdout: libssw_pyssw.py.out
