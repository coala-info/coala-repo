cwlVersion: v1.2
class: CommandLineTool
baseCommand: chipseq-greylist
label: chipseq-greylist
doc: "Identify and filter reads that are likely to be from a greylist (e.g., blacklisted
  regions or repetitive elements).\n\nTool homepage: https://github.com/roryk/chipseq-greylist"
inputs:
  - id: bamfile
    type: File
    doc: Input BAM file containing aligned reads.
    inputBinding:
      position: 1
  - id: bootstraps
    type:
      - 'null'
      - int
    doc: The number of bootstrap samples to generate for estimating the 
      significance of the greylist score.
    inputBinding:
      position: 102
      prefix: --bootstraps
  - id: cutoff
    type:
      - 'null'
      - float
    doc: The cutoff value for determining if a read is part of the greylist. 
      Reads with a score above this cutoff will be filtered.
    inputBinding:
      position: 102
      prefix: --cutoff
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress verbose output and only show essential information.
    inputBinding:
      position: 102
      prefix: --quiet
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Directory to save output files.
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chipseq-greylist:1.0.2--pyh145b6a8_1
