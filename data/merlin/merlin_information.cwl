cwlVersion: v1.2
class: CommandLineTool
baseCommand: merlin
label: merlin_information
doc: "MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis\n\nTool homepage: http://csg.sph.umich.edu/abecasis/merlin"
inputs:
  - id: all
    type:
      - 'null'
      - boolean
    doc: Haplotyping --all
    inputBinding:
      position: 101
      prefix: --all
  - id: allele_frequencies
    type:
      - 'null'
      - string
    doc: Allele Frequencies (a|e|f|m|file)
    inputBinding:
      position: 101
      prefix: -f
  - id: ascertainment
    type:
      - 'null'
      - boolean
    doc: VC Linkage --ascertainment
    inputBinding:
      position: 101
      prefix: --ascertainment
  - id: assoc
    type:
      - 'null'
      - boolean
    doc: Association --assoc
    inputBinding:
      position: 101
      prefix: --assoc
  - id: best
    type:
      - 'null'
      - boolean
    doc: Haplotyping --best
    inputBinding:
      position: 101
      prefix: --best
  - id: bits
    type:
      - 'null'
      - int
    doc: Limits --bits [24]
    inputBinding:
      position: 101
      prefix: --bits
  - id: cfreq
    type:
      - 'null'
      - float
    doc: LD Clusters --cfreq
    inputBinding:
      position: 101
      prefix: --cfreq
  - id: clusters
    type:
      - 'null'
      - type: array
        items: string
    doc: LD Clusters --clusters []
    inputBinding:
      position: 101
      prefix: --clusters
  - id: custom
    type:
      - 'null'
      - File
    doc: Association --custom [cov.tbl]
    inputBinding:
      position: 101
      prefix: --custom
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
    doc: NPL Linkage --deviates
    inputBinding:
      position: 101
      prefix: --deviates
  - id: distance
    type:
      - 'null'
      - float
    doc: LD Clusters --distance
    inputBinding:
      position: 101
      prefix: --distance
  - id: error
    type:
      - 'null'
      - boolean
    doc: General error analysis
    inputBinding:
      position: 101
      prefix: --error
  - id: exp
    type:
      - 'null'
      - boolean
    doc: NPL Linkage --exp
    inputBinding:
      position: 101
      prefix: --exp
  - id: extended
    type:
      - 'null'
      - boolean
    doc: IBD States --extended
    inputBinding:
      position: 101
      prefix: --extended
  - id: fast_assoc
    type:
      - 'null'
      - boolean
    doc: Association --fastAssoc
    inputBinding:
      position: 101
      prefix: --fastAssoc
  - id: filter
    type:
      - 'null'
      - boolean
    doc: Association --filter
    inputBinding:
      position: 101
      prefix: --filter
  - id: founders
    type:
      - 'null'
      - boolean
    doc: Haplotyping --founders
    inputBinding:
      position: 101
      prefix: --founders
  - id: frequencies
    type:
      - 'null'
      - boolean
    doc: Output --frequencies
    inputBinding:
      position: 101
      prefix: --frequencies
  - id: grid
    type:
      - 'null'
      - boolean
    doc: Positions --grid
    inputBinding:
      position: 101
      prefix: --grid
  - id: horizontal
    type:
      - 'null'
      - boolean
    doc: Haplotyping --horizontal
    inputBinding:
      position: 101
      prefix: --horizontal
  - id: ibd
    type:
      - 'null'
      - boolean
    doc: IBD States --ibd
    inputBinding:
      position: 101
      prefix: --ibd
  - id: infer
    type:
      - 'null'
      - boolean
    doc: Association --infer
    inputBinding:
      position: 101
      prefix: --infer
  - id: information
    type:
      - 'null'
      - boolean
    doc: General information analysis
    inputBinding:
      position: 101
      prefix: --information
  - id: kinship
    type:
      - 'null'
      - boolean
    doc: IBD States --kinship
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
    type: File
    doc: Map File
    inputBinding:
      position: 101
      prefix: -mname
  - id: marker_names
    type:
      - 'null'
      - boolean
    doc: Output --markerNames
    inputBinding:
      position: 101
      prefix: --markerNames
  - id: matrices
    type:
      - 'null'
      - boolean
    doc: IBD States --matrices
    inputBinding:
      position: 101
      prefix: --matrices
  - id: max_step
    type:
      - 'null'
      - float
    doc: Positions --maxStep
    inputBinding:
      position: 101
      prefix: --maxStep
  - id: megabytes
    type:
      - 'null'
      - int
    doc: Limits --megabytes
    inputBinding:
      position: 101
      prefix: --megabytes
  - id: min_step
    type:
      - 'null'
      - float
    doc: Positions --minStep
    inputBinding:
      position: 101
      prefix: --minStep
  - id: minutes
    type:
      - 'null'
      - int
    doc: Limits --minutes
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
    doc: General model analysis [param.tbl]
    inputBinding:
      position: 101
      prefix: --model
  - id: no_couple_bits
    type:
      - 'null'
      - boolean
    doc: Performance --noCoupleBits
    inputBinding:
      position: 101
      prefix: --noCoupleBits
  - id: npl
    type:
      - 'null'
      - boolean
    doc: NPL Linkage --npl
    inputBinding:
      position: 101
      prefix: --npl
  - id: one
    type:
      - 'null'
      - boolean
    doc: Recombination --one
    inputBinding:
      position: 101
      prefix: --one
  - id: pairs
    type:
      - 'null'
      - boolean
    doc: NPL Linkage --pairs
    inputBinding:
      position: 101
      prefix: --pairs
  - id: pdf
    type:
      - 'null'
      - boolean
    doc: Output --pdf
    inputBinding:
      position: 101
      prefix: --pdf
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
    doc: Output --perFamily
    inputBinding:
      position: 101
      prefix: --perFamily
  - id: prefix
    type:
      - 'null'
      - string
    doc: Output --prefix [merlin]
    inputBinding:
      position: 101
      prefix: --prefix
  - id: qtl
    type:
      - 'null'
      - boolean
    doc: NPL Linkage --qtl
    inputBinding:
      position: 101
      prefix: --qtl
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Output --quiet
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
    doc: Simulation --reruns
    inputBinding:
      position: 101
      prefix: --reruns
  - id: rsq
    type:
      - 'null'
      - float
    doc: LD Clusters --rsq
    inputBinding:
      position: 101
      prefix: --rsq
  - id: sample
    type:
      - 'null'
      - boolean
    doc: Haplotyping --sample
    inputBinding:
      position: 101
      prefix: --sample
  - id: save
    type:
      - 'null'
      - boolean
    doc: Simulation --save
    inputBinding:
      position: 101
      prefix: --save
  - id: select
    type:
      - 'null'
      - boolean
    doc: IBD States --select
    inputBinding:
      position: 101
      prefix: --select
  - id: simulate
    type:
      - 'null'
      - boolean
    doc: Simulation --simulate
    inputBinding:
      position: 101
      prefix: --simulate
  - id: singlepoint
    type:
      - 'null'
      - boolean
    doc: Recombination --singlepoint
    inputBinding:
      position: 101
      prefix: --singlepoint
  - id: small_swap
    type:
      - 'null'
      - boolean
    doc: Performance --smallSwap
    inputBinding:
      position: 101
      prefix: --smallSwap
  - id: start
    type:
      - 'null'
      - float
    doc: Positions --start
    inputBinding:
      position: 101
      prefix: --start
  - id: steps
    type:
      - 'null'
      - boolean
    doc: Positions --steps
    inputBinding:
      position: 101
      prefix: --steps
  - id: stop
    type:
      - 'null'
      - float
    doc: Positions --stop
    inputBinding:
      position: 101
      prefix: --stop
  - id: swap
    type:
      - 'null'
      - boolean
    doc: Performance --swap
    inputBinding:
      position: 101
      prefix: --swap
  - id: tabulate
    type:
      - 'null'
      - boolean
    doc: Output --tabulate
    inputBinding:
      position: 101
      prefix: --tabulate
  - id: three
    type:
      - 'null'
      - boolean
    doc: Recombination --three
    inputBinding:
      position: 101
      prefix: --three
  - id: trait
    type:
      - 'null'
      - type: array
        items: string
    doc: Simulation --trait []
    inputBinding:
      position: 101
      prefix: --trait
  - id: trim
    type:
      - 'null'
      - boolean
    doc: Performance --trim
    inputBinding:
      position: 101
      prefix: --trim
  - id: two
    type:
      - 'null'
      - boolean
    doc: Recombination --two
    inputBinding:
      position: 101
      prefix: --two
  - id: unlinked
    type:
      - 'null'
      - float
    doc: VC Linkage --unlinked [0.00]
    inputBinding:
      position: 101
      prefix: --unlinked
  - id: use_covariates
    type:
      - 'null'
      - boolean
    doc: VC Linkage --useCovariates
    inputBinding:
      position: 101
      prefix: --useCovariates
  - id: vc
    type:
      - 'null'
      - boolean
    doc: VC Linkage --vc
    inputBinding:
      position: 101
      prefix: --vc
  - id: zero
    type:
      - 'null'
      - boolean
    doc: Recombination --zero
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
stdout: merlin_information.out
