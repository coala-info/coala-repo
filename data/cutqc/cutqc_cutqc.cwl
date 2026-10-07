cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cutqc
  - cutqc
label: cutqc_cutqc
doc: "Take pair-end inputs (R1.fq.gz and R2.fq.gz) and perform cutadapt in pair-end
  mode. Fastqc will be performed both before and after trimming, and an HTML report
  is rendered.\n\nTool homepage: https://github.com/obenno/cutqc"
inputs:
  - id: in_read1
    type: File
    doc: Input read 1 FASTQ file (gzipped).
    inputBinding:
      position: 1
  - id: in_read2
    type: File
    doc: Input read 2 FASTQ file (gzipped).
    inputBinding:
      position: 2
  - id: out_report
    type: string
    doc: Output report file name (HTML).
    inputBinding:
      position: 3
  - id: cutadapt_option
    type:
      - 'null'
      - type: array
        items: string
    doc: Options to be passed to cutadapt. Refer to cutadapt manual for details.
    inputBinding:
      position: 4
outputs:
  - id: report
    type: File
    doc: Output report file (HTML).
    outputBinding:
      glob: $(inputs.out_report)
  - id: trimmed_reads
    type:
      type: array
      items: File
    doc: Trimmed read 1 and read 2 (<name>.trimmed.fq.gz)
    outputBinding:
      glob: '*.trimmed.fq.gz'
  - id: cutadapt_command
    type:
      - 'null'
      - File
    doc: The cutadapt command line that was run
    outputBinding:
      glob: cutadapt_command
  - id: stdout
    type: stdout
    doc: cutadapt summary report
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cutqc:0.07--hdfd78af_0
stdout: cutqc_cutqc.out
