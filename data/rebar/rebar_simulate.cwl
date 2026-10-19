cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rebar
  - simulate
label: rebar_simulate
doc: "Simulate recombination between parent populations of a dataset.

Tool homepage: https://github.com/phac-nml/rebar"
inputs:
  - id: dataset_dir
    type: Directory
    doc: "Dataset directory"
    inputBinding:
      position: 1
      prefix: --dataset-dir
  - id: parents
    type: string
    doc: "Simulate recombination between these parents, 5' to 3'"
    inputBinding:
      position: 2
      prefix: --parents
  - id: output_dir
    type: string
    doc: "Output directory. It is created if it does not exist"
    inputBinding:
      position: 3
      prefix: --output-dir
  - id: breakpoints
    type:
      - 'null'
      - string
    doc: "Breakpoints; random if not provided"
    inputBinding:
      position: 4
      prefix: --breakpoints
  - id: verbosity
    type:
      - 'null'
      - string
    doc: "Control output verbosity level (info, warn, debug, error). Default is info"
    inputBinding:
      position: 90
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: sim_dir
    type: Directory
    doc: "Simulation output directory"
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rebar:0.2.1--h9ee0642_0
stdout: rebar_simulate.out
