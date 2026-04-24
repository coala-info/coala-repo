cwlVersion: v1.2
class: CommandLineTool
baseCommand: snoscan
label: snoscan
doc: "Find snoRNA genes containing rRNA complementarity and C & D boxes\n\nTool homepage:
  http://lowelab.ucsc.edu/snoscan"
inputs:
  - id: rRNA_sequence_file
    type: File
    doc: rRNA sequence file
    inputBinding:
      position: 1
  - id: query_sequence_file
    type: File
    doc: query sequence file
    inputBinding:
      position: 2
  - id: c_box_score_cutoff
    type:
      - 'null'
      - float
    doc: set C Box score cutoff to <Score>
    inputBinding:
      position: 103
      prefix: -C
  - id: d_prime_box_score_cutoff
    type:
      - 'null'
      - float
    doc: set D prime Box score cutoff to <Score>
    inputBinding:
      position: 103
      prefix: -D
  - id: final_score_cutoff
    type:
      - 'null'
      - float
    doc: set final score cutoff to <Score>
    inputBinding:
      position: 103
      prefix: -X
  - id: initiate_scan_position
    type:
      - 'null'
      - int
    doc: Initiate scan at <position> in sequence
    inputBinding:
      position: 103
      prefix: -i
  - id: max_c_d_box_distance
    type:
      - 'null'
      - int
    doc: set max distance between C & D boxes
    inputBinding:
      position: 103
      prefix: -d
  - id: max_distance_to_meth_site
    type:
      - 'null'
      - int
    doc: set max distance to known meth site
    inputBinding:
      position: 103
      prefix: -M
  - id: methylation_sites_file
    type:
      - 'null'
      - File
    doc: specify methylation sites
    inputBinding:
      position: 103
      prefix: -m
  - id: min_complementary_region_score
    type:
      - 'null'
      - float
    doc: set min score for complementary region match
    inputBinding:
      position: 103
      prefix: -c
  - id: min_pairing_length
    type:
      - 'null'
      - int
    doc: set minimim length for snoRNA-rRNA pairing
    inputBinding:
      position: 103
      prefix: -l
  - id: min_rRNA_match_d_box_distance
    type:
      - 'null'
      - int
    doc: set min distance between rRNA match & D box when D prime box is present
    inputBinding:
      position: 103
      prefix: -p
  - id: save_snoRNA_sequences
    type:
      - 'null'
      - boolean
    doc: save snoRNA sequences with hit info
    inputBinding:
      position: 103
      prefix: -s
  - id: verbose_output
    type:
      - 'null'
      - boolean
    doc: verbose output
    inputBinding:
      position: 103
      prefix: -V
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: save candidates in <outfile>
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snoscan:1.0--pl5321h031d066_5
