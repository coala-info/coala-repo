cwlVersion: v1.2
class: CommandLineTool
baseCommand: combine_cov
label: metacoag_combine_cov
doc: "combine_cov: Combine multiple coverage files of samples from CoverM\n\nTool homepage:
  https://github.com/metagentools/MetaCoAG"
inputs:
  - id: covpath
    type: Directory
    doc: path to the .tsv files from CoverM
    inputBinding:
      prefix: --covpath
  - id: output_prefix
    type: string
    doc: path to the output folder. This version appends coverage.tsv and
      coverage_with_header.tsv straight to this text, so use a file name prefix
      such as combined_ (or a folder that exists, ending in a slash)
    default: combined_
    inputBinding:
      prefix: --output
outputs:
  - id: coverage
    type: File
    doc: combined coverage values without a header
    outputBinding:
      glob: $(inputs.output_prefix)coverage.tsv
  - id: coverage_with_header
    type: File
    doc: combined coverage values with a header
    outputBinding:
      glob: $(inputs.output_prefix)coverage_with_header.tsv
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metacoag:1.2.2--py312h9ee0642_0
stdout: metacoag_combine_cov.out
