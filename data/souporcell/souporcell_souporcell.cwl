cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/souporcell/target/release/souporcell
label: souporcell_souporcell
doc: "Cluster scRNAseq cells by genotype from vartrix ref and alt matrices\n\nTool homepage: https://github.com/wheaton5/souporcell"
inputs:
  - id: alt_matrix
    type: File
    doc: "alt matrix from vartrix"
    inputBinding:
      position: 11
      prefix: --alt_matrix
  - id: ref_matrix
    type: File
    doc: "ref matrix from vartrix"
    inputBinding:
      position: 11
      prefix: --ref_matrix
  - id: barcodes
    type: File
    doc: "cell barcodes"
    inputBinding:
      position: 11
      prefix: --barcodes
  - id: num_clusters
    type: int
    doc: "number of clusters"
    inputBinding:
      position: 11
      prefix: --num_clusters
  - id: initialization_strategy
    type:
      - 'null'
      - string
    doc: "cluster initialization strategy, defaults to kmeans++, valid values are kmeans++, random_uniform, middle_variance, random_cell_assignment"
    inputBinding:
      position: 11
      prefix: --initialization_strategy
  - id: known_cell_assignments
    type:
      - 'null'
      - File
    doc: "tsv with barcodes and their known assignments"
    inputBinding:
      position: 11
      prefix: --known_cell_assignments
  - id: known_genotypes
    type:
      - 'null'
      - File
    doc: "population vcf/bcf of known genotypes if available."
    inputBinding:
      position: 11
      prefix: --known_genotypes
  - id: known_genotypes_sample_names
    type:
      - 'null'
      - type: array
        items: string
    doc: "sample names, must be samples from the known_genotypes vcf"
    inputBinding:
      position: 11
      prefix: --known_genotypes_sample_names
  - id: min_alt
    type:
      - 'null'
      - int
    doc: "minimum number of cells containing the alt allele for the variant to be used for clustering"
    inputBinding:
      position: 11
      prefix: --min_alt
  - id: min_alt_umis
    type:
      - 'null'
      - int
    doc: "min alt umis to use locus for clustering"
    inputBinding:
      position: 11
      prefix: --min_alt_umis
  - id: min_ref
    type:
      - 'null'
      - int
    doc: "minimum number of cells containing the ref allele for the variant to be used for clustering"
    inputBinding:
      position: 11
      prefix: --min_ref
  - id: min_ref_umis
    type:
      - 'null'
      - int
    doc: "min ref umis to use locus for clustering"
    inputBinding:
      position: 11
      prefix: --min_ref_umis
  - id: restarts
    type:
      - 'null'
      - int
    doc: "number of random seedings"
    inputBinding:
      position: 11
      prefix: --restarts
  - id: seed
    type:
      - 'null'
      - int
    doc: "optional random seed"
    inputBinding:
      position: 11
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: "number of threads to use"
    inputBinding:
      position: 11
      prefix: --threads
outputs:
  - id: clusters
    type: stdout
    doc: Cluster assignments per cell (stdout)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/souporcell:2.5--hc1c3326_0
stdout: souporcell_clusters.tsv
