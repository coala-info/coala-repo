cwlVersion: v1.2
class: CommandLineTool
baseCommand: merlin
label: merlin_distance
doc: "MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis\n\nTool homepage: http://csg.sph.umich.edu/abecasis/merlin"
inputs:
  - id: all
    type:
      - 'null'
      - boolean
    doc: Haplotyping all paths
    inputBinding:
      position: 101
      prefix: --all
  - id: allele_frequencies
    type:
      - 'null'
      - string
    doc: Allele Frequencies [a|e|f|m|file]
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
      prefix: --ascertainment
  - id: assoc
    type:
      - 'null'
      - boolean
    doc: Association analysis
    inputBinding:
      position: 101
      prefix: --assoc
  - id: best
    type:
      - 'null'
      - boolean
    doc: Haplotyping best path
    inputBinding:
      position: 101
      prefix: --best
  - id: bits
    type:
      - 'null'
      - int
    doc: Limits bits for internal representation
    inputBinding:
      position: 101
      prefix: --bits
  - id: cfreq
    type:
      - 'null'
      - float
    doc: LD Clusters cluster frequency
    inputBinding:
      position: 101
      prefix: --cfreq
  - id: clusters
    type:
      - 'null'
      - type: array
        items: string
    doc: LD Clusters specification
    inputBinding:
      position: 101
      prefix: --clusters
  - id: custom_covariates
    type:
      - 'null'
      - File
    doc: Association custom covariates table
    inputBinding:
      position: 101
      prefix: --custom
  - id: data_file
    type:
      - 'null'
      - File
    doc: Data File
    inputBinding:
      position: 101
      prefix: -dname
  - id: deviates
    type:
      - 'null'
      - boolean
    doc: NPL Linkage deviates
    inputBinding:
      position: 101
      prefix: --deviates
  - id: distance
    type:
      - 'null'
      - float
    doc: LD Clusters distance
    inputBinding:
      position: 101
      prefix: --distance
  - id: error
    type:
      - 'null'
      - boolean
    doc: General error reporting
    inputBinding:
      position: 101
      prefix: --error
  - id: exp
    type:
      - 'null'
      - boolean
    doc: NPL Linkage expected values
    inputBinding:
      position: 101
      prefix: --exp
  - id: extended
    type:
      - 'null'
      - boolean
    doc: IBD States extended output
    inputBinding:
      position: 101
      prefix: --extended
  - id: fast_assoc
    type:
      - 'null'
      - boolean
    doc: Association fast analysis
    inputBinding:
      position: 101
      prefix: --fastAssoc
  - id: filter
    type:
      - 'null'
      - boolean
    doc: Association filter
    inputBinding:
      position: 101
      prefix: --filter
  - id: founders
    type:
      - 'null'
      - boolean
    doc: Haplotyping founders only
    inputBinding:
      position: 101
      prefix: --founders
  - id: frequencies
    type:
      - 'null'
      - boolean
    doc: Output allele frequencies
    inputBinding:
      position: 101
      prefix: --frequencies
  - id: grid
    type:
      - 'null'
      - boolean
    doc: Positions grid search
    inputBinding:
      position: 101
      prefix: --grid
  - id: horizontal
    type:
      - 'null'
      - boolean
    doc: Haplotyping horizontal output
    inputBinding:
      position: 101
      prefix: --horizontal
  - id: ibd
    type:
      - 'null'
      - boolean
    doc: IBD States calculation
    inputBinding:
      position: 101
      prefix: --ibd
  - id: infer
    type:
      - 'null'
      - boolean
    doc: Association inference
    inputBinding:
      position: 101
      prefix: --infer
  - id: information
    type:
      - 'null'
      - boolean
    doc: General information reporting
    inputBinding:
      position: 101
      prefix: --information
  - id: kinship
    type:
      - 'null'
      - boolean
    doc: IBD States kinship calculation
    inputBinding:
      position: 101
      prefix: --kinship
  - id: likelihood
    type:
      - 'null'
      - boolean
    doc: General likelihood analysis
    inputBinding:
      position: 101
      prefix: --likelihood
  - id: map_file
    type:
      - 'null'
      - File
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
    doc: IBD States matrices output
    inputBinding:
      position: 101
      prefix: --matrices
  - id: max_step
    type:
      - 'null'
      - int
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
      prefix: --megabytes
  - id: min_step
    type:
      - 'null'
      - int
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
      prefix: --minutes
  - id: missing_value_code
    type:
      - 'null'
      - float
    doc: Missing Value Code
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
      prefix: --model
  - id: no_couple_bits
    type:
      - 'null'
      - boolean
    doc: Performance disable couple bits
    inputBinding:
      position: 101
      prefix: --noCoupleBits
  - id: npl
    type:
      - 'null'
      - boolean
    doc: NPL Linkage analysis
    inputBinding:
      position: 101
      prefix: --npl
  - id: one
    type:
      - 'null'
      - boolean
    doc: Recombination one crossover
    inputBinding:
      position: 101
      prefix: --one
  - id: pairs
    type:
      - 'null'
      - boolean
    doc: NPL Linkage pairs analysis
    inputBinding:
      position: 101
      prefix: --pairs
  - id: pdf
    type:
      - 'null'
      - boolean
    doc: Output PDF plots
    inputBinding:
      position: 101
      prefix: --pdf
  - id: pedigree_file
    type:
      - 'null'
      - File
    doc: Pedigree File
    inputBinding:
      position: 101
      prefix: -pname
  - id: per_family
    type:
      - 'null'
      - boolean
    doc: Output per family results
    inputBinding:
      position: 101
      prefix: --perFamily
  - id: prefix
    type:
      - 'null'
      - string
    doc: Output file prefix
    inputBinding:
      position: 101
      prefix: --prefix
  - id: qtl
    type:
      - 'null'
      - boolean
    doc: NPL Linkage QTL analysis
    inputBinding:
      position: 101
      prefix: --qtl
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Output quiet mode
    inputBinding:
      position: 101
      prefix: --quiet
  - id: random_seed
    type:
      - 'null'
      - int
    doc: Random Seed
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
      prefix: --reruns
  - id: rsq
    type:
      - 'null'
      - float
    doc: LD Clusters rsq threshold
    inputBinding:
      position: 101
      prefix: --rsq
  - id: sample
    type:
      - 'null'
      - boolean
    doc: Haplotyping sample paths
    inputBinding:
      position: 101
      prefix: --sample
  - id: save
    type:
      - 'null'
      - File
    doc: Simulation save file
    inputBinding:
      position: 101
      prefix: --save
  - id: select
    type:
      - 'null'
      - boolean
    doc: IBD States selection
    inputBinding:
      position: 101
      prefix: --select
  - id: simulate
    type:
      - 'null'
      - boolean
    doc: Simulation mode
    inputBinding:
      position: 101
      prefix: --simulate
  - id: singlepoint
    type:
      - 'null'
      - boolean
    doc: Recombination single point analysis
    inputBinding:
      position: 101
      prefix: --singlepoint
  - id: small_swap
    type:
      - 'null'
      - boolean
    doc: Performance small swap memory usage
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
      prefix: --start
  - id: steps
    type:
      - 'null'
      - boolean
    doc: Positions by steps
    inputBinding:
      position: 101
      prefix: --steps
  - id: stop
    type:
      - 'null'
      - float
    doc: Positions stop position
    inputBinding:
      position: 101
      prefix: --stop
  - id: swap
    type:
      - 'null'
      - boolean
    doc: Performance swap memory usage
    inputBinding:
      position: 101
      prefix: --swap
  - id: tabulate
    type:
      - 'null'
      - boolean
    doc: Output tabulated results
    inputBinding:
      position: 101
      prefix: --tabulate
  - id: three
    type:
      - 'null'
      - boolean
    doc: Recombination three crossovers
    inputBinding:
      position: 101
      prefix: --three
  - id: trait
    type:
      - 'null'
      - type: array
        items: string
    doc: Simulation trait specification
    inputBinding:
      position: 101
      prefix: --trait
  - id: trim
    type:
      - 'null'
      - boolean
    doc: Performance trim output
    inputBinding:
      position: 101
      prefix: --trim
  - id: two
    type:
      - 'null'
      - boolean
    doc: Recombination two crossovers
    inputBinding:
      position: 101
      prefix: --two
  - id: unlinked
    type:
      - 'null'
      - float
    doc: VC Linkage unlinked parameter
    inputBinding:
      position: 101
      prefix: --unlinked
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
    doc: VC Linkage analysis
    inputBinding:
      position: 101
      prefix: --vc
  - id: zero
    type:
      - 'null'
      - boolean
    doc: Recombination zero crossovers
    inputBinding:
      position: 101
      prefix: --zero
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
stdout: merlin_distance.out
