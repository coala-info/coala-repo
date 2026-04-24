cwlVersion: v1.2
class: CommandLineTool
baseCommand: merlin
label: merlin_bits
doc: "MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis\n\nTool homepage: http://csg.sph.umich.edu/abecasis/merlin"
inputs:
  - id: all
    type:
      - 'null'
      - boolean
    doc: Haplotyping - --all
    inputBinding:
      position: 101
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
    doc: VC Linkage - --ascertainment
    inputBinding:
      position: 101
  - id: assoc
    type:
      - 'null'
      - boolean
    doc: Association - --assoc
    inputBinding:
      position: 101
  - id: best
    type:
      - 'null'
      - boolean
    doc: Haplotyping - --best
    inputBinding:
      position: 101
  - id: bits
    type:
      - 'null'
      - int
    doc: Limits - --bits
    inputBinding:
      position: 101
      prefix: --bits
  - id: cfreq
    type:
      - 'null'
      - float
    doc: LD Clusters - --cfreq
    inputBinding:
      position: 101
  - id: clusters
    type:
      - 'null'
      - type: array
        items: string
    doc: LD Clusters - --clusters []
    inputBinding:
      position: 101
  - id: custom
    type:
      - 'null'
      - File
    doc: Association - --custom [cov.tbl]
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
    doc: NPL Linkage - --deviates
    inputBinding:
      position: 101
  - id: distance
    type:
      - 'null'
      - float
    doc: LD Clusters - --distance
    inputBinding:
      position: 101
  - id: error
    type:
      - 'null'
      - boolean
    doc: General - error
    inputBinding:
      position: 101
  - id: exp
    type:
      - 'null'
      - boolean
    doc: NPL Linkage - --exp
    inputBinding:
      position: 101
  - id: extended
    type:
      - 'null'
      - boolean
    doc: IBD States - --extended
    inputBinding:
      position: 101
  - id: fast_assoc
    type:
      - 'null'
      - boolean
    doc: Association - --fastAssoc
    inputBinding:
      position: 101
  - id: filter
    type:
      - 'null'
      - boolean
    doc: Association - --filter
    inputBinding:
      position: 101
  - id: founders
    type:
      - 'null'
      - boolean
    doc: Haplotyping - --founders
    inputBinding:
      position: 101
  - id: frequencies
    type:
      - 'null'
      - boolean
    doc: Output - --frequencies
    inputBinding:
      position: 101
  - id: grid
    type:
      - 'null'
      - boolean
    doc: Positions - --grid
    inputBinding:
      position: 101
  - id: horizontal
    type:
      - 'null'
      - boolean
    doc: Haplotyping - --horizontal
    inputBinding:
      position: 101
  - id: ibd
    type:
      - 'null'
      - boolean
    doc: IBD States - --ibd
    inputBinding:
      position: 101
  - id: infer
    type:
      - 'null'
      - boolean
    doc: Association - --infer
    inputBinding:
      position: 101
  - id: information
    type:
      - 'null'
      - boolean
    doc: General - information
    inputBinding:
      position: 101
  - id: kinship
    type:
      - 'null'
      - boolean
    doc: IBD States - --kinship
    inputBinding:
      position: 101
  - id: likelihood
    type:
      - 'null'
      - boolean
    doc: General - likelihood
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
    doc: Output - --markerNames
    inputBinding:
      position: 101
  - id: matrices
    type:
      - 'null'
      - boolean
    doc: IBD States - --matrices
    inputBinding:
      position: 101
  - id: max_step
    type:
      - 'null'
      - float
    doc: Positions - --maxStep
    inputBinding:
      position: 101
      prefix: --maxStep
  - id: megabytes
    type:
      - 'null'
      - int
    doc: Limits - --megabytes
    inputBinding:
      position: 101
      prefix: --megabytes
  - id: min_step
    type:
      - 'null'
      - float
    doc: Positions - --minStep
    inputBinding:
      position: 101
      prefix: --minStep
  - id: minutes
    type:
      - 'null'
      - int
    doc: Limits - --minutes
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
    doc: General - model [param.tbl]
    inputBinding:
      position: 101
  - id: no_couple_bits
    type:
      - 'null'
      - boolean
    doc: Performance - --noCoupleBits
    inputBinding:
      position: 101
  - id: npl
    type:
      - 'null'
      - boolean
    doc: NPL Linkage - --npl
    inputBinding:
      position: 101
  - id: one
    type:
      - 'null'
      - boolean
    doc: Recombination - --one
    inputBinding:
      position: 101
  - id: pairs
    type:
      - 'null'
      - boolean
    doc: NPL Linkage - --pairs
    inputBinding:
      position: 101
  - id: pdf
    type:
      - 'null'
      - boolean
    doc: Output - --pdf
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
    doc: Output - --perFamily
    inputBinding:
      position: 101
  - id: prefix
    type:
      - 'null'
      - string
    doc: Output - --prefix
    inputBinding:
      position: 101
  - id: qtl
    type:
      - 'null'
      - boolean
    doc: NPL Linkage - --qtl
    inputBinding:
      position: 101
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Output - --quiet
    inputBinding:
      position: 101
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
    doc: Simulation - --reruns
    inputBinding:
      position: 101
  - id: rsq
    type:
      - 'null'
      - float
    doc: LD Clusters - --rsq
    inputBinding:
      position: 101
  - id: sample
    type:
      - 'null'
      - boolean
    doc: Haplotyping - --sample
    inputBinding:
      position: 101
  - id: save
    type:
      - 'null'
      - File
    doc: Simulation - --save
    inputBinding:
      position: 101
  - id: select
    type:
      - 'null'
      - boolean
    doc: IBD States - --select
    inputBinding:
      position: 101
  - id: simulate
    type:
      - 'null'
      - boolean
    doc: Simulation - --simulate
    inputBinding:
      position: 101
  - id: singlepoint
    type:
      - 'null'
      - boolean
    doc: Recombination - --singlepoint
    inputBinding:
      position: 101
  - id: small_swap
    type:
      - 'null'
      - boolean
    doc: Performance - --smallSwap
    inputBinding:
      position: 101
  - id: start
    type:
      - 'null'
      - float
    doc: Positions - --start
    inputBinding:
      position: 101
  - id: steps
    type:
      - 'null'
      - boolean
    doc: Positions - --steps
    inputBinding:
      position: 101
  - id: stop
    type:
      - 'null'
      - float
    doc: Positions - --stop
    inputBinding:
      position: 101
  - id: swap
    type:
      - 'null'
      - boolean
    doc: Performance - --swap
    inputBinding:
      position: 101
  - id: tabulate
    type:
      - 'null'
      - boolean
    doc: Output - --tabulate
    inputBinding:
      position: 101
  - id: three
    type:
      - 'null'
      - boolean
    doc: Recombination - --three
    inputBinding:
      position: 101
  - id: trait
    type:
      - 'null'
      - type: array
        items: string
    doc: Simulation - --trait []
    inputBinding:
      position: 101
  - id: trim
    type:
      - 'null'
      - boolean
    doc: Performance - --trim
    inputBinding:
      position: 101
  - id: two
    type:
      - 'null'
      - boolean
    doc: Recombination - --two
    inputBinding:
      position: 101
  - id: unlinked
    type:
      - 'null'
      - float
    doc: VC Linkage - --unlinked
    inputBinding:
      position: 101
  - id: use_covariates
    type:
      - 'null'
      - boolean
    doc: VC Linkage - --useCovariates
    inputBinding:
      position: 101
  - id: vc
    type:
      - 'null'
      - boolean
    doc: VC Linkage - --vc
    inputBinding:
      position: 101
  - id: zero
    type:
      - 'null'
      - boolean
    doc: Recombination - --zero
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merlin:1.1.2--h077b44d_8
stdout: merlin_bits.out
