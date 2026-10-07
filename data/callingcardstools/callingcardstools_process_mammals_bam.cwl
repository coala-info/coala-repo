cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - callingcardstools
  - process_mammals_bam
label: callingcardstools_process_mammals_bam
doc: "Processes BAM files for calling cards analysis in mammals.\n\nTool homepage:
  https://github.com/cmatKhan/callingCardsTools"
inputs:
  - id: barcode_details
    type: File
    doc: Path to the barcode details JSON file.
    inputBinding:
      position: 101
      prefix: --barcode_details
  - id: filename
    type:
      - 'null'
      - string
    doc: Base filename for output files, excluding suffix and extension. 
      Defaults to the input file's basename minus the extension.
    inputBinding:
      position: 101
      prefix: --filename
  - id: genome
    type: File
    secondaryFiles:
      - .fai
      - pattern: .gzi
        required: false
    doc: Path to the genome FASTA file. Must have a corresponding .fai index 
      file.
    inputBinding:
      position: 101
      prefix: --genome
  - id: input
    type: File
    secondaryFiles:
      - .bai
    doc: Path to the BAM file. Must be sorted and have a corresponding .bai 
      index file.
    inputBinding:
      position: 101
      prefix: --input
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Set the logging level. Options are: critical, error, warning, info, debug.'
    inputBinding:
      position: 101
      prefix: --log_level
  - id: mapq_threshold
    type:
      - 'null'
      - int
    doc: Reads with mapping quality less than or equal to this threshold will be
      marked as failed.
    inputBinding:
      position: 101
      prefix: --mapq_threshold
  - id: pickle
    type:
      - 'null'
      - boolean
    doc: If set, save qbed and qc data as pickle files. Useful for parallel 
      processing and later combining. Defaults to False, saving as qbed/tsv.
    inputBinding:
      position: 101
      prefix: --pickle
  - id: suffix
    type:
      - 'null'
      - string
    doc: Suffix to append to output files.
    inputBinding:
      position: 101
      prefix: --suffix
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: passing_bam
    type:
      - 'null'
      - File
    doc: Sorted bam of the passing reads
    outputBinding:
      glob: '$(inputs.filename ? inputs.filename : inputs.input.nameroot)$(inputs.suffix ? "_" + inputs.suffix : "")_passing.bam'
  - id: failing_bam
    type:
      - 'null'
      - File
    doc: Sorted bam of the failing reads
    outputBinding:
      glob: '$(inputs.filename ? inputs.filename : inputs.input.nameroot)$(inputs.suffix ? "_" + inputs.suffix : "")_failing.bam'
  - id: qbed
    type:
      - 'null'
      - File
    doc: qBed of the passing insertions (not written with --pickle)
    outputBinding:
      glob: '$(inputs.filename ? inputs.filename : inputs.input.nameroot)$(inputs.suffix ? "_" + inputs.suffix : "").qbed'
  - id: qc_files
    type:
      type: array
      items: File
    doc: All files written with the output basename (bams, qbed, QC tables, or 
      the qbed and barcode QC pickles with --pickle)
    outputBinding:
      glob: '$(inputs.filename ? inputs.filename : inputs.input.nameroot)$(inputs.suffix ? "_" + inputs.suffix : "")_*'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/callingcardstools:1.8.1--pyhdfd78af_0
stdout: callingcardstools_process_mammals_bam.out
