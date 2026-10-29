cwlVersion: v1.2
class: CommandLineTool
baseCommand: make_batch_for_get_organelle.py
label: getorganelle_make_batch_for_get_organelle.py
doc: "Make a batch file (shell script) that runs get_organelle_from_reads.py on each sample folder holding a pair of fastq files.\n\nTool homepage: http://github.com/Kinggerm/GetOrganelle"
inputs:
  - id: sample_dirs
    type:
      - 'null'
      - type: array
        items: Directory
    doc: "A list of folders. Each folder should include a/several pair(s) of fastq files."
    inputBinding:
      position: 1
  - id: output_base
    type:
      - string
    doc: "Output base name for each sample."
    inputBinding:
      position: 101
      prefix: "-o"
  - id: other_arguments
    type:
      - string
    doc: "Other arguments that get_organelle_from_reads.py would take. Example: \"-s plastome.fasta -a mitochondrial.fasta -F embplant_pt -w 105\""
    inputBinding:
      position: 101
      prefix: "-p"
  - id: all_samples
    type:
      - 'null'
      - boolean
    doc: "Choose to make command for all samples including samples with results. Default: skip those with results."
    inputBinding:
      position: 101
      prefix: "--all"
  - id: skip_comment
    type:
      - 'null'
      - boolean
    doc: "Choose to treat #-commented command as skipped. Default: False."
    inputBinding:
      position: 101
      prefix: "--skip-comment"
  - id: strict
    type:
      - 'null'
      - boolean
    doc: "Choose to only search for the fastq with the same base name with the directory (*/*_1.fq). Default: relaxed searching."
    inputBinding:
      position: 101
      prefix: "--strict"
outputs:
  - id: batch_script
    type:
      - File
    doc: "The generated batch script get_organelle_<basename>.sh."
    outputBinding:
      glob: "get_organelle_*.sh"
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/getorganelle:1.7.7.1--pyhdfd78af_0
stdout: getorganelle_make_batch_for_get_organelle.py.out
