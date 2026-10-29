cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - illumina.py
  - miseq_fastq_to_bam
label: viral-ngs_illumina_miseq_fastq_to_bam
doc: "Convert fastq read files to a single bam file. Fastq file names must conform to patterns emitted by Miseq machines. Sample metadata must be provided in a SampleSheet.csv that corresponds to the fastq filename. Specifically, the _S##_ index in the fastq file name will be used to find the corresponding row in the SampleSheet\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: out_bam
    type: string
    doc: "Output BAM file."
    inputBinding:
      position: 1
  - id: sample_sheet
    type: File
    doc: "Input SampleSheet.csv file."
    inputBinding:
      position: 2
  - id: in_fastq1
    type: File
    doc: "Input fastq file; 1st end of paired-end reads if paired."
    inputBinding:
      position: 3
  - id: in_fastq2
    type:
      - 'null'
      - File
    doc: "Input fastq file; 2nd end of paired-end reads."
    inputBinding:
      position: 20
      prefix: --inFastq2
  - id: run_info
    type:
      - 'null'
      - File
    doc: "Input RunInfo.xml file."
    inputBinding:
      position: 20
      prefix: --runInfo
  - id: sequencing_center
    type:
      - 'null'
      - string
    doc: "Name of your sequencing center (default is the sequencing machine ID from the RunInfo.xml)"
    inputBinding:
      position: 20
      prefix: --sequencing_center
  - id: jvm_memory
    type:
      - 'null'
      - string
    doc: "JVM virtual memory size (default: 2g)"
    inputBinding:
      position: 20
      prefix: --JVMmemory
  - id: loglevel
    type:
      - 'null'
      - type: enum
        symbols:
          - DEBUG
          - INFO
          - WARNING
          - ERROR
          - CRITICAL
          - EXCEPTION
    doc: "Verboseness of output. [default: DEBUG]"
    inputBinding:
      position: 20
      prefix: --loglevel
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: "Base directory for temp files. [default: /tmp]"
    inputBinding:
      position: 20
      prefix: --tmp_dir
  - id: tmp_dir_keep
    type:
      - 'null'
      - boolean
    doc: "Keep the tmp_dir if an exception occurs while running. Default is to delete all temp files at the end, even if there's a failure."
    inputBinding:
      position: 20
      prefix: --tmp_dirKeep
outputs:
  - id: out_bam_file
    type: File
    doc: "Output file written to out_bam"
    outputBinding:
      glob: $(inputs.out_bam)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
