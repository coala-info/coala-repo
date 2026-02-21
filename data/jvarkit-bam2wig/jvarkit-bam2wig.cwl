cwlVersion: v1.2
class: CommandLineTool
baseCommand: jvarkit-bam2wig
label: jvarkit-bam2wig
doc: "BAM to Wiggle converter (Note: The provided text is an error log and does not
  contain usage information or argument definitions).\n\nTool homepage: http://lindenb.github.io/jvarkit/Bam2Wig.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jvarkit-bam2wig:201904251722--0
stdout: jvarkit-bam2wig.out
