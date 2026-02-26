cwlVersion: v1.2
class: CommandLineTool
baseCommand: phertilizer
label: phertilizer
doc: "Phertilizer is a tool for inferring clonal evolution and copy number alterations
  from single-cell sequencing data.\n\nTool homepage: https://github.com/elkebir-group/phertilizer"
inputs:
  - id: alpha
    type:
      - 'null'
      - float
    doc: per base read error rate
    inputBinding:
      position: 101
      prefix: --alpha
  - id: bin_count_data
    type: File
    doc: input binned read counts with headers containing bin ids
    inputBinding:
      position: 101
      prefix: --bin_count_data
  - id: bin_count_normal
    type:
      - 'null'
      - File
    doc: input binned read counts for normal cells with identical bins as the 
      bin count data
    inputBinding:
      position: 101
      prefix: --bin_count_normal
  - id: copies
    type:
      - 'null'
      - int
    doc: max number of copies
    inputBinding:
      position: 101
      prefix: --copies
  - id: input_file
    type: File
    doc: 'input file for variant and total read counts with unlabled columns: [chr
      snv cell base var total]'
    inputBinding:
      position: 101
      prefix: --file
  - id: iterations
    type:
      - 'null'
      - int
    doc: maximum number of iterations
    inputBinding:
      position: 101
      prefix: --iterations
  - id: min_cells
    type:
      - 'null'
      - int
    doc: smallest number of cells required to form a clone
    inputBinding:
      position: 101
      prefix: --min_cells
  - id: min_frac
    type:
      - 'null'
      - float
    doc: smallest proportion of total cells(snvs) needed to form a cluster, if 
      min_cells or min_snvs are given, min_frac is ignored
    inputBinding:
      position: 101
      prefix: --min_frac
  - id: min_snvs
    type:
      - 'null'
      - int
    doc: smallest number of SNVs required to form a cluster
    inputBinding:
      position: 101
      prefix: --min_snvs
  - id: neutral_eps
    type:
      - 'null'
      - float
    doc: cutoff of neutral RDR distribution
    inputBinding:
      position: 101
      prefix: --neutral_eps
  - id: neutral_mean
    type:
      - 'null'
      - float
    doc: center of neutral RDR distribution
    inputBinding:
      position: 101
      prefix: --neutral_mean
  - id: npass
    type:
      - 'null'
      - int
    doc: npass
    inputBinding:
      position: 101
      prefix: --npass
  - id: radius
    type:
      - 'null'
      - float
    doc: radius
    inputBinding:
      position: 101
      prefix: --radius
  - id: seed
    type:
      - 'null'
      - int
    doc: seed
    inputBinding:
      position: 101
      prefix: --seed
  - id: snv_bin_mapping
    type:
      - 'null'
      - File
    doc: 'a comma delimited file with unlabeled columns: [snv chr bin]'
    inputBinding:
      position: 101
      prefix: --snv_bin_mapping
  - id: starts
    type:
      - 'null'
      - int
    doc: number of restarts
    inputBinding:
      position: 101
      prefix: --starts
outputs:
  - id: pred_mut
    type:
      - 'null'
      - File
    doc: output file for mutation clusters
    outputBinding:
      glob: $(inputs.pred_mut)
  - id: pred_cell
    type:
      - 'null'
      - File
    doc: output file cell clusters
    outputBinding:
      glob: $(inputs.pred_cell)
  - id: pred_event
    type:
      - 'null'
      - File
    doc: output file cna genotypes
    outputBinding:
      glob: $(inputs.pred_event)
  - id: tree
    type:
      - 'null'
      - File
    doc: output file for png (dot) of Phertilizer tree
    outputBinding:
      glob: $(inputs.tree)
  - id: tree_pickle
    type:
      - 'null'
      - File
    doc: output pickle of Phertilizer tree
    outputBinding:
      glob: $(inputs.tree_pickle)
  - id: tree_path
    type:
      - 'null'
      - Directory
    doc: path to directory where pngs of all trees are saved
    outputBinding:
      glob: $(inputs.tree_path)
  - id: tree_list
    type:
      - 'null'
      - File
    doc: pickle file to save a ClonalTreeList of all generated trees
    outputBinding:
      glob: $(inputs.tree_list)
  - id: cell_lookup
    type:
      - 'null'
      - File
    doc: output file that maps internal cell index to the input cell label
    outputBinding:
      glob: $(inputs.cell_lookup)
  - id: mut_lookup
    type:
      - 'null'
      - File
    doc: output file that maps internal mutation index to the input mutation 
      label
    outputBinding:
      glob: $(inputs.mut_lookup)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phertilizer:0.1.0--pyhdfd78af_0
