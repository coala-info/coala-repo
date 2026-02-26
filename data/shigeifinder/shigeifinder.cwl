cwlVersion: v1.2
class: CommandLineTool
baseCommand: ShigeiFinder.py
label: shigeifinder
doc: "ShigeiFinder.py is a tool for analyzing assembly or raw read data.\n\nTool homepage:
  https://github.com/LanLab/ShigEiFinder"
inputs:
  - id: check_hits
    type:
      - 'null'
      - boolean
    doc: To show the blast/alignment hits
    inputBinding:
      position: 101
      prefix: --check
  - id: depth
    type:
      - 'null'
      - float
    doc: When using reads as input the minimum read depth for non ipaH/Oantigen 
      gene to be called (default 10.0).
    default: 10.0
    inputBinding:
      position: 101
      prefix: --depth
  - id: input_data
    type:
      type: array
      items: string
    doc: path/to/input_data
    inputBinding:
      position: 101
      prefix: -i
  - id: ipaH_depth
    type:
      - 'null'
      - float
    doc: When using reads as input the minimum depth percentage relative to 
      genome average for positive ipaH gene call (default 1.0).
    default: 1.0
    inputBinding:
      position: 101
      prefix: --ipaH_depth
  - id: noheader
    type:
      - 'null'
      - boolean
    doc: do not print output header
    inputBinding:
      position: 101
      prefix: --noheader
  - id: o_depth
    type:
      - 'null'
      - float
    doc: When using reads as input the minimum depth percentage relative to 
      genome average for positive O antigen gene call (default 1.0).
    default: 1.0
    inputBinding:
      position: 101
      prefix: --o_depth
  - id: raw_reads
    type:
      - 'null'
      - boolean
    doc: Add flag if file is raw reads.
    inputBinding:
      position: 101
      prefix: -r
  - id: show_dratio
    type:
      - 'null'
      - boolean
    doc: To show the depth ratios of cluster-specific genes to House Keeping 
      genes
    inputBinding:
      position: 101
      prefix: --dratio
  - id: show_hits
    type:
      - 'null'
      - boolean
    doc: To show the blast/alignment hits
    inputBinding:
      position: 101
      prefix: --hits
  - id: single_end
    type:
      - 'null'
      - boolean
    doc: Add flag if raw reads are single end rather than paired.
    inputBinding:
      position: 101
      prefix: --single_end
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads.
    default: 4
    inputBinding:
      position: 101
      prefix: -t
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: temporary folder to use for intermediate files
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: update_db
    type:
      - 'null'
      - boolean
    doc: Add flag if you added new sequences to genes database.
    inputBinding:
      position: 101
      prefix: --update_db
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output file to write to (if not used writes to stdout)
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shigeifinder:1.3.5--pyhdfd78af_0
