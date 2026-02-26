cwlVersion: v1.2
class: CommandLineTool
baseCommand: peakachu window
label: peakachu_window
doc: "peakachu window\n\nTool homepage: https://github.com/tbischler/PEAKachu"
inputs:
  - id: ctr_libs
    type:
      type: array
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
    doc: Fold change cutoff for differential expression
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
    doc: Folder containing GFF files for gene annotations
    inputBinding:
      position: 101
      prefix: --gff_folder
  - id: het_p_val_threshold
    type:
      - 'null'
      - float
    doc: Heterogeneity p-value threshold
    inputBinding:
      position: 101
      prefix: --het_p_val_threshold
  - id: mad_multiplier
    type:
      - 'null'
      - float
    doc: Multiplier for Median Absolute Deviation (MAD) for outlier detection
    inputBinding:
      position: 101
      prefix: --mad_multiplier
  - id: max_insert_size
    type:
      - 'null'
      - int
    doc: Maximum insert size for paired-end reads
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
  - id: norm_method
    type:
      - 'null'
      - string
    doc: Normalization method (tmm, deseq, count, manual, none)
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
  - id: rep_pair_p_val_threshold
    type:
      - 'null'
      - float
    doc: Replicate pair p-value threshold
    inputBinding:
      position: 101
      prefix: --rep_pair_p_val_threshold
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
  - id: stat_test
    type:
      - 'null'
      - string
    doc: Statistical test to use (gtest or deseq)
    inputBinding:
      position: 101
      prefix: --stat_test
  - id: step_size
    type:
      - 'null'
      - int
    doc: Step size for the sliding window
    inputBinding:
      position: 101
      prefix: --step_size
  - id: sub_features
    type:
      - 'null'
      - type: array
        items: string
    doc: List of sub-features to consider
    inputBinding:
      position: 101
      prefix: --sub_features
  - id: window_size
    type:
      - 'null'
      - int
    doc: Size of the sliding window
    inputBinding:
      position: 101
      prefix: --window_size
outputs:
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: Output folder for results
    outputBinding:
      glob: $(inputs.output_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peakachu:0.2.0--py38h0020b31_4
