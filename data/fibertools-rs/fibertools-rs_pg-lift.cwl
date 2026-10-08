cwlVersion: v1.2
class: CommandLineTool
baseCommand: [ft, pg-lift]
label: fibertools-rs_pg-lift
doc: "Lift annotations through a pangenome graph from source to target coordinates\n\nTool homepage: https://github.com/fiberseq/fibertools-rs"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fibertools-rs:0.8.2--h3b373d1_0
inputs:
  - id: input
    type: File
    doc: "Input file with annotations to lift (BED by default, BAM with --bam)."
    inputBinding:
      position: 1
      prefix: --input
  - id: graph
    type: File
    doc: "Pangenome graph file in GBZ format."
    inputBinding:
      position: 1
      prefix: --graph
  - id: out_bed
    type: string
    doc: "Output BED file name with lifted annotations."
    default: "lifted.bed"
    inputBinding:
      position: 1
      prefix: --out
  - id: prefix
    type: string
    doc: "panSN-spec prefix to add before graph injection (e.g. \"HG002_2#0#\")."
    inputBinding:
      position: 1
      prefix: --prefix
  - id: target
    type: string
    doc: "Target sample/haplotype name for surjection (e.g. \"HG002_1\")."
    inputBinding:
      position: 1
      prefix: --target
  - id: bam
    type: ['null', boolean]
    doc: "Input file is in BAM format (default: BED format)."
    inputBinding:
      position: 1
      prefix: --bam
  - id: split_size
    type: ['null', int]
    doc: "Split contigs into multiple BAM records every N base pairs for graph injection (default 100000)."
    inputBinding:
      position: 1
      prefix: --split-size
  - id: vg_threads
    type: ['null', int]
    doc: "Number of threads to use for vg operations (default 16)."
    inputBinding:
      position: 1
      prefix: --vg-threads
  - id: vg_binary
    type: ['null', string]
    doc: "Path to the vg binary (default: searches PATH)."
    inputBinding:
      position: 1
      prefix: --vg-binary
  - id: delimiter
    type: ['null', string]
    doc: "Delimiter character to use when stripping panSN-spec (default '#')."
    inputBinding:
      position: 1
      prefix: --delimiter
  - id: keep_intermediate
    type: ['null', boolean]
    doc: "Keep intermediate files for debugging."
    inputBinding:
      position: 1
      prefix: --keep-intermediate
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
  - id: reference
    type: File
    doc: "Reference FASTA file to use as source coordinates."
    inputBinding:
      position: 10
outputs:
  - id: lifted_bed
    type: File
    doc: "BED file with lifted annotations."
    outputBinding:
      glob: $(inputs.out_bed)
