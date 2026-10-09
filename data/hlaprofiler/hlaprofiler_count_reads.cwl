cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - HLAProfiler.pl
  - count_reads
label: hlaprofiler_count_reads
doc: "Count the reads in filtered fastq files to create read count files.\n\nTool homepage: https://github.com/ExpressionAnalysis/HLAProfiler"
inputs:
  - id: reads_directory
    type: Directory
    doc: 'Directory with the filtered read fastqs (filter them with HLAProfiler.pl filter first)'
    inputBinding:
      position: 1
      prefix: -reads_directory
  - id: sample_name
    type: string
    doc: 'Name of the sample; must match the prefix of the read files'
    inputBinding:
      position: 1
      prefix: -sample_name
  - id: output_directory
    type: string
    doc: 'Directory for the read count files (created in the working directory)'
    inputBinding:
      position: 1
      prefix: -output_directory
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use for processing (default: 1)'
    inputBinding:
      position: 1
      prefix: -threads
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory with the read count files
    outputBinding:
      glob: $(inputs.output_directory)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.output_directory)
        entry: '$({class: "Directory", listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hlaprofiler:1.0.5--0
