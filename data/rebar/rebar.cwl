cwlVersion: v1.2
class: CommandLineTool
baseCommand: rebar
label: rebar
doc: "rebar is a tool for identifying and analyzing recombinant lineages in SARS-CoV-2
  (and potentially other) genomic sequences.\n\nTool homepage: https://github.com/phac-nml/rebar"
inputs:
  - id: subcommand
    type: string
    doc: The subcommand to execute (e.g., dataset, run, plot)
    inputBinding:
      position: 1
  - id: alignment
    type:
      - 'null'
      - File
    doc: Path to the input alignment file (FASTA)
    inputBinding:
      position: 102
      prefix: --alignment
  - id: dataset
    type:
      - 'null'
      - Directory
    doc: Path to the dataset directory
    inputBinding:
      position: 102
      prefix: --dataset
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Directory to write output files
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rebar:0.2.1--h9ee0642_0
