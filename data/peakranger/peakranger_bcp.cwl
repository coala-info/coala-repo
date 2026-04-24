cwlVersion: v1.2
class: CommandLineTool
baseCommand: bcp
label: peakranger_bcp
doc: Peakranger BCP (Broadly Conserved Peaks) tool for identifying conserved 
  peaks.
inputs:
  - id: control_file
    type:
      - 'null'
      - File
    doc: control file
    inputBinding:
      position: 101
      prefix: --control
  - id: data_file
    type:
      - 'null'
      - File
    doc: data file
    inputBinding:
      position: 101
      prefix: --data
  - id: ext_length
    type:
      - 'null'
      - int
    doc: read extension length
    inputBinding:
      position: 101
      prefix: --ext_length
  - id: format
    type:
      - 'null'
      - string
    doc: 'the format of the data file, can be one of : bowtie, sam, bam and bed'
    inputBinding:
      position: 101
  - id: gene_annot_file
    type:
      - 'null'
      - File
    doc: the gene annotation file
    inputBinding:
      position: 101
  - id: generate_reports
    type:
      - 'null'
      - boolean
    doc: generate html reports
    inputBinding:
      position: 101
      prefix: --report
  - id: p_value_cutoff
    type:
      - 'null'
      - float
    doc: p value cut-off
    inputBinding:
      position: 101
      prefix: --pval
  - id: plot_region
    type:
      - 'null'
      - int
    doc: the length of the snapshort regions in the report
    inputBinding:
      position: 101
      prefix: --plot_region
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: show progress
    inputBinding:
      position: 101
      prefix: --verbose
  - id: win_size
    type:
      - 'null'
      - int
    doc: sliding window size
    inputBinding:
      position: 101
outputs:
  - id: output_location
    type:
      - 'null'
      - Directory
    doc: the output location
    outputBinding:
      glob: $(inputs.output_location)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peakranger:1.18--hdcf5f25_9
