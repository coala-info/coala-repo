cwlVersion: v1.2
class: CommandLineTool
baseCommand: metabomatching
label: metabomatching
doc: "A tool for metabolite identification by matching experimental spectra against
  databases.\n\nTool homepage: https://github.com/rrueedi/metabomatching"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/metabomatching:phenomenal-v0.2.1_cv0.5.67
stdout: metabomatching.out
