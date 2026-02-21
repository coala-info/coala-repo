cwlVersion: v1.2
class: CommandLineTool
baseCommand: oncogemini_vcf2db.py
label: oncogemini_vcf2db.py
doc: "The provided text contains system execution logs and error messages regarding
  container environment setup and disk space issues, rather than the tool's help documentation.
  Consequently, no command-line arguments could be extracted.\n\nTool homepage: https://github.com/fakedrtom/oncogemini"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oncogemini:1.0.0--pyh3252c3a_0
stdout: oncogemini_vcf2db.py.out
