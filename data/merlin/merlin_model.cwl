cwlVersion: v1.2
class: CommandLineTool
baseCommand: merlin
label: merlin_model
doc: "MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis\n\nTool homepage: http://csg.sph.umich.edu/abecasis/merlin"
inputs:
  - id: all
    type:
      - 'null'
      - boolean
    doc: 'Haplotyping: all possible haplotypes'
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
    doc: 'VC Linkage: ascertainment correction'
    inputBinding:
      position: 101
      prefix: --ascertainment
  - id: assoc
    type:
      - 'null'
      - boolean
    doc: 'Association: standard association test'
    inputBinding:
      position: 101
      prefix: --assoc
  - id: best
    type:
      - 'null'
      - boolean
    doc: 'Haplotyping: best-guess haplotypes'
    inputBinding:
      position: 101
      prefix: --best
  - id: bits
    type:
      - 'null'
      - int
    doc: 'Limits: bits for calculations'
    inputBinding:
      position: 101
      prefix: --bits
  - id: cfreq
    type:
      - 'null'
      - boolean
    doc: 'LD Clusters: cluster by common frequency'
    inputBinding:
      position: 101
      prefix: --cfreq
  - id: clusters
    type:
      - 'null'
      - type: array
        items: string
    doc: 'LD Clusters: specify clusters'
    inputBinding:
      position: 101
      prefix: --clusters
  - id: custom
    type:
      - 'null'
      - File
    doc: 'Association: custom association test with covariates'
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
    doc: 'NPL Linkage: NPL deviates'
    inputBinding:
      position: 101
      prefix: --deviates
  - id: distance
    type:
      - 'null'
      - float
    doc: 'LD Clusters: distance for clustering'
    inputBinding:
      position: 101
      prefix: --distance
  - id: error
    type:
      - 'null'
      - boolean
    doc: 'General: error reporting'
    inputBinding:
      position: 101
      prefix: --error
  - id: exp
    type:
      - 'null'
      - boolean
    doc: 'NPL Linkage: expected NPL scores'
    inputBinding:
      position: 101
      prefix: --exp
  - id: extended
    type:
      - 'null'
      - boolean
    doc: 'IBD States: extended IBD states'
    inputBinding:
      position: 101
      prefix: --extended
  - id: fast_assoc
    type:
      - 'null'
      - boolean
    doc: 'Association: fast association test'
    inputBinding:
      position: 101
      prefix: --fastAssoc
  - id: filter
    type:
      - 'null'
      - boolean
    doc: 'Association: filter individuals'
    inputBinding:
      position: 101
      prefix: --filter
  - id: founders
    type:
      - 'null'
      - boolean
    doc: 'Haplotyping: founder haplotypes'
    inputBinding:
      position: 101
      prefix: --founders
  - id: frequencies
    type:
      - 'null'
      - boolean
    doc: 'Output: output allele frequencies'
    inputBinding:
      position: 101
      prefix: --frequencies
  - id: grid
    type:
      - 'null'
      - boolean
    doc: 'Positions: analyze on a grid'
    inputBinding:
      position: 101
      prefix: --grid
  - id: horizontal
    type:
      - 'null'
      - boolean
    doc: 'Haplotyping: horizontal haplotyping output'
    inputBinding:
      position: 101
      prefix: --horizontal
  - id: ibd
    type:
      - 'null'
      - boolean
    doc: 'IBD States: calculate IBD states'
    inputBinding:
      position: 101
      prefix: --ibd
  - id: infer
    type:
      - 'null'
      - boolean
    doc: 'Association: infer genotypes'
    inputBinding:
      position: 101
      prefix: --infer
  - id: information
    type:
      - 'null'
      - boolean
    doc: 'General: information reporting'
    inputBinding:
      position: 101
      prefix: --information
  - id: kinship
    type:
      - 'null'
      - boolean
    doc: 'IBD States: calculate kinship coefficients'
    inputBinding:
      position: 101
      prefix: --kinship
  - id: likelihood
    type:
      - 'null'
      - boolean
    doc: 'General: likelihood calculation'
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
    doc: 'Output: use marker names'
    inputBinding:
      position: 101
      prefix: --markerNames
  - id: matrices
    type:
      - 'null'
      - boolean
    doc: 'IBD States: output IBD matrices'
    inputBinding:
      position: 101
      prefix: --matrices
  - id: max_step
    type:
      - 'null'
      - int
    doc: 'Positions: maximum step size'
    inputBinding:
      position: 101
      prefix: --maxStep
  - id: megabytes
    type:
      - 'null'
      - int
    doc: 'Limits: memory limit in megabytes'
    inputBinding:
      position: 101
      prefix: --megabytes
  - id: min_step
    type:
      - 'null'
      - int
    doc: 'Positions: minimum step size'
    inputBinding:
      position: 101
      prefix: --minStep
  - id: minutes
    type:
      - 'null'
      - int
    doc: 'Limits: time limit in minutes'
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
    doc: 'General: model parameter table'
    inputBinding:
      position: 101
      prefix: --model
  - id: no_couple_bits
    type:
      - 'null'
      - boolean
    doc: 'Performance: disable couple bits optimization'
    inputBinding:
      position: 101
      prefix: --noCoupleBits
  - id: npl
    type:
      - 'null'
      - boolean
    doc: 'NPL Linkage: NPL scores'
    inputBinding:
      position: 101
      prefix: --npl
  - id: one
    type:
      - 'null'
      - boolean
    doc: 'Recombination: one recombination rate'
    inputBinding:
      position: 101
      prefix: --one
  - id: pairs
    type:
      - 'null'
      - boolean
    doc: 'NPL Linkage: NPL scores for pairs'
    inputBinding:
      position: 101
      prefix: --pairs
  - id: pdf
    type:
      - 'null'
      - boolean
    doc: 'Output: output in PDF format'
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
    doc: 'Output: output results per family'
    inputBinding:
      position: 101
      prefix: --perFamily
  - id: prefix
    type:
      - 'null'
      - string
    doc: 'Output: output file prefix'
    inputBinding:
      position: 101
      prefix: --prefix
  - id: qtl
    type:
      - 'null'
      - boolean
    doc: 'NPL Linkage: QTL analysis'
    inputBinding:
      position: 101
      prefix: --qtl
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: 'Output: suppress output'
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
    doc: 'Simulation: number of reruns'
    inputBinding:
      position: 101
      prefix: --reruns
  - id: rsq
    type:
      - 'null'
      - float
    doc: 'LD Clusters: R-squared threshold'
    inputBinding:
      position: 101
      prefix: --rsq
  - id: sample
    type:
      - 'null'
      - boolean
    doc: 'Haplotyping: sample haplotypes'
    inputBinding:
      position: 101
      prefix: --sample
  - id: save
    type:
      - 'null'
      - boolean
    doc: 'Simulation: save simulated data'
    inputBinding:
      position: 101
      prefix: --save
  - id: select
    type:
      - 'null'
      - boolean
    doc: 'IBD States: select individuals based on IBD'
    inputBinding:
      position: 101
      prefix: --select
  - id: simulate
    type:
      - 'null'
      - boolean
    doc: 'Simulation: simulate data'
    inputBinding:
      position: 101
      prefix: --simulate
  - id: singlepoint
    type:
      - 'null'
      - boolean
    doc: 'Recombination: singlepoint recombination analysis'
    inputBinding:
      position: 101
      prefix: --singlepoint
  - id: small_swap
    type:
      - 'null'
      - boolean
    doc: 'Performance: use small swap files'
    inputBinding:
      position: 101
      prefix: --smallSwap
  - id: start
    type:
      - 'null'
      - float
    doc: 'Positions: start position'
    inputBinding:
      position: 101
      prefix: --start
  - id: steps
    type:
      - 'null'
      - boolean
    doc: 'Positions: analyze by steps'
    inputBinding:
      position: 101
      prefix: --steps
  - id: stop
    type:
      - 'null'
      - float
    doc: 'Positions: stop position'
    inputBinding:
      position: 101
      prefix: --stop
  - id: swap
    type:
      - 'null'
      - boolean
    doc: 'Performance: swap data to disk'
    inputBinding:
      position: 101
      prefix: --swap
  - id: tabulate
    type:
      - 'null'
      - boolean
    doc: 'Output: tabulate results'
    inputBinding:
      position: 101
      prefix: --tabulate
  - id: three
    type:
      - 'null'
      - boolean
    doc: 'Recombination: three recombination rates'
    inputBinding:
      position: 101
      prefix: --three
  - id: trait
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Simulation: specify trait(s) to simulate'
    inputBinding:
      position: 101
      prefix: --trait
  - id: trim
    type:
      - 'null'
      - boolean
    doc: 'Performance: trim data'
    inputBinding:
      position: 101
      prefix: --trim
  - id: two
    type:
      - 'null'
      - boolean
    doc: 'Recombination: two recombination rates'
    inputBinding:
      position: 101
      prefix: --two
  - id: unlinked
    type:
      - 'null'
      - float
    doc: 'VC Linkage: unlinked markers'
    inputBinding:
      position: 101
      prefix: --unlinked
  - id: use_covariates
    type:
      - 'null'
      - boolean
    doc: 'VC Linkage: use covariates in VC analysis'
    inputBinding:
      position: 101
      prefix: --useCovariates
  - id: vc
    type:
      - 'null'
      - boolean
    doc: 'VC Linkage: variance components analysis'
    inputBinding:
      position: 101
      prefix: --vc
  - id: zero
    type:
      - 'null'
      - boolean
    doc: 'Recombination: zero recombination rate'
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
stdout: merlin_model.out
