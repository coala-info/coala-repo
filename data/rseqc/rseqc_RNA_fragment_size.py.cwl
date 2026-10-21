cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- RNA_fragment_size.py
label: rseqc_RNA_fragment_size.py
doc: 'Calculate fragment size for each gene/transcript: number of fragments used,
  mean, median and standard deviation of the fragment size.


  Tool homepage: https://rseqc.sourceforge.net'
inputs:
- id: input
  type: File
  secondaryFiles:
  - pattern: .bai
    required: true
  doc: Input BAM file
  inputBinding:
    position: 1
    prefix: --input
- id: refgene
  type: File
  doc: Reference gene model in BED format. Must be strandard 12-column BED file. [required]
  inputBinding:
    position: 1
    prefix: --refgene
- id: mapq
  type:
  - 'null'
  - int
  doc: Minimum mapping quality (phred scaled) for an alignment to be called "uniquely
    mapped". default=30
  inputBinding:
    position: 1
    prefix: --mapq
- id: frag_num
  type:
  - 'null'
  - int
  doc: Minimum number of fragment. default=3
  inputBinding:
    position: 1
    prefix: --frag-num
outputs:
- id: stdout
  type: stdout
  doc: Table of fragment count, mean, median and standard deviation of the fragment
    size per gene.
stdout: RNA_fragment_size.out
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
