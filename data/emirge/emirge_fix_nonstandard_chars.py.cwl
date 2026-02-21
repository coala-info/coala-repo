cwlVersion: v1.2
class: CommandLineTool
baseCommand: emirge_fix_nonstandard_chars.py
label: emirge_fix_nonstandard_chars.py
doc: "Fix non-standard characters in EMIRGE files. (Note: The provided help text contains
  only system error messages and does not list specific arguments.)\n\nTool homepage:
  https://github.com/csmiller/EMIRGE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emirge:0.61.1--py27_1
stdout: emirge_fix_nonstandard_chars.py.out
