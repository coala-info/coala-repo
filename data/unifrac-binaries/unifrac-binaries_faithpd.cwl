cwlVersion: v1.2
class: CommandLineTool
baseCommand: faithpd
label: unifrac-binaries_faithpd
doc: "Calculates Faith's Phylogenetic Diversity for each sample in a BIOM table using
  a provided phylogeny.\n\nTool homepage: https://github.com/biocore/unifrac-binaries"
inputs:
  - id: biom_table
    type: File
    doc: The input BIOM table.
    inputBinding:
      position: 101
      prefix: -i
  - id: newick_tree
    type: File
    doc: The input phylogeny in newick.
    inputBinding:
      position: 101
      prefix: -t
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 102
      prefix: --output-file
outputs:
  - id: output_file
    type: File
    doc: The output series.
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unifrac-binaries:1.6--h9d55e78_0
