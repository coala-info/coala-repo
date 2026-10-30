cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - featurealigner2msstats.py
label: msproteomicstools_featurealigner2msstats.py
doc: "Convert a feature alignment table (tsv or tsv.gz) to an MSstats compatible csv file.\n\nTool homepage: https://github.com/msproteomicstools/msproteomicstools"
inputs:
  - id: input_tsv
    type: File
    doc: "Feature alignment table (tsv or tsv.gz)"
    inputBinding:
      position: 1
  - id: output_path
    type: string
    doc: "Output MSstats compatible csv file"
    inputBinding:
      position: 2
outputs:
  - id: output
    type: File
    doc: "MSstats input csv"
    outputBinding:
      glob: "$(inputs.output_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
