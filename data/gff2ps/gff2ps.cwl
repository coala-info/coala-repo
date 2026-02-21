cwlVersion: v1.2
class: CommandLineTool
baseCommand: gff2ps
label: gff2ps
doc: "A tool for converting GFF (General Feature Format) files to PostScript for visualization.\n
  \nTool homepage: https://github.com/guigolab/gff2ps"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/gff2ps:v0.98d-5-deb_cv1
stdout: gff2ps.out
