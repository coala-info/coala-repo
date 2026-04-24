cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pathoscope
  - MAP
label: pathoscope_MAP
doc: "PathoScope MAP module for mapping reads to target and filter reference genomes
  using Bowtie2\n\nTool homepage: https://github.com/PathoScope/PathoScope"
inputs:
  - id: bt_home
    type:
      - 'null'
      - Directory
    doc: 'Full Path to Bowtie2 binary directory (Default: Uses bowtie2 in system path)'
    inputBinding:
      position: 101
      prefix: -btHome
  - id: exp_tag
    type:
      - 'null'
      - string
    doc: 'Experiment Tag added to files generated for identification (Default: pathomap)'
    inputBinding:
      position: 101
      prefix: -expTag
  - id: filter_align_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Filter Alignment Files Full Path (Comma Separated)
    inputBinding:
      position: 101
      prefix: -filterAlignFiles
  - id: filter_align_params
    type:
      - 'null'
      - string
    doc: 'Filter Mapping Bowtie2 Parameters (Default: Use the same Target Mapping
      Bowtie2 parameters)'
    inputBinding:
      position: 101
      prefix: -filterAlignParams
  - id: filter_index_prefixes
    type:
      - 'null'
      - type: array
        items: string
    doc: Filter Index Prefixes (Comma Separated)
    inputBinding:
      position: 101
      prefix: -filterIndexPrefixes
  - id: filter_ref_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Filter Reference Genome Fasta Files Full Path (Comma Separated)
    inputBinding:
      position: 101
      prefix: -filterRefFiles
  - id: index_dir
    type:
      - 'null'
      - Directory
    doc: Index Directory (Default=. (current directory))
    inputBinding:
      position: 101
      prefix: -indexDir
  - id: input_read_pair1
    type:
      - 'null'
      - File
    doc: Input Read Fastq File (Pair 1)
    inputBinding:
      position: 101
      prefix: '-1'
  - id: input_read_pair2
    type:
      - 'null'
      - File
    doc: Input Read Fastq File (Pair 2)
    inputBinding:
      position: 101
      prefix: '-2'
  - id: input_read_unpaired
    type:
      - 'null'
      - File
    doc: Input Read Fastq File (Unpaired/Single-end)
    inputBinding:
      position: 101
      prefix: -U
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use by aligner (bowtie2) if different from default (8)
    inputBinding:
      position: 101
      prefix: -numThreads
  - id: target_align_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Target Alignment Files Full Path (Comma Separated)
    inputBinding:
      position: 101
      prefix: -targetAlignFiles
  - id: target_align_params
    type:
      - 'null'
      - string
    doc: 'Target Mapping Bowtie2 Parameters (Default: Pathoscope chosen best parameters)'
    inputBinding:
      position: 101
      prefix: -targetAlignParams
  - id: target_index_prefixes
    type:
      - 'null'
      - type: array
        items: string
    doc: Target Index Prefixes (Comma Separated)
    inputBinding:
      position: 101
      prefix: -targetIndexPrefixes
  - id: target_ref_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Target Reference Genome Fasta Files Full Path (Comma Separated)
    inputBinding:
      position: 101
      prefix: -targetRefFiles
outputs:
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Output Directory (Default=. (current directory))
    outputBinding:
      glob: $(inputs.out_dir)
  - id: out_align
    type:
      - 'null'
      - File
    doc: Output Alignment File Name (Default=outalign.sam)
    outputBinding:
      glob: $(inputs.out_align)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pathoscope:2.0.7--pyhdfd78af_2
