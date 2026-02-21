cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mimi
  - mimi
  - kegg
  - extract
label: mimi_mimi_kegg_extract
doc: "Extract KEGG data using the mimi tool suite. (Note: The provided help text contained
  only container runtime error messages and no usage information.)\n\nTool homepage:
  https://github.com/NYUAD-Core-Bioinformatics/MIMI"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimi:1.0.4--pyhdfd78af_0
stdout: mimi_mimi_kegg_extract.out
