cwlVersion: v1.2
class: CommandLineTool
baseCommand: pbmarkdup
label: pbmarkdup
doc: "Mark duplicate reads from PacBio sequencing of an amplified library.\n\nTool
  homepage: https://github.com/PacificBiosciences/pbmarkdup"
inputs:
  - id: input_file
    type: File
    doc: Input file(s) as BAM, DATASET.XML, FASTA[.GZ], FASTQ[.GZ], or FOFN
    inputBinding:
      position: 1
  - id: clobber
    type:
      - 'null'
      - boolean
    doc: Overwrite OUTFILE if it exists.
    inputBinding:
      position: 102
      prefix: --clobber
  - id: cross_library
    type:
      - 'null'
      - boolean
    doc: Identify duplicates across sequencing libraries (LB tag in read group).
    inputBinding:
      position: 102
      prefix: --cross-library
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Set log level. Valid choices: (TRACE, DEBUG, INFO, WARN, FATAL).'
    inputBinding:
      position: 102
      prefix: --log-level
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use, 0 means autodetection.
    inputBinding:
      position: 102
      prefix: --num-threads
  - id: rmdup
    type:
      - 'null'
      - boolean
    doc: Exclude duplicates from OUTFILE. Redundant when --dup-file is provided.
    inputBinding:
      position: 102
      prefix: --rmdup
outputs:
  - id: output_file
    type: File
    doc: Output file as BAM, DATASET.XML, FASTA.GZ or FASTQ.GZ
    outputBinding:
      glob: '*.out'
  - id: dup_file
    type:
      - 'null'
      - File
    doc: Write duplicates to this file instead of OUTFILE.
    outputBinding:
      glob: $(inputs.dup_file)
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log to a file, instead of stderr.
    outputBinding:
      glob: $(inputs.log_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbmarkdup:1.2.0--h9ee0642_0
