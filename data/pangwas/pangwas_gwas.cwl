cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pangwas
  - gwas
label: pangwas_gwas
doc: "Run genome-wide association study (GWAS) tests with pyseer.\n\nTakes as input the TSV file of summarized clusters from summarize, an Rtab file of variants,\na TSV/CSV table of phenotypes, and a column name representing the trait of interest.\nOutputs tables of locus effects, and optionally lineage effects (bugwas) if specified.\n\nAny additional arguments will be passed to `pyseer`. If no additional\narguments are used, the following default args will apply:\n--lmm\n\nTool homepage: https://github.com/phac-nml/pangwas"
inputs:
  - id: variants
    type: File
    doc: "Rtab file of variants."
    inputBinding:
      position: 101
      prefix: --variants
  - id: table
    type: File
    doc: "TSV or CSV table of phenotypes (variables)."
    inputBinding:
      position: 101
      prefix: --table
  - id: column
    type: string
    doc: "Column name of trait (variable) in table."
    inputBinding:
      position: 101
      prefix: --column
  - id: lineage_column
    type:
      - 'null'
      - string
    doc: "Column name of lineages in table. Enables bugwas lineage effects."
    inputBinding:
      position: 101
      prefix: --lineage-column
  - id: no_midpoint
    type:
      - 'null'
      - boolean
    doc: "Disable midpoint rooting of the tree for the kinship matrix."
    inputBinding:
      position: 101
      prefix: --no-midpoint
  - id: tree
    type:
      - 'null'
      - File
    doc: "Newick phylogenetic tree. Not required if pyseer args includes --no-distances."
    inputBinding:
      position: 101
      prefix: --tree
  - id: continuous
    type:
      - 'null'
      - boolean
    doc: "Treat the column trait as a continuous variable."
    inputBinding:
      position: 101
      prefix: --continuous
  - id: exclude_missing
    type:
      - 'null'
      - boolean
    doc: "Exclude samples missing phenotype data."
    inputBinding:
      position: 101
      prefix: --exclude-missing
  - id: clusters
    type:
      - 'null'
      - File
    doc: "TSV of clusters from summarize."
    inputBinding:
      position: 101
      prefix: --clusters
  - id: outdir
    type:
      - 'null'
      - string
    doc: "Output directory. (default: . )"
    inputBinding:
      position: 101
      prefix: --outdir
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Prefix for output files. (default: the trait column name)"
    inputBinding:
      position: 101
      prefix: --prefix
  - id: threads
    type:
      - 'null'
      - int
    doc: "CPU threads for pyseer. (default: 1)"
    inputBinding:
      position: 101
      prefix: --threads
  - id: extra_args
    type:
      - 'null'
      - type: array
        items: string
    doc: "Additional arguments passed on to `pyseer`."
    inputBinding:
      position: 200
outputs:
  - id: gwas_files
    type: File[]
    doc: "All files written for the trait: locus effects, lineage effects, samplesheet, filtered inputs, kinship, QQ plot and pyseer log"
    outputBinding:
      glob: "$((inputs.outdir ? inputs.outdir + '/' : '') + (inputs.prefix || inputs.column) + '.*')"
  - id: locus_effects
    type:
      - 'null'
      - File
    doc: "Table of locus effects"
    outputBinding:
      glob: "$((inputs.outdir ? inputs.outdir + '/' : '') + (inputs.prefix || inputs.column) + '.locus_effects.tsv')"
  - id: locus_effects_significant
    type:
      - 'null'
      - File
    doc: "Table of significant locus effects"
    outputBinding:
      glob: "$((inputs.outdir ? inputs.outdir + '/' : '') + (inputs.prefix || inputs.column) + '.locus_effects.significant.tsv')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
