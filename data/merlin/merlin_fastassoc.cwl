cwlVersion: v1.2
class: CommandLineTool
baseCommand: merlin
label: merlin_fastassoc
doc: "MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis\n\nTool homepage: http://csg.sph.umich.edu/abecasis/merlin"
inputs:
  - id: all
    type:
      - 'null'
      - boolean
    doc: Haplotyping all haplotyping
    inputBinding:
      position: 101
  - id: allele_frequencies
    type:
      - 'null'
      - string
    doc: Allele Frequencies (a|e|f|m|file)
    default: a
    inputBinding:
      position: 101
      prefix: -f
  - id: ascertainment
    type:
      - 'null'
      - boolean
    doc: VC Linkage ascertainment
    inputBinding:
      position: 101
  - id: assoc
    type:
      - 'null'
      - boolean
    doc: Association analysis
    inputBinding:
      position: 101
  - id: best
    type:
      - 'null'
      - boolean
    doc: Haplotyping best haplotyping
    inputBinding:
      position: 101
  - id: bits
    type:
      - 'null'
      - int
    doc: Limits bits for internal calculations
    default: 24
    inputBinding:
      position: 101
  - id: cfreq
    type:
      - 'null'
      - float
    doc: LD Clusters conditional frequency
    inputBinding:
      position: 101
  - id: clusters
    type:
      - 'null'
      - type: array
        items: string
    doc: LD Clusters specification
    inputBinding:
      position: 101
  - id: custom
    type:
      - 'null'
      - File
    doc: Association custom analysis covariance table
    inputBinding:
      position: 101
  - id: data_file
    type: File
    doc: Data File
    inputBinding:
      position: 101
      prefix: -dname
  - id: deviates
    type:
      - 'null'
      - boolean
    doc: NPL Linkage deviates calculation
    inputBinding:
      position: 101
  - id: distance
    type:
      - 'null'
      - float
    doc: LD Clusters distance
    inputBinding:
      position: 101
  - id: error
    type:
      - 'null'
      - boolean
    doc: General error reporting
    inputBinding:
      position: 101
  - id: exp
    type:
      - 'null'
      - boolean
    doc: NPL Linkage expected values
    inputBinding:
      position: 101
  - id: extended
    type:
      - 'null'
      - boolean
    doc: IBD States extended calculation
    inputBinding:
      position: 101
  - id: fast_assoc
    type:
      - 'null'
      - boolean
    doc: Association fast association analysis
    inputBinding:
      position: 101
      prefix: --fastAssoc
  - id: filter
    type:
      - 'null'
      - boolean
    doc: Association filtering
    inputBinding:
      position: 101
  - id: founders
    type:
      - 'null'
      - boolean
    doc: Haplotyping founder haplotyping
    inputBinding:
      position: 101
  - id: frequencies
    type:
      - 'null'
      - boolean
    doc: Output allele frequencies
    inputBinding:
      position: 101
  - id: grid
    type:
      - 'null'
      - boolean
    doc: Positions grid search
    inputBinding:
      position: 101
  - id: horizontal
    type:
      - 'null'
      - boolean
    doc: Haplotyping horizontal haplotyping
    inputBinding:
      position: 101
  - id: ibd
    type:
      - 'null'
      - boolean
    doc: IBD States calculation
    inputBinding:
      position: 101
  - id: infer
    type:
      - 'null'
      - boolean
    doc: Association inference
    inputBinding:
      position: 101
  - id: information
    type:
      - 'null'
      - boolean
    doc: General information reporting
    inputBinding:
      position: 101
  - id: kinship
    type:
      - 'null'
      - boolean
    doc: IBD States kinship calculation
    inputBinding:
      position: 101
  - id: likelihood
    type:
      - 'null'
      - boolean
    doc: General likelihood calculation
    inputBinding:
      position: 101
  - id: map_file
    type: File
    doc: Map File
    inputBinding:
      position: 101
      prefix: -mname
  - id: marker_names
    type:
      - 'null'
      - boolean
    doc: Output marker names
    inputBinding:
      position: 101
      prefix: --markerNames
  - id: matrices
    type:
      - 'null'
      - boolean
    doc: IBD States matrices calculation
    inputBinding:
      position: 101
  - id: max_step
    type:
      - 'null'
      - float
    doc: Positions maximum step size
    inputBinding:
      position: 101
      prefix: --maxStep
  - id: megabytes
    type:
      - 'null'
      - int
    doc: Limits memory usage in megabytes
    inputBinding:
      position: 101
  - id: min_step
    type:
      - 'null'
      - float
    doc: Positions minimum step size
    inputBinding:
      position: 101
      prefix: --minStep
  - id: minutes
    type:
      - 'null'
      - int
    doc: Limits runtime in minutes
    inputBinding:
      position: 101
  - id: missing_value_code
    type:
      - 'null'
      - float
    doc: Missing Value Code
    default: -99.999
    inputBinding:
      position: 101
      prefix: -xname
  - id: model
    type:
      - 'null'
      - File
    doc: General model parameter table
    inputBinding:
      position: 101
  - id: no_couple_bits
    type:
      - 'null'
      - boolean
    doc: Performance disable couple bits optimization
    inputBinding:
      position: 101
      prefix: --noCoupleBits
  - id: npl
    type:
      - 'null'
      - boolean
    doc: NPL Linkage calculation
    inputBinding:
      position: 101
  - id: one
    type:
      - 'null'
      - boolean
    doc: Recombination one recombination rate
    inputBinding:
      position: 101
  - id: pairs
    type:
      - 'null'
      - boolean
    doc: NPL Linkage pairs analysis
    inputBinding:
      position: 101
  - id: pdf
    type:
      - 'null'
      - boolean
    doc: Output results in PDF format
    inputBinding:
      position: 101
  - id: pedigree_file
    type: File
    doc: Pedigree File
    inputBinding:
      position: 101
      prefix: -pname
  - id: per_family
    type:
      - 'null'
      - boolean
    doc: Output results per family
    inputBinding:
      position: 101
      prefix: --perFamily
  - id: prefix
    type:
      - 'null'
      - string
    doc: Output file prefix
    default: merlin
    inputBinding:
      position: 101
  - id: qtl
    type:
      - 'null'
      - boolean
    doc: NPL Linkage QTL analysis
    inputBinding:
      position: 101
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Output quiet mode
    inputBinding:
      position: 101
  - id: random_seed
    type:
      - 'null'
      - int
    doc: Random Seed
    default: 123456
    inputBinding:
      position: 101
      prefix: -r9999
  - id: reruns
    type:
      - 'null'
      - int
    doc: Simulation number of reruns
    inputBinding:
      position: 101
  - id: rsq
    type:
      - 'null'
      - float
    doc: LD Clusters rsq threshold
    inputBinding:
      position: 101
  - id: sample
    type:
      - 'null'
      - boolean
    doc: Haplotyping sample haplotyping
    inputBinding:
      position: 101
  - id: save
    type:
      - 'null'
      - boolean
    doc: Simulation save simulation results
    inputBinding:
      position: 101
  - id: select
    type:
      - 'null'
      - boolean
    doc: IBD States selection
    inputBinding:
      position: 101
  - id: simulate
    type:
      - 'null'
      - boolean
    doc: Simulation mode
    inputBinding:
      position: 101
  - id: singlepoint
    type:
      - 'null'
      - boolean
    doc: Recombination singlepoint analysis
    inputBinding:
      position: 101
  - id: small_swap
    type:
      - 'null'
      - boolean
    doc: Performance use smaller swap files
    inputBinding:
      position: 101
      prefix: --smallSwap
  - id: start
    type:
      - 'null'
      - float
    doc: Positions start position
    inputBinding:
      position: 101
  - id: steps
    type:
      - 'null'
      - boolean
    doc: Positions step analysis
    inputBinding:
      position: 101
  - id: stop
    type:
      - 'null'
      - float
    doc: Positions stop position
    inputBinding:
      position: 101
  - id: swap
    type:
      - 'null'
      - boolean
    doc: Performance swap data to disk
    inputBinding:
      position: 101
  - id: tabulate
    type:
      - 'null'
      - boolean
    doc: Output results in tabulated format
    inputBinding:
      position: 101
  - id: three
    type:
      - 'null'
      - boolean
    doc: Recombination three recombination rate
    inputBinding:
      position: 101
  - id: trait
    type:
      - 'null'
      - type: array
        items: string
    doc: Simulation trait values
    inputBinding:
      position: 101
  - id: trim
    type:
      - 'null'
      - boolean
    doc: Performance trim results
    inputBinding:
      position: 101
  - id: two
    type:
      - 'null'
      - boolean
    doc: Recombination two recombination rate
    inputBinding:
      position: 101
  - id: unlinked
    type:
      - 'null'
      - float
    doc: VC Linkage unlinked parameter
    default: 0.0
    inputBinding:
      position: 101
  - id: use_covariates
    type:
      - 'null'
      - boolean
    doc: VC Linkage use covariates
    inputBinding:
      position: 101
      prefix: --useCovariates
  - id: vc
    type:
      - 'null'
      - boolean
    doc: VC Linkage calculation
    inputBinding:
      position: 101
  - id: zero
    type:
      - 'null'
      - boolean
    doc: Recombination zero recombination rate
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
stdout: merlin_fastassoc.out
