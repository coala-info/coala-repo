cwlVersion: v1.2
class: CommandLineTool
baseCommand: msalign2
label: msalign2
doc: "msalign2 aligns two LC-MS or CE-MS datasets (mzXML) by matching accurate masses
  across the runs and fitting a piecewise curve to the matched retention times.\n\nTool
  homepage: http://www.ms-utils.org/msalign2/index.html"
inputs:
  - id: lc_ms_dataset_1_filename
    type: File
    doc: LC-MS dataset 1 (mzXML) filename; the dataset to align.
    inputBinding:
      position: 1
      prefix: '-1'
      separate: false
  - id: lc_ms_dataset_2_filename
    type: File
    doc: LC-MS dataset 2 (mzXML) filename; the master dataset.
    inputBinding:
      position: 2
      prefix: '-2'
      separate: false
  - id: max_mass_error_ppm
    type: float
    doc: Maximum mass error in MS-only data (in ppm).
    inputBinding:
      position: 3
      prefix: -e
      separate: false
  - id: number_of_features
    type: int
    doc: Number of features used for alignment (within +/-10% of this value). Not
      in the -h text, but required by the program (-f; see the tool homepage).
    inputBinding:
      position: 4
      prefix: -f
      separate: false
  - id: cost_per_breakpoint
    type: float
    doc: Cost per breakpoint (general value is between 0.3 and 0.5). Not in the -h
      text, but required by the program (-c; see the tool homepage).
    inputBinding:
      position: 5
      prefix: -c
      separate: false
  - id: fitness
    type: float
    doc: Fitness (general value is 1). Not in the -h text, but required by the
      program (-d; see the tool homepage).
    inputBinding:
      position: 6
      prefix: -d
      separate: false
  - id: background
    type:
      - 'null'
      - string
    doc: Background. Accepted by the help text, but ignored by this version (the
      option is commented out in the source).
    inputBinding:
      position: 7
      prefix: -b
      separate: false
  - id: typical_std_dev_lc_retention_time
    type:
      - 'null'
      - float
    doc: Typical standard deviation in LC retention time in LC-MS data.
    inputBinding:
      position: 8
      prefix: -l
      separate: false
  - id: xmax
    type:
      - 'null'
      - float
    doc: Xmax.
    inputBinding:
      position: 9
      prefix: -X
      separate: false
  - id: ymax
    type:
      - 'null'
      - float
    doc: Ymax.
    inputBinding:
      position: 10
      prefix: -Y
      separate: false
  - id: ms_scan_range
    type:
      - 'null'
      - string
    doc: 'MS start scan and MS end scan, as "start,end" (for example 1,1300).'
    inputBinding:
      position: 11
      prefix: -R
      separate: false
  - id: no_graphics
    type:
      - 'null'
      - boolean
    doc: Do not draw graphics.
    inputBinding:
      position: 12
      prefix: -nographics
  - id: output_file_path
    type: string
    doc: Output file name (the matched time pairs; the best fit goes to <output>.plf).
    inputBinding:
      position: 13
      prefix: -o
      separate: false
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Matched masses and scans of the two datasets.
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: best_fit
    type:
      - 'null'
      - File
    doc: Best piecewise fit (.plf file).
    outputBinding:
      glob: $(inputs.output_file_path).plf
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msalign2:1.0--h577a1d6_6
