cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pangwas
  - gwas
label: pangwas_gwas
doc: "Run genome-wide association study (GWAS) tests with pyseer.\n\nTakes as input
  the TSV file of summarized clusters from summarize, an Rtab file of variants,\n\
  a TSV/CSV table of phenotypes, and a column name representing the trait of interest.\n\
  Outputs tables of locus effects, and optionally lineage effects (bugwas) if specified.\n\
  \nAny additional arguments will be passed to `pyseer`. If no additional\narguments
  are used, the following default args will apply:\n--lmm\n\nTool homepage: https://github.com/phac-nml/pangwas"
inputs:
  - id: clusters
    type:
      - 'null'
      - File
    doc: TSV of clusters from summarize.
    inputBinding:
      position: 101
      prefix: --clusters
  - id: column
    type: string
    doc: Column name of trait (variable) in table.
    inputBinding:
      position: 101
      prefix: --column
  - id: continuous
    type:
      - 'null'
      - boolean
    doc: Treat the column trait as a continuous variable.
    inputBinding:
      position: 101
      prefix: --continuous
  - id: exclude_missing
    type:
      - 'null'
      - boolean
    doc: Exclude samples missing phenotype data.
    inputBinding:
      position: 101
      prefix: --exclude-missing
  - id: lineage_column
    type:
      - 'null'
      - string
    doc: Column name of lineages in table. Enables bugwas lineage effects.
    inputBinding:
      position: 101
      prefix: --lineage-column
  - id: no_midpoint
    type:
      - 'null'
      - boolean
    doc: Disable midpoint rooting of the tree for the kinship matrix.
    inputBinding:
      position: 101
      prefix: --no-midpoint
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory.
    default: .
    inputBinding:
      position: 101
      prefix: --outdir
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files.
    inputBinding:
      position: 101
      prefix: --prefix
  - id: table
    type: File
    doc: TSV or CSV table of phenotypes (variables).
    inputBinding:
      position: 101
      prefix: --table
  - id: threads
    type:
      - 'null'
      - int
    doc: CPU threads for pyseer.
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: tree
    type:
      - 'null'
      - File
    doc: Newick phylogenetic tree. Not required if pyseer args includes 
      --no-distances.
    inputBinding:
      position: 101
      prefix: --tree
  - id: variants
    type: File
    doc: Rtab file of variants.
    inputBinding:
      position: 101
      prefix: --variants
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
stdout: pangwas_gwas.out
