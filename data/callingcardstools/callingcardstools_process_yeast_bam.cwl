cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - callingcardstools
  - process_yeast_bam
label: callingcardstools_process_yeast_bam
doc: "Processes yeast BAM files.\n\nTool homepage: https://github.com/cmatKhan/callingCardsTools"
inputs:
  - id: bampath
    type: File
    secondaryFiles:
      - .bai
    doc: path to the input bam file
    inputBinding:
      position: 101
      prefix: --bampath
  - id: barcode_details
    type: File
    doc: Path to the barcode details json file
    inputBinding:
      position: 101
      prefix: --barcode_details
  - id: genome
    type: File
    secondaryFiles:
      - .fai
    doc: Path to a genome .fasta file. Note that an index .fai file must exist 
      in the same path
    inputBinding:
      position: 101
      prefix: --genome
  - id: log_level
    type:
      - 'null'
      - string
    doc: Logging level
    inputBinding:
      position: 101
      prefix: --log_level
  - id: mapq_threshold
    type:
      - 'null'
      - int
    doc: Mapping quality threshold
    inputBinding:
      position: 101
      prefix: --mapq_threshold
  - id: output_dir
    type:
      - 'null'
      - string
    doc: path to the output directory
    inputBinding:
      position: 101
      prefix: --output_dir
  - id: verbose_qc
    type:
      - 'null'
      - boolean
    doc: save complete alignment summary
    inputBinding:
      position: 101
      prefix: --verbose_qc
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dir_dir
    type:
      - 'null'
      - Directory
    doc: path to the output directory
    outputBinding:
      glob: $(inputs.output_dir)
  - id: passing_bam
    type: File
    doc: Tagged alignments that pass the filters
    outputBinding:
      glob: '$(inputs.output_dir ? inputs.output_dir : ".")/$(inputs.bampath.nameroot)_passing_tagged.bam'
  - id: failing_bam
    type: File
    doc: Tagged alignments that fail the filters
    outputBinding:
      glob: '$(inputs.output_dir ? inputs.output_dir : ".")/$(inputs.bampath.nameroot)_failing_tagged.bam'
  - id: qbed
    type: File
    doc: qBed file of the passing insertions
    outputBinding:
      glob: '$(inputs.output_dir ? inputs.output_dir : ".")/$(inputs.bampath.nameroot).qbed'
  - id: summary
    type: File
    doc: Barcode and alignment QC summary
    outputBinding:
      glob: '$(inputs.output_dir ? inputs.output_dir : ".")/$(inputs.bampath.nameroot)_summary.tsv'
  - id: aln_info
    type:
      - 'null'
      - File
    doc: Complete alignment summary, written with --verbose_qc
    outputBinding:
      glob: '$(inputs.output_dir ? inputs.output_dir : ".")/$(inputs.bampath.nameroot)_aln_info.tsv'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '$(inputs.output_dir && inputs.output_dir != "." ? [{"class": "Directory",
      "basename": inputs.output_dir, "listing": [], "writable": true}] : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/callingcardstools:1.8.1--pyhdfd78af_0
stdout: callingcardstools_process_yeast_bam.out
