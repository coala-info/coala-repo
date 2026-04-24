cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fairy
  - coverage
label: fairy_coverage
doc: "Extremely fast species-level coverage calculation by k-mer sketching\n\nTool
  homepage: https://github.com/bluenote-1577/fairy"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Pre-sketched *.bcsp files and raw fasta/gzip contig files
    inputBinding:
      position: 1
  - id: aemb_format
    type:
      - 'null'
      - boolean
    doc: 'Strobealign --aemb format (default: MetaBAT2 format with variances)'
    inputBinding:
      position: 102
      prefix: --aemb-format
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug output
    inputBinding:
      position: 102
      prefix: --debug
  - id: file_list
    type:
      - 'null'
      - File
    doc: Newline delimited file of file inputs
    inputBinding:
      position: 102
      prefix: --list
  - id: full_contig_name
    type:
      - 'null'
      - boolean
    doc: Use full contig name (including characters after the first space)
    inputBinding:
      position: 102
      prefix: --full-contig-name
  - id: k_value
    type:
      - 'null'
      - int
    doc: Value of k. Only k = 21, 31 are currently supported. Does nothing for 
      pre-sketched files
    inputBinding:
      position: 102
      prefix: -k
  - id: maxbin_format
    type:
      - 'null'
      - boolean
    doc: 'Remove contig length, average depth, and variance columns. (default: MetaBAT2
      format with variances)'
    inputBinding:
      position: 102
      prefix: --maxbin-format
  - id: min_number_kmers
    type:
      - 'null'
      - int
    doc: Exclude genomes with less than this number of sampled k-mers
    inputBinding:
      position: 102
      prefix: --min-number-kmers
  - id: min_spacing
    type:
      - 'null'
      - int
    doc: Minimum spacing between selected k-mers on the contigs.
    inputBinding:
      position: 102
      prefix: --min-spacing
  - id: minimum_ani
    type:
      - 'null'
      - float
    doc: Minimum adjusted ANI to consider (0-100) for coverage calculation. 
      Default is 95. Don't lower this unless you know what you're doing
    inputBinding:
      position: 102
      prefix: --minimum-ani
  - id: sample_threads
    type:
      - 'null'
      - int
    doc: 'Number of samples to be processed concurrently. Default: (# of total threads
      / 2) + 1'
    inputBinding:
      position: 102
      prefix: --sample-threads
  - id: subsampling_rate
    type:
      - 'null'
      - int
    doc: Subsampling rate. Does nothing for pre-sketched files
    inputBinding:
      position: 102
      prefix: -c
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 102
      prefix: -t
  - id: trace
    type:
      - 'null'
      - boolean
    doc: 'Trace output (caution: very verbose)'
    inputBinding:
      position: 102
      prefix: --trace
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output to this file instead of stdout
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fairy:0.5.8--hc1c3326_0
