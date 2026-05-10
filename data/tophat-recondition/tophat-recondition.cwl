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
      - File
    doc: Name of the file containing mapped reads
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
      - File
    doc: Name of the file containing unmapped reads
    inputBinding:
      position: 102
      prefix: --unmapped-file
  - id: logfile_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `logfile_path`
    inputBinding:
      position: 103
      prefix: --logfile
  - id: result_dir_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `result_dir_path`
    inputBinding:
      position: 104
      prefix: --result-dir
outputs:
  - id: logfile
    type:
      - 'null'
      - File
    doc: 'log file (optional, (default: result_dir/tophat-recondition.log)'
    outputBinding:
      glob: $(inputs.logfile_path)
  - id: result_dir
    type:
      - 'null'
      - Directory
    doc: 'directory to write unmapped_fixup.bam to (default: tophat_output_dir)'
    outputBinding:
      glob: $(inputs.result_dir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tophat-recondition:1.4--py35_0
