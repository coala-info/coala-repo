cwlVersion: v1.2
class: CommandLineTool
baseCommand: SAMstatsParallel
label: samstats_SAMstatsParallel
doc: "A tool for calculating statistics on SAM/BAM files. (Note: The provided help
  text contains only container execution errors and no usage information).\n\nTool
  homepage: https://github.com/kundajelab/SAMstats"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samstats:0.2.2--py_0
stdout: samstats_SAMstatsParallel.out
