cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- geneBody_coverage2.py
label: rseqc_geneBody_coverage2.py
doc: 'Calculate the RNA-seq reads coverage over gene body. This module uses bigwig
  file as input.


  Tool homepage: https://rseqc.sourceforge.net'
inputs:
- id: input_file
  type: File
  doc: Coverage signal file in bigwig format
  inputBinding:
    position: 1
    prefix: --input-file
- id: refgene
  type: File
  doc: Reference gene model in bed format. [required]
  inputBinding:
    position: 1
    prefix: --refgene
- id: out_prefix
  type: string
  doc: Prefix of output files(s). [required]
  inputBinding:
    position: 1
    prefix: --out-prefix
- id: graph_type
  type:
  - 'null'
  - string
  doc: Graphic file type in "pdf", "jpeg", "bmp", "bmp", "tiff" or "png".default=pdf
    [optional]
  inputBinding:
    position: 1
    prefix: --graph-type
outputs:
- id: coverage_txt
  type: File
  doc: Table of gene body coverage per percentile position.
  outputBinding:
    glob: $(inputs.out_prefix).geneBodyCoverage.txt
- id: coverage_r
  type: File
  doc: R script that draws the gene body coverage plot.
  outputBinding:
    glob: $(inputs.out_prefix).geneBodyCoverage_plot.r
- id: coverage_plot
  type:
  - 'null'
  - File
  doc: Gene body coverage plot (format set by --graph-type). Not written when R fails.
  outputBinding:
    glob: '$(inputs.out_prefix).geneBodyCoverage.$(inputs.graph_type ? inputs.graph_type
      : ''pdf'')'
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
