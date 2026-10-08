cwlVersion: v1.2
class: CommandLineTool
baseCommand: [ft, qc]
label: fibertools-rs_qc
doc: "Collect QC metrics from a fiberseq bam file\n\nTool homepage: https://github.com/fiberseq/fibertools-rs"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fibertools-rs:0.8.2--h3b373d1_0
inputs:
  - id: acf
    type: ['null', boolean]
    doc: "Calculate the auto-correlation function of the m6A marks in the fiber-seq data."
    inputBinding:
      position: 1
      prefix: --acf
  - id: acf_max_lag
    type: ['null', int]
    doc: "Maximum lag for the ACF calculation (default 250)."
    inputBinding:
      position: 1
      prefix: --acf-max-lag
  - id: acf_min_m6a
    type: ['null', int]
    doc: "Minimum number of m6A marks to use a read in the ACF calculation (default 100)."
    inputBinding:
      position: 1
      prefix: --acf-min-m6a
  - id: acf_max_reads
    type: ['null', int]
    doc: "Maximum number of reads to use in the ACF calculation (default 10000)."
    inputBinding:
      position: 1
      prefix: --acf-max-reads
  - id: acf_sample_rate
    type: ['null', int]
    doc: "After sampling the first \"acf-max-reads\", randomly sample one of every \"acf-sample-rate\" reads and replace one of the previous reads at random (default 100)."
    inputBinding:
      position: 1
      prefix: --acf-sample-rate
  - id: m6a_per_msp
    type: ['null', boolean]
    doc: "In the output include a measure of the number of m6A events per MSP of a given size."
    inputBinding:
      position: 1
      prefix: -m
  - id: n_reads
    type: ['null', int]
    doc: "Only process the first \"n\" reads in the input BAM file."
    inputBinding:
      position: 1
      prefix: --n-reads
  - id: filter
    type: ['null', int]
    doc: "BAM bit flags to filter on, equivalent to `-F` in samtools view (default 0)."
    inputBinding:
      position: 1
      prefix: -F
  - id: ftx
    type: ['null', string]
    doc: "Filtering expression to use for filtering records, for example \"len(nuc)>150\" or \"len(nuc)<150,len(msp)=30:50\". Supports len() and qual() over msp, nuc, m6a, cpg."
    inputBinding:
      position: 1
      prefix: -x
  - id: ml
    type: ['null', int]
    doc: "Minimum score in the ML tag to use or include in the output (default 125)."
    inputBinding:
      position: 1
      prefix: --ml
  - id: uncompressed
    type: ['null', boolean]
    doc: "Output uncompressed BAM files."
    inputBinding:
      position: 1
      prefix: -u
  - id: threads
    type: ['null', int]
    doc: "Threads (default 8)."
    inputBinding:
      position: 1
      prefix: -t
  - id: verbose
    type: ['null', boolean]
    doc: "Logging level: info. Use ft help for deeper levels."
    inputBinding:
      position: 1
      prefix: -v
  - id: quiet
    type: ['null', boolean]
    doc: "Turn off all logging."
    inputBinding:
      position: 1
      prefix: --quiet
  - id: bam
    type: File
    doc: "Input BAM file. For m6A prediction this should be a HiFi BAM file with kinetics data. For other commands this should be a BAM file with m6A calls."
    inputBinding:
      position: 10
  - id: out_txt
    type: string
    doc: "Output text file with QC metrics (tab-separated: statistic, value, count)."
    default: "qc.txt"
    inputBinding:
      position: 11
outputs:
  - id: qc_metrics
    type: File
    doc: "Tab-separated QC metrics with columns statistic, value and count."
    outputBinding:
      glob: $(inputs.out_txt)
