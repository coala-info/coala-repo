cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- inner_distance.py
label: rseqc_inner_distance.py
doc: 'Calculate the inner distance (insert size) of RNA-seq fragments: fragment size
  = read_1 + insert_size + read_2.


  Tool homepage: https://rseqc.sourceforge.net'
inputs:
- id: input_file
  type: File
  doc: Alignment file in BAM or SAM format.
  inputBinding:
    position: 1
    prefix: --input-file
- id: out_prefix
  type: string
  doc: Prefix of output files(s)
  inputBinding:
    position: 1
    prefix: --out-prefix
- id: refgene
  type: File
  doc: Reference gene model in BED format.
  inputBinding:
    position: 1
    prefix: --refgene
- id: sample_size
  type:
  - 'null'
  - int
  doc: Number of read-pairs used to estimate inner distance. default=1000000
  inputBinding:
    position: 1
    prefix: --sample-size
- id: lower_bound
  type:
  - 'null'
  - int
  doc: Lower bound of inner distance (bp). This option is used for ploting histograme.
    default=-250
  inputBinding:
    position: 1
    prefix: --lower-bound
- id: upper_bound
  type:
  - 'null'
  - int
  doc: Upper bound of inner distance (bp). This option is used for plotting histogram.
    default=250
  inputBinding:
    position: 1
    prefix: --upper-bound
- id: step
  type:
  - 'null'
  - int
  doc: Step size (bp) of histograme. This option is used for plotting histogram. default=5
  inputBinding:
    position: 1
    prefix: --step
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
- id: inner_distance_txt
  type: File
  doc: Inner distance of each read pair.
  outputBinding:
    glob: $(inputs.out_prefix).inner_distance.txt
- id: inner_distance_freq_txt
  type: File
  doc: Histogram of the inner distance.
  outputBinding:
    glob: $(inputs.out_prefix).inner_distance_freq.txt
- id: inner_distance_r
  type: File
  doc: R script that draws the histogram.
  outputBinding:
    glob: $(inputs.out_prefix).inner_distance_plot.r
- id: inner_distance_pdf
  type: File
  doc: Histogram plot.
  outputBinding:
    glob: $(inputs.out_prefix).inner_distance_plot.pdf
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
