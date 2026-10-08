cwlVersion: v1.2
class: CommandLineTool
baseCommand: [fastreeR]
label: fastreer_DIST2TREE
doc: "Compute a phylogenetic tree (Newick) from a distance matrix\n\nTool homepage: https://github.com/gkanogiannis/fastreeR"
arguments:
  - position: 1
    valueFrom: DIST2TREE
inputs:
  - id: mem
    type: ['null', int]
    doc: Max RAM for JVM in MB (default 256)
    inputBinding:
      position: 0
      prefix: --mem
  - id: lib
    type: ['null', string]
    doc: Path to JAR library folder inside the container
    inputBinding:
      position: 0
      prefix: --lib
  - id: pipe_stderr
    type: ['null', boolean]
    doc: Pipe Java stderr to CLI
    inputBinding:
      position: 0
      prefix: --pipe-stderr
  - id: extra_verbose
    type: ['null', boolean]
    doc: Print extra messages on stderr
    inputBinding:
      position: 0
      prefix: --extraVerbose
  - id: input_file
    type: ['null', File]
    doc: Input distance file (positional)
    inputBinding:
      position: 10
  - id: named_input
    type: ['null', File]
    doc: Optional input distance file (overrides positional)
    inputBinding:
      position: 9
      prefix: -i
  - id: output
    type: string
    doc: "Output file path"
    inputBinding:
      position: 11
      prefix: -o
  - id: verbose
    type: ['null', boolean]
    doc: "Print progress messages on stderr"
    inputBinding:
      position: 11
      prefix: -v
outputs:
  - id: output_file
    type: ['null', File]
    doc: Output file written with -o
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastreer:2.1.3--pyhdfd78af_0
