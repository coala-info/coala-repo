cwlVersion: v1.2
class: CommandLineTool
baseCommand: logol-bin_generate-doc.sh
label: logol-bin_generate-doc.sh
doc: "Generate documentation for Logol (Note: The provided text is an error log and
  does not contain usage information).\n\nTool homepage: https://github.com/genouest/logol"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/logol-bin:v1.7.9-1-deb_cv1
stdout: logol-bin_generate-doc.sh.out
