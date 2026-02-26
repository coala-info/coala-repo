cwlVersion: v1.2
class: CommandLineTool
baseCommand: CITE-seq-Count
label: cite-seq-count_CITE-seq-Count
doc: "This script counts matching antibody tags from paired fastq files. Version 1.4.5\n\
  \nTool homepage: https://hoohm.github.io/CITE-seq-Count/"
inputs:
  - id: bc_threshold
    type:
      - 'null'
      - int
    doc: threshold for cellular barcode collapsing.
    inputBinding:
      position: 101
      prefix: --bc_collapsing_dist
  - id: cell_barcode_first_base
    type: int
    doc: Postion of the first base of your cell barcodes.
    inputBinding:
      position: 101
      prefix: --cell_barcode_first_base
  - id: cell_barcode_last_base
    type: int
    doc: Postion of the last base of your cell barcodes.
    inputBinding:
      position: 101
      prefix: --cell_barcode_last_base
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print extra information for debugging.
    inputBinding:
      position: 101
      prefix: --debug
  - id: dense_output
    type:
      - 'null'
      - boolean
    doc: Add a dense output to the results folder
    inputBinding:
      position: 101
      prefix: --dense
  - id: expected_cells
    type: int
    doc: Number of expected cells from your run.
    inputBinding:
      position: 101
      prefix: --expected_cells
  - id: first_n
    type:
      - 'null'
      - int
    doc: Select N reads to run on instead of all.
    inputBinding:
      position: 101
      prefix: --first_n
  - id: max_error
    type:
      - 'null'
      - int
    doc: Maximum Levenshtein distance allowed for antibody barcodes.
    inputBinding:
      position: 101
      prefix: --max-errors
  - id: no_umi_correction
    type:
      - 'null'
      - boolean
    doc: Deactivate UMI collapsing
    inputBinding:
      position: 101
      prefix: --no_umi_correction
  - id: read1_path
    type: File
    doc: The path of Read1 in gz format, or a comma-separated list of paths to 
      all Read1 files in gz format (E.g. A1.fq.gz,B1.fq,gz,...
    inputBinding:
      position: 101
      prefix: --read1
  - id: read2_path
    type: File
    doc: The path of Read2 in gz format, or a comma-separated list of paths to 
      all Read2 files in gz format (E.g. A2.fq.gz,B2.fq,gz,...
    inputBinding:
      position: 101
      prefix: --read2
  - id: sliding_window
    type:
      - 'null'
      - boolean
    doc: Allow for a sliding window when aligning.
    inputBinding:
      position: 101
      prefix: --sliding-window
  - id: start_trim
    type:
      - 'null'
      - int
    doc: Number of bases to discard from read2.
    inputBinding:
      position: 101
      prefix: --start-trim
  - id: tags
    type: File
    doc: The path to the csv file containing the antibody barcodes as well as 
      their respective names.
    inputBinding:
      position: 101
      prefix: --tags
  - id: threads
    type:
      - 'null'
      - int
    doc: How many threads are to be used for running the program
    inputBinding:
      position: 101
      prefix: --threads
  - id: umi_first_base
    type: int
    doc: Postion of the first base of your UMI.
    inputBinding:
      position: 101
      prefix: --umi_first_base
  - id: umi_last_base
    type: int
    doc: Postion of the last base of your UMI.
    inputBinding:
      position: 101
      prefix: --umi_last_base
  - id: umi_threshold
    type:
      - 'null'
      - int
    doc: threshold for umi collapsing.
    inputBinding:
      position: 101
      prefix: --umi_collapsing_dist
  - id: unknown_top_tags
    type:
      - 'null'
      - int
    doc: Top n unmapped TAGs.
    inputBinding:
      position: 101
      prefix: --unknown-top-tags
  - id: whitelist
    type:
      - 'null'
      - File
    doc: A csv file containning a whitelist of barcodes produced by the mRNA 
      data.
    inputBinding:
      position: 101
      prefix: --whitelist
outputs:
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: Results will be written to this folder
    outputBinding:
      glob: $(inputs.output_folder)
  - id: unmapped_file
    type:
      - 'null'
      - File
    doc: Write table of unknown TAGs to file.
    outputBinding:
      glob: $(inputs.unmapped_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cite-seq-count:1.4.5--pyhdfd78af_0
