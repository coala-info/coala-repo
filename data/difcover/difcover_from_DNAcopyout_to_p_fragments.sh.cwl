cwlVersion: v1.2
class: CommandLineTool
baseCommand: from_DNAcopyout_to_p_fragments.sh
label: difcover_from_DNAcopyout_to_p_fragments.sh
doc: "Converts DNAcopy output to p fragments, filtering intervals based on enrichment
  scores.\n\nTool homepage: https://github.com/timnat/DifCover"
inputs:
  - id: dna_copy_out_files
    type:
      type: array
      items: File
    doc: 'Input files in *.DNAcopyout format. Format: scaffold fragment_start fragment_size
      number_of_windows_merged_into_fragment av(adj_coef*log2ratio).'
    inputBinding:
      position: 1
  - id: enrichment_filter_p
    type: float
    doc: Filter only intervals with |enrichment scores| > p
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/difcover:3.0.1--h9948957_2
stdout: difcover_from_DNAcopyout_to_p_fragments.sh.out
