cwlVersion: v1.2
class: CommandLineTool
baseCommand: [ft, center]
label: fibertools-rs_center
doc: "This command centers fiberseq data around given reference positions. This is useful for making aggregate m6A and CpG observations, as well as visualization of SVs\n\nTool homepage: https://github.com/fiberseq/fibertools-rs"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fibertools-rs:0.8.2--h3b373d1_0
inputs:
  - id: bed
    type: File
    doc: "Bed file on which to center fiberseq reads. Data is adjusted to the start position of each record and corrected for strand if the strand is in the 6th (or 4th) column."
    inputBinding:
      position: 1
      prefix: --bed
  - id: dist
    type: ['null', int]
    doc: "Set a maximum distance from the start of the motif to keep a feature."
    inputBinding:
      position: 1
      prefix: -d
  - id: wide
    type: ['null', boolean]
    doc: "Provide data in wide format, one row per read."
    inputBinding:
      position: 1
      prefix: -w
  - id: reference
    type: ['null', boolean]
    doc: "Return relative reference position instead of relative molecular position."
    inputBinding:
      position: 1
      prefix: -r
  - id: simplify
    type: ['null', boolean]
    doc: "Replace the sequence output column with just \"N\"."
    inputBinding:
      position: 1
      prefix: -s
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
    doc: "Input BAM file. For m6A prediction this should be a HiFi BAM file with kinetics data. For other commands this should be a BAM file with m6A calls. Needs a BAM index (.bai) beside it."
    secondaryFiles:
      - pattern: .bai
        required: true
    inputBinding:
      position: 10
  - id: out_name
    type: string
    doc: "Name of the file that receives the standard output (centered table)."
    default: "centered.tsv"
outputs:
  - id: centered
    type: stdout
    doc: "Tab-separated table of fiberseq data centered on the BED positions."
stdout: $(inputs.out_name)
