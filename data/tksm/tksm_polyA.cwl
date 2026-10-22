cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tksm
  - polyA
label: tksm_polyA
doc: "Adds polyA tails to molecules with given size distribution\n\nTool homepage: https://github.com/vpc-ccg/tksm"
inputs:
  - id: input
    type: File
    doc: "Input file"
    inputBinding:
      position: 1
      prefix: --input
  - id: output
    type: string
    doc: "Output file"
    inputBinding:
      position: 1
      prefix: --output
  - id: gamma
    type:
      - 'null'
      - string
    doc: "Use Gamma distribution [alpha,beta]"
    inputBinding:
      position: 1
      prefix: --gamma
  - id: poisson
    type:
      - 'null'
      - string
    doc: "Use Poisson distribution [lambda]"
    inputBinding:
      position: 1
      prefix: --poisson
  - id: weibull
    type:
      - 'null'
      - string
    doc: "Use Weibull distribution [alpha,beta]"
    inputBinding:
      position: 1
      prefix: --weibull
  - id: normal
    type:
      - 'null'
      - string
    doc: "Use Normal distribution [mu,sigma]"
    inputBinding:
      position: 1
      prefix: --normal
  - id: min_length
    type:
      - 'null'
      - int
    doc: "Minimum length of polyA (default: 0)"
    inputBinding:
      position: 1
      prefix: --min-length
  - id: max_length
    type:
      - 'null'
      - int
    doc: "Maximum length of polyA (default: 5000)"
    inputBinding:
      position: 1
      prefix: --max-length
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
  - id: tailed
    type: File
    doc: "Molecules with polyA tails (MDF)"
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
stdout: tksm_polyA.out
