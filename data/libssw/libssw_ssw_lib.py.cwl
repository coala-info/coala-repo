cwlVersion: v1.2
class: CommandLineTool
baseCommand: libssw_ssw_lib.py
label: libssw_ssw_lib.py
doc: "A Python utility associated with the libssw SIMD Smith-Waterman library. Note:
  The provided text contains system error messages regarding container execution and
  does not include help documentation or argument definitions.\n\nTool homepage: https://github.com/mengyao/Complete-Striped-Smith-Waterman-Library"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/libssw:1.2.5--h5ca1c30_0
stdout: libssw_ssw_lib.py.out
