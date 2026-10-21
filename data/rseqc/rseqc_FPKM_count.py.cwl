cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- FPKM_count.py
label: rseqc_FPKM_count.py
doc: 'Calculate raw read count, FPM (fragment per million) and FPKM (fragment per
  million mapped reads per kilobase exon) for each gene in BED file.


  Tool homepage: https://rseqc.sourceforge.net'
inputs:
- id: input_file
  type: File
  secondaryFiles:
  - pattern: .bai
    required: true
  doc: Alignment file in BAM format (SAM is not supported). [required]
  inputBinding:
    position: 1
    prefix: --input-file
- id: out_prefix
  type: string
  doc: Prefix of output files(s). [required]
  inputBinding:
    position: 1
    prefix: --out-prefix
- id: refgene
  type: File
  doc: Reference gene model in bed fomat. [required]
  inputBinding:
    position: 1
    prefix: --refgene
- id: strand
  type:
  - 'null'
  - string
  doc: 'How read(s) were stranded during sequencing. For example: --strand=''1++,1--,2+-,2-+''
    means that this is a pair-end, strand-specific RNA-seq, and the strand rule is:
    read1 mapped to ''+'' => parental gene on ''+''; read1 mapped to ''-'' => parental
    gene on ''-''; read2 mapped to ''+'' => parental gene on ''-''; read2 mapped to
    ''-'' => parental gene on ''+''. If you are not sure about the strand rule, run
    ''infer_experiment.py''. default=none (Not a strand specific RNA-seq data)'
  inputBinding:
    position: 1
    prefix: --strand
- id: skip_multi_hits
  type:
  - 'null'
  - boolean
  doc: How to deal with multiple hit reads. Presence this option renders program to
    skip multiple hits reads.
  inputBinding:
    position: 1
    prefix: --skip-multi-hits
- id: only_exonic
  type:
  - 'null'
  - boolean
  doc: How to count total reads. Presence of this option renders program only used
    exonic (UTR exons and CDS exons) reads, otherwise use all reads.
  inputBinding:
    position: 1
    prefix: --only-exonic
- id: mapq
  type:
  - 'null'
  - int
  doc: Minimum mapping quality (phred scaled) for an alignment to be called "uniquely
    mapped". default=30
  inputBinding:
    position: 1
    prefix: --mapq
- id: single_read
  type:
  - 'null'
  - float
  doc: 'How to count read-pairs that only have one end mapped. 0: ignore it. 0.5:
    treat it as half fragment. 1: treat it as whole fragment. default=1'
  inputBinding:
    position: 1
    prefix: --single-read
outputs:
- id: fpkm_xls
  type: File
  doc: Table with raw read count, FPM and FPKM for each gene.
  outputBinding:
    glob: $(inputs.out_prefix).FPKM.xls
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
