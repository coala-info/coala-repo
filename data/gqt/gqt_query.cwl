cwlVersion: v1.2
class: CommandLineTool
baseCommand: gqt query
label: gqt_query
doc: "A GQT query returns a set of variants that meet some number of population and
  genotype conditions. Conditions are specified by a population query and genotype
  query pair, where the population query defines the set of individuals to consider
  and the genotype query defines a filter on that population. The result is the set
  of variants within that sub-population that meet the given conditions.\n\nTool homepage:
  https://github.com/ryanlayer/gqt"
inputs:
  - id: bim_file
    type:
      - 'null'
      - File
    doc: bim file (opt.)
    inputBinding:
      position: 101
      prefix: -B
  - id: genotype_query_1
    type: string
    doc: genotype query 1
    inputBinding:
      position: 101
      prefix: -g
  - id: genotype_query_2
    type:
      - 'null'
      - string
    doc: genotype query 2
    inputBinding:
      position: 101
      prefix: -g
  - id: gqt_file
    type:
      - 'null'
      - File
    doc: gqt file (opt.)
    inputBinding:
      position: 101
      prefix: -G
  - id: input_file
    type: File
    doc: bcf/vcf or gqt file
    inputBinding:
      position: 101
      prefix: -i
  - id: off_file
    type:
      - 'null'
      - File
    doc: off file (opt.)
    inputBinding:
      position: 101
      prefix: -O
  - id: only_print_count
    type:
      - 'null'
      - boolean
    doc: only print number of resulting variants
    inputBinding:
      position: 101
      prefix: -c
  - id: ped_database_file
    type: File
    doc: ped database file
    inputBinding:
      position: 101
      prefix: -d
  - id: population_query_1
    type: string
    doc: population query 1
    inputBinding:
      position: 101
      prefix: -p
  - id: population_query_2
    type:
      - 'null'
      - string
    doc: population query 2
    inputBinding:
      position: 101
      prefix: -p
  - id: print_genotypes
    type:
      - 'null'
      - boolean
    doc: print genotypes (from the source bcf/vcf)
    inputBinding:
      position: 101
      prefix: -v
  - id: tmp_directory
    type:
      - 'null'
      - Directory
    doc: tmp direcory name for remote files
    inputBinding:
      position: 101
      prefix: -t
  - id: vid_file
    type:
      - 'null'
      - File
    doc: vid file (opt.)
    inputBinding:
      position: 101
      prefix: -V
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gqt:1.1.3--h0263287_3
stdout: gqt_query.out
