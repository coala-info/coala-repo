cwlVersion: v1.2
class: CommandLineTool
baseCommand: tgsseqsplit
label: tgsgapcloser_tgsseqsplit
doc: "Split scaffolds into contigs at gaps (step 1 of TGS-GapCloser).\n\nTool homepage: https://github.com/BGI-Qingdao/TGS-GapCloser"
inputs:
  - id: input_scaff
    type: File
    doc: the input scaffold fasta file
    inputBinding:
      position: 101
      prefix: --input_scaff
  - id: prefix
    type: string
    doc: the prefix of output files
    inputBinding:
      position: 101
      prefix: --prefix
outputs:
  - id: contig
    type: File
    doc: scaffold pieces (contigs) split at gaps
    outputBinding:
      glob: $(inputs.prefix).contig
  - id: orignial_scaff_infos
    type: File
    doc: original scaffold structure (contig order, orientation and gaps)
    outputBinding:
      glob: $(inputs.prefix).orignial_scaff_infos
  - id: name_map
    type: File
    doc: map from scaffold index to scaffold name
    outputBinding:
      glob: $(inputs.prefix).name_map
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tgsgapcloser:1.2.1--h6f25541_3
