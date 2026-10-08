cwlVersion: v1.2
class: CommandLineTool
baseCommand: [ft, pileup]
label: fibertools-rs_pileup
doc: "Make a pileup track of Fiber-seq features from a FIRE bam\n\nTool homepage: https://github.com/fiberseq/fibertools-rs"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fibertools-rs:0.8.2--h3b373d1_0
inputs:
  - id: out_file
    type: string
    doc: "Output file name."
    default: "pileup.bed"
    inputBinding:
      position: 1
      prefix: --out
  - id: m6a
    type: ['null', boolean]
    doc: "Include m6A calls."
    inputBinding:
      position: 1
      prefix: -m
  - id: cpg
    type: ['null', boolean]
    doc: "Include 5mC calls."
    inputBinding:
      position: 1
      prefix: -c
  - id: haps
    type: ['null', boolean]
    doc: "For each column add two new columns with the hap1 and hap2 specific data."
    inputBinding:
      position: 1
      prefix: --haps
  - id: keep_zeros
    type: ['null', boolean]
    doc: "Keep zero coverage regions."
    inputBinding:
      position: 1
      prefix: -k
  - id: per_base
    type: ['null', boolean]
    doc: "Write output one base at a time even if the values do not change."
    inputBinding:
      position: 1
      prefix: -p
  - id: fiber_coverage
    type: ['null', boolean]
    doc: "Calculate coverage starting from the first MSP/NUC to the last MSP/NUC position instead of the complete span of the read alignment."
    inputBinding:
      position: 1
      prefix: --fiber-coverage
  - id: shuffle
    type: ['null', File]
    doc: "Shuffle the fiber-seq data according to a bed file of the shuffled positions (columns: #chrom shuffled_start shuffled_end read_name original_start)."
    inputBinding:
      position: 1
      prefix: --shuffle
  - id: rolling_max
    type: ['null', int]
    doc: "Output a rolling max of the score column over X bases."
    inputBinding:
      position: 1
      prefix: --rolling-max
  - id: no_msp
    type: ['null', boolean]
    doc: "No MSP columns."
    inputBinding:
      position: 1
      prefix: --no-msp
  - id: no_nuc
    type: ['null', boolean]
    doc: "No NUC columns."
    inputBinding:
      position: 1
      prefix: --no-nuc
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
    doc: "Input BAM file. For m6A prediction this should be a HiFi BAM file with kinetics data. For other commands this should be a BAM file with m6A calls. For pileup this should be a FIRE BAM file."
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      position: 10
  - id: region
    type: ['null', string]
    doc: "Region string to make a pileup of, for example chr1:1-1000. If not provided a pileup of the whole genome is made. Needs a BAM index (.bai) beside the BAM."
    inputBinding:
      position: 11
outputs:
  - id: pileup_file
    type: File
    doc: "Pileup track of Fiber-seq features."
    outputBinding:
      glob: $(inputs.out_file)
