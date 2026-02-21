cwlVersion: v1.2
class: CommandLineTool
baseCommand: xmlindent
label: bftools_xmlindent
doc: "A tool for indenting and formatting XML files, part of the Bio-Formats (bftools)
  suite.\n\nTool homepage: https://docs.openmicroscopy.org/bio-formats/5.7.1/users/comlinetools/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bftools:8.0.0--hdfd78af_0
stdout: bftools_xmlindent.out
