cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - djinn
  - sam
  - sample
label: djinn_sam_sample
doc: "Downsample data by barcode\n\nTool homepage: https://github.com/pdimens/djinn"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: downsample
    type:
      - 'null'
      - float
    doc: Number/fraction of barcodes to retain
    inputBinding:
      position: 1
      prefix: --downsample
  - id: invalid
    type:
      - 'null'
      - float
    doc: Proportion of invalid barcodes to sample
    inputBinding:
      position: 1
      prefix: --invalid
  - id: random_seed
    type:
      - 'null'
      - int
    doc: Random seed for sampling
    inputBinding:
      position: 1
      prefix: --random-seed
  - id: sam
    type:
      - 'null'
      - boolean
    doc: Output as SAM instead of BAM
    inputBinding:
      position: 1
      prefix: --sam
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use (minimum 4)
    inputBinding:
      position: 1
      prefix: --threads
  - id: input
    type: File
    doc: Input SAM/BAM file
    inputBinding:
      position: 101
outputs:
  - id: output_alignments
    type: stdout
    doc: Downsampled alignments
  - id: barcode_list
    type: File
    doc: Sampled barcodes (<input name>.bc)
    outputBinding:
      glob: $(inputs.input.basename).bc
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/djinn:2.1.1--pyhdfd78af_0
stdout: '$(inputs.sam ? ''djinn_sam_sample.sam'' : ''djinn_sam_sample.bam'')'
