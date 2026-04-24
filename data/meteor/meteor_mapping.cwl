cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - meteor
  - mapping
label: meteor_mapping
doc: "Map reads against a gene catalog and calculate raw gene counts.\n\nTool homepage:
  https://github.com/metagenopolis/meteor"
inputs:
  - id: alignment_number
    type:
      - 'null'
      - int
    doc: Maximum number alignments to report for each read
    inputBinding:
      position: 101
      prefix: --align
  - id: core_size
    type:
      - 'null'
      - int
    doc: Number of signature genes per species (MSP) used to estimate their 
      respective abundance
    inputBinding:
      position: 101
      prefix: --core_size
  - id: count_strategy
    type:
      - 'null'
      - string
    doc: Strategy to calculate raw gene counts (total, smart_shared, or unique).
    inputBinding:
      position: 101
      prefix: -c
  - id: fastq_dir
    type: Directory
    doc: Directory corresponding to the sample to process. (contains sequencing 
      metadata files ending with _census_stage_0.json)
    inputBinding:
      position: 101
      prefix: -i
  - id: identity_threshold
    type:
      - 'null'
      - string
    doc: Select only read alignments with a nucleotide identity >= 
      IDENTITY_THRESHOLD. If 0.0, no filtering.
    inputBinding:
      position: 101
      prefix: --id
  - id: keep_all
    type:
      - 'null'
      - boolean
    doc: Keep raw bowtie2 output in cram format. Required for calculating gene 
      counts with another strategy.
    inputBinding:
      position: 101
      prefix: --ka
  - id: keep_filtered
    type:
      - 'null'
      - boolean
    doc: Keep filtered alignments on marker genes. Required for strain analysis.
    inputBinding:
      position: 101
      prefix: --kf
  - id: ref_dir
    type: Directory
    doc: Directory corresponding to the gene catalog against which reads are 
      mapped. (contains a file ending with *_reference.json)
    inputBinding:
      position: 101
      prefix: -r
  - id: strategy
    type:
      - 'null'
      - string
    doc: Strategy to map reads against the catalogue (end-to-end or local).
    inputBinding:
      position: 101
      prefix: -p
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of alignment threads to launch
    inputBinding:
      position: 101
      prefix: -t
  - id: tmp_path
    type:
      - 'null'
      - Directory
    doc: Directory where temporary files (e.g. cram) are stored
    inputBinding:
      position: 101
      prefix: --tmp
  - id: trim
    type:
      - 'null'
      - int
    doc: Trim reads exceeding TRIM bases before mapping. If 0, no trim.
    inputBinding:
      position: 101
      prefix: --trim
outputs:
  - id: mapping_dir
    type: Directory
    doc: Directory where mapping and raw gene counts of the sample are saved.
    outputBinding:
      glob: $(inputs.mapping_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meteor:2.0.22--pyhdfd78af_0
