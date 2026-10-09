cwlVersion: v1.2
class: CommandLineTool
baseCommand: harvesttools
label: harvesttools
doc: "HarvestTools converts between Gingr files and standard text formats (VCF, multi-fasta
  alignments, MAF, XMFA, Newick trees, FASTA, GenBank) and filters and re-roots the
  data stored in a Gingr file.\n\nTool homepage: https://github.com/marbl/harvest-tools"
inputs:
  - id: gingr_input
    type:
      - 'null'
      - File
    doc: Gingr input
    inputBinding:
      position: 101
      prefix: -i
  - id: bed_filter_file
    type:
      - 'null'
      - File
    doc: BED file with the filter intervals (part of the -b option)
  - id: bed_filter_name
    type:
      - 'null'
      - string
    doc: Name of the filter (part of the -b option; required with bed_filter_file)
  - id: bed_filter_description
    type:
      - 'null'
      - string
    doc: Description of the filter (part of the -b option)
  - id: reference_fasta
    type:
      - 'null'
      - File
    doc: reference fasta
    inputBinding:
      position: 101
      prefix: -f
  - id: reference_genbank
    type:
      - 'null'
      - File
    doc: reference genbank
    inputBinding:
      position: 101
      prefix: -g
  - id: maf_alignment_input
    type:
      - 'null'
      - File
    doc: MAF alignment input
    inputBinding:
      position: 101
      prefix: -a
  - id: multi_fasta_alignment_input
    type:
      - 'null'
      - File
    doc: multi-fasta alignment input
    inputBinding:
      position: 101
      prefix: -m
  - id: newick_tree_input
    type:
      - 'null'
      - File
    doc: Newick tree input
    inputBinding:
      position: 101
      prefix: -n
  - id: midpoint_reroot
    type:
      - 'null'
      - boolean
    doc: reroot the tree at its midpoint after loading
    inputBinding:
      position: 101
      prefix: --midpoint-reroot
  - id: update_branch_values
    type:
      - 'null'
      - int
    doc: update the branch values to reflect genome length (0/1)
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
  - id: xmfa_alignment_file
    type:
      - 'null'
      - File
    doc: xmfa alignment file
    inputBinding:
      position: 101
      prefix: -x
  - id: internal
    type:
      - 'null'
      - string
    doc: 'only variants that differ among tracks listed (track1,track2,...), or only variants that differ within the LCA clade of track1:track2'
    inputBinding:
      position: 101
      prefix: --internal
  - id: signature
    type:
      - 'null'
      - string
    doc: 'only signature variants of tracks listed (track1,track2,...), or of the LCA clade of track1:track2'
    inputBinding:
      position: 101
      prefix: --signature
  - id: quiet_mode
    type:
      - 'null'
      - boolean
    doc: quiet mode
    inputBinding:
      position: 101
      prefix: -q
  - id: gingr_output
    type:
      - 'null'
      - string
    doc: Gingr output file name
    inputBinding:
      position: 101
      prefix: -o
  - id: output_backbone_intervals
    type:
      - 'null'
      - string
    doc: output backbone intervals file name
    inputBinding:
      position: 101
      prefix: -B
  - id: reference_fasta_out
    type:
      - 'null'
      - string
    doc: reference fasta output file name
    inputBinding:
      position: 101
      prefix: -F
  - id: multi_fasta_alignment_output_concatenated_lcbs
    type:
      - 'null'
      - string
    doc: multi-fasta alignment output file name (concatenated LCBs)
    inputBinding:
      position: 101
      prefix: -M
  - id: multi_fasta_alignment_output_concatenated_lcbs_minus_filtered_snps
    type:
      - 'null'
      - string
    doc: multi-fasta alignment output file name (concatenated LCBs minus filtered SNPs)
    inputBinding:
      position: 101
      prefix: -I
  - id: newick_tree_output
    type:
      - 'null'
      - string
    doc: Newick tree output file name
    inputBinding:
      position: 101
      prefix: -N
  - id: output_multi_fasta_snps
    type:
      - 'null'
      - string
    doc: output file name for multi-fasta SNPs
    inputBinding:
      position: 101
      prefix: -S
  - id: vcf_output
    type:
      - 'null'
      - string
    doc: VCF output file name
    inputBinding:
      position: 101
      prefix: -V
  - id: output_xmfa_alignment_file
    type:
      - 'null'
      - string
    doc: output xmfa alignment file name
    inputBinding:
      position: 101
      prefix: -X
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: gingr_output_out
    type:
      - 'null'
      - File
    doc: Gingr output
    outputBinding:
      glob: $(inputs.gingr_output)
  - id: output_backbone_intervals_out
    type:
      - 'null'
      - File
    doc: output backbone intervals
    outputBinding:
      glob: $(inputs.output_backbone_intervals)
  - id: reference_fasta_out_out
    type:
      - 'null'
      - File
    doc: reference fasta output
    outputBinding:
      glob: $(inputs.reference_fasta_out)
  - id: multi_fasta_alignment_output_concatenated_lcbs_out
    type:
      - 'null'
      - File
    doc: multi-fasta alignment output (concatenated LCBs)
    outputBinding:
      glob: $(inputs.multi_fasta_alignment_output_concatenated_lcbs)
  - id: multi_fasta_alignment_output_concatenated_lcbs_minus_filtered_snps_out
    type:
      - 'null'
      - File
    doc: multi-fasta alignment output (concatenated LCBs minus filtered SNPs)
    outputBinding:
      glob: $(inputs.multi_fasta_alignment_output_concatenated_lcbs_minus_filtered_snps)
  - id: newick_tree_output_out
    type:
      - 'null'
      - File
    doc: Newick tree output
    outputBinding:
      glob: $(inputs.newick_tree_output)
  - id: output_multi_fasta_snps_out
    type:
      - 'null'
      - File
    doc: multi-fasta SNPs output
    outputBinding:
      glob: $(inputs.output_multi_fasta_snps)
  - id: vcf_output_out
    type:
      - 'null'
      - File
    doc: VCF output
    outputBinding:
      glob: $(inputs.vcf_output)
  - id: output_xmfa_alignment_file_out
    type:
      - 'null'
      - File
    doc: xmfa alignment output
    outputBinding:
      glob: $(inputs.output_xmfa_alignment_file)
arguments:
  - prefix: -b
    position: 101
    valueFrom: "$(inputs.bed_filter_file ? inputs.bed_filter_file.path + ',' + inputs.bed_filter_name + ',' + (inputs.bed_filter_description || '') : null)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/harvesttools:1.3--ha9fde67_0
stdout: harvesttools.out
