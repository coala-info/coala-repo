cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ripcal_summarise
label: ripcal_ripcal_summarise
doc: "Summarise a RIPCAL tabular output file for one repeat class (RIP dominance, mutation totals, match lengths). The summary is written to standard output; usage: ripcal_summarise input model [1], where 1 also writes the field ids.\n\nTool homepage: https://sourceforge.net/projects/ripcal"
inputs:
  - id: input_table
    type: File
    doc: RIPCAL tabular output file
    inputBinding:
      position: 1
  - id: model
    type: string
    doc: Name of the repeat class analysed in the input file
    inputBinding:
      position: 2
  - id: write_field_ids
    type:
      - 'null'
      - int
    doc: Set to 1 to write the field ids as a header line
    inputBinding:
      position: 3
outputs:
  - id: summary
    type: stdout
    doc: Tab-delimited summary (standard output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ripcal:2.0--hdfd78af_0
stdout: ripcal_ripcal_summarise.out
