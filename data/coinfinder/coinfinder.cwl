cwlVersion: v1.2
class: CommandLineTool
baseCommand: confinder
label: coinfinder
doc: "File input- specify either: The path to the gene_presence_absence.csv output
  from Roary -or- The path of the Gene-to-Genome file with (gene)(TAB)(genome)\n\n\
  Tool homepage: https://github.com/fwhelan/coinfinder"
inputs:
  - id: all
    type:
      - 'null'
      - boolean
    doc: Outputs all results, regardless of significance.
    inputBinding:
      position: 101
      prefix: --all
  - id: associate
    type:
      - 'null'
      - boolean
    doc: Overlap; identify groups that tend to associate/co-occur (default).
    default: true
    inputBinding:
      position: 101
      prefix: --associate
  - id: bonferroni
    type:
      - 'null'
      - boolean
    doc: Bonferroni correction multiple correction (recommended & default)
    default: true
    inputBinding:
      position: 101
      prefix: --bonferroni
  - id: dissociate
    type:
      - 'null'
      - boolean
    doc: Separation; identify groups that tend to dissociate/avoid.
    inputBinding:
      position: 101
      prefix: --dissociate
  - id: filter
    type:
      - 'null'
      - boolean
    doc: Permit filtering of saturated and low-abundance data.
    inputBinding:
      position: 101
      prefix: --filter
  - id: filthreshold
    type:
      - 'null'
      - float
    doc: 'Threshold for low-abundance data filtering (default: 0.05 i.e. any gene
      in <=5% of genomes.'
    default: 0.05
    inputBinding:
      position: 101
      prefix: --filthreshold
  - id: fraction
    type:
      - 'null'
      - boolean
    doc: (Connectivity analysis only) Use fraction rather than p-value
    inputBinding:
      position: 101
      prefix: --fraction
  - id: greater
    type:
      - 'null'
      - boolean
    doc: Greater (recommended & default)
    default: true
    inputBinding:
      position: 101
      prefix: --greater
  - id: input
    type:
      - 'null'
      - File
    doc: The path to the gene_presence_absence.csv output from Roary -or- The 
      path of the Gene-to-Genome file with (gene)(TAB)(genome)
    inputBinding:
      position: 101
      prefix: --input
  - id: inputroary
    type:
      - 'null'
      - boolean
    doc: Set if -i is in the gene_presence_absence.csv format from Roary
    inputBinding:
      position: 101
      prefix: --inputroary
  - id: less
    type:
      - 'null'
      - boolean
    doc: Less
    inputBinding:
      position: 101
      prefix: --less
  - id: level
    type:
      - 'null'
      - float
    doc: 'Specify the significnace level cutoff (default: 0.05)'
    default: 0.05
    inputBinding:
      position: 101
      prefix: --level
  - id: nocorrection
    type:
      - 'null'
      - boolean
    doc: No correction, use value as-is
    inputBinding:
      position: 101
      prefix: --nocorrection
  - id: num_cores
    type:
      - 'null'
      - int
    doc: 'The number of cores to use (default: 2)'
    default: 2
    inputBinding:
      position: 101
      prefix: --num_cores
  - id: output
    type:
      - 'null'
      - string
    doc: 'The prefix of all output files (default: coincident).'
    default: coincident
    inputBinding:
      position: 101
      prefix: --output
  - id: phylogeny
    type: File
    doc: Phylogeny of Betas in Newick format (required)
    inputBinding:
      position: 101
      prefix: --phylogeny
  - id: query
    type:
      - 'null'
      - File
    doc: The path to a file containing a list of genes to specificcally query, 
      one per line (optional).
    inputBinding:
      position: 101
      prefix: --query
  - id: test
    type:
      - 'null'
      - boolean
    doc: Runs the test cases and exits.
    inputBinding:
      position: 101
      prefix: --test
  - id: twotailed
    type:
      - 'null'
      - boolean
    doc: Two-tailed
    inputBinding:
      position: 101
      prefix: --twotailed
  - id: upfilthreshold
    type:
      - 'null'
      - float
    doc: 'Upper filter threshold for high-abundance data filtering (default: 1.0 i.e.
      any gene in >=100/% of genomes.'
    default: 1.0
    inputBinding:
      position: 101
      prefix: --upfilthreshold
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coinfinder:1.2.1--py39hb8976ed_3
stdout: coinfinder.out
