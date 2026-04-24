cwlVersion: v1.2
class: CommandLineTool
baseCommand: SimBac
label: simbac_SimBac
doc: "Simulates bacterial recombination events.\n\nTool homepage: https://github.com/tbrown91/SimBac"
inputs:
  - id: avg_length_external_recombinant_interval
    type:
      - 'null'
      - int
    doc: Sets the average length of external recombinant interval
    inputBinding:
      position: 101
      prefix: -e
  - id: delta
    type:
      - 'null'
      - int
    doc: Sets the value of delta
    inputBinding:
      position: 101
      prefix: -D
  - id: fragments
    type:
      - 'null'
      - type: array
        items: string
    doc: Sets the number and length of the fragments
    inputBinding:
      position: 101
      prefix: -B
  - id: gap_between_fragments
    type:
      - 'null'
      - int
    doc: Sets the gap between each fragment
    inputBinding:
      position: 101
      prefix: -G
  - id: include_ancestral_material
    type:
      - 'null'
      - boolean
    doc: Include ancestral material in the DOT graph
    inputBinding:
      position: 101
      prefix: -a
  - id: max_mutation_prob
    type:
      - 'null'
      - float
    doc: Sets the maximum probability of mutation in an interval of external 
      recombination between 0 & 1
    inputBinding:
      position: 101
      prefix: -M
  - id: min_mutation_prob
    type:
      - 'null'
      - float
    doc: Sets the minimum probability of mutation in an interval of external 
      recombination between 0 & 1
    inputBinding:
      position: 101
      prefix: -m
  - id: num_isolates
    type:
      - 'null'
      - int
    doc: Sets the number of isolates
    inputBinding:
      position: 101
      prefix: -N
  - id: seed
    type:
      - 'null'
      - int
    doc: Use given seed to initiate random number generator
    inputBinding:
      position: 101
      prefix: -s
  - id: site_specific_external_recombination_rate
    type:
      - 'null'
      - float
    doc: Sets the rate of R external, the site-specific rate of external 
      recombination
    inputBinding:
      position: 101
      prefix: -r
  - id: site_specific_internal_recombination_rate
    type:
      - 'null'
      - float
    doc: Sets the value of R, the site-specific internal recombination rate
    inputBinding:
      position: 101
      prefix: -R
  - id: theta
    type:
      - 'null'
      - float
    doc: Sets the value of theta, between 0 and 1
    inputBinding:
      position: 101
      prefix: -T
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Export data to given file
    outputBinding:
      glob: $(inputs.output_file)
  - id: clonal_genealogy_file
    type:
      - 'null'
      - File
    doc: Export clonal genealogy to given file
    outputBinding:
      glob: $(inputs.clonal_genealogy_file)
  - id: local_trees_file
    type:
      - 'null'
      - File
    doc: Export local trees to given file
    outputBinding:
      glob: $(inputs.local_trees_file)
  - id: internal_recombinant_break_log
    type:
      - 'null'
      - File
    doc: Write log file of internal recombinant break interval locations
    outputBinding:
      glob: $(inputs.internal_recombinant_break_log)
  - id: external_recombinant_break_log
    type:
      - 'null'
      - File
    doc: Write log file of external recombinant break interval locations
    outputBinding:
      glob: $(inputs.external_recombinant_break_log)
  - id: recombinant_break_log_with_taxa
    type:
      - 'null'
      - File
    doc: Write log file of recombinant break interval locations and relevant 
      taxa (Use only recommended for small ARGs)
    outputBinding:
      glob: $(inputs.recombinant_break_log_with_taxa)
  - id: dot_graph_file
    type:
      - 'null'
      - File
    doc: Export DOT graph to given file
    outputBinding:
      glob: $(inputs.dot_graph_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/simbac:0.1a--h3053a90_6
