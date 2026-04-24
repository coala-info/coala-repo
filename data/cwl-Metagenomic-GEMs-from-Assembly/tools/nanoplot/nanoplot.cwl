#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool

label: "NanoPlot"
doc: |
      Plotting suite for long read sequencing data and alignments
      
      Modified from:
        https://github.com/common-workflow-library/bio-cwl-tools/blob/release/nanoplot/nanoplot.cwl

# Network access needed for Plotly (kaleido)
requirements:
  InlineJavascriptRequirement: {}
  NetworkAccess:
    networkAccess: true

hints:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/nanoplot:1.43.0--pyhdfd78af_1
  SoftwareRequirement:
    packages:
      NanoPlot:
        specs: [ "https://github.com/wdecoster/NanoPlot/releases", "doi.org/10.1093/bioinformatics/btad311"]
        version: [ "1.43.0" ]

baseCommand: NanoPlot

inputs:
  threads:
    type: int?
    inputBinding:
      prefix: '--threads'
  verbose:
    type: boolean?
    inputBinding:
      prefix: '--verbose'
  max_length:
    type: int?
    inputBinding:
      prefix: '--maxlength'
  min_length:
    type: int?
    inputBinding:
      prefix: '--minlength'
  min_quality:
    type: int?
    inputBinding:
      prefix: '--minqual'
  drop_outliers:
    type: boolean?
    inputBinding:
      prefix: '--drop_outliers'
  log_length:
    type: boolean?
    inputBinding:
      prefix: '--loglength'
  percent_quality:
    type: boolean?
    inputBinding:
      prefix: '--percentqual'
  aligned_length:
    type: boolean?
    inputBinding:
      prefix: '--alength'
  barcoded:
    type: boolean?
    inputBinding:
      prefix: '--barcoded'
  downsample:
    type: int?
    inputBinding:
      prefix: '--downsample'
  run_until:
    type: int?
    inputBinding:
      prefix: '--runtime_until'
  read_type:
    type:
      - "null"
      - type: enum
        symbols: [1D, 2D, 1D2]
    inputBinding:
      prefix: '--readtype'

  color:
    type: string?
    inputBinding:
      prefix: '--color'
  colormap:
    type: string?
    inputBinding:
      prefix: '--colormap'
  format:
    type:
      - type: enum
        symbols: [eps,jpeg,jpg,pdf,pgf,png,ps,raw,rgba,svg,svgz,tif,tiff]
      - "null"
    inputBinding:
      prefix: '--format'
  plots:
    type:
      - type: array
        items:
          type: enum
          symbols: [kde,hex,dot]
      - "null"
    inputBinding:
      prefix: '--plots'
  listcolors:
    type: boolean?
    inputBinding:
      prefix: '--listcolors'
  listcolormaps:
    type: boolean?
    inputBinding:
      prefix: '--listcolormaps'
  hide_n50:
    type: boolean?
    inputBinding:
      prefix: '--no-N50'
  show_n50:
    type: boolean?
    inputBinding:
      prefix: '--N50'
  plot_title:
    type: string?
    inputBinding:
      prefix: '--title'
  file_prefix:
    type: string?
    inputBinding:
      prefix: '--prefix'
  font_scale:
    type: float?
    inputBinding:
      prefix: '--font_scale'
  dpi:
    type: int?
    inputBinding:
      prefix: '--dpi'
  hide_stats:
    type: boolean?
    inputBinding:
      prefix: '--hide_stats'

  store_raw:
    type: boolean?
    doc: Store the extracted data in tab separated file.
    inputBinding:
      prefix: '--raw'
  store_pickle:
    type: boolean?
    doc: Store the extracted data in a pickle file for future plotting.
    inputBinding:
      prefix: '--store'
  tsv_stats:
    type: boolean?
    doc: Output the stats file as a properly formatted TSV.
    inputBinding:
      prefix: '--tsv_stats'
  info_in_report:
    type: boolean?
    doc: Add NanoPlot run info in the report.
    inputBinding:
      prefix: '--info_in_report'

  fastq_files:
    type: File[]?
    inputBinding:
      prefix: '--fastq'
  fasta_files:
    type: File[]?
    format: edam:format_1931  # FASTA
    inputBinding:
      prefix: '--fasta'
  rich_fastq_files:
    type: File[]?
    inputBinding:
      prefix: '--fastq_rich'
  minimal_fastq_files:
    type: File[]?
    inputBinding:
      prefix: '--fastq_minimal'
  summary_files:
    type: File[]?
    inputBinding:
      prefix: '--summary'
  bam_files:
    type: File[]?
    format: edam:format_2572  # BAM
    inputBinding:
      prefix: '--bam'
  ubam_files:
    type: File[]?
    inputBinding:
      prefix: '--ubam'
  cram_files:
    type: File[]?
    format: edam:format_3462  # CRAM
    inputBinding:
      prefix: '--cram'
  use_pickle_file:
    type: boolean?
    inputBinding:
      prefix: '--pickle'

