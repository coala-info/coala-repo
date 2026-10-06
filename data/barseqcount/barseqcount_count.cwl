cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - barseqcount
  - count
label: barseqcount_count
doc: "Count barcodes from read files. The configuration file names the read files and
  the template FASTA file; stage them with input_files so the names resolve. Without
  a configuration file, a new one is created for editing.\n\nTool homepage: https://github.com/damienmarsic/barseqcount"
inputs:
  - id: configuration_file
    type:
      - 'null'
      - File
    doc: 'Configuration file for the barseqcount count program (default: barseqcount_count.conf),
      will be created if absent'
    inputBinding:
      position: 101
      prefix: --configuration_file
  - id: new
    type:
      - 'null'
      - boolean
    doc: Create new configuration file and rename existing one
    inputBinding:
      position: 101
      prefix: --new
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Read files (FASTA/FASTQ, plain or gzipped) and template FASTA named in the
      configuration file, staged in the working directory
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: count_csv
    type:
      - 'null'
      - File
    doc: Barcode distribution file (<project>_count.csv)
    outputBinding:
      glob: '*_count.csv'
  - id: count_report
    type:
      - 'null'
      - File
    doc: Count report (<project>_count_report.txt)
    outputBinding:
      glob: '*_count_report.txt'
  - id: new_configuration_file
    type:
      - 'null'
      - File
    doc: Configuration file created when none was given
    outputBinding:
      glob: barseqcount_count.conf
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/barseqcount:0.1.5--pyhdfd78af_0
stdout: barseqcount_count.out
