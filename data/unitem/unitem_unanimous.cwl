cwlVersion: v1.2
class: CommandLineTool
baseCommand: unitem unanimous
label: unitem_unanimous
doc: "Unanimous bin filtering across multiple binning methods.\n\nTool homepage: https://github.com/dparks1134/UniteM"
inputs:
  - id: profile_dir
    type: Directory
    doc: directory with bin profiles (output of 'profile' command)
    inputBinding:
      position: 1
  - id: output_dir
    type: Directory
    doc: output directory
    inputBinding:
      position: 2
  - id: bin_dirs
    type:
      - 'null'
      - type: array
        items: Directory
    doc: directories with bins from different binning methods
    inputBinding:
      position: 103
      prefix: --bin_dirs
  - id: bin_file
    type: File
    doc: 'tab-separated file indicating directories with bins from binning methods
      (two columns: method name and directory)'
    inputBinding:
      position: 103
      prefix: --bin_file
  - id: bin_prefix
    type:
      - 'null'
      - string
    doc: prefix for output bins
    default: bin_
    inputBinding:
      position: 103
      prefix: --bin_prefix
  - id: marker_dir
    type:
      - 'null'
      - Directory
    doc: directory containing Pfam and TIGRfam marker genes data
    inputBinding:
      position: 103
      prefix: --marker_dir
  - id: report_min_quality
    type:
      - 'null'
      - int
    doc: minimum quality of bin to report
    default: 10
    inputBinding:
      position: 103
      prefix: --report_min_quality
  - id: sel_max_cont
    type:
      - 'null'
      - int
    doc: maximum contamination of bin to consider during bin selection process
    default: 10
    inputBinding:
      position: 103
      prefix: --sel_max_cont
  - id: sel_min_comp
    type:
      - 'null'
      - int
    doc: minimum completeness of bin to consider during bin selection process
    default: 50
    inputBinding:
      position: 103
      prefix: --sel_min_comp
  - id: sel_min_quality
    type:
      - 'null'
      - int
    doc: minimum quality of bin to consider during bin selection process
    default: 50
    inputBinding:
      position: 103
      prefix: --sel_min_quality
  - id: silent
    type:
      - 'null'
      - boolean
    doc: suppress output of logger
    inputBinding:
      position: 103
      prefix: --silent
  - id: simple_headers
    type:
      - 'null'
      - boolean
    doc: do not add additional information to FASTA headers
    inputBinding:
      position: 103
      prefix: --simple_headers
  - id: weight
    type:
      - 'null'
      - float
    doc: weight given to contamination for assessing genome quality
    default: 2
    inputBinding:
      position: 103
      prefix: --weight
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unitem:1.2.6--pyhdfd78af_0
stdout: unitem_unanimous.out
