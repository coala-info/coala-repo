cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- junction_saturation.py
label: rseqc_junction_saturation.py
doc: 'Check if sequencing depth is saturated or not, based on the concept that when
  sequencing depth is approaching saturation, less NEW junctions will be discovered.


  Tool homepage: https://rseqc.sourceforge.net'
inputs:
- id: input_file
  type: File
  doc: Alignment file in BAM or SAM format.[required]
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
  doc: Reference gene model in bed fomat. This gene model is used to determine known
    splicing junctions. [required]
  inputBinding:
    position: 1
    prefix: --refgene
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
- id: min_intron
  type:
  - 'null'
  - int
  doc: Minimum intron size (bp). default=50
  inputBinding:
    position: 1
    prefix: --min-intron
- id: min_coverage
  type:
  - 'null'
  - int
  doc: Minimum number of supportting reads to call a junction. default=1
  inputBinding:
    position: 1
    prefix: --min-coverage
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
- id: saturation_r
  type: File
  doc: R script that draws the saturation plot (holds the sampled junction counts).
  outputBinding:
    glob: $(inputs.out_prefix).junctionSaturation_plot.r
- id: saturation_pdf
  type: File
  doc: Junction saturation plot.
  outputBinding:
    glob: $(inputs.out_prefix).junctionSaturation_plot.pdf
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
