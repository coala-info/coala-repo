cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - java
  - -jar
  - MendelScan.jar
  - sibd
label: mendelscan_sibd
doc: "Calculates IBD segments for sibling pairs.\n\nTool homepage: https://github.com/genome/mendelscan"
inputs:
  - id: fibd
    type: File
    doc: The uncompressed FastIBD output file from BEAGLE
    inputBinding:
      position: 1
  - id: centromere_file
    type:
      - 'null'
      - File
    doc: A tab-delimited, BED-like file indicating centromere locations by 
      chromosome
    inputBinding:
      position: 102
      prefix: --centromere-file
  - id: ibd_score_threshold
    type:
      - 'null'
      - float
    doc: Maximum Beagle FastIBD score below which segments will be used
    default: '10e-10'
    inputBinding:
      position: 102
      prefix: --ibd-score-threshold
  - id: inheritance
    type:
      - 'null'
      - string
    doc: 'Presumed model of inheritance: dominant, recessive, x-linked'
    default: dominant
    inputBinding:
      position: 102
      prefix: --inheritance
  - id: markers_file
    type:
      - 'null'
      - File
    doc: Markers file in BEAGLE format
    inputBinding:
      position: 102
      prefix: --markers-file
  - id: ped_file
    type:
      - 'null'
      - File
    doc: Pedigree file in 6-column tab-delimited format
    inputBinding:
      position: 102
      prefix: --ped-file
  - id: window_resolution
    type:
      - 'null'
      - int
    doc: Window size in base pairs to use for SIBD region binning
    default: 100000
    inputBinding:
      position: 102
      prefix: --window-resolution
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file to contain IBD markers with chromosomal coordinates
    outputBinding:
      glob: $(inputs.output_file)
  - id: output_windows
    type:
      - 'null'
      - File
    doc: Output file to contain RHRO windows. Otherwise they print to STDOUT
    outputBinding:
      glob: $(inputs.output_windows)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mendelscan:v1.2.2--0
