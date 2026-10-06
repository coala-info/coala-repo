cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - AuthentiCT
  - deam2cont
label: authentict
doc: "AuthentiCT deam2cont: estimate the present-day DNA contamination rate of an ancient
  DNA single-stranded library from its deamination patterns. The input SAM needs MD tags
  (samtools calmd).\n\nTool homepage: https://github.com/StephanePeyregne/AuthentiCT"
inputs:
  - id: input_sam
    type: File
    doc: Input SAM file with MD tags
    inputBinding:
      position: 1
  - id: config
    type:
      - 'null'
      - File
    doc: Input configuration file with tab-separated parameter names and start values
      (e, rss, lo, lss, lds, rds, contam, o, o2)
    inputBinding:
      position: 0
      prefix: --config
  - id: terminal
    type:
      - 'null'
      - boolean
    doc: Estimate contamination rate from terminal C-to-T substitutions only
    inputBinding:
      position: 0
      prefix: --terminal
  - id: mapq
    type:
      - 'null'
      - int
    doc: 'Mapping quality cutoff (default: 0)'
    inputBinding:
      position: 0
      prefix: --mapq
  - id: minlength
    type:
      - 'null'
      - int
    doc: 'Read length cutoff (default: 0)'
    inputBinding:
      position: 0
      prefix: --minlength
  - id: bq
    type:
      - 'null'
      - int
    doc: 'Base quality cutoff (default: 0)'
    inputBinding:
      position: 0
      prefix: --bq
  - id: positions
    type:
      - 'null'
      - File
    doc: Positions that sequences should overlap
    inputBinding:
      position: 0
      prefix: --positions
  - id: sample
    type:
      - 'null'
      - int
    doc: 'Maximum number of sequences used to fit the deamination model (default: 100000)'
    inputBinding:
      position: 0
      prefix: --sample
  - id: decoding
    type:
      - 'null'
      - boolean
    doc: Print the posterior probabilities of each state, one line per position
    inputBinding:
      position: 0
      prefix: --decoding
  - id: output_file
    type: string
    doc: Output file name
    default: authentict_deam2cont.txt
    inputBinding:
      position: 0
      prefix: -o
outputs:
  - id: output
    type: File
    doc: Parameter estimates, including the contamination rate (contam)
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/authentict:1.0.1--py311h9f5acd7_0
