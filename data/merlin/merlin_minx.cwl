cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - minx
label: merlin_minx
doc: "MERLIN 1.1.2 with chromosome X support: multipoint linkage analysis, IBD and haplotype estimation, error detection and association analysis for pedigrees on the X chromosome.\n\nTool homepage: http://csg.sph.umich.edu/abecasis/merlin"
inputs:
  - id: data_file
    type: File
    doc: "Data file, in linkage or QTDT format (-d)"
    inputBinding:
      position: 1
      prefix: '-d'
  - id: pedigree_file
    type: File
    doc: "Pedigree file, with genotype, phenotype and family structure information (-p)"
    inputBinding:
      position: 1
      prefix: '-p'
  - id: map_file
    type: File
    doc: "Map file with chromosome and centimorgan position for each marker (-m)"
    inputBinding:
      position: 1
      prefix: '-m'
  - id: missing_value_code
    type:
      - 'null'
      - string
    doc: "Missing value code for quantitative phenotypes and covariates (default -99.999)"
    inputBinding:
      position: 1
      prefix: '-x'
  - id: allele_frequencies
    type:
      - 'null'
      - string
    doc: "Source for allele frequencies: a (all individuals), e (equal), f (founders) or m (maximum likelihood); rendered as -fa, -fe, -ff or -fm"
    inputBinding:
      position: 1
      prefix: '-f'
      separate: false
  - id: allele_frequency_file
    type:
      - 'null'
      - File
    doc: "File with allele frequencies (-f file)"
    inputBinding:
      position: 1
      prefix: '-f'
  - id: random_seed
    type:
      - 'null'
      - int
    doc: "Random seed for simulation and haplotype sampling (default 123456)"
    inputBinding:
      position: 1
      prefix: '-r'
  - id: error
    type:
      - 'null'
      - boolean
    doc: "Find unlikely genotypes; likely errors are listed in <prefix>.err"
    inputBinding:
      position: 1
      prefix: '--error'
  - id: information
    type:
      - 'null'
      - boolean
    doc: "Calculate information content based on entropy at each analysis position"
    inputBinding:
      position: 1
      prefix: '--information'
  - id: likelihood
    type:
      - 'null'
      - boolean
    doc: "Calculate the likelihood of the observed genotype data"
    inputBinding:
      position: 1
      prefix: '--likelihood'
  - id: model
    type:
      - 'null'
      - File
    doc: "Parametric model table: calculate parametric LOD scores using the models in this file"
    inputBinding:
      position: 1
      prefix: '--model'
  - id: ibd
    type:
      - 'null'
      - boolean
    doc: "Output pairwise IBD coefficients to <prefix>.ibd"
    inputBinding:
      position: 1
      prefix: '--ibd'
  - id: kinship
    type:
      - 'null'
      - boolean
    doc: "Output pairwise kinship coefficients to <prefix>.kin"
    inputBinding:
      position: 1
      prefix: '--kinship'
  - id: matrices
    type:
      - 'null'
      - boolean
    doc: "Calculate possible pairwise IBD matrices and their probabilities for each family"
    inputBinding:
      position: 1
      prefix: '--matrices'
  - id: select
    type:
      - 'null'
      - boolean
    doc: "Select the most informative affected individuals from allele sharing"
    inputBinding:
      position: 1
      prefix: '--select'
  - id: npl
    type:
      - 'null'
      - boolean
    doc: "Non-parametric linkage analysis with the NPL all statistic"
    inputBinding:
      position: 1
      prefix: '--npl'
  - id: pairs
    type:
      - 'null'
      - boolean
    doc: "Non-parametric linkage analysis with the NPL pairs statistic"
    inputBinding:
      position: 1
      prefix: '--pairs'
  - id: qtl
    type:
      - 'null'
      - boolean
    doc: "Non-parametric linkage test for sharing among individuals with similar quantitative phenotypes"
    inputBinding:
      position: 1
      prefix: '--qtl'
  - id: deviates
    type:
      - 'null'
      - boolean
    doc: "Non-parametric quantitative trait linkage test using deviates from the population mean"
    inputBinding:
      position: 1
      prefix: '--deviates'
  - id: exp
    type:
      - 'null'
      - boolean
    doc: "Calculate LOD scores with the Kong and Cox exponential model"
    inputBinding:
      position: 1
      prefix: '--exp'
  - id: vc
    type:
      - 'null'
      - boolean
    doc: "Variance components linkage analysis"
    inputBinding:
      position: 1
      prefix: '--vc'
  - id: use_covariates
    type:
      - 'null'
      - boolean
    doc: "Model covariate effects (C columns in the data file)"
    inputBinding:
      position: 1
      prefix: '--useCovariates'
  - id: ascertainment
    type:
      - 'null'
      - boolean
    doc: "Model single proband ascertainment"
    inputBinding:
      position: 1
      prefix: '--ascertainment'
  - id: unlinked
    type:
      - 'null'
      - float
    doc: "Heterogeneity model: fraction of families assumed unlinked"
    inputBinding:
      position: 1
      prefix: '--unlinked'
  - id: infer
    type:
      - 'null'
      - boolean
    doc: "Estimate missing SNP genotypes in pedigrees; writes a new pedigree and data file"
    inputBinding:
      position: 1
      prefix: '--infer'
  - id: assoc
    type:
      - 'null'
      - boolean
    doc: "Quantitative trait association analysis with a variance component model"
    inputBinding:
      position: 1
      prefix: '--assoc'
  - id: fast_assoc
    type:
      - 'null'
      - boolean
    doc: "Rapid score test of quantitative trait association for each SNP"
    inputBinding:
      position: 1
      prefix: '--fastAssoc'
  - id: filter
    type:
      - 'null'
      - float
    doc: "Only output p-values below this threshold"
    inputBinding:
      position: 1
      prefix: '--filter'
  - id: custom
    type:
      - 'null'
      - File
    doc: "Custom covariate table (TRAIT and COVARIATE lines for each trait)"
    inputBinding:
      position: 1
      prefix: '--custom'
  - id: best
    type:
      - 'null'
      - boolean
    doc: "Output the most likely haplotype vector to <prefix>.chr"
    inputBinding:
      position: 1
      prefix: '--best'
  - id: sample
    type:
      - 'null'
      - boolean
    doc: "Sample a likely haplotype vector according to its likelihood"
    inputBinding:
      position: 1
      prefix: '--sample'
  - id: all
    type:
      - 'null'
      - boolean
    doc: "Output all haplotype vectors"
    inputBinding:
      position: 1
      prefix: '--all'
  - id: founders
    type:
      - 'null'
      - boolean
    doc: "List founder haplotype graphs in <prefix>.hap"
    inputBinding:
      position: 1
      prefix: '--founders'
  - id: horizontal
    type:
      - 'null'
      - boolean
    doc: "Output haplotypes in horizontal format"
    inputBinding:
      position: 1
      prefix: '--horizontal'
  - id: steps
    type:
      - 'null'
      - int
    doc: "Analyse at n equally spaced locations between consecutive markers"
    inputBinding:
      position: 1
      prefix: '--steps'
  - id: max_step
    type:
      - 'null'
      - float
    doc: "Maximum distance in cM between consecutive analysis locations"
    inputBinding:
      position: 1
      prefix: '--maxStep'
  - id: min_step
    type:
      - 'null'
      - float
    doc: "Minimum distance in cM between consecutive analysis locations"
    inputBinding:
      position: 1
      prefix: '--minStep'
  - id: grid
    type:
      - 'null'
      - float
    doc: "Analyse along an n-cM grid of equally spaced locations"
    inputBinding:
      position: 1
      prefix: '--grid'
  - id: start
    type:
      - 'null'
      - float
    doc: "Start analyses at this position in cM"
    inputBinding:
      position: 1
      prefix: '--start'
  - id: stop
    type:
      - 'null'
      - float
    doc: "Stop analyses at this position in cM"
    inputBinding:
      position: 1
      prefix: '--stop'
  - id: zero
    type:
      - 'null'
      - boolean
    doc: "Assume no recombination between markers"
    inputBinding:
      position: 1
      prefix: '--zero'
  - id: one
    type:
      - 'null'
      - boolean
    doc: "Allow 1 recombination event between consecutive informative markers"
    inputBinding:
      position: 1
      prefix: '--one'
  - id: two
    type:
      - 'null'
      - boolean
    doc: "Allow 2 recombination events between consecutive informative markers"
    inputBinding:
      position: 1
      prefix: '--two'
  - id: three
    type:
      - 'null'
      - boolean
    doc: "Allow 3 recombination events between consecutive informative markers"
    inputBinding:
      position: 1
      prefix: '--three'
  - id: singlepoint
    type:
      - 'null'
      - boolean
    doc: "Consider each marker individually"
    inputBinding:
      position: 1
      prefix: '--singlepoint'
  - id: clusters
    type:
      - 'null'
      - File
    doc: "Marker cluster table to model linkage disequilibrium between neighbouring markers"
    inputBinding:
      position: 1
      prefix: '--clusters'
  - id: distance
    type:
      - 'null'
      - float
    doc: "Define clusters of markers less than this many cM apart"
    inputBinding:
      position: 1
      prefix: '--distance'
  - id: rsq
    type:
      - 'null'
      - float
    doc: "Define clusters of SNPs whose pairwise r2 exceeds this threshold"
    inputBinding:
      position: 1
      prefix: '--rsq'
  - id: cfreq
    type:
      - 'null'
      - boolean
    doc: "Write a file summarising clusters of markers in linkage disequilibrium and their haplotype frequencies"
    inputBinding:
      position: 1
      prefix: '--cfreq'
  - id: bits
    type:
      - 'null'
      - int
    doc: "Do not analyse pedigrees of more than this bit complexity (default 24)"
    inputBinding:
      position: 1
      prefix: '--bits'
  - id: megabytes
    type:
      - 'null'
      - int
    doc: "Do not allocate more than this many megabytes of memory"
    inputBinding:
      position: 1
      prefix: '--megabytes'
  - id: minutes
    type:
      - 'null'
      - int
    doc: "Skip families whose calculations need more than this many minutes"
    inputBinding:
      position: 1
      prefix: '--minutes'
  - id: trim
    type:
      - 'null'
      - boolean
    doc: "Trim uninformative individuals from pedigrees"
    inputBinding:
      position: 1
      prefix: '--trim'
  - id: swap
    type:
      - 'null'
      - boolean
    doc: "Use a swap file to reduce memory usage"
    inputBinding:
      position: 1
      prefix: '--swap'
  - id: small_swap
    type:
      - 'null'
      - boolean
    doc: "Use an alternative swap strategy that saves disk space"
    inputBinding:
      position: 1
      prefix: '--smallSwap'
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Do not output progress reports for large families"
    inputBinding:
      position: 1
      prefix: '--quiet'
  - id: marker_names
    type:
      - 'null'
      - boolean
    doc: "Label results with marker names instead of cM positions"
    inputBinding:
      position: 1
      prefix: '--markerNames'
  - id: per_family
    type:
      - 'null'
      - boolean
    doc: "Write per-family results to a file"
    inputBinding:
      position: 1
      prefix: '--perFamily'
  - id: pdf
    type:
      - 'null'
      - boolean
    doc: "Write LOD score plots to <prefix>.pdf"
    inputBinding:
      position: 1
      prefix: '--pdf'
  - id: tabulate
    type:
      - 'null'
      - boolean
    doc: "Write tab-delimited tables of key results"
    inputBinding:
      position: 1
      prefix: '--tabulate'
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Prefix for output file names (default merlin)"
    inputBinding:
      position: 1
      prefix: '--prefix'
  - id: frequencies
    type:
      - 'null'
      - boolean
    doc: "Output allele frequencies calculated internally to <prefix>.freq"
    inputBinding:
      position: 1
      prefix: '--frequencies'
  - id: simulate
    type:
      - 'null'
      - boolean
    doc: "Gene dropping simulation: replace genotypes with simulated genotypes before analysis"
    inputBinding:
      position: 1
      prefix: '--simulate'
  - id: reruns
    type:
      - 'null'
      - int
    doc: "Repeat the simulation this many times"
    inputBinding:
      position: 1
      prefix: '--reruns'
  - id: trait
    type:
      - 'null'
      - string
    doc: "Trait model for simulation, e.g. AFFECTION,FREQ,PEN(+/+),PEN(+/-),PEN(-/-),POSITION or QTLNAME,SNP,VarQTL,VarPoly,VarEnv"
    inputBinding:
      position: 1
      prefix: '--trait'
  - id: save
    type:
      - 'null'
      - boolean
    doc: "Save the simulated replicates as pedigree, data, map and frequency files"
    inputBinding:
      position: 1
      prefix: '--save'
outputs:
  - id: stdout
    type: stdout
    doc: "Program report (standard output)"
  - id: result_files
    type:
      type: array
      items: File
    doc: "Result files written with the output prefix (tables, error list, IBD, haplotypes, plots, ...)"
    outputBinding:
      glob:
        - "$(inputs.prefix ? inputs.prefix : 'merlin').*"
        - "$(inputs.prefix ? inputs.prefix : 'merlin')-*"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
stdout: merlin_minx.out
