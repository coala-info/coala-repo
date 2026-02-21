cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mimi
  - mimi
  - cache
  - create
label: mimi_mimi_cache_create
doc: "Create a cache for the mimi tool (Note: The provided text contains error logs
  rather than help documentation, so no arguments could be identified).\n\nTool homepage:
  https://github.com/NYUAD-Core-Bioinformatics/MIMI"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimi:1.0.4--pyhdfd78af_0
stdout: mimi_mimi_cache_create.out
