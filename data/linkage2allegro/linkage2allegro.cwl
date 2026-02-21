cwlVersion: v1.2
class: CommandLineTool
baseCommand: linkage2allegro
label: linkage2allegro
doc: "A tool for converting linkage format files to Allegro format. (Note: The provided
  help text contains only system error messages and no usage information.)\n\nTool
  homepage: https://github.com/BioTools-Tek/linkage-converter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/linkage2allegro:2017.3--py35_0
stdout: linkage2allegro.out
