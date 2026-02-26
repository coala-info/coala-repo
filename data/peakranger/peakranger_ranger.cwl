cwlVersion: v1.2
class: CommandLineTool
baseCommand: ranger
label: peakranger_ranger
doc: Peak calling tool for ChIP-seq data
inputs:
  - id: bandwidth
    type:
      - 'null'
      - int
    doc: smoothing bandwidth
    default: 99
    inputBinding:
      position: 101
      prefix: --bandwidth
  - id: control_file
    type: File
    doc: control file
    inputBinding:
      position: 101
      prefix: --control
  - id: data_file
    type: File
    doc: data file
    inputBinding:
      position: 101
      prefix: --data
  - id: delta
    type:
      - 'null'
      - int
    doc: sensitivity of the summit detector
    default: 1
    inputBinding:
      position: 101
      prefix: --delta
  - id: ext_length
    type:
      - 'null'
      - int
    doc: read extension length
    default: 100
    inputBinding:
      position: 101
      prefix: --ext_length
  - id: fdr
    type:
      - 'null'
      - float
    doc: FDR cut-off
    default: 0.01
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
  - id: pad
    type:
      - 'null'
      - boolean
    doc: pad read coverage profile to avoid false positive summmits
    inputBinding:
      position: 101
      prefix: --pad
  - id: plot_region
    type:
      - 'null'
      - int
    doc: the length of the snapshort regions in the report
    default: 6000
    inputBinding:
      position: 101
      prefix: --plot_region
  - id: pval
    type:
      - 'null'
      - float
    doc: p value cut-off
    default: 0.0001
    inputBinding:
      position: 101
      prefix: --pval
  - id: thread
    type:
      - 'null'
      - int
    doc: number of worker threads
    default: 19
    inputBinding:
      position: 101
      prefix: --thread
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: show progress
    inputBinding:
      position: 101
      prefix: --verbose
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
