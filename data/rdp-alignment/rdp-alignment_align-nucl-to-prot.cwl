cwlVersion: v1.2
class: CommandLineTool
baseCommand: AlignNucleotideToProtein
label: rdp-alignment_align-nucl-to-prot
doc: "Aligns nucleotide sequences to a protein alignment.\n\nTool homepage: https://github.com/AlbertoMartinPerez/Sequence_Analyzer_automations"
inputs:
  - id: aligned_prot_seqs
    type: File
    doc: Input file containing aligned protein sequences.
    inputBinding:
      position: 1
  - id: unaligned_nucl_seqs
    type: File
    doc: Input file containing unaligned nucleotide sequences.
    inputBinding:
      position: 2
outputs:
  - id: aligned_nucl_out
    type: File
    doc: Output file for aligned nucleotide sequences.
    outputBinding:
      glob: '*.out'
  - id: stats_out
    type: File
    doc: Output file for alignment statistics.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rdp-alignment:v1.2.0-5-deb_cv1
