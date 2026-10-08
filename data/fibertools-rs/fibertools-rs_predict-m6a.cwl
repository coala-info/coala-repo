cwlVersion: v1.2
class: CommandLineTool
baseCommand: [ft, predict-m6a]
label: fibertools-rs_predict-m6a
doc: "Predict m6A positions using HiFi kinetics data and encode the results in the MM and ML bam tags. Also adds nucleosome (nl, ns) and MTase sensitive patches (al, as)\n\nTool homepage: https://github.com/fiberseq/fibertools-rs"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fibertools-rs:0.8.2--h3b373d1_0
inputs:
  - id: nucleosome_length
    type: ['null', int]
    doc: "Minimum nucleosome length (default 75)."
    inputBinding:
      position: 1
      prefix: -n
  - id: combined_nucleosome_length
    type: ['null', int]
    doc: "Minimum nucleosome length when combining over a single m6A (default 100)."
    inputBinding:
      position: 1
      prefix: -c
  - id: min_distance_added
    type: ['null', int]
    doc: "Minimum distance needed to add to an already existing nucleosome by crossing an m6A (default 25)."
    inputBinding:
      position: 1
      prefix: --min-distance-added
  - id: distance_from_end
    type: ['null', int]
    doc: "Minimum distance from the end of a fiber to call a nucleosome or MSP (default 45)."
    inputBinding:
      position: 1
      prefix: -d
  - id: keep
    type: ['null', boolean]
    doc: "Keep HiFi kinetics data."
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
  - id: force_min_ml_score
    type: ['null', int]
    doc: "Force a different minimum ML score."
    inputBinding:
      position: 1
      prefix: --force-min-ml-score
  - id: all_calls
    type: ['null', boolean]
    doc: "Keep all m6A calls regardless of how low the ML value is."
    inputBinding:
      position: 1
      prefix: --all-calls
  - id: batch_size
    type: ['null', int]
    doc: "Number of reads to include in batch prediction (default 1)."
    inputBinding:
      position: 1
      prefix: -b
  - id: bam
    type: File
    doc: "Input BAM file. For m6A prediction this should be a HiFi BAM file with kinetics data. For other commands this should be a BAM file with m6A calls."
    inputBinding:
      position: 10
  - id: out_bam
    type: string
    doc: "Output BAM file name, with m6A calls in new or extended MM and ML tags."
    default: "predict_m6a.bam"
    inputBinding:
      position: 11
outputs:
  - id: output_bam
    type: File
    doc: "Output BAM file with m6A calls, nucleosomes (nl, ns) and MTase sensitive patches (al, as)."
    outputBinding:
      glob: $(inputs.out_bam)
