cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ariba
  - expandflag
label: ariba_expandflag
doc: "Expands the flag column in a report file from number to comma-separated list of flag bits\n\nTool homepage: https://github.com/sanger-pathogens/ariba"
inputs:
  - id: infile
    type: File
    doc: "Name of input report TSV file"
    inputBinding:
      position: 10
  - id: outfile
    type: string
    doc: "Name of output report TSV file"
    default: expanded.report.tsv
    inputBinding:
      position: 11
outputs:
  - id: expanded_report
    type: File
    doc: Report TSV with the flag column expanded
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ariba:2.14.7--py310h5140242_0
