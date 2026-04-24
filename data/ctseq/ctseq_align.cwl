cwlVersion: v1.2
class: CommandLineTool
baseCommand: ctseq_align
label: ctseq_align
doc: "Aligns sequencing reads to a reference genome and prepares methylation calls.\n\
  \nTool homepage: https://github.com/ryanhmiller/ctseq"
inputs:
  - id: bismark_cores
    type:
      - 'null'
      - int
    doc: number of cores to use to align with Bismark. Default=1. Highly 
      recommended to run with more than 1 core, try starting with 6 cores
    inputBinding:
      position: 101
      prefix: --bismarkCores
  - id: cutadapt_cores
    type:
      - 'null'
      - int
    doc: number of cores to use with Cutadapt. Default=1. Highly recommended to 
      run with more than 1 core, try starting with 18 cores
    inputBinding:
      position: 101
      prefix: --cutadaptCores
  - id: fastq_directory
    type:
      - 'null'
      - Directory
    doc: Path to directory where you have your fastq files. If no '--dir' is 
      specified, ctseq will look in your current directory.
    inputBinding:
      position: 101
      prefix: --dir
  - id: forward_adapter
    type:
      - 'null'
      - string
    doc: adapter sequence to remove from FORWARD reads
    inputBinding:
      position: 101
      prefix: --forwardAdapter
  - id: reads_per_file
    type:
      - 'null'
      - int
    doc: number of reads to analyze per fastq file (should only adjust this if 
      you think you are too big of a file through bismark). Default=5000000 (5 
      million)
    inputBinding:
      position: 101
      prefix: --readsPerFile
  - id: reference_directory
    type:
      - 'null'
      - Directory
    doc: Full path to directory where you have already built your methylation 
      reference files. If no '--refDir' is specified, ctseq will look in your 
      current directory.
    inputBinding:
      position: 101
      prefix: --refDir
  - id: reverse_adapter
    type:
      - 'null'
      - string
    doc: adapter sequence to remove from REVERSE reads
    inputBinding:
      position: 101
      prefix: --reverseAdapter
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ctseq:0.0.2--py_0
stdout: ctseq_align.out
