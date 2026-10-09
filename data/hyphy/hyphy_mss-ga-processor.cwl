cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hyphy
  - mss-ga-processor
label: hyphy_mss-ga-processor
doc: "[MSS-GA-processor] Process results for a genetic algorithm codon MSS model search.\n\nTool homepage: http://hyphy.org/"
inputs:
  - id: cpu
    type:
      - 'null'
      - int
    doc: "Number of threads to use (HyPhy CPU= argument)."
    inputBinding:
      position: 0
      prefix: CPU=
      separate: false
  - id: json
    type: File
    doc: "Codon GA output JSON file."
    inputBinding:
      position: 101
      prefix: --json
  - id: code
    type:
      - 'null'
      - string
    doc: "Which genetic code should be used (default: Universal)."
    inputBinding:
      position: 101
      prefix: --code
  - id: tsv
    type: string
    doc: "Output model partition table."
    inputBinding:
      position: 102
      prefix: --tsv
outputs:
  - id: stdout
    type: stdout
    doc: Standard output with the analysis results
  - id: partition_table
    type: File
    doc: The model partition table.
    outputBinding:
      glob: $(inputs.tsv)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hyphy:2.5.94--h5837470_0
stdout: hyphy_mss-ga-processor.out
