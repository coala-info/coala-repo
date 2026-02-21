cwlVersion: v1.2
class: CommandLineTool
baseCommand: bam-tools
label: hmftools-bam-tools
doc: "A tool from the hmftools suite for BAM file manipulation (Note: The provided
  text contains only container execution errors and no help documentation; therefore,
  no arguments could be extracted).\n\nTool homepage: https://github.com/hartwigmedical/hmftools/blob/master/bam-tools/README.md"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmftools-bam-tools:1.5--hdfd78af_0
stdout: hmftools-bam-tools.out
