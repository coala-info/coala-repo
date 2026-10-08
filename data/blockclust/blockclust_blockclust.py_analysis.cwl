cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - blockclust.py
label: blockclust_blockclust.py_analysis
doc: "BlockClust analysis mode (-m ANALYSIS): clustering and/or classification of
  blockgroups (blockbuster output) into non-coding RNA classes\n\nTool homepage: https://github.com/pavanvidem/blockclust"
arguments:
  - position: 100
    prefix: --mode
    valueFrom: ANALYSIS
inputs:
  - id: test_input
    type: File
    doc: Output of preprocessing mode as input (blockgroups from blockbuster)
    inputBinding:
      position: 101
      prefix: --test_input
  - id: accept_annotations
    type: File
    doc: Annotations of known ncRNAs in BED format (e.g. 
      share/blockclust_data/hg19/hg19.accept.bed)
    inputBinding:
      position: 101
      prefix: --accept
  - id: reject_annotations
    type: File
    doc: Annotations of other known transcripts (eg. protein coding) in BED 
      format (e.g. share/blockclust_data/hg19/hg19.reject.bed)
    inputBinding:
      position: 101
      prefix: --reject
  - id: config_file
    type:
      - 'null'
      - File
    doc: 'blockClust configuration file. (default: 
      /usr/local/share/blockclust_data/blockclust.config)'
    inputBinding:
      position: 101
      prefix: --config
  - id: classify
    type:
      - 'null'
      - boolean
    doc: Classify the input blockgroups
    inputBinding:
      position: 101
      prefix: --classify
  - id: clmode
    type:
      - 'null'
      - type: enum
        symbols:
          - NEAREST
          - MODEL
    doc: 'Type of classification: MODEL = Model based classification, NEAREST = 
      Nearest neighbour classification (default: MODEL)'
    inputBinding:
      position: 101
      prefix: --clmode
  - id: model_dir
    type:
      - 'null'
      - Directory
    doc: 'Directory containing trained models for classification (default: 
      /usr/local/share/blockclust_data/models)'
    inputBinding:
      position: 101
      prefix: --model_dir
  - id: no_chr
    type:
      - 'null'
      - boolean
    doc: Input blockgroups do not contain 'chr' in the begining of chromosome 
      ids (for eg. Ensembl database do not use 'chr').
    inputBinding:
      position: 101
      prefix: --no_chr
  - id: output_dir_path
    type: string
    doc: Output directory path for the whole analysis
    inputBinding:
      position: 102
      prefix: --out
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory of the whole analysis
    outputBinding:
      glob: $(inputs.output_dir_path)
  - id: clusters_bed
    type: File
    doc: BED of predicted clusters (mcl_clusters/all_clusters.bed)
    outputBinding:
      glob: $(inputs.output_dir_path)/mcl_clusters/all_clusters.bed
  - id: sim_tab
    type: File
    doc: Tabular file of pairwise blockgroup similarities (discretized.gspan.tab)
    outputBinding:
      glob: $(inputs.output_dir_path)/discretized.gspan.tab
  - id: hclust_plot
    type:
      - 'null'
      - File
    doc: Hierarchical clustering plot (hclust_tree.pdf)
    outputBinding:
      glob: $(inputs.output_dir_path)/hclust_tree.pdf
  - id: model_based_predictions
    type:
      - 'null'
      - File
    doc: Model based predictions BED (with --classify --clmode MODEL)
    outputBinding:
      glob: $(inputs.output_dir_path)/model_based_predictions.txt
  - id: nearest_neighbour_predictions
    type:
      - 'null'
      - File
    doc: Nearest neighbour predictions BED (with --classify --clmode NEAREST)
    outputBinding:
      glob: $(inputs.output_dir_path)/nearest_neighbour_predictions.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blockclust:1.1.1--py311r43h2a4ad6c_1
