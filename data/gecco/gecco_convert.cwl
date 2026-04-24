cwlVersion: v1.2
class: CommandLineTool
baseCommand: gecco convert
label: gecco_convert
doc: "Convert the GenBank records to a different format.\n\nTool homepage: https://gecco.embl.de/"
inputs:
  - id: input
    type:
      type: array
      items: string
    doc: Input GenBank records or clusters table
    inputBinding:
      position: 1
  - id: jobs
    type:
      - 'null'
      - int
    doc: The number of jobs to use for multithreading. Use 0 to use all 
      available CPUs.
    inputBinding:
      position: 102
      prefix: --jobs
  - id: no_color
    type:
      - 'null'
      - boolean
    doc: Disable the console color
    inputBinding:
      position: 102
      prefix: --no-color
  - id: no_markup
    type:
      - 'null'
      - boolean
    doc: Disable the console markup
    inputBinding:
      position: 102
      prefix: --no-markup
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Reduce or disable the console output
    inputBinding:
      position: 102
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase the console output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gecco:0.10.2--pyhdfd78af_0
stdout: gecco_convert.out
