cwlVersion: v1.2
class: CommandLineTool
baseCommand: minimizers
label: minimizers
doc: "Extract the set of minimizers from a sequence file\n\nTool homepage: https://github.com/cumbof/minimizers"
inputs:
  - id: aggregate
    type:
      - 'null'
      - boolean
    doc: Aggregate record results
    inputBinding:
      position: 101
      prefix: --aggregate
  - id: input
    type: File
    doc: "Path to the input sequence file in fasta format. It\n                  \
      \      can be Gzip compressed"
    inputBinding:
      position: 101
      prefix: --input
  - id: nproc
    type:
      - 'null'
      - int
    doc: Make it parallel
    inputBinding:
      position: 101
      prefix: --nproc
  - id: output_type
    type:
      - 'null'
      - string
    doc: "The output can be formatted as a list of kmers or as a\n               \
      \         fasta file"
    inputBinding:
      position: 101
      prefix: --output-type
  - id: report_counts
    type:
      - 'null'
      - boolean
    doc: "Report the frequencies of the minimizers. This is\n                    \
      \    compatible with \"--output-type list\" only"
    inputBinding:
      position: 101
      prefix: --report-counts
  - id: size
    type:
      - 'null'
      - int
    doc: Length of the minimizers
    inputBinding:
      position: 101
      prefix: --size
  - id: top_num
    type:
      - 'null'
      - int
    doc: "Report the top number of minimizers based on their\n                   \
      \     frequency"
    inputBinding:
      position: 101
      prefix: --top-num
  - id: top_perc
    type:
      - 'null'
      - float
    doc: "Report the top percentage of minimizers based on their\n               \
      \         frequency"
    inputBinding:
      position: 101
      prefix: --top-perc
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print messages on the stdout
    inputBinding:
      position: 101
      prefix: --verbose
  - id: window
    type:
      - 'null'
      - int
    doc: "Size of the sliding window. It must be greater than\n                  \
      \      the minimizer size"
    inputBinding:
      position: 101
      prefix: --window
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: "Path to the output file with minimizers. Results are\n                 \
      \       printed on the stdout if no output is provided"
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minimizers:0.1.2--pyhdfd78af_0
