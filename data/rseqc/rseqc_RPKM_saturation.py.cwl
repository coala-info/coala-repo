cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- RPKM_saturation.py
label: rseqc_RPKM_saturation.py
doc: 'For each gene, check whether the RPKM value was saturated or not. Saturation
  analysis is based on re-sampling (5%, 10%, ... 100% of the mapped reads). Strand
  specific sequencing protocol is supported.


  Tool homepage: https://rseqc.sourceforge.net'
inputs:
- id: input_file
  type: File
  doc: Alignment file in BAM or SAM format. [required]
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
- id: percentile_floor
  type:
  - 'null'
  - int
  doc: Sampling starts from this percentile. A integer between 0 and 100. default=5
  inputBinding:
    position: 1
    prefix: --percentile-floor
- id: percentile_ceiling
  type:
  - 'null'
  - int
  doc: Sampling ends at this percentile. A integer between 0 and 100. default=100
  inputBinding:
    position: 1
    prefix: --percentile-ceiling
- id: percentile_step
  type:
  - 'null'
  - int
  doc: Sampling frequency. Smaller value means more sampling times. A integer between
    0 and 100. default=5
  inputBinding:
    position: 1
    prefix: --percentile-step
- id: rpkm_cutoff
  type:
  - 'null'
  - float
  doc: Transcripts with RPKM smaller than this number will be ignored in visualization
    plot. default=0.01
  inputBinding:
    position: 1
    prefix: --rpkm-cutoff
- id: mapq
  type:
  - 'null'
  - int
  doc: Minimum mapping quality (phred scaled) for an alignment to be called "uniquely
    mapped". default=30
  inputBinding:
    position: 1
    prefix: --mapq
outputs:
- id: erpkm_xls
  type: File
  doc: RPKM of each gene at each sampling percentile.
  outputBinding:
    glob: $(inputs.out_prefix).eRPKM.xls
- id: rawcount_xls
  type: File
  doc: Raw read count of each gene at each sampling percentile.
  outputBinding:
    glob: $(inputs.out_prefix).rawCount.xls
- id: saturation_r
  type: File
  doc: R script that draws the saturation plot.
  outputBinding:
    glob: $(inputs.out_prefix).saturation.r
- id: saturation_pdf
  type: File
  doc: RPKM saturation plot.
  outputBinding:
    glob: $(inputs.out_prefix).saturation.pdf
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
