cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - reports.py
  - consolidate_spike_count
label: viral-ngs_reports_consolidate_spike_count
doc: "Consolidate multiple spike count reports into one.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: in_dir
    type: Directory
    doc: "Input spike count directory."
    inputBinding:
      position: 1
  - id: out_file
    type: string
    doc: "Output report file."
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: out_file_out
    type: File
    doc: "Consolidated report file"
    outputBinding:
      glob: $(inputs.out_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
stdout: viral-ngs_reports_consolidate_spike_count.out
