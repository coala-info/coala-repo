cwlVersion: v1.2
class: CommandLineTool
baseCommand: lucy
label: lucy
doc: "Less Useful Chunks Yank (lucy)\n\nTool homepage: https://github.com/DecartAI/Lucy-Edit-ComfyUI"
inputs:
  - id: sequence_file
    type: File
    doc: Input sequence file
    inputBinding:
      position: 1
  - id: quality_file
    type: File
    doc: Input quality file
    inputBinding:
      position: 2
  - id: second_sequence_file
    type:
      - 'null'
      - File
    doc: Optional second input sequence file
    inputBinding:
      position: 3
  - id: alignment
    type:
      - 'null'
      - type: array
        items: string
    doc: area1 area2 area3
    inputBinding:
      position: 104
  - id: bracket
    type:
      - 'null'
      - type: array
        items: float
    doc: window_size max_avg_error
    inputBinding:
      position: 104
  - id: cdna
    type:
      - 'null'
      - boolean
    doc: minimum_span maximum_error initial_search_range
    inputBinding:
      position: 104
  - id: debug
    type:
      - 'null'
      - File
    doc: filename
    inputBinding:
      position: 104
  - id: error
    type:
      - 'null'
      - type: array
        items: float
    doc: max_avg_error max_error_at_ends
    inputBinding:
      position: 104
  - id: inform_me
    type:
      - 'null'
      - boolean
    doc: Inform the user
    inputBinding:
      position: 104
  - id: keep
    type:
      - 'null'
      - boolean
    doc: Keep intermediate files
    inputBinding:
      position: 104
  - id: minimum
    type:
      - 'null'
      - int
    doc: good_sequence_length
    inputBinding:
      position: 104
  - id: pass_along
    type:
      - 'null'
      - type: array
        items: float
    doc: min_value max_value med_value
    inputBinding:
      position: 104
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress output
    inputBinding:
      position: 104
  - id: range
    type:
      - 'null'
      - type: array
        items: string
    doc: area1 area2 area3
    inputBinding:
      position: 104
  - id: size
    type:
      - 'null'
      - int
    doc: vector_tag_size
    inputBinding:
      position: 104
  - id: threshold
    type:
      - 'null'
      - float
    doc: vector_cutoff
    inputBinding:
      position: 104
  - id: vector
    type:
      - 'null'
      - type: array
        items: File
    doc: vector_sequence_file splice_site_file
    inputBinding:
      position: 104
  - id: window
    type:
      - 'null'
      - type: array
        items: float
    doc: window_size max_avg_error [window_size max_avg_error ...]
    inputBinding:
      position: 104
  - id: xtra
    type:
      - 'null'
      - int
    doc: cpu_threads
    inputBinding:
      position: 104
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: sequence_filename quality_filename
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/lucy:v1.20-1-deb_cv1
