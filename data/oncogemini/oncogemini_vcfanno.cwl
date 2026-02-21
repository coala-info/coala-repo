cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - oncogemini
  - vcfanno
label: oncogemini_vcfanno
doc: "The provided text does not contain help information or a description of the
  tool; it contains system log messages and a fatal error regarding disk space during
  a container build.\n\nTool homepage: https://github.com/fakedrtom/oncogemini"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oncogemini:1.0.0--pyh3252c3a_0
stdout: oncogemini_vcfanno.out
