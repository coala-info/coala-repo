cwlVersion: v1.2
class: CommandLineTool
baseCommand: harvesttools
label: harvesttools
doc: "harvesttools version 1.3 options:\n\nTool homepage: https://github.com/marbl/harvest-tools"
inputs:
  - id: bed_filter
    type:
      - 'null'
      - string
    doc: bed filter intervals,filter name,"description"
    inputBinding:
      position: 101
      prefix: -b
  - id: gingr_input
    type:
      - 'null'
      - File
    doc: Gingr input
    inputBinding:
      position: 101
      prefix: -i
  - id: gingr_output
    type:
      - 'null'
      - File
    doc: Gingr output
    inputBinding:
      position: 101
      prefix: -o
  - id: internal_tracks_diff
    type:
      - 'null'
      - string
    doc: only variants that differ among tracks listed
    inputBinding:
      position: 101
      prefix: --internal
  - id: internal_tracks_lca_diff
    type:
      - 'null'
      - string
    doc: only variants that differ within LCA clade of <track1> and <track2>
    inputBinding:
      position: 101
      prefix: --internal
  - id: maf_alignment_input
    type:
      - 'null'
      - File
    doc: MAF alignment input
    inputBinding:
      position: 101
      prefix: -a
  - id: midpoint_reroot
    type:
      - 'null'
      - boolean
    doc: reroot the tree at its midpoint after loading
    inputBinding:
      position: 101
      prefix: --midpoint-reroot
  - id: multi_fasta_alignment_input
    type:
      - 'null'
      - File
    doc: multi-fasta alignment input
    inputBinding:
      position: 101
      prefix: -m
  - id: multi_fasta_alignment_output_concatenated_lcbs
    type:
      - 'null'
      - File
    doc: multi-fasta alignment output (concatenated LCBs)
    inputBinding:
      position: 101
      prefix: -M
  - id: multi_fasta_alignment_output_concatenated_lcbs_minus_filtered_snps
    type:
      - 'null'
      - File
    doc: multi-fasta alignment output (concatenated LCBs minus filtered SNPs)
    inputBinding:
      position: 101
      prefix: -I
  - id: newick_tree_input
    type:
      - 'null'
      - File
    doc: Newick tree input
    inputBinding:
      position: 101
      prefix: -n
  - id: newick_tree_output
    type:
      - 'null'
      - File
    doc: Newick tree output
    inputBinding:
      position: 101
      prefix: -N
  - id: output_backbone_intervals
    type:
      - 'null'
      - File
    doc: output backbone intervals
    inputBinding:
      position: 101
      prefix: -B
  - id: output_multi_fasta_snps
    type:
      - 'null'
      - File
    doc: output for multi-fasta SNPs
    inputBinding:
      position: 101
      prefix: -S
  - id: output_xmfa_alignment_file
    type:
      - 'null'
      - File
    doc: output xmfa alignment file
    inputBinding:
      position: 101
      prefix: -X
  - id: quiet_mode
    type:
      - 'null'
      - boolean
    doc: quiet mode
    inputBinding:
      position: 101
      prefix: -q
  - id: reference_fasta
    type:
      - 'null'
      - File
    doc: reference fasta
    inputBinding:
      position: 101
      prefix: -f
  - id: reference_fasta_out
    type:
      - 'null'
      - File
    doc: reference fasta out
    inputBinding:
      position: 101
      prefix: -F
  - id: reference_genbank
    type:
      - 'null'
      - File
    doc: reference genbank
    inputBinding:
      position: 101
      prefix: -g
  - id: signature_tracks
    type:
      - 'null'
      - string
    doc: only signature variants of tracks listed
    inputBinding:
      position: 101
      prefix: --signature
  - id: signature_tracks_lca
    type:
      - 'null'
      - string
    doc: only signature variants of LCA clade of <track1> and <track2>
    inputBinding:
      position: 101
      prefix: --signature
  - id: update_branch_values
    type:
      - 'null'
      - boolean
    doc: update the branch values to reflect genome length
    inputBinding:
      position: 101
      prefix: -u
  - id: vcf_input
    type:
      - 'null'
      - File
    doc: VCF input
    inputBinding:
      position: 101
      prefix: -v
  - id: vcf_output
    type:
      - 'null'
      - File
    doc: VCF output
    inputBinding:
      position: 101
      prefix: -V
  - id: xmfa_alignment_file
    type:
      - 'null'
      - File
    doc: xmfa alignment file
    inputBinding:
      position: 101
      prefix: -x
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/harvesttools:1.3--ha9fde67_0
stdout: harvesttools.out
