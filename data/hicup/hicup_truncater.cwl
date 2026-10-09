cwlVersion: v1.2
class: CommandLineTool
baseCommand: hicup_truncater
label: hicup_truncater
doc: 'The hicup_truncater script terminates reads at Hi-C ligation junctions. It identifies
  ligation junctions within reads and deletes sequences downstream of the restriction
  enzyme recognition sequence.


  Tool homepage: http://www.bioinformatics.babraham.ac.uk/projects/hicup/'
inputs:
  - id: fastq_files
    type:
      type: array
      items: File
    doc: FASTQ file pairs, placed next to each other (read 1 then read 2 of each pair)
    inputBinding:
      position: 2
  - id: config
    type:
      - 'null'
      - File
    doc: Specify the configuration file
    inputBinding:
      position: 103
      prefix: --config
  - id: nofill
    type:
      - 'null'
      - boolean
    doc: Hi-C protocol did NOT include a fill-in of sticky ends prior to re-ligation
      and therefore reads shall be truncated at the restriction site sequence. Only
      supported for single restriction enzyme Hi-C
    inputBinding:
      position: 103
      prefix: --nofill
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress all progress reports
    inputBinding:
      position: 103
      prefix: --quiet
  - id: re1
    type:
      - 'null'
      - string
    doc: Restriction enzyme recognition sequence, e.g. A^GATCT,BglII. Several enzymes
      and N nucleotides are accepted, e.g. A^GATCT,BglII:A^AGCTT,HindIII:^GANTC,myRE
    inputBinding:
      position: 103
      prefix: --re1
  - id: sequences
    type:
      - 'null'
      - string
    doc: Instead of specifying a restriction enzyme recognition sequence, specify
      the ligation sequences directly
    inputBinding:
      position: 103
      prefix: --sequences
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use, allowing simultaneous processing of different files
    inputBinding:
      position: 103
      prefix: --threads
  - id: zip_output
    type:
      - 'null'
      - boolean
    doc: Compress output using gzip
    inputBinding:
      position: 103
      prefix: --zip
  - id: output_directory_path
    type: string
    default: hicup_out
    doc: Directory to write output files
    inputBinding:
      position: 104
      prefix: --outdir
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Directory with all output files
    outputBinding:
      glob: $(inputs.output_directory_path)
  - id: truncated_fastq
    type:
      - 'null'
      - type: array
        items: File
    doc: Truncated FASTQ files
    outputBinding:
      glob: $(inputs.output_directory_path)/*.trunc.fastq*
  - id: summary
    type:
      - 'null'
      - type: array
        items: File
    doc: Truncation summary table
    outputBinding:
      glob: $(inputs.output_directory_path)/hicup_truncater_summary_*
  - id: charts
    type:
      - 'null'
      - type: array
        items: File
    doc: Truncation bar charts
    outputBinding:
      glob: $(inputs.output_directory_path)/*.svg
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.output_directory_path)
        entry: '$({class: "Directory", listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicup:0.9.2--hdfd78af_1
