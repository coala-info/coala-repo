cwlVersion: v1.2
class: CommandLineTool
baseCommand: panaroo-merge
label: panaroo_merge
doc: "Merge independent runs of Panaroo into one pangenome graph.

Tool homepage: https://gtonkinhill.github.io/panaroo"
inputs:
  - id: directories
    type:
      type: array
      items: Directory
    doc: "Separate Panaroo output directories to merge."
    inputBinding:
      prefix: --directories
  - id: out_dir
    type: string
    doc: "Location of a new output directory."
    inputBinding:
      prefix: --out_dir
  - id: threshold
    type:
      - 'null'
      - float
    doc: "Sequence identity threshold."
    inputBinding:
      prefix: --threshold
  - id: family_threshold
    type:
      - 'null'
      - float
    doc: "Protein family sequence identity threshold (default 0.7)."
    inputBinding:
      prefix: --family_threshold
  - id: len_dif_percent
    type:
      - 'null'
      - float
    doc: "Length difference cutoff."
    inputBinding:
      prefix: --len_dif_percent
  - id: family_len_dif_percent
    type:
      - 'null'
      - float
    doc: "Length difference cutoff at the gene family level (default 0.0)."
    inputBinding:
      prefix: --family_len_dif_percent
  - id: merge_paralogs
    type:
      - 'null'
      - boolean
    doc: "Do not split paralogs."
    inputBinding:
      prefix: --merge_paralogs
  - id: length_outlier_support_proportion
    type:
      - 'null'
      - float
    doc: "Proportion of genomes supporting a gene with a length more than 1.5x outside the interquartile range for genes in the same cluster (default 0.01). Genes failing this test are re-annotated at the shorter length."
    inputBinding:
      prefix: --length_outlier_support_proportion
  - id: min_edge_support_sv
    type:
      - 'null'
      - int
    doc: "Minimum edge support required to call structural variants in the presence/absence sv file (default max(2, 0.01*n_samples))."
    inputBinding:
      prefix: --min_edge_support_sv
  - id: alignment
    type:
      - 'null'
      - string
    doc: "Output alignments of core genes or all genes: 'core' or 'pan'. Default: none."
    inputBinding:
      prefix: --alignment
  - id: aligner
    type:
      - 'null'
      - string
    doc: "Aligner to use: 'prank', 'clustal' or 'mafft' (default 'mafft')."
    inputBinding:
      prefix: --aligner
  - id: codons
    type:
      - 'null'
      - boolean
    doc: "Generate codon alignments by aligning sequences at the protein level."
    inputBinding:
      prefix: --codons
  - id: core_threshold
    type:
      - 'null'
      - float
    doc: "Core-genome sample threshold (default 0.95)."
    inputBinding:
      prefix: --core_threshold
  - id: core_subset
    type:
      - 'null'
      - int
    doc: "Randomly subset the core genome to this many genes (default all)."
    inputBinding:
      prefix: --core_subset
  - id: core_entropy_filter
    type:
      - 'null'
      - float
    doc: "Manually set the Block Mapping and Gathering with Entropy (BMGE) filter, between 0.0 and 1.0. Default: Tukey outlier method."
    inputBinding:
      prefix: --core_entropy_filter
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use (default 1)."
    inputBinding:
      prefix: --threads
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Suppress additional output."
    inputBinding:
      prefix: --quiet
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: "Output directory with the merged pangenome."
    outputBinding:
      glob: $(inputs.out_dir)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panaroo:1.6.0--pyhdfd78af_0
stdout: panaroo_merge.out
