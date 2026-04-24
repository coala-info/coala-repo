cwlVersion: v1.2
class: CommandLineTool
baseCommand: LINKS
label: links_LINKS
doc: "v2.0.1\n\nTool homepage: https://github.com/bcgsc/LINKS"
inputs:
  - id: bloom_filter_false_positive_rate
    type:
      - 'null'
      - float
    doc: Bloom filter false positive rate (default -p 0.001, optional; increase 
      to prevent memory allocation errors)
    inputBinding:
      position: 101
      prefix: -p
  - id: bloom_filter_input_file
    type:
      - 'null'
      - File
    doc: "Bloom filter input file for sequences supplied in -s (optional, if none
      provided will output to .bloom)\n                    NOTE: BLOOM FILTER MUST
      BE DERIVED FROM THE SAME FILE SUPPLIED IN -f WITH SAME -k VALUE\n          \
      \          IF YOU DO NOT SUPPLY A BLOOM FILTER, ONE WILL BE CREATED (.bloom)"
    inputBinding:
      position: 101
      prefix: -r
  - id: distance_between_kmer_pairs
    type:
      - 'null'
      - type: array
        items: string
    doc: "distance between k-mer pairs (ie. target distances to re-scaffold on. default
      -d 4000, optional)\n                    Multiple distances are separated by
      comma. eg. -d 500,1000,2000,3000"
    inputBinding:
      position: 101
      prefix: -d
  - id: error_percentage
    type:
      - 'null'
      - float
    doc: error (%) allowed on -d distance   e.g. -e 0.1  == distance +/- 10% 
      (default -e 0.1, optional)
    inputBinding:
      position: 101
      prefix: -e
  - id: kmer_value
    type:
      - 'null'
      - int
    doc: k-mer value (default -k 15, optional)
    inputBinding:
      position: 101
      prefix: -k
  - id: long_sequence_reads_or_mpet_pairs
    type: File
    doc: file-of-filenames, full path to long sequence reads or MPET pairs [see 
      below] (Multi-FASTA/fastq format, required)
    inputBinding:
      position: 101
      prefix: -s
  - id: maximum_link_ratio
    type:
      - 'null'
      - float
    doc: "maximum link ratio between two best contig pairs (default -a 0.3, optional)\n\
      \                    *higher values lead to least accurate scaffolding*"
    inputBinding:
      position: 101
      prefix: -a
  - id: minimum_contig_length
    type:
      - 'null'
      - int
    doc: minimum contig length to consider for scaffolding (default -z 500, 
      optional)
    inputBinding:
      position: 101
      prefix: -z
  - id: minimum_links
    type:
      - 'null'
      - int
    doc: minimum number of links (k-mer pairs) to compute scaffold (default -l 
      5, optional)
    inputBinding:
      position: 101
      prefix: -l
  - id: offset_position
    type:
      - 'null'
      - int
    doc: offset position for extracting k-mer pairs (default -o 0, optional)
    inputBinding:
      position: 101
      prefix: -o
  - id: output_base_name
    type:
      - 'null'
      - string
    doc: base name for your output files (optional)
    inputBinding:
      position: 101
      prefix: -b
  - id: sequences_to_scaffold
    type: File
    doc: sequences to scaffold (Multi-FASTA format, required)
    inputBinding:
      position: 101
      prefix: -f
  - id: step_of_sliding_window
    type:
      - 'null'
      - type: array
        items: string
    doc: "step of sliding window when extracting k-mer pairs from long reads (default
      -t 2, optional)\n                    Multiple steps are separated by comma.
      eg. -t 10,5"
    inputBinding:
      position: 101
      prefix: -t
  - id: threads
    type:
      - 'null'
      - int
    doc: threads  (default -j 3, optional)
    inputBinding:
      position: 101
      prefix: -j
  - id: turn_off_bloom_filter
    type:
      - 'null'
      - boolean
    doc: Turn off Bloom filter functionality (-x 1 = yes, default = no, 
      optional)
    inputBinding:
      position: 101
      prefix: -x
  - id: verbose_mode
    type:
      - 'null'
      - boolean
    doc: Runs in verbose mode (-v 1 = yes, default = no, optional)
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/links:2.0.1--h9948957_7
stdout: links_LINKS.out
