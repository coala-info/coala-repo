cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwtk
  - chroms
label: bwtk_chroms
doc: "Print a chrom.sizes file from a bigWig header\n\nTool homepage: https://github.com/bjmt/bwtk"
inputs:
  - id: input_bigwig
    type: File
    doc: Input bigWig
    inputBinding:
      position: 1
      prefix: -i
  - id: output_chrom_sizes
    type: string
    doc: Output chrom.sizes file
    inputBinding:
      position: 1
      prefix: -o
outputs:
  - id: chrom_sizes
    type: File
    doc: chrom.sizes file from the bigWig header
    outputBinding:
      glob: $(inputs.output_chrom_sizes)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwtk:1.8.1--h9990f68_0
