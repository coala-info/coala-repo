cwlVersion: v1.2
class: CommandLineTool
baseCommand: slamdunk_map
label: slamdunk_map
doc: "Map sequencing reads to a reference genome.\n\nTool homepage: http://t-neumann.github.io/slamdunk"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: Single csv/tsv file (recommended) containing all sample files and 
      sample info or a list of all sample BAM/FASTA(gz)/FASTQ(gz) files
    inputBinding:
      position: 1
  - id: endtoend
    type:
      - 'null'
      - boolean
    doc: Use a end to end alignment algorithm for mapping.
    default: false
    inputBinding:
      position: 102
      prefix: --endtoend
  - id: max_polya
    type:
      - 'null'
      - int
    doc: Max number of As at the 3' end of a read.
    default: 4
    inputBinding:
      position: 102
      prefix: --max-polya
  - id: quantseq
    type:
      - 'null'
      - boolean
    doc: Run plain Quantseq alignment without SLAM-seq scoring
    default: false
    inputBinding:
      position: 102
      prefix: --quantseq
  - id: reference_file
    type: File
    doc: Reference fasta file
    inputBinding:
      position: 102
      prefix: --reference
  - id: sample_index
    type:
      - 'null'
      - int
    doc: Run analysis only for sample <i>. Use for distributing slamdunk 
      analysis on a cluster (index is 1-based).
    default: -1
    inputBinding:
      position: 102
      prefix: --sample-index
  - id: sample_name
    type:
      - 'null'
      - string
    doc: Use this sample name for all supplied samples
    default: None
    inputBinding:
      position: 102
      prefix: --sampleName
  - id: sample_time
    type:
      - 'null'
      - int
    doc: Use this sample time for all supplied samples
    default: 0
    inputBinding:
      position: 102
      prefix: --sampleTime
  - id: sample_type
    type:
      - 'null'
      - string
    doc: Use this sample type for all supplied samples
    default: pulse
    inputBinding:
      position: 102
      prefix: --sampleType
  - id: skip_sam
    type:
      - 'null'
      - boolean
    doc: Output BAM while mapping. Slower but, uses less hard disk.
    default: false
    inputBinding:
      position: 102
      prefix: --skip-sam
  - id: threads
    type:
      - 'null'
      - int
    doc: Thread number
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: topn
    type:
      - 'null'
      - int
    doc: Max. number of alignments to report per read
    default: 1
    inputBinding:
      position: 102
      prefix: --topn
  - id: trim_5p
    type:
      - 'null'
      - int
    doc: Number of bp removed from 5' end of all reads.
    default: 12
    inputBinding:
      position: 102
      prefix: --trim-5p
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory for mapped BAM files.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slamdunk:0.4.3--py_0
