cwlVersion: v1.2
class: CommandLineTool
baseCommand: cgpbigwig_bam2bedgraph
label: cgpbigwig_bam2bedgraph
doc: "A tool for converting BAM files to BedGraph format (Note: The provided help
  text contains only system error logs and no usage information).\n\nTool homepage:
  https://github.com/cancerit/cgpBigWig"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cgpbigwig:1.7.0--h523f0d1_0
stdout: cgpbigwig_bam2bedgraph.out
