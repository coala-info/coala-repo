cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tradis
  - compare
  - essentiality
label: quatradis_tradis_compare_essentiality
doc: "Determine how essential each gene is based on the transposon insertion site plot counts.\n\nTool homepage: https://github.com/quadram-institute-bioscience/QuaTradis"
inputs:
  - id: count_file
    type: File
    doc: "Counts from a transposon insertion site plot file (from tradis plot count)."
    inputBinding:
      position: 1
  - id: profile
    type:
      - 'null'
      - boolean
    doc: "Turn on profiling."
    inputBinding:
      position: 100
      prefix: --profile
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Print out extra information about the process while it runs."
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: result_files
    type:
      type: array
      items: File
    doc: "Essentiality result files written next to the count file"
    outputBinding:
      glob: '*.ess*'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.count_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quatradis:1.4.0--py312h0fa9677_1
stdout: quatradis_tradis_compare_essentiality.out
