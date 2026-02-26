cwlVersion: v1.2
class: CommandLineTool
baseCommand: ./Sreport
label: fastqpuri_Sreport
doc: "Uses all *bin files found in a folder (output of Qreport|trimFilter|trimFilterPE)
  and generates a summary report in html format (of Qreport|trimFilter|trimFilterPE).\n\
  \nTool homepage: https://github.com/jengelmann/FastqPuri"
inputs:
  - id: input_folder
    type: Directory
    doc: Input folder containing *bin data (output from Qreport).
    inputBinding:
      position: 101
      prefix: -i
  - id: report_type
    type: string
    doc: "Type of report to be generated: 'Q' for quality summary report, 'F' for
      filter summary report (single-end reads), and 'P' for filter summary report
      (paired-end reads)"
    inputBinding:
      position: 101
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Prints package version.
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_file
    type: File
    doc: Output file (with NO extension).
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqpuri:1.0.7--r44hb1d24b7_9