outputs:
  log:
    type: File[]?
    outputBinding:
      glob: "*.log"
  WeightedHistogramReadlength:
    type: File[]?
    outputBinding:
      glob: $(inputs.file_prefix)WeightedHistogramReadlength.*
  WeightedLogTransformed_HistogramReadlength:
    type: File[]?
    outputBinding:
      glob: $(inputs.file_prefix)WeightedLogTransformed_HistogramReadlength.*
  Non_weightedHistogramReadlength:
    type: File[]?
    outputBinding:
      glob: $(inputs.file_prefix)Non_weightedHistogramReadlength.*
  Non_weightedLogTransformed_HistogramReadlength:
    type: File[]?
    outputBinding:
      glob: $(inputs.file_prefix)Non_weightedLogTransformed_HistogramReadlength.*
  LengthvsQualityScatterPlot:
    type: File[]?
    outputBinding:
      glob: $(inputs.file_prefix)LengthvsQualityScatterPlot_*.*
  Yield_By_Length:
    type: File[]?
    outputBinding:
      glob: $(inputs.file_prefix)Yield_By_Length.*
  report:
    type: File?
    outputBinding:
      glob: $(inputs.file_prefix)NanoPlot-report.html
  logfile:
    type: File?
    outputBinding:
      glob: $(inputs.file_prefix)NanoPlot_*.log
  nanostats:
    type: File?
    outputBinding:
      glob: $(inputs.file_prefix)NanoStats.txt
  pickle:
    type: File?
    outputBinding:
      glob: $(inputs.file_prefix)NanoPlot-data.pickle
  raw_data:
    type: File?
    outputBinding:
      glob: $(inputs.file_prefix)NanoPlot-data.tsv.gz

  #### Generated with fastq rich files
  ActivityMap_ReadsPerChannel:
    type: File[]?
    outputBinding:
      glob: $(inputs.file_prefix)ActivityMap_ReadsPerChannel.*
  CumulativeYieldPlot_Gigabases:
    type: File[]?
    outputBinding:
      glob: $(inputs.file_prefix)CumulativeYieldPlot_Gigabases.*
  CumulativeYieldPlot_NumberOfReads:
    type: File[]?
    outputBinding:
      glob: $(inputs.file_prefix)CumulativeYieldPlot_NumberOfReads.*
  NumberOfReads_Over_Time:
    type: File[]?
    outputBinding:
      glob: $(inputs.file_prefix)NumberOfReads_Over_Time.*
  ActivePores_Over_Time:
    type: File[]?
    outputBinding:
      glob: $(inputs.file_prefix)ActivePores_Over_Time.*
  TimeLengthViolinPlot:
    type: File[]?
    outputBinding:
      glob: $(inputs.file_prefix)TimeLengthViolinPlot.*
  TimeQualityViolinPlot:
    type: File[]?
    outputBinding:
      glob: $(inputs.file_prefix)TimeQualityViolinPlot.*


s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0009-0001-1350-5644
    s:email: mailto:changlin.ke@wur.nl
    s:name: Changlin Ke
  - class: s:Person
    s:identifier: https://orcid.org/0000-0002-2703-8936 
    s:name: Miguel Boland
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-8172-8981
    s:name: Michael R. Crusoe
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse

s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateCreated: "2020-04-04"
s:dateModified: "2023-04-03"
s:license: https://spdx.org/licenses/Apache-2.0
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  edam: http://edamontology.org/
  s: https://schema.org/