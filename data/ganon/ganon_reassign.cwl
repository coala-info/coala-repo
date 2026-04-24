cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ganon
  - reassign
label: ganon_reassign
doc: "Reassigns sequences based on EM algorithm.\n\nTool homepage: https://github.com/pirovc/ganon"
inputs:
  - id: input_prefix
    type: string
    doc: Input prefix to find files from ganon classify (.all and optionally 
      .rep)
    inputBinding:
      position: 101
      prefix: --input-prefix
  - id: max_iter
    type:
      - 'null'
      - int
    doc: Max. number of iterations for the EM algorithm. If 0, will run until 
      convergence (check --threshold)
    inputBinding:
      position: 101
      prefix: --max-iter
  - id: output_prefix
    type: string
    doc: Output prefix for reassigned file (.one and optionally .rep). In case 
      of multiple files, the base input filename will be appended at the end of 
      the output file 'output_prefix + FILENAME.out'
    inputBinding:
      position: 101
      prefix: --output-prefix
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet output mode
    inputBinding:
      position: 101
      prefix: --quiet
  - id: remove_all
    type:
      - 'null'
      - boolean
    doc: Remove input file (.all) after processing.
    inputBinding:
      position: 101
      prefix: --remove-all
  - id: skip_one
    type:
      - 'null'
      - boolean
    doc: Do not write output file (.one) after processing.
    inputBinding:
      position: 101
      prefix: --skip-one
  - id: threshold
    type:
      - 'null'
      - float
    doc: Convergence threshold limit to stop the EM algorithm.
    inputBinding:
      position: 101
      prefix: --threshold
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output mode
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ganon:2.2.0--py312hfc6b275_0
stdout: ganon_reassign.out
