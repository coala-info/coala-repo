cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tksm
  - flip
label: tksm_flip
doc: "Simulates strand flipping: flips the strand of molecules with a given probability\n\nTool homepage: https://github.com/vpc-ccg/tksm"
inputs:
  - id: input
    type: File
    doc: "input mdf file"
    inputBinding:
      position: 1
      prefix: --input
  - id: output
    type: string
    doc: "output mdf file"
    inputBinding:
      position: 1
      prefix: --output
  - id: flip_probability
    type: float
    doc: "probability of flipping the strand of a molecule"
    inputBinding:
      position: 1
      prefix: --flip-probability
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random seed (default: 42)"
    inputBinding:
      position: 1
      prefix: --seed
  - id: verbosity
    type:
      - 'null'
      - string
    doc: "Verbosity level to choose from [DEBUG, ERROR, INFO, OFF, WARN] (default: INFO)"
    inputBinding:
      position: 1
      prefix: --verbosity
  - id: log_file
    type:
      - 'null'
      - string
    doc: "Log file to write the logs (or stderr/stdout) (default: stderr)"
    inputBinding:
      position: 1
      prefix: --log-file
outputs:
  - id: flipped
    type: File
    doc: "Molecules after strand flipping (MDF)"
    outputBinding:
      glob: "$(inputs.output)"
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tksm:0.6.1--py310ha025fb0_1
stdout: tksm_flip.out
