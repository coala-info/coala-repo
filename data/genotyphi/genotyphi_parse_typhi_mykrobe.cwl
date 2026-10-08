cwlVersion: v1.2
class: CommandLineTool
baseCommand: parse_typhi_mykrobe.py
label: genotyphi_parse_typhi_mykrobe
doc: "Parse mykrobe predict JSON files (Typhi genotype, AMR and plasmid calls) into
  one table.\n\nTool homepage: https://github.com/typhoidgenomics/genotyphi"
inputs:
  - id: jsons
    type:
      type: array
      items: File
    doc: JSON files output from mykrobe predict
    inputBinding:
      position: 1
      prefix: --jsons
  - id: prefix
    type: string
    doc: prefix for output files
    inputBinding:
      position: 2
      prefix: --prefix
outputs:
  - id: predict_results
    type:
      - 'null'
      - File
    doc: table of genotype and AMR results
    outputBinding:
      glob: $(inputs.prefix)_predictResults.tsv
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genotyphi:2.0--hdfd78af_0
stdout: genotyphi_parse_typhi_mykrobe.out
