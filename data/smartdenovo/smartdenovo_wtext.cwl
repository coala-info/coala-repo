cwlVersion: v1.2
class: CommandLineTool
baseCommand: wtext
label: smartdenovo_wtext
doc: "WTEXT: Extending and clipping overlaps (SMARTdenovo)\n\nTool homepage: https://github.com/ruanjue/smartdenovo"
inputs:
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads, [1]"
    inputBinding:
      position: 101
      prefix: -t
  - id: total_parallel_jobs
    type:
      - 'null'
      - int
    doc: "Total parallel jobs, [1]"
    inputBinding:
      position: 101
      prefix: -P
  - id: current_job_index
    type:
      - 'null'
      - int
    doc: "Index of current job (0-based), [0]"
    inputBinding:
      position: 101
      prefix: -p
  - id: long_reads
    type:
      type: array
      items: File
      inputBinding:
        prefix: -i
    doc: "Long reads sequences file(s), +, *"
    inputBinding:
      position: 101
  - id: previous_retained_region
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: -B
    doc: "Long reads previous retained region, often from wtcyc, +. Format: read_name\\toffset\\tlength"
    inputBinding:
      position: 101
  - id: retained_region
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: -b
    doc: "Long reads retained region, often from wtobt, +. Format: read_name\\toffset\\tlength"
    inputBinding:
      position: 101
  - id: overlap_files
    type:
      type: array
      items: File
      inputBinding:
        prefix: -j
    doc: "Overlap file(s), +, *. Format: reads1\\t+/-\\tlen1\\tbeg1\\tend1\\treads2\\t+/-\\tlen2\\tbeg2\\tend2\\tscore\\tidentity\\tmat\\tmis\\tins\\tdel\\tcigar"
    inputBinding:
      position: 101
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: "Force overwrite"
    inputBinding:
      position: 101
      prefix: -f
  - id: bandwidth
    type:
      - 'null'
      - float
    doc: "Bandwidth, [800]"
    inputBinding:
      position: 101
      prefix: -W
  - id: penalty_match
    type:
      - 'null'
      - int
    doc: "Alignment penalty: match, [2]"
    inputBinding:
      position: 101
      prefix: -M
  - id: penalty_mismatch
    type:
      - 'null'
      - int
    doc: "Alignment penalty: mismatch, [-5]"
    inputBinding:
      position: 101
      prefix: -X
  - id: penalty_indel
    type:
      - 'null'
      - int
    doc: "Alignment penalty: insertion or deletion, [-3]"
    inputBinding:
      position: 101
      prefix: -O
  - id: penalty_gap_extension
    type:
      - 'null'
      - int
    doc: "Alignment penalty: gap extension, [-1]"
    inputBinding:
      position: 101
      prefix: -E
  - id: penalty_end_clipping
    type:
      - 'null'
      - int
    doc: "Alignment penalty: read end clipping [-100]"
    inputBinding:
      position: 101
      prefix: -T
  - id: max_extension
    type:
      - 'null'
      - int
    doc: "Maximum extension (bp) in each end, [400]"
    inputBinding:
      position: 101
      prefix: -S
  - id: output_path
    type: string
    doc: "Output file of extended alignments, *"
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: output
    type: File
    doc: "Extended alignments"
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smartdenovo:1.0.0--h7b50bb2_8
