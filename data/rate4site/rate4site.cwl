cwlVersion: v1.2
class: CommandLineTool
baseCommand: rate4site
label: rate4site
doc: "Rate4Site calculates the relative evolutionary rate of each site in a multiple sequence alignment (MSA) using a maximum likelihood or an empirical Bayesian approach.\n\nTool homepage: https://www.tau.ac.il/~itaymay/cp/rate4site.html"
inputs:
  - id: seq_file
    type: File
    doc: "Input sequence alignment file (accepted formats: Fasta, Mase, Molphy, Phylip, Clustal)"
    inputBinding:
      position: 1
      prefix: "-s"
  - id: tree_file
    type:
      - 'null'
      - File
    doc: "Input tree file (Newick). If not given, a tree is built (see tree_search_algorithm)"
    inputBinding:
      position: 2
      prefix: "-t"
  - id: out_file
    type:
      - 'null'
      - string
    doc: "Output file for the normalized rates (default r4s.res)"
    inputBinding:
      position: 3
      prefix: "-o"
  - id: tree_out_file
    type:
      - 'null'
      - string
    doc: "Output tree file (default TheTree.txt)"
    inputBinding:
      position: 4
      prefix: "-x"
  - id: unnormalized_out_file
    type:
      - 'null'
      - string
    doc: "Output file for the un-normalized rates"
    inputBinding:
      position: 5
      prefix: "-y"
  - id: model
    type:
      - 'null'
      - type: enum
        symbols: ["j", "r", "d", "w", "l", "C", "a", "n", "g", "h", "t"]
    doc: "Substitution model, given as the letter after -M: j=JTT, r=REV (mitochondrial genomes), d=DAY, w=WAG, l=LG, C=cpREV (chloroplast genomes), a=JC amino acids, n=JC nucleotides, g=GTR nucleotides, h=HKY, t=Tamura92"
    inputBinding:
      position: 6
      prefix: "-M"
      separate: false
  - id: inference_method
    type:
      - 'null'
      - type: enum
        symbols: ["m", "b"]
    doc: "Rate inference method, given as the letter after -i: m=ML rate inference, b=empirical Bayesian (eb-Exp)"
    inputBinding:
      position: 7
      prefix: "-i"
      separate: false
  - id: bayesian_categories
    type:
      - 'null'
      - int
    doc: "Number of categories for Bayesian rates"
    inputBinding:
      position: 8
      prefix: "-k"
  - id: inference_categories
    type:
      - 'null'
      - int
    doc: "Number of categories for inference"
    inputBinding:
      position: 9
      prefix: "-n"
  - id: branch_optimization
    type:
      - 'null'
      - type: enum
        symbols: ["n", "h", "g", "r"]
    doc: "Branch lengths optimization, given as the letter after -b: n=no optimization, h=homogeneous model, g=gamma model, r=general gamma model (default: gamma model)"
    inputBinding:
      position: 10
      prefix: "-b"
      separate: false
  - id: reference_sequence
    type:
      - 'null'
      - string
    doc: "Reference sequence name (default: first sequence in the alignment)"
    inputBinding:
      position: 11
      prefix: "-a"
  - id: substitution_matrices_file
    type:
      - 'null'
      - File
    doc: "Input file with many substitution matrices"
    inputBinding:
      position: 12
      prefix: "-f"
  - id: matrices_attributes
    type:
      - 'null'
      - string
    doc: "Attributes for the substitution matrices file"
    inputBinding:
      position: 13
      prefix: "-p"
  - id: many_trees_file
    type:
      - 'null'
      - File
    doc: "Input file with many trees"
    inputBinding:
      position: 14
      prefix: "-c"
  - id: trees_attributes
    type:
      - 'null'
      - string
    doc: "Attributes for the tree file"
    inputBinding:
      position: 15
      prefix: "-u"
  - id: tree_search_algorithm
    type:
      - 'null'
      - type: enum
        symbols: ["j", "n", "l", "o"]
    doc: "Tree search algorithm, given as the letter after -z: j=JC, n=NJ with ML distances, l=ML tree based on many random NJ trees, o=JC with gaps counted as differences"
    inputBinding:
      position: 16
      prefix: "-z"
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: rates_file
    type:
      - 'null'
      - File
    doc: Normalized rates per site (r4s.res unless out_file is given)
    outputBinding:
      glob: $(inputs.out_file || 'r4s.res')
  - id: tree_out
    type:
      - 'null'
      - File
    doc: Output tree (TheTree.txt unless tree_out_file is given)
    outputBinding:
      glob: $(inputs.tree_out_file || 'TheTree.txt')
  - id: unnormalized_rates_file
    type:
      - 'null'
      - File
    doc: Un-normalized rates per site
    outputBinding:
      glob: $(inputs.unnormalized_out_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rate4site:v3.0.0-6-deb_cv1
stdout: rate4site_stdout.txt
