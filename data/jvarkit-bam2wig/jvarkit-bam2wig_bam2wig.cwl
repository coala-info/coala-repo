cwlVersion: v1.2
class: CommandLineTool
baseCommand: jvarkit-bam2wig
label: jvarkit-bam2wig_bam2wig
doc: "A tool to convert BAM files to WIG format. (Note: The provided help text contains
  only system error messages regarding container execution and does not list specific
  command-line arguments.)\n\nTool homepage: http://lindenb.github.io/jvarkit/Bam2Wig.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jvarkit-bam2wig:201904251722--0
stdout: jvarkit-bam2wig_bam2wig.out
