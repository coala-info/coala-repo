cwlVersion: v1.2
class: CommandLineTool
baseCommand: tadarida-d
label: tadarida-d
doc: "Tadarida-D is a tool for the automated identification of bat species from acoustic
  recordings.\n\nTool homepage: https://github.com/YvesBas/Tadarida-D"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tadarida-d:1.03--hef2fcd1_9
stdout: tadarida-d.out
