cwlVersion: v1.2
class: CommandLineTool
baseCommand: pxcomp
label: phyx_pxcomp
doc: "Sequence compositional homogeneity test. Chi-square test for equivalent character
  state counts across lineages. This will take fasta, phylip, and nexus formats from
  a file or STDIN.\n\nTool homepage: https://github.com/FePhyFoFum/phyx"
inputs:
  - id: citation
    type:
      - 'null'
      - boolean
    doc: display phyx citation and exit
    inputBinding:
      position: 101
      prefix: --citation
  - id: seq_file
    type:
      - 'null'
      - File
    doc: input seq file, STDIN otherwise
    inputBinding:
      position: 101
      prefix: --seqf
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output stats file, STOUT otherwise
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyx:1.1--hc0837bd_5
