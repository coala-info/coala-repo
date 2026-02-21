cwlVersion: v1.2
class: CommandLineTool
baseCommand: dindel_makeWindows.py
label: dindel_makeWindows.py
doc: "A tool for creating windows for Dindel indel calling. (Note: The provided text
  contains system error messages regarding container execution and does not list specific
  command-line arguments.)\n\nTool homepage: https://github.com/genome/dindel-tgi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/dindel:v1.01-wu1-3dfsg-1b1-deb_cv1
stdout: dindel_makeWindows.py.out
