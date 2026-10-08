cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hamronize
  - tbprofiler
label: hamronization_hamronize_tbprofiler
doc: "Applies hAMRonization specification to output(s) from tbprofiler (OUTPUT.results.json)\n\nTool homepage: https://github.com/pha4ge/hAMRonization"
inputs:
  - id: report
    type:
      type: array
      items: File
    doc: Path to report(s)
    inputBinding:
      position: 1
  - id: format
    type:
      - 'null'
      - string
    doc: Output format (tsv or json)
    inputBinding:
      position: 102
      prefix: --format
  - id: output_path
    type: string
    doc: Output location
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output location
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hamronization:1.1.9--pyhdfd78af_1
