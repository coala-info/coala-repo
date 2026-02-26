cwlVersion: v1.2
class: CommandLineTool
baseCommand: augur_mask
label: augur_mask
doc: "Mask specified sites from a VCF or FASTA file.\n\nTool homepage: https://github.com/nextstrain/augur"
inputs:
  - id: mask_file
    type:
      - 'null'
      - File
    doc: locations to be masked in either BED file format, DRM format, or one 
      1-indexed site per line.
    inputBinding:
      position: 101
      prefix: --mask
  - id: mask_from_beginning
    type:
      - 'null'
      - int
    doc: 'FASTA Only: Number of sites to mask from beginning'
    default: 0
    inputBinding:
      position: 101
      prefix: --mask-from-beginning
  - id: mask_from_end
    type:
      - 'null'
      - int
    doc: 'FASTA Only: Number of sites to mask from end'
    default: 0
    inputBinding:
      position: 101
      prefix: --mask-from-end
  - id: mask_invalid
    type:
      - 'null'
      - boolean
    doc: 'FASTA Only: Mask invalid nucleotides'
    default: false
    inputBinding:
      position: 101
      prefix: --mask-invalid
  - id: mask_sites
    type:
      - 'null'
      - type: array
        items: int
    doc: 1-indexed list of sites to mask
    inputBinding:
      position: 101
      prefix: --mask-sites
  - id: no_cleanup
    type:
      - 'null'
      - boolean
    doc: Leave intermediate files around. May be useful for debugging
    default: true
    inputBinding:
      position: 101
      prefix: --no-cleanup
  - id: sequences
    type: File
    doc: sequences in VCF or FASTA format
    inputBinding:
      position: 101
      prefix: --sequences
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
