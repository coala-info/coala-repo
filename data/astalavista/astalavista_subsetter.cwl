cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - astalavista
  - -t
  - subsetter
label: astalavista_subsetter
doc: "Extract a random subset of lines from a file\n\nTool homepage: https://github.com/divyavewall/astalavista-frontend"
inputs:
  - id: input
    type: File
    doc: Input file
    inputBinding:
      position: 102
      prefix: --input
  - id: output_path
    type: string
    doc: Output file name (passed as an absolute path; the tool fails on a bare file
      name)
    inputBinding:
      position: 102
      prefix: --output
      valueFrom: $(runtime.outdir)/$(self)
  - id: number
    type:
      - 'null'
      - int
    doc: Number of lines to be subset
    inputBinding:
      position: 102
      prefix: --number
  - id: lines
    type:
      - 'null'
      - int
    doc: Number of lines in the input file
    inputBinding:
      position: 102
      prefix: --lines
  - id: force
    type:
      - 'null'
      - boolean
    doc: Disable interactivity. No questions will be asked
    inputBinding:
      position: 101
      prefix: --force
  - id: log
    type:
      - 'null'
      - string
    doc: Log level (NONE|INFO|ERROR|DEBUG)
    inputBinding:
      position: 101
      prefix: --log
  - id: threads
    type:
      - 'null'
      - int
    doc: Maximum number of threads to use.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type: File
    doc: Random subset of the input lines
    outputBinding:
      glob: $(inputs.output_path)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/astalavista:4.0--0
stdout: astalavista_subsetter.out
