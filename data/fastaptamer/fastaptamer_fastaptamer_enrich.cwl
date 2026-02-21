cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaptamer
  - enrich
label: fastaptamer_fastaptamer_enrich
doc: "A tool from the FASTAptamer suite, likely used for enrichment analysis of aptamer
  sequences. (Note: The provided help text contains only system error messages and
  no usage information.)\n\nTool homepage: http://burkelab.missouri.edu/fastaptamer.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastaptamer:1.0.16--hdfd78af_0
stdout: fastaptamer_fastaptamer_enrich.out
