cwlVersion: v1.2
class: CommandLineTool
baseCommand: [ft, validate]
label: fibertools-rs_validate
doc: "Validate a Fiber-seq BAM file for m6A, nucleosome, and optionally FIRE calls\n\nTool homepage: https://github.com/fiberseq/fibertools-rs"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fibertools-rs:0.8.2--h3b373d1_0
inputs:
  - id: reads
    type: ['null', int]
    doc: "Number of reads to validate (default 5000)."
    inputBinding:
      position: 1
      prefix: -r
  - id: m6a
    type: ['null', float]
    doc: "The fraction of reads that must have m6A calls to pass validation (default 0.5)."
    inputBinding:
      position: 1
      prefix: -m
  - id: nuc
    type: ['null', float]
    doc: "The fraction of reads that must have nucleosome and MSP calls to pass validation (default 0.5)."
    inputBinding:
      position: 1
      prefix: -n
  - id: fire
    type: ['null', boolean]
    doc: "Check for FIRE calls in the reads; there must be at least one FIRE call to pass validation."
    inputBinding:
      position: 1
      prefix: -f
  - id: aligned
    type: ['null', float]
    doc: "Check for the fraction of reads with alignment to a reference genome (default 0.0)."
    inputBinding:
      position: 1
      prefix: -a
  - id: phased
    type: ['null', float]
    doc: "Check for the fraction of reads with phasing information (default 0.0)."
    inputBinding:
      position: 1
      prefix: -p
  - id: kinetics
    type: ['null', float]
    doc: "Check for the fraction of reads with kinetics information (default 0.0)."
    inputBinding:
      position: 1
      prefix: -k
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
  - id: out_name
    type: string
    doc: "Name of the file that receives the standard error (validation messages)."
    default: "validate.log"
outputs:
  - id: validation_log
    type: stderr
    doc: "Validation messages written by ft validate; the exit code is non-zero when validation fails."
stderr: $(inputs.out_name)
