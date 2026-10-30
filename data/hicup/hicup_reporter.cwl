cwlVersion: v1.2
class: CommandLineTool
baseCommand: [hicup_reporter]
label: hicup_reporter
doc: "Generate summary results for the whole HiCUP pipeline. It collates the summary\
  \ reports written by the HiCUP pipeline scripts (hicup_truncater, hicup_mapper\
  \ and so on) into collated summary text files and an HTML document. Pass the folder\
  \ that holds the summary files.\n\nTool homepage: http://www.bioinformatics.babraham.ac.uk/projects/hicup/"
inputs:
  - id: quiet
    type: ['null', boolean]
    doc: "Suppress progress reports (except warnings)"
    inputBinding:
      position: 1
      prefix: --quiet
  - id: summary_folder
    type: Directory
    doc: "Folder with the summary files made by the HiCUP pipeline scripts"
    inputBinding:
      position: 2
outputs:
  - id: combined_summary
    type: File[]
    doc: "Collated HiCUP summary report text files"
    outputBinding:
      glob: "*HiCUP_summary_report_*.txt"
  - id: html_report
    type: ['null', 'File[]']
    doc: "Interactive HTML summary report"
    outputBinding:
      glob: "*.html"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicup:0.9.2--hdfd78af_1
