cwlVersion: v1.2
class: CommandLineTool
baseCommand: GenePrioritization
label: ngs-bits_GenePrioritization
doc: "Performs gene prioritization based on list of known disease genes of a disease and a PPI graph.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: input_file
    type:
      - File
    doc: "Input TSV file with one gene identifier per line (known disease genes of a disease)."
    inputBinding:
      position: 1
      prefix: -in
  - id: graph
    type:
      - File
    doc: "Graph TSV file with two gene identifiers per line (PPI graph)."
    inputBinding:
      position: 2
      prefix: -graph
  - id: output_file_path
    type:
      - string
    doc: "Output TSV file containing prioritized genes for the disease."
    inputBinding:
      position: 3
      prefix: -out
  - id: method
    type:
      - 'null'
      - type: enum
        symbols: [flooding, random_walk]
    doc: "Gene prioritization method to use. Valid: 'flooding,random_walk'. Default value: 'flooding'"
    inputBinding:
      position: 4
      prefix: -method
  - id: n
    type:
      - 'null'
      - int
    doc: "Number of network diffusion iterations (flooding). Default value: 2"
    inputBinding:
      position: 5
      prefix: -n
  - id: restart
    type:
      - 'null'
      - float
    doc: "Restart probability (random_walk). Default value: 0.4"
    inputBinding:
      position: 6
      prefix: -restart
  - id: debug_path
    type:
      - 'null'
      - string
    doc: "Output TSV file for debugging. Default value: ''"
    inputBinding:
      position: 7
      prefix: -debug
  - id: settings
    type:
      - 'null'
      - File
    doc: "Settings override file (no other settings files are used)."
    inputBinding:
      position: 100
      prefix: --settings
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "TSV file with prioritized genes."
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: debug_file
    type:
      - 'null'
      - File
    doc: "Debug TSV file (only if -debug is given)."
    outputBinding:
      glob: $(inputs.debug_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
