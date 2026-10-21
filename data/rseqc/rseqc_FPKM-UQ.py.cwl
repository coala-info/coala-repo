cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- FPKM-UQ.py
label: rseqc_FPKM-UQ.py
doc: 'Calculate count, FPKM, and FPKM-UQ values (upper-quartile FPKM as defined by
  the TCGA RNA-seq workflow). Needs the ''htseq-count'' command.


  Tool homepage: https://rseqc.sourceforge.net'
inputs:
- id: bam
  type: File
  secondaryFiles:
  - pattern: .bai
    required: false
  doc: Alignment file in BAM format. BAM file shoul be sorted and indexed. Ideally,
    the BAM file should generaet from the TCGA RNA-seq analysis workflow described
    at https://docs.gdc.cancer.gov/Data/Bioinformatics_Pipelines/Expression_mRNA_Pipeline/.
  inputBinding:
    position: 1
    prefix: --bam
- id: gtf
  type: File
  doc: Gene model in GTF format.
  inputBinding:
    position: 1
    prefix: --gtf
- id: info
  type: File
  doc: Gene model information file.
  inputBinding:
    position: 1
    prefix: --info
- id: output
  type: string
  doc: The prefix of the output file.
  inputBinding:
    position: 1
    prefix: --output
- id: log2
  type:
  - 'null'
  - boolean
  doc: Convert FPKM and FPKM-UQ values into log2 (x+1) scale. A pseudo count 1 will
    be added to each gene/transcript.
  inputBinding:
    position: 1
    prefix: --log2
outputs:
- id: htseq_counts
  type: File
  doc: Read counts per gene made by htseq-count.
  outputBinding:
    glob: $(inputs.output).htseq.counts.txt
- id: fpkm_uq_txt
  type: File
  doc: Table with raw count, FPKM and FPKM-UQ per gene.
  outputBinding:
    glob: $(inputs.output).FPKM-UQ.txt
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
