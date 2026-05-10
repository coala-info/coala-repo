cwlVersion: v1.2
class: CommandLineTool
baseCommand: pxupgma
label: phyx_pxupgma
doc: "Bare bones UPGMA tree generator. Currently only uses uncorrected p-distances.
  This will take fasta, fastq, phylip, and nexus formats from a file or STDIN.\n\n\
  \ Tool homepage: https://github.com/FePhyFoFum/phyx"
inputs:
  - id: citation
    type:
      - 'null'
      - boolean
    doc: display phyx citation and exit
    inputBinding:
      position: 101
      prefix: --citation
  - id: sequence_file
    type:
      - 'null'
      - File
    doc: input sequence file, STDIN otherwise
    inputBinding:
      position: 101
      prefix: --seqf
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 102
      prefix: --output-file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output newick file, STOUT otherwise
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyx:1.1--hc0837bd_5
