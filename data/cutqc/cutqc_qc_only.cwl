cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cutqc
  - qc_only
label: cutqc_qc_only
doc: "Take one single fastq file as input and perfom fastqc only; the FastQC result
  is rendered as an HTML report. Only gzipped input files are supported.\n\nTool
  homepage: https://github.com/obenno/cutqc"
inputs:
  - id: in_read
    type: File
    doc: Input FASTQ file (gzipped).
    inputBinding:
      position: 1
  - id: output_report
    type: string
    doc: Output report file name (HTML). The tool default writes beside the 
      input file, so a name is required here.
    default: fastqc_report.html
    inputBinding:
      position: 2
outputs:
  - id: report
    type: File
    doc: Output report file (HTML).
    outputBinding:
      glob: $(inputs.output_report)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cutqc:0.07--hdfd78af_0
