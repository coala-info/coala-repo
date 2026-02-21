cwlVersion: v1.2
class: CommandLineTool
baseCommand: tiffcomment
label: bftools_tiffcomment
doc: "A tool from the Bio-Formats suite to read or set the TIFF comment (usually OME-XML
  metadata) of a file.\n\nTool homepage: https://docs.openmicroscopy.org/bio-formats/5.7.1/users/comlinetools/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bftools:8.0.0--hdfd78af_0
stdout: bftools_tiffcomment.out
