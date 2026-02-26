cwlVersion: v1.2
class: CommandLineTool
baseCommand: gubbins
label: gubbins
doc: "This program is not supposed to be directly run. Use run_gubbins.py instead\n\
  \nTool homepage: https://github.com/nickjcroucher/gubbins"
inputs:
  - id: alignment_file
    type: File
    doc: alignment_file
    inputBinding:
      position: 1
  - id: detect_recombinations_mode
    type:
      - 'null'
      - boolean
    doc: detect recombinations mode
    inputBinding:
      position: 102
      prefix: -r
  - id: max_window_size
    type:
      - 'null'
      - int
    doc: Max window size
    inputBinding:
      position: 102
      prefix: -b
  - id: min_snps_recombination
    type:
      - 'null'
      - int
    doc: Min SNPs for identifying a recombination block
    inputBinding:
      position: 102
      prefix: -m
  - id: min_window_size
    type:
      - 'null'
      - int
    doc: Min window size
    inputBinding:
      position: 102
      prefix: -a
  - id: newick_tree_file
    type:
      - 'null'
      - File
    doc: Newick tree file
    inputBinding:
      position: 102
      prefix: -t
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for recombination detection
    inputBinding:
      position: 102
      prefix: -n
  - id: original_multifasta_file
    type:
      - 'null'
      - File
    doc: Original Multifasta file
    inputBinding:
      position: 102
      prefix: -f
  - id: p_value_ratio_trimming
    type:
      - 'null'
      - float
    doc: p value ratio for trimming recombinations
    inputBinding:
      position: 102
      prefix: -i
  - id: p_value_recombinations
    type:
      - 'null'
      - float
    doc: p value for detecting recombinations
    inputBinding:
      position: 102
      prefix: -p
  - id: scale_branch_lengths_no_invariant
    type:
      - 'null'
      - boolean
    doc: scale branch lengths without correcting for invariant sites
    inputBinding:
      position: 102
      prefix: -s
  - id: vcf_file
    type:
      - 'null'
      - File
    doc: VCF file
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gubbins:3.4.3--py39h746d604_0
stdout: gubbins.out
