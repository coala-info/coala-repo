cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scepia
  - area27
label: scepia_area27
doc: "Determine the enhancer-based regulatory potential (ERP) score per gene. This
  approach is based on the method developed by Wang et al., 2016. In this implementation
  the score is calculated based only on H3K27ac signal in enhancers, using log-transformed,
  z-score normalized H3K27ac read counts in 2kb windows centered at enhancer locations.\n\nTool
  homepage: https://github.com/vanheeringen-lab/scepia"
inputs:
  - id: bamfile
    type: File
    doc: H3K27ac BAM file
    inputBinding:
      position: 1
  - id: outfile_path
    type: string
    doc: Output file name
    inputBinding:
      position: 2
  - id: window
    type:
      - 'null'
      - string
    doc: window
    inputBinding:
      position: 101
      prefix: --window
  - id: nthreads
    type:
      - 'null'
      - int
    doc: Number of threads.
    inputBinding:
      position: 101
      prefix: --nthreads
outputs:
  - id: outfile
    type: File
    doc: Output file with the ERP scores
    outputBinding:
      glob: $(inputs.outfile_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scepia:0.5.1--pyhdfd78af_1
