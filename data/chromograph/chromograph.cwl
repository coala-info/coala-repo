cwlVersion: v1.2
class: CommandLineTool
baseCommand: chromograph
label: chromograph
doc: "Chromograph is a tool for plotting data on chromosomes. (Note: The provided
  text contains system error logs rather than help text; arguments were inferred from
  the tool's standard interface).\n\nTool homepage: https://github.com/Clinical-Genomics/chromograph"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files to plot
    inputBinding:
      position: 1
  - id: config
    type:
      - 'null'
      - File
    doc: Config file
    inputBinding:
      position: 102
      prefix: --config
  - id: kde
    type:
      - 'null'
      - boolean
    doc: Plot KDE
    inputBinding:
      position: 102
      prefix: --kde
  - id: monochrome
    type:
      - 'null'
      - boolean
    doc: Plot monochrome
    inputBinding:
      position: 102
      prefix: --monochrome
  - id: step
    type:
      - 'null'
      - boolean
    doc: Plot step
    inputBinding:
      position: 102
      prefix: --step
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chromograph:1.3.1--pyhdfd78af_2
