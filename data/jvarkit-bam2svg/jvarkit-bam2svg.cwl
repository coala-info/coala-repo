cwlVersion: v1.2
class: CommandLineTool
baseCommand: jvarkit-bam2svg
label: jvarkit-bam2svg
doc: "A tool to convert BAM files to SVG format. (Note: The provided input text contains
  system error messages regarding a container runtime failure and does not contain
  the actual help documentation or argument list.)\n\nTool homepage: http://lindenb.github.io/jvarkit/BamToSVG.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jvarkit-bam2svg:201904251722--0
stdout: jvarkit-bam2svg.out
