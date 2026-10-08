cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - CrossMap
  - viewchain
label: crossmap_viewchain
doc: "CrossMap viewchain prints the chain file as a block-to-block table: the source chromosome, start, end and strand, and the target chromosome, start, end and strand of each aligned block.\n\nTool homepage: https://crossmap.sourceforge.net"
inputs:
  - id: chain_file
    type: File
    doc: Chain file (https://genome.ucsc.edu/goldenPath/help/chain.html) describes
      pairwise alignments between two genomes. The input chain file can be a plain
      text file or compressed (.gz, .Z, .z, .bz, .bz2, .bzip2) file.
    inputBinding:
      position: 1
outputs:
  - id: chain_table
    type: stdout
    doc: Tab-separated table of aligned blocks in the chain file.
stdout: $(inputs.chain_file.nameroot).chain_table.tsv
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crossmap:0.7.3--pyhdfd78af_0
