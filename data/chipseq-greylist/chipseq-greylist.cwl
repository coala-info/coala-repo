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
    secondaryFiles:
      - .bai
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
  - id: outdir_path
    type: string
    doc: Directory to save output files (created before the run).
    default: greylist_out
    inputBinding:
      position: 103
      prefix: --outdir
outputs:
  - id: outdir
    type: Directory
    doc: Directory with the greylist BED file and depth tables.
    outputBinding:
      glob: $(inputs.outdir_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - "${ return {class: 'Directory', basename: inputs.outdir_path, listing: [], writable: true}; }"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chipseq-greylist:1.0.2--pyh145b6a8_1
