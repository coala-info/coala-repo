cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rdp-alignment
  - align-nucl-to-prot
label: rdp-alignment_align-nucl-to-prot
doc: "Transfer a sequence alignment from protein sequences to the matching nucleotide sequences (AlignNucleotideToProtein).

Tool homepage: https://github.com/rdpstaff/Alignment"
inputs:
  - id: aligned_prot_seqs
    type: File
    doc: "Aligned protein sequences"
    inputBinding:
      position: 1
  - id: unaligned_nucl_seqs
    type: File
    doc: "Unaligned nucleotide sequences"
    inputBinding:
      position: 2
  - id: aligned_nucl_out
    type: string
    doc: "Output file for the aligned nucleotide sequences"
    inputBinding:
      position: 3
  - id: stats_out
    type: string
    doc: "Output file for the alignment statistics"
    inputBinding:
      position: 4
outputs:
  - id: aligned_nucl
    type:
      - 'null'
      - File
    doc: "Aligned nucleotide sequences"
    outputBinding:
      glob: $(inputs.aligned_nucl_out)
  - id: stats
    type:
      - 'null'
      - File
    doc: "Alignment statistics"
    outputBinding:
      glob: $(inputs.stats_out)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rdp-alignment:v1.2.0-5-deb_cv1
