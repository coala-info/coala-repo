cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - votuderep
  - splitcoverm
label: votuderep_splitcoverm
doc: "Split a CoverM TSV by metric into separate TSVs, one per metric. Reads a CoverM
  output table containing multiple metrics across samples and splits it into individual
  TSV files, one for each metric.\n\nTool homepage: https://github.com/quadram-institute-bioscience/votuderep"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input
    type: File
    doc: Input CoverM TSV (optionally gzipped, .gz)
    inputBinding:
      position: 101
      prefix: --input
  - id: output_basename
    type: string
    doc: Output basename/prefix for generated files
    inputBinding:
      position: 102
      prefix: --output-basename
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: One TSV per metric, named from the output basename
    outputBinding:
      glob: $(inputs.output_basename)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/votuderep:0.6.0--pyhdfd78af_0
