cwlVersion: v1.2
class: CommandLineTool
baseCommand: ccat
label: peakranger_ccat
doc: "ccat 1.18\n\nTool homepage: https://www.gnu.org/software/coreutils/"
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
  - id: extension_length
    type:
      - 'null'
      - int
    doc: read extension length
    default: 200
    inputBinding:
      position: 101
      prefix: --ext_length
  - id: fdr_cutoff
    type:
      - 'null'
      - float
    doc: FDR cut-off
    default: 0.11
    inputBinding:
      position: 101
      prefix: --FDR
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
  - id: min_window_reads_count
    type:
      - 'null'
      - int
    doc: minimum window reads count
    default: 4
    inputBinding:
      position: 101
      prefix: --min_count
  - id: min_window_reads_fold_change
    type:
      - 'null'
      - int
    doc: minimum window reads fold change
    default: 5
    inputBinding:
      position: 101
      prefix: --min_score
  - id: plot_region_length
    type:
      - 'null'
      - int
    doc: the length of the snapshort regions in the report
    default: 6000
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
  - id: window_size
    type:
      - 'null'
      - int
    doc: sliding window size
    default: 500
    inputBinding:
      position: 101
      prefix: --win_size
  - id: window_step
    type:
      - 'null'
      - int
    doc: window moving step
    default: 50
    inputBinding:
      position: 101
      prefix: --win_step
  - id: worker_threads
    type:
      - 'null'
      - int
    doc: number of worker threads
    default: 19
    inputBinding:
      position: 101
      prefix: --thread
outputs:
  - id: output_location
    type:
      - 'null'
      - File
    doc: the output location
    outputBinding:
      glob: $(inputs.output_location)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peakranger:1.18--hdcf5f25_9
