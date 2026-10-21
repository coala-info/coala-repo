cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- infer_experiment.py
label: rseqc_infer_experiment.py
doc: 'Infer how RNA-seq reads were stranded (the strand rule) from the alignments
  of reads on a gene model.


  Tool homepage: https://rseqc.sourceforge.net'
inputs:
- id: input_file
  type: File
  doc: Input alignment file in SAM or BAM format
  inputBinding:
    position: 1
    prefix: --input-file
- id: refgene
  type: File
  doc: Reference gene model in bed fomat.
  inputBinding:
    position: 1
    prefix: --refgene
- id: sample_size
  type:
  - 'null'
  - int
  doc: Number of reads sampled from SAM/BAM file. default=200000
  inputBinding:
    position: 1
    prefix: --sample-size
- id: mapq
  type:
  - 'null'
  - int
  doc: Minimum mapping quality (phred scaled) for an alignment to be considered as
    "uniquely mapped". default=30
  inputBinding:
    position: 1
    prefix: --mapq
outputs:
- id: stdout
  type: stdout
  doc: Library layout and the fractions of reads explained by each strand rule.
stdout: infer_experiment.out
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
