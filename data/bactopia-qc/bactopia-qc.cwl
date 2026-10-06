cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bactopia-qc
label: bactopia-qc
doc: "Quality control of Illumina or Oxford Nanopore reads for Bactopia: validate\
  \ read pairs, remove adapters and PhiX, reduce coverage, and report read statistics.\n\
  \nUsage: bactopia-qc <PREFIX> <RUNTYPE> <R1> <R2> <GENOME_SIZE_FILE> <OPT1> ...\
  \ <OPTN>\n\nTool homepage: https://bactopia.github.io/"
inputs:
  - id: prefix
    type: string
    doc: Sample name used as the prefix of the output files
    inputBinding:
      position: 1
  - id: runtype
    type: string
    doc: Read type (paired-end, single-end or ont)
    inputBinding:
      position: 2
  - id: r1
    type: File
    doc: First (or only) FASTQ file, gzip-compressed
    inputBinding:
      position: 3
  - id: r2
    type: File
    doc: Second FASTQ file of a pair, gzip-compressed
    inputBinding:
      position: 4
  - id: genome_size_file
    type: File
    doc: Text file whose first line is the genome size
    inputBinding:
      position: 5
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional options (OPT1 ... OPTN); the script accepts them but does not
      use them
    inputBinding:
      position: 6
outputs:
  - id: results
    type: Directory
    doc: Cleaned FASTQs, error FASTQs and the summary folder (fastq-scan JSON, FastQC
      or NanoPlot reports)
    outputBinding:
      glob: results
  - id: error_reports
    type: File[]
    doc: Error messages written when reads fail a QC step
    outputBinding:
      glob: $(inputs.prefix)-*error.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bactopia-qc:1.0.3--hdfd78af_0
