cwlVersion: v1.2
class: CommandLineTool
baseCommand: wiggletools_wilcoxon
label: wiggletools_wilcoxon
doc: "Performs a Wilcoxon rank-sum test on wiggle files.\n\nTool homepage: https://github.com/Ensembl/WiggleTools"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Two or more wiggle files to compare.
    inputBinding:
      position: 1
  - id: group_size
    type:
      - 'null'
      - int
    doc: The number of files to group together for comparison. Defaults to 2.
    inputBinding:
      position: 102
      prefix: --group-size
  - id: paired
    type:
      - 'null'
      - boolean
    doc: Perform a paired Wilcoxon test. Requires an even number of input files.
    inputBinding:
      position: 102
      prefix: --paired
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: File to write the results to. Defaults to stdout.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wiggletools:1.2.11--h7118728_10
