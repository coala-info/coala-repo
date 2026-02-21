cwlVersion: v1.2
class: CommandLineTool
baseCommand: ccmetagen
label: ccmetagen
doc: "CCMetagen is a tool for accurate taxonomic classification of metagenomes. (Note:
  The provided input text appears to be a container execution error log rather than
  help text; no arguments could be extracted from the provided text.)\n\nTool homepage:
  https://github.com/vrmarcelino/CCMetagen"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ccmetagen:1.5.0--pyh7cba7a3_0
stdout: ccmetagen.out
