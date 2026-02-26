cwlVersion: v1.2
class: CommandLineTool
baseCommand: bcl_to_fastq
label: bcl2fastq-nextseq_bcl_to_fastq
doc: "Runs bcl2fastq2, creating fastqs and concatenating fastqs across lanes.\n  Undetermined
  files are deleted by default.\n\n  Any arguments not matching those outlined below
  will be sent to the\n  `bcl2fastq` call.\n\nTool homepage: https://github.com/brwnj/bcl2fastq"
inputs:
  - id: bcl2fastq_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional arguments to pass to bcl2fastq
    inputBinding:
      position: 1
  - id: barcode_mismatches
    type:
      - 'null'
      - int
    doc: number of allowed mismatches per index
    default: 0
    inputBinding:
      position: 102
  - id: delay
    type:
      - 'null'
      - int
    doc: "number of seconds to sleep after finding\n                             \
      \   RTAComplete.txt -- applies only when waiting\n                         \
      \       for a run to complete"
    default: 14400
    inputBinding:
      position: 102
  - id: determine
    type:
      - 'null'
      - boolean
    doc: "use barcodes in samplesheet as well as the\n                           \
      \     reverse complement of index 2, then\n                                demultiplex
      with best"
    default: false
    inputBinding:
      position: 102
  - id: input_dir
    type:
      - 'null'
      - Directory
    doc: "path to input directory; default is RUNFOLDER-\n                       \
      \         DIR/Data/Intensities/BaseCalls"
    inputBinding:
      position: 102
      prefix: --input-dir
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: save Undetermined reads
    default: false
    inputBinding:
      position: 102
  - id: loading
    type:
      - 'null'
      - int
    doc: number of threads used for loading BCL data
    default: 12
    inputBinding:
      position: 102
  - id: no_cleanup
    type:
      - 'null'
      - boolean
    doc: "skip all cleaning up -- do not rename fastq\n                          \
      \      output and do not delete undetermined files"
    default: false
    inputBinding:
      position: 102
  - id: no_wait
    type:
      - 'null'
      - boolean
    doc: "process the run without checking its\n                                completion
      status"
    default: false
    inputBinding:
      position: 102
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: "path to demultiplexed output; default is same\n                        \
      \        as INPUT-DIR"
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: "overwrite existing fastq files in the output\n                         \
      \       directory"
    default: false
    inputBinding:
      position: 102
  - id: processing
    type:
      - 'null'
      - int
    doc: "number of threads used for processing\n                                demultiplexed
      data"
    default: 24
    inputBinding:
      position: 102
  - id: reverse_complement
    type:
      - 'null'
      - boolean
    doc: reverse complement index 2 of the sample sheet
    default: false
    inputBinding:
      position: 102
  - id: runfolder_dir
    type:
      - 'null'
      - Directory
    doc: path to directory containing run data
    default: /
    inputBinding:
      position: 102
      prefix: --runfolder-dir
  - id: sample_sheet
    type:
      - 'null'
      - File
    doc: "file path to sample sheet; default is\n                                RUNFOLDER-DIR/SampleSheet.csv"
    inputBinding:
      position: 102
  - id: writing
    type:
      - 'null'
      - int
    doc: number of threads used for writing FASTQ data
    default: 12
    inputBinding:
      position: 102
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcl2fastq-nextseq:1.3.0--pyh5e36f6f_0
stdout: bcl2fastq-nextseq_bcl_to_fastq.out
