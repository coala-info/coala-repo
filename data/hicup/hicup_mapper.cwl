cwlVersion: v1.2
class: CommandLineTool
baseCommand: hicup_mapper
label: hicup_mapper
doc: 'The hicup_mapper script aligns paired-end read files to a specified reference
  genome. Forward and reverse reads are aligned independently with Bowtie or Bowtie2
  and then paired, so two input files result in one output file.


  Tool homepage: http://www.bioinformatics.babraham.ac.uk/projects/hicup/'
inputs:
  - id: fastq_files
    type:
      type: array
      items: File
    doc: FASTQ file pairs (usually the truncated reads), placed next to each other
    inputBinding:
      position: 2
  - id: bowtie_path
    type:
      - 'null'
      - string
    doc: Specify the path to Bowtie
    inputBinding:
      position: 103
      prefix: --bowtie
  - id: bowtie2_path
    type:
      - 'null'
      - string
    doc: Specify the path to Bowtie 2
    inputBinding:
      position: 103
      prefix: --bowtie2
  - id: config
    type:
      - 'null'
      - File
    doc: Specify the configuration file
    inputBinding:
      position: 103
      prefix: --config
  - id: fastq_format
    type:
      - 'null'
      - string
    doc: 'Specify FASTQ format. Options: Sanger, Solexa_Illumina_1.0, Illumina_1.3,
      Illumina_1.5'
    inputBinding:
      position: 103
      prefix: --format
  - id: reference_index
    type:
      - 'null'
      - type: array
        items: File
    doc: Bowtie/Bowtie2 index files of the reference genome (staged in the working
      directory so that the index prefix resolves)
  - id: index_prefix
    type:
      - 'null'
      - string
    doc: Path (prefix) to the relevant reference genome Bowtie/Bowtie2 indices
    inputBinding:
      position: 103
      prefix: --index
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress progress reports (except warnings)
    inputBinding:
      position: 103
      prefix: --quiet
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Specify the number of threads, allowing simultaneous processing of different
      files (default: 1)'
    inputBinding:
      position: 103
      prefix: --threads
  - id: zip_output
    type:
      - 'null'
      - boolean
    doc: Compress output
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
  - id: paired_alignments
    type:
      - 'null'
      - type: array
        items: File
    doc: Paired alignment file (SAM, or BAM with --zip)
    outputBinding:
      glob: $(inputs.output_directory_path)/*.pair.*
  - id: summary
    type:
      - 'null'
      - type: array
        items: File
    doc: Mapper summary table
    outputBinding:
      glob: $(inputs.output_directory_path)/hicup_mapper_summary_*
  - id: charts
    type:
      - 'null'
      - type: array
        items: File
    doc: Mapping bar charts
    outputBinding:
      glob: $(inputs.output_directory_path)/*.svg
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.reference_index || [])
      - entryname: $(inputs.output_directory_path)
        entry: '$({class: "Directory", listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicup:0.9.2--hdfd78af_1
