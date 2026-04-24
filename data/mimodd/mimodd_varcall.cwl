cwlVersion: v1.2
class: CommandLineTool
baseCommand: varcall
label: mimodd_varcall
doc: "Call variants from aligned reads\n\nTool homepage: http://sourceforge.net/projects/mimodd"
inputs:
  - id: reference_genome
    type: File
    doc: the reference genome (in fasta format)
    inputBinding:
      position: 1
  - id: input_files
    type:
      type: array
      items: File
    doc: one or more BAM input files of aligned reads from one or more samples 
      (will be indexed automatically)
    inputBinding:
      position: 2
  - id: group_by_id
    type:
      - 'null'
      - boolean
    doc: optional flag to control handling of multi-sample input; if enabled, 
      reads from different read groups are analyzed as separate samples even if 
      the sample names associated with the read groups are identical; otherwise,
      the samtools default is used (reads are grouped based on the sample names 
      of their read groups)
    inputBinding:
      position: 103
      prefix: --group-by-id
  - id: index_files
    type:
      - 'null'
      - type: array
        items: File
    doc: pre-computed index files for all input files
    inputBinding:
      position: 103
      prefix: --index-files
  - id: max_depth
    type:
      - 'null'
      - int
    doc: average sample depth cap applied to input with extraordinarily large 
      numbers of samples sequenced at high coverage to limit memory usage
    inputBinding:
      position: 103
      prefix: --max-depth
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: suppress original messages from samtools mpileup and bcftools call
    inputBinding:
      position: 103
      prefix: --quiet
  - id: relaxed
    type:
      - 'null'
      - boolean
    doc: turn off md5 checksum comparison between sequences in the reference 
      genome and those specified in the BAM input file header(s)
    inputBinding:
      position: 103
      prefix: --relaxed
  - id: threads
    type:
      - 'null'
      - int
    doc: the number of threads to use (overrides config setting)
    inputBinding:
      position: 103
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose output independent of samtools/bcftools
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: redirect the output (variant sites) to the specified file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimodd:0.1.9--py35_0
