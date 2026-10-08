cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gqt
  - query
label: gqt_query
doc: "A GQT query returns a set of variants that meet some number of population and
  genotype conditions. Conditions are specified by a population query and genotype
  query pair, where the population query defines the set of individuals to consider
  and the genotype query defines a filter on that population. The result is the set
  of variants within that sub-population that meet the given conditions.\n\nTool homepage:
  https://github.com/ryanlayer/gqt"
requirements:
  - class: SchemaDefRequirement
    types:
      - name: gqt_query_pair
        type: record
        fields:
          - name: population_query
            type: string
            doc: Population query (for example "Population = 'GBR'")
            inputBinding:
              position: 1
              prefix: -p
          - name: genotype_query
            type: string
            doc: Genotype query (for example "HET" or "count(HET) >= 10")
            inputBinding:
              position: 2
              prefix: -g
inputs:
  - id: input_file
    type: File
    secondaryFiles:
      - pattern: ^.vid
        required: false
      - pattern: ^.off
        required: false
      - pattern: ^.bim
        required: false
    doc: bcf/vcf or gqt file (a gqt file needs its .vid, .off and .bim files beside
      it)
    inputBinding:
      position: 101
      prefix: -i
  - id: ped_database_file
    type:
      - 'null'
      - File
    doc: ped database file
    inputBinding:
      position: 101
      prefix: -d
  - id: bim_file
    type:
      - 'null'
      - File
    doc: bim file (opt.)
    inputBinding:
      position: 101
      prefix: -B
  - id: off_file
    type:
      - 'null'
      - File
    doc: off file (opt.)
    inputBinding:
      position: 101
      prefix: -O
  - id: vid_file
    type:
      - 'null'
      - File
    doc: vid file (opt.)
    inputBinding:
      position: 101
      prefix: -V
  - id: gqt_file
    type:
      - 'null'
      - File
    doc: gqt file (opt.)
    inputBinding:
      position: 101
      prefix: -G
  - id: only_print_count
    type:
      - 'null'
      - boolean
    doc: only print number of resulting variants
    inputBinding:
      position: 101
      prefix: -c
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
      - string
    doc: tmp direcory name for remote files (default ./)
    inputBinding:
      position: 101
      prefix: -t
  - id: queries
    type:
      - 'null'
      - type: array
        items: gqt_query_pair
    doc: Population query and genotype query pairs. Any number of pairs can be
      given to refine the set of variants.
    inputBinding:
      position: 102
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gqt:1.1.3--h0263287_3
stdout: gqt_query.out
