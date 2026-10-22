cwlVersion: v1.2
class: CommandLineTool
baseCommand: tgsseqgen
label: tgsgapcloser_tgsseqgen
doc: "Generate the final scaffold sequences from the updated scaffold infos (last step of TGS-GapCloser).\n\nTool homepage: https://github.com/BGI-Qingdao/TGS-GapCloser"
inputs:
  - id: prefix
    type: string
    doc: prefix of files
    inputBinding:
      position: 101
      prefix: --prefix
  - id: contig
    type: File
    doc: xxx.contig from tgsseqsplit (staged as prefix.contig)
  - id: updated_scaff_infos
    type: File
    doc: xxx.updated_scaff_infos from tgsgapcloser (staged as prefix.updated_scaff_infos)
  - id: name_map
    type: File
    doc: xxx.name_map from tgsseqsplit (staged as prefix.name_map)
outputs:
  - id: scaff_seqs
    type: File
    doc: final scaffold sequences with gaps filled
    outputBinding:
      glob: $(inputs.prefix).scaff_seqs
  - id: fill_detail
    type: File
    doc: details of the filled gaps (written as prefix.gap_fill_detail)
    outputBinding:
      glob: $(inputs.prefix).*fill_detail
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.prefix).contig
        entry: $(inputs.contig)
      - entryname: $(inputs.prefix).updated_scaff_infos
        entry: $(inputs.updated_scaff_infos)
      - entryname: $(inputs.prefix).name_map
        entry: $(inputs.name_map)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tgsgapcloser:1.2.1--h6f25541_3
