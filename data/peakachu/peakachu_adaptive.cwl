cwlVersion: v1.2
class: CommandLineTool
baseCommand: peakachu adaptive
label: peakachu_adaptive
doc: "Adaptive peak calling for ChIP-seq data.\n\nTool homepage: https://github.com/tbischler/PEAKachu"
inputs:
  - id: blockbuster_path
    type:
      - 'null'
      - File
    doc: Location of blockbuster executable. Per default required to be on the 
      $PATH.
    inputBinding:
      position: 101
      prefix: --blockbuster_path
  - id: ctr_libs
    type:
      - 'null'
      - type: array
        items: File
    doc: Control libraries
    inputBinding:
      position: 101
      prefix: --ctr_libs
  - id: exp_libs
    type:
      type: array
      items: File
    doc: Experimental libraries
    inputBinding:
      position: 101
      prefix: --exp_libs
  - id: fc_cutoff
    type:
      - 'null'
      - float
    doc: Fold change cutoff
    inputBinding:
      position: 101
      prefix: --fc_cutoff
  - id: features
    type:
      - 'null'
      - type: array
        items: string
    doc: List of features to consider
    inputBinding:
      position: 101
      prefix: --features
  - id: gff_folder
    type:
      - 'null'
      - Directory
    doc: Folder containing GFF files
    inputBinding:
      position: 101
      prefix: --gff_folder
  - id: mad_multiplier
    type:
      - 'null'
      - float
    doc: Median Absolute Deviation multiplier
    inputBinding:
      position: 101
      prefix: --mad_multiplier
  - id: max_insert_size
    type:
      - 'null'
      - int
    doc: Maximum insert size
    inputBinding:
      position: 101
      prefix: --max_insert_size
  - id: max_proc
    type:
      - 'null'
      - int
    doc: Maximum number of processes to use
    inputBinding:
      position: 101
      prefix: --max_proc
  - id: min_block_overlap
    type:
      - 'null'
      - float
    doc: Minimum fraction of the width of the current maximum block that has to 
      overlap with a subblock to consider it for peak merging
    inputBinding:
      position: 101
      prefix: --min_block_overlap
  - id: min_cluster_expr_frac
    type:
      - 'null'
      - float
    doc: Minimum fraction of the blockbuster cluster expression that a maximum 
      block needs to have for further consideration
    inputBinding:
      position: 101
      prefix: --min_cluster_expr_frac
  - id: min_max_block_expr_frac
    type:
      - 'null'
      - float
    doc: Minimum fraction of the expression of the current maximum block that a 
      subblock needs to have to consider it for peak merging
    inputBinding:
      position: 101
      prefix: --min_max_block_expr_frac
  - id: norm_method
    type:
      - 'null'
      - string
    doc: Normalization method (deseq, manual, none)
    inputBinding:
      position: 101
      prefix: --norm_method
  - id: padj_threshold
    type:
      - 'null'
      - float
    doc: Adjusted p-value threshold
    inputBinding:
      position: 101
      prefix: --padj_threshold
  - id: paired_end
    type:
      - 'null'
      - boolean
    doc: Paired-end sequencing data
    inputBinding:
      position: 101
      prefix: --paired_end
  - id: pairwise_replicates
    type:
      - 'null'
      - boolean
    doc: Perform pairwise comparisons between replicates
    inputBinding:
      position: 101
      prefix: --pairwise_replicates
  - id: size_factors
    type:
      - 'null'
      - type: array
        items: float
    doc: Normalization factors for libraries in input order (first experiment 
      then control libraries)
    inputBinding:
      position: 101
      prefix: --size_factors
  - id: sub_features
    type:
      - 'null'
      - type: array
        items: string
    doc: List of sub-features to consider
    inputBinding:
      position: 101
      prefix: --sub_features
outputs:
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: Output folder
    outputBinding:
      glob: $(inputs.output_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peakachu:0.2.0--py38h0020b31_4
