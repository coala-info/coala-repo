cwlVersion: v1.2
class: CommandLineTool
baseCommand: [ft, fire]
label: fibertools-rs_fire
doc: "Add FIREs (Fiber-seq Inferred Regulatory Elements) to a bam file with m6a predictions\n\nTool homepage: https://github.com/fiberseq/fibertools-rs"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fibertools-rs:0.8.2--h3b373d1_0
inputs:
  - id: ont
    type: ['null', boolean]
    doc: "Use an ONT heuristic adjustment for FIRE calling (adds pseudo counts to the m6A counts)."
    inputBinding:
      position: 1
      prefix: --ont
  - id: extract
    type: ['null', boolean]
    doc: "Output just FIRE elements in bed9 format."
    inputBinding:
      position: 1
      prefix: -e
  - id: all
    type: ['null', boolean]
    doc: "When extracting bed9 format include all MSPs and nucleosomes."
    inputBinding:
      position: 1
      prefix: --all
  - id: feats_to_text
    type: ['null', boolean]
    doc: "Output FIRE features for training in a table format."
    inputBinding:
      position: 1
      prefix: -f
  - id: skip_no_m6a
    type: ['null', boolean]
    doc: "Do not write reads with no m6A calls to the output BAM."
    inputBinding:
      position: 1
      prefix: -s
  - id: min_msp
    type: ['null', int]
    doc: "Skip reads without at least N MSP calls (default 0)."
    inputBinding:
      position: 1
      prefix: --min-msp
  - id: min_ave_msp_size
    type: ['null', int]
    doc: "Skip reads without an average MSP size greater than N (default 0)."
    inputBinding:
      position: 1
      prefix: --min-ave-msp-size
  - id: width_bin
    type: ['null', int]
    doc: "Width of bin for feature collection (default 40)."
    inputBinding:
      position: 1
      prefix: -w
  - id: bin_num
    type: ['null', int]
    doc: "Number of bins to collect (default 9)."
    inputBinding:
      position: 1
      prefix: -b
  - id: best_window_size
    type: ['null', int]
    doc: "Calculate stats for the highest X bp window within each MSP (default 100)."
    inputBinding:
      position: 1
      prefix: --best-window-size
  - id: min_msp_length_for_positive_fire_call
    type: ['null', int]
    doc: "Minimum length of MSP to call a FIRE (default 85)."
    inputBinding:
      position: 1
      prefix: --min-msp-length-for-positive-fire-call
  - id: model
    type: ['null', File]
    doc: "Optional path to a model JSON file. If not provided ft uses the default model (recommended)."
    inputBinding:
      position: 1
      prefix: --model
  - id: fdr_table
    type: ['null', File]
    doc: "Optional path to an FDR table."
    inputBinding:
      position: 1
      prefix: --fdr-table
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
  - id: out_file
    type: string
    doc: "Output file name. BAM by default, a table of MSP features with --feats-to-text, and bed9 with --extract."
    default: "fire_out.bam"
    inputBinding:
      position: 11
outputs:
  - id: output_file
    type: File
    doc: "Output file: BAM with FIRE calls, MSP feature table (--feats-to-text) or FIRE bed9 (--extract)."
    outputBinding:
      glob: $(inputs.out_file)
