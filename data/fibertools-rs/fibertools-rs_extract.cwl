cwlVersion: v1.2
class: CommandLineTool
baseCommand: [ft, extract]
label: fibertools-rs_extract
doc: "Extract fiberseq data into plain text files\n\nTool homepage: https://github.com/fiberseq/fibertools-rs"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fibertools-rs:0.8.2--h3b373d1_0
inputs:
  - id: reference
    type: ['null', boolean]
    doc: "Report positions in reference sequence coordinates."
    inputBinding:
      position: 1
      prefix: -r
  - id: molecular
    type: ['null', boolean]
    doc: "Report positions in the molecular sequence coordinates."
    inputBinding:
      position: 1
      prefix: --molecular
  - id: out_m6a
    type: ['null', string]
    doc: "Output path for m6a bed12."
    inputBinding:
      position: 1
      prefix: --m6a
  - id: out_cpg
    type: ['null', string]
    doc: "Output path for 5mC (CpG, primrose) bed12."
    inputBinding:
      position: 1
      prefix: -c
  - id: out_msp
    type: ['null', string]
    doc: "Output path for methylation sensitive patch (MSP) bed12."
    inputBinding:
      position: 1
      prefix: --msp
  - id: out_nuc
    type: ['null', string]
    doc: "Output path for nucleosome bed12."
    inputBinding:
      position: 1
      prefix: -n
  - id: out_all
    type: ['null', string]
    doc: "Output path for tabular format including all fiberseq information in the BAM."
    inputBinding:
      position: 1
      prefix: -a
  - id: quality
    type: ['null', boolean]
    doc: "Include per base quality scores in \"fiber_qual\"."
    inputBinding:
      position: 1
      prefix: -q
  - id: simplify
    type: ['null', boolean]
    doc: "Simplify output by removing fiber sequence."
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
    doc: "Input BAM file. For m6A prediction this should be a HiFi BAM file with kinetics data. For other commands this should be a BAM file with m6A calls."
    inputBinding:
      position: 10
outputs:
  - id: m6a_file
    type: ['null', File]
    doc: "Output m6a bed12."
    outputBinding:
      glob: $(inputs.out_m6a)
  - id: cpg_file
    type: ['null', File]
    doc: "Output 5mC (CpG, primrose) bed12."
    outputBinding:
      glob: $(inputs.out_cpg)
  - id: msp_file
    type: ['null', File]
    doc: "Output methylation sensitive patch (MSP) bed12."
    outputBinding:
      glob: $(inputs.out_msp)
  - id: nuc_file
    type: ['null', File]
    doc: "Output nucleosome bed12."
    outputBinding:
      glob: $(inputs.out_nuc)
  - id: all_file
    type: ['null', File]
    doc: "Output tabular format including all fiberseq information in the BAM."
    outputBinding:
      glob: $(inputs.out_all)
