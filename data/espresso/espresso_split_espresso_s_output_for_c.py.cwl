cwlVersion: v1.2
class: CommandLineTool
baseCommand: espresso_split_espresso_s_output_for_c.py
label: espresso_split_espresso_s_output_for_c.py
doc: "A script to split ESPRESSO's output. (Note: The provided help text contains
  only system error messages regarding container image conversion and does not list
  command-line arguments.)\n\nTool homepage: https://github.com/Xinglab/espresso"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/espresso:1.6.0--pl5321h5ca1c30_1
stdout: espresso_split_espresso_s_output_for_c.py.out
