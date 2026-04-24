cwlVersion: v1.2
class: CommandLineTool
baseCommand: pgscatalog-ancestry-adjust
label: pgscatalog.calc_pgscatalog-ancestry-adjust
doc: "Program to analyze ancestry outputs of the pgscatalog/pgsc_calc pipeline. Current
  inputs: \n  - PCA projections from reference and target datasets (*.pcs) \n  - calculated
  polygenic scores (e.g. aggregated_scores.txt.gz), \n  - information about related
  samples in the reference dataset (e.g. deg2_hg38.king.cutoff.out.id).\n\nTool homepage:
  https://github.com/PGScatalog/pygscatalog/"
inputs:
  - id: ref_pcs
    type:
      type: array
      items: File
    doc: Principal components path (output from fraposa_pgsc)
    inputBinding:
      position: 1
  - id: target_pcs
    type:
      type: array
      items: File
    doc: Principal components path (output from fraposa_pgsc)
    inputBinding:
      position: 2
  - id: psam
    type: File
    doc: Reference sample information file path in plink2 psam format)
    inputBinding:
      position: 3
  - id: agg_scores
    type:
      - 'null'
      - File
    doc: Aggregated scores in PGS Catalog format ([sampleset, IID] indexed)
    inputBinding:
      position: 104
      prefix: --agg_scores
  - id: ancestry_method
    type:
      - 'null'
      - string
    doc: Method used for population/ancestry assignment
    inputBinding:
      position: 104
      prefix: --ancestry_method
  - id: dataset_label
    type: string
    doc: Label of the TARGET genomic dataset
    inputBinding:
      position: 104
      prefix: --dataset
  - id: n_normalization
    type:
      - 'null'
      - int
    doc: Number of PCs used for population NORMALIZATION (default = 4)
    inputBinding:
      position: 104
      prefix: --n_normalization
  - id: n_popcomp
    type:
      - 'null'
      - int
    doc: Number of PCs used for population comparison (default = 5)
    inputBinding:
      position: 104
      prefix: --n_popcomp
  - id: normalization_method
    type:
      - 'null'
      - type: array
        items: string
    doc: Method used for adjustment of PGS using genetic ancestry
    inputBinding:
      position: 104
      prefix: --normalization_method
  - id: pop_label
    type:
      - 'null'
      - string
    doc: Population labels in REFERENCE psam to use for assignment
    inputBinding:
      position: 104
      prefix: --pop_label
  - id: pval_threshold
    type:
      - 'null'
      - float
    doc: p-value threshold used to identify low-confidence ancestry similarities
    inputBinding:
      position: 104
      prefix: --pval_threshold
  - id: reference_label
    type: string
    doc: Label of the REFERENCE genomic dataset
    inputBinding:
      position: 104
      prefix: --reference
  - id: reference_related
    type:
      - 'null'
      - File
    doc: File of related sample IDs (excluded from training ancestry 
      assignments)
    inputBinding:
      position: 104
      prefix: --reference_related
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Extra logging information
    inputBinding:
      position: 104
      prefix: --verbose
outputs:
  - id: outdir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgscatalog.calc:0.3.1--pyhdfd78af_1
