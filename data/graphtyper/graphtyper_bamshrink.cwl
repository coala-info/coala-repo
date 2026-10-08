cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - graphtyper
  - bamshrink
label: graphtyper_bamshrink
doc: "Run bamShrink: reduce a BAM/CRAM file to the reads useful for genotyping.\n\nTool homepage: https://github.com/DecodeGenetics/graphtyper"
inputs:
  - id: bam_path_in
    type: File
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: .crai
        required: false
      - pattern: ^.bai
        required: false
    doc: "Input BAM file path."
    inputBinding:
      position: 1
  - id: log
    type:
      - 'null'
      - string
    doc: "Set path to log file."
    inputBinding:
      position: 10
      prefix: "--log="
      separate: false
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Set to output verbose logging."
    inputBinding:
      position: 10
      prefix: "--verbose"
  - id: vverbose
    type:
      - 'null'
      - boolean
    doc: "Set to output very verbose logging."
    inputBinding:
      position: 10
      prefix: "--vverbose"
  - id: avg_cov_by_readlen
    type:
      - 'null'
      - float
    doc: "Average coverage divided by read length (default 0.3)."
    inputBinding:
      position: 10
      prefix: "--avg-cov-by-readlen="
      separate: false
  - id: index
    type:
      - 'null'
      - File
    doc: "Input BAM bai/CRAM crai index file (default <bamPathIn>.[bai,crai])."
    inputBinding:
      position: 10
      prefix: "--index="
      separate: false
  - id: output
    type: string
    default: bamshrink.bam
    doc: "Output BAM file."
    inputBinding:
      position: 10
      prefix: "--output="
      separate: false
  - id: interval
    type:
      - 'null'
      - string
    doc: "Interval/region to filter on in format chrA:N-M."
    inputBinding:
      position: 10
      prefix: "--interval="
      separate: false
  - id: interval_file
    type:
      - 'null'
      - File
    doc: "File with interval(s)/region(s) to filter on."
    inputBinding:
      position: 10
      prefix: "--interval-file="
      separate: false
  - id: max_fragment_length
    type:
      - 'null'
      - int
    doc: "Maximum fragment length allowed (default 1000)."
    inputBinding:
      position: 10
      prefix: "--max-fragment-length="
      separate: false
  - id: min_num_matching
    type:
      - 'null'
      - int
    doc: "Minumum number of matching bases in read (default 55)."
    inputBinding:
      position: 10
      prefix: "--min-num-matching="
      separate: false
outputs:
  - id: shrunk_bam
    type: File
    doc: Reduced BAM file
    outputBinding:
      glob: $(inputs.output)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphtyper:2.7.7--h7594796_1
stdout: graphtyper_bamshrink.out
