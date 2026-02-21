cwlVersion: v1.2
class: CommandLineTool
baseCommand: islandpath
label: islandpath
doc: "IslandPath-DIMOB is a tool for predicting genomic islands in bacterial and archaeal
  genomes. (Note: The provided help text contains only container runtime error messages
  and no usage information.)\n\nTool homepage: http://www.pathogenomics.sfu.ca/islandpath/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/islandpath:1.0.6--hdfd78af_0
stdout: islandpath.out
