cwlVersion: v1.2
class: CommandLineTool
baseCommand: gpp-gerpelem
label: gerp_gerpelem
doc: "gpp-gerpelem options:\n\nTool homepage: http://mendel.stanford.edu/SidowLab/downloads/gerp/index.html"
inputs:
  - id: acceptable_false_positive_rate
    type:
      - 'null'
      - float
    doc: acceptable false positive rate
    inputBinding:
      position: 101
      prefix: -e
  - id: border_nucleotides_for_shallow_regions
    type:
      - 'null'
      - int
    doc: number of border nucleotides for shallow regions
    inputBinding:
      position: 101
      prefix: -b
  - id: chromosome
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: -c
  - id: column_scores_filename
    type:
      - 'null'
      - File
    doc: column scores filename
    inputBinding:
      position: 101
      prefix: -f
  - id: denominator_min_candidate_element_score
    type:
      - 'null'
      - float
    doc: denominator for minimum candidate element score formula
    inputBinding:
      position: 101
      prefix: -q
  - id: depth_threshold
    type:
      - 'null'
      - float
    doc: depth threshold for shallow columns, in substitutions per site
    inputBinding:
      position: 101
      prefix: -d
  - id: exclusion_region_file_suffix
    type:
      - 'null'
      - string
    doc: suffix for naming exclusion region file
    inputBinding:
      position: 101
      prefix: -w
  - id: exponent_min_candidate_element_score
    type:
      - 'null'
      - float
    doc: exponent for minimum candidate element score formula
    inputBinding:
      position: 101
      prefix: -r
  - id: inverse_tolerance
    type:
      - 'null'
      - float
    doc: inverse of the rounding tolerance
    inputBinding:
      position: 101
      prefix: -t
  - id: max_element_length
    type:
      - 'null'
      - int
    doc: maximum element length
    inputBinding:
      position: 101
      prefix: -L
  - id: min_element_length
    type:
      - 'null'
      - int
    doc: minimum element length
    inputBinding:
      position: 101
      prefix: -l
  - id: output_files_suffix
    type:
      - 'null'
      - string
    doc: suffix for naming output files
    inputBinding:
      position: 101
      prefix: -x
  - id: shallow_columns_penalty
    type:
      - 'null'
      - float
    doc: penalty coefficient for shallow columns, as fraction of the median 
      neutral rate
    inputBinding:
      position: 101
      prefix: -p
  - id: start_offset
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: -s
  - id: total_allowed_non_border_shallow_nucleotides_per_element
    type:
      - 'null'
      - int
    doc: total number of allowed non-border shallow nucleotides per element
    inputBinding:
      position: 101
      prefix: -a
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose mode
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gerp:2.1--h1b792b2_2
stdout: gerp_gerpelem.out
