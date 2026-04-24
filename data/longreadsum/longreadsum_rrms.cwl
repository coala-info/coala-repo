cwlVersion: v1.2
class: CommandLineTool
baseCommand: longreadsum rrms
label: longreadsum_rrms
doc: "Extracts read information based on a CSV file and BAM input.\n\nTool homepage:
  https://github.com/WGLab/LongReadSum"
inputs:
  - id: csv
    type: File
    doc: CSV file containing read IDs to extract from the BAM file. The CSV file
      should contain a read id column with the header 'read_id' as well as a 
      column containing the accepted/rejected status of the read with the header
      'decision'. Accepted reads should have a value of 'stop_receiving' in the 
      'decision' column, while rejected reads should have a value of 'unblock'.
    inputBinding:
      position: 101
      prefix: --csv
  - id: detail
    type:
      - 'null'
      - int
    doc: 'Will output detail in files? Default: 0(no).'
    inputBinding:
      position: 101
      prefix: --detail
  - id: downsample_percentage
    type:
      - 'null'
      - float
    doc: 'The percentage of downsampling for quick run. Default: 1.0 without downsampling'
    inputBinding:
      position: 101
      prefix: --downsample_percentage
  - id: fontsize
    type:
      - 'null'
      - int
    doc: 'Font size for plots. Default: 14'
    inputBinding:
      position: 101
      prefix: --fontsize
  - id: input
    type:
      - 'null'
      - File
    doc: Single input filepath
    inputBinding:
      position: 101
      prefix: --input
  - id: input_pattern
    type:
      - 'null'
      - string
    doc: Use pattern matching (*) to specify multiple input files. Enclose the 
      pattern in double quotes.
    inputBinding:
      position: 101
      prefix: --inputPattern
  - id: inputs
    type:
      - 'null'
      - type: array
        items: string
    doc: Multiple comma-separated input filepaths
    inputBinding:
      position: 101
      prefix: --inputs
  - id: log
    type:
      - 'null'
      - File
    doc: Log file
    inputBinding:
      position: 101
      prefix: --log
  - id: log_level
    type:
      - 'null'
      - int
    doc: 'Logging level. 1: DEBUG, 2: INFO, 3: WARNING, 4: ERROR, 5: CRITICAL. Default:
      2.'
    inputBinding:
      position: 101
      prefix: --log_level
  - id: markersize
    type:
      - 'null'
      - int
    doc: 'Marker size for plots. Default: 10'
    inputBinding:
      position: 101
      prefix: --markersize
  - id: outprefix
    type:
      - 'null'
      - string
    doc: 'The prefix of output. Default: `QC_`.'
    inputBinding:
      position: 101
      prefix: --outprefix
  - id: read_count
    type:
      - 'null'
      - type: array
        items: int
    doc: 'Set the number of reads to randomly sample from the file. Default: 8.'
    inputBinding:
      position: 101
      prefix: --readCount
  - id: seed
    type:
      - 'null'
      - int
    doc: 'The number for random seed. Default: 1.'
    inputBinding:
      position: 101
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: 'The number of threads used. Default: 1.'
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: The output folder.
    outputBinding:
      glob: $(inputs.output_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/longreadsum:1.3.1--py310h16889fc_2
