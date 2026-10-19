cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ribo
  - sim
label: riboseed_ribo_sim
doc: "Use the JC model of genome evolution to test the effectiveness of riboSeed on divergent reference sequences.\n\nTool homepage: https://github.com/nickp60/riboSeed"
inputs:
  - id: fasta
    type: File
    doc: "(multi)fasta file containing the sequences to be mutated"
    inputBinding:
      position: 1
  - id: verbosity
    type:
      - 'null'
      - int
    doc: "Logger writes debug to file in output dir; this sets verbosity level sent to stderr. 1 = debug(), 2 = info(), 3 = warning(), 4 = error() and 5 = critical(); default: 2"
    inputBinding:
      position: 101
      prefix: '--verbosity'
  - id: frequency
    type:
      - 'null'
      - float
    doc: "Probability of mutated bases; default: 0.01"
    inputBinding:
      position: 101
      prefix: '--frequency'
  - id: end_length
    type:
      - 'null'
      - int
    doc: "if value given, only mutated the ends of the sequences and ignore the middle"
    inputBinding:
      position: 101
      prefix: '--end_length'
  - id: seed
    type:
      - 'null'
      - int
    doc: "cause reproducibility; default: None"
    inputBinding:
      position: 101
      prefix: '--seed'
  - id: output
    type: string
    doc: "output directory"
    inputBinding:
      position: 102
      prefix: '--output'
outputs:
  - id: output_dir
    type: Directory
    doc: "Output directory"
    outputBinding:
      glob: $(inputs.output)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/riboseed:0.4.90--py_0
stdout: riboseed_ribo_sim.out
