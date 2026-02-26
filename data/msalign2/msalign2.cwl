cwlVersion: v1.2
class: CommandLineTool
baseCommand: msalign
label: msalign2
doc: "(c) Magnus Palmblad 2007-\n\nTool homepage: http://www.ms-utils.org/msalign2/index.html"
inputs:
  - id: background
    type:
      - 'null'
      - string
    doc: background
    inputBinding:
      position: 101
      prefix: -b
  - id: lc_ms_dataset_1_filename
    type: File
    doc: LC-MS dataset 1 filename
    inputBinding:
      position: 101
      prefix: '-1'
  - id: lc_ms_dataset_2_filename
    type: File
    doc: LC-MS dataset 2 filename
    inputBinding:
      position: 101
      prefix: '-2'
  - id: max_mass_error_ppm
    type: float
    doc: max. mass error in MS-only data (in ppm)
    inputBinding:
      position: 101
      prefix: -e
  - id: ms_scan_range
    type:
      - 'null'
      - string
    doc: MS start scan,MS end scan
    inputBinding:
      position: 101
      prefix: -R
  - id: no_graphics
    type:
      - 'null'
      - boolean
    doc: no graphics
    inputBinding:
      position: 101
      prefix: -nographics
  - id: typical_std_dev_lc_retention_time
    type:
      - 'null'
      - float
    doc: typical standard deviation in LC retention time in LC-MS data
    inputBinding:
      position: 101
      prefix: -l
  - id: xmax
    type:
      - 'null'
      - float
    doc: Xmax
    inputBinding:
      position: 101
      prefix: -X
  - id: ymax
    type:
      - 'null'
      - float
    doc: Ymax
    inputBinding:
      position: 101
      prefix: -Y
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msalign2:1.0--h577a1d6_6
