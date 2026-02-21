cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - determine-phred
label: ea-utils_determine-phred
doc: "A tool from the ea-utils suite used to determine the Phred quality score encoding
  (e.g., Phred+33 or Phred+64) of FASTQ files.\n\nTool homepage: https://expressionanalysis.github.io/ea-utils/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ea-utils:1.1.2.779--h9dd4a16_0
stdout: ea-utils_determine-phred.out
