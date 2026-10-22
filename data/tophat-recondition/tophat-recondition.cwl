cwlVersion: v1.2
class: CommandLineTool
baseCommand: tophat-recondition
label: tophat-recondition
doc: "Post-process TopHat unmapped reads. Corrects issues with TopHat unmapped read
  files.\n\nTool homepage: https://github.com/cbrueffer/tophat-recondition"
inputs:
  - id: tophat_result_dir
    type: Directory
    doc: directory containing TopHat mapped and unmapped read files.
    inputBinding:
      position: 1
  - id: mapped_file
    type:
      - 'null'
      - string
    doc: Name of the file containing mapped reads (default accepted_hits.bam)
    inputBinding:
      position: 102
      prefix: --mapped-file
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: quiet mode, no console output
    inputBinding:
      position: 102
      prefix: --quiet
  - id: unmapped_file
    type:
      - 'null'
      - string
    doc: Name of the file containing unmapped reads (default unmapped.bam)
    inputBinding:
      position: 102
      prefix: --unmapped-file
  - id: logfile_path
    type:
      - 'null'
      - string
    doc: log file (optional, default result_dir/tophat-recondition.log)
    inputBinding:
      position: 103
      prefix: --logfile
  - id: result_dir_path
    type: string
    default: recondition_out
    doc: Name of the directory to write unmapped_fixup.bam to. It is created before
      the run (the input directory is read-only).
    inputBinding:
      position: 104
      prefix: --result_dir
outputs:
  - id: logfile
    type:
      - 'null'
      - File
    doc: log file
    outputBinding:
      glob: "$(inputs.logfile_path ? inputs.logfile_path : inputs.result_dir_path + '/tophat-recondition.log')"
  - id: result_dir
    type:
      - 'null'
      - Directory
    doc: directory with unmapped_fixup.bam
    outputBinding:
      glob: $(inputs.result_dir_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.result_dir_path)
        entry: '$({"class": "Directory", "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tophat-recondition:1.4--py35_0
