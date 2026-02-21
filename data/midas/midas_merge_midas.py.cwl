cwlVersion: v1.2
class: CommandLineTool
baseCommand: midas_merge_midas.py
label: midas_merge_midas.py
doc: "Merge MIDAS results across multiple samples. (Note: The provided text contains
  system error messages regarding container execution and does not include the actual
  help documentation for the tool.)\n\nTool homepage: https://github.com/snayfach/MIDAS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/midas:1.3.2--py35_0
stdout: midas_merge_midas.py.out
