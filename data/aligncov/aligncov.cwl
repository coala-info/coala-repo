cwlVersion: v1.2
class: CommandLineTool
baseCommand: aligncov
label: aligncov
doc: "Parse a sorted BAM file to generate two tables: a table of alignment summary
  statistics ('_stats.tsv'), including fold-coverages (fold_cov) and proportions of
  target lengths covered by mapped reads (prop_cov), and a table of read depths ('_depth.tsv')
  for each bp position of each target.\n\nTool homepage: https://github.com/pcrxn/aligncov"
inputs:
  - id: input
    type: File
    doc: Path to sorted BAM file to process.
    inputBinding:
      position: 101
      prefix: --input
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Path and base name of files to save as tab-separated tables 
      ('[output]_stats.tsv', '[output]_depth.tsv').
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aligncov:0.0.2--pyh7cba7a3_0
