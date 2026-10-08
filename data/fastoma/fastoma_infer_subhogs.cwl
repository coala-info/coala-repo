cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastoma-infer-subhogs
label: fastoma_infer_subhogs
doc: "Infer the sub-hierarchical orthologous groups (subHOGs) inside each rootHOG, using multiple sequence alignment, gene trees and the species tree.\n\nTool homepage: https://github.com/DessimozLab/FastOMA"
inputs:
  - id: input_rhog_folder
    type: Directory
    doc: Path to the input rootHOG folder.
    inputBinding:
      position: 1
      prefix: --input-rhog-folder
  - id: species_tree
    type: File
    doc: Path to the input species tree file in newick format
    inputBinding:
      position: 2
      prefix: --species-tree
  - id: output_pickles
    type: string
    doc: "Path to the output folder (default: pickle_hogs)"
    inputBinding:
      position: 3
      prefix: --output-pickles
  - id: parallel
    type:
      - 'null'
      - boolean
    doc: "Use concurrent parallel per rootHOG (default: False)"
    inputBinding:
      position: 4
      prefix: --parallel
  - id: threshold_dubious_sd
    type:
      - 'null'
      - float
    doc: "Threshold to remove proteins in a gene tree due to low species overlap score, not enough evidence for duplication event. (default: 0.1)"
    inputBinding:
      position: 5
      prefix: --threshold-dubious-sd
  - id: number_of_samples_per_hog
    type:
      - 'null'
      - int
    doc: "Number of representatives (sequences) per HOG. (default: 5)"
    inputBinding:
      position: 6
      prefix: --number-of-samples-per-hog
  - id: overlap_fragments
    type:
      - 'null'
      - float
    doc: "Threshold overlap between two sequences (rows) in MSA to decide whether they are fragments of a gene. (default: 0.15)"
    inputBinding:
      position: 7
      prefix: --overlap-fragments
  - id: gene_rooting_method
    type:
      - 'null'
      - string
    doc: "The method used for rooting of gene tree: midpoint, mad, Nevers_rooting (default: midpoint)"
    inputBinding:
      position: 8
      prefix: --gene-rooting-method
  - id: gene_trees_write
    type:
      - 'null'
      - boolean
    doc: "Write all gene trees (default: False)"
    inputBinding:
      position: 9
      prefix: --gene-trees-write
  - id: msa_write
    type:
      - 'null'
      - boolean
    doc: "Write the raw MSAs (default: False)"
    inputBinding:
      position: 10
      prefix: --msa-write
  - id: msa_filter_method
    type:
      - 'null'
      - type: enum
        symbols:
          - col-row-threshold
          - col-elbow-row-threshold
          - trimal
    doc: "The method used for filtering MSAs (default: col-row-threshold)"
    inputBinding:
      position: 11
      prefix: --msa-filter-method
  - id: gap_ratio_row
    type:
      - 'null'
      - float
    doc: "For trimming the MSA, the threshold of ratio of gaps for each row. (default: 0.3)"
    inputBinding:
      position: 12
      prefix: --gap-ratio-row
  - id: gap_ratio_col
    type:
      - 'null'
      - float
    doc: "For trimming the MSA, the threshold of ratio of gaps for each column. (default: 0.5)"
    inputBinding:
      position: 13
      prefix: --gap-ratio-col
  - id: min_col_trim
    type:
      - 'null'
      - int
    doc: "Minimum number of columns in the MSA to consider for filtering (default: 50)"
    inputBinding:
      position: 14
      prefix: --min-col-trim
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Increase verbosity to info/debug"
    inputBinding:
      position: 15
      prefix: -v
outputs:
  - id: pickle_folder
    type:
      - 'null'
      - Directory
    doc: Folder with the pickled HOGs.
    outputBinding:
      glob: $(inputs.output_pickles)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastoma:0.5.1--pyhdfd78af_0
stdout: fastoma_infer_subhogs.out
