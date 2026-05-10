cwlVersion: v1.2
class: CommandLineTool
baseCommand: arcs
label: arcs
doc: "ARCS/ARKS utilizes linked read alignments or kmers for scaffolding draft genomes.\n\
  \ \nTool homepage: https://github.com/bcgsc/arcs"
inputs:
  - id: alignment_files
    type:
      - 'null'
      - type: array
        items: File
    doc: List of alignment files (SAM/BAM) or linked read files
    inputBinding:
      position: 1
  - id: arks
    type:
      - 'null'
      - boolean
    doc: Use ARKS method
    inputBinding:
      position: 102
      prefix: --arks
  - id: base_name
    type:
      - 'null'
      - string
    doc: output file prefix
    inputBinding:
      position: 102
      prefix: --base_name
  - id: bin_size
    type:
      - 'null'
      - int
    doc: estimate distance using N closest Jaccard scores
    inputBinding:
      position: 102
      prefix: --bin_size
  - id: contig_file
    type:
      - 'null'
      - File
    doc: FASTA file of contig sequences to scaffold
    inputBinding:
      position: 102
      prefix: --file
  - id: dist_est
    type:
      - 'null'
      - boolean
    doc: enable distance estimation
    inputBinding:
      position: 102
      prefix: --dist_est
  - id: dist_median
    type:
      - 'null'
      - boolean
    doc: use median distance in ABySS dist.gv
    inputBinding:
      position: 102
      prefix: --dist_median
  - id: dist_upper
    type:
      - 'null'
      - boolean
    doc: use upper bound distance in ABySS dist.gv
    inputBinding:
      position: 102
      prefix: --dist_upper
  - id: end_length
    type:
      - 'null'
      - int
    doc: contig head/tail length for masking alignments
    inputBinding:
      position: 102
      prefix: --end_length
  - id: error_percent
    type:
      - 'null'
      - float
    doc: p-value for head/tail assignment and link orientation
    inputBinding:
      position: 102
      prefix: --error_percent
  - id: fof_name
    type:
      - 'null'
      - File
    doc: text file listing input filenames
    inputBinding:
      position: 102
      prefix: --fofName
  - id: gap_size
    type:
      - 'null'
      - int
    doc: fixed gap size for ABySS dist.gv file
    inputBinding:
      position: 102
      prefix: --gap
  - id: index_multiplicity
    type:
      - 'null'
      - string
    doc: barcode multiplicity range
    inputBinding:
      position: 102
      prefix: --index_multiplicity
  - id: j_index
    type:
      - 'null'
      - float
    doc: minimum fraction of read kmers matching a contigId (ARKS specific)
    inputBinding:
      position: 102
      prefix: --j_index
  - id: k_value
    type:
      - 'null'
      - int
    doc: size of a k-mer (ARKS specific)
    inputBinding:
      position: 102
      prefix: --k_value
  - id: max_degree
    type:
      - 'null'
      - int
    doc: max node degree in scaffold graph
    inputBinding:
      position: 102
      prefix: --max_degree
  - id: min_links
    type:
      - 'null'
      - int
    doc: min shared barcodes between contigs
    inputBinding:
      position: 102
      prefix: --min_links
  - id: min_reads
    type:
      - 'null'
      - int
    doc: min aligned read pairs per barcode mapping
    inputBinding:
      position: 102
      prefix: --min_reads
  - id: min_size
    type:
      - 'null'
      - int
    doc: min contig length
    inputBinding:
      position: 102
      prefix: --min_size
  - id: multfile
    type:
      - 'null'
      - File
    doc: tsv or csv file listing barcode multiplicities [optional]
    inputBinding:
      position: 102
      prefix: --multfile
  - id: no_dist_est
    type:
      - 'null'
      - boolean
    doc: disable distance estimation
    inputBinding:
      position: 102
      prefix: --no_dist_est
  - id: pair_output
    type:
      - 'null'
      - boolean
    doc: output scaffolds pairing TSV with number of barcode links supporting 
      each of the 4 possible orientation
    inputBinding:
      position: 102
      prefix: --pair
  - id: run_verbose
    type:
      - 'null'
      - boolean
    doc: verbose logging
    inputBinding:
      position: 102
      prefix: --run_verbose
  - id: seq_id
    type:
      - 'null'
      - int
    doc: min sequence identity for read alignments (ARCS specific)
    inputBinding:
      position: 102
      prefix: --seq_id
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads (ARKS specific)
    inputBinding:
      position: 102
      prefix: --threads
  - id: barcode_counts_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `barcode_counts_file_path`
    inputBinding:
      position: 103
      prefix: --barcode-counts-file
  - id: dist_tsv_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `dist_tsv_path`
    inputBinding:
      position: 104
      prefix: --dist-tsv
  - id: graph_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `graph_file_path`
    inputBinding:
      position: 105
      prefix: --graph-file
  - id: samples_tsv_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `samples_tsv_path`
    inputBinding:
      position: 106
      prefix: --samples-tsv
  - id: tsv_output_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `tsv_output_path`
    inputBinding:
      position: 107
      prefix: --tsv-output
outputs:
  - id: graph_file
    type:
      - 'null'
      - File
    doc: write the ABySS dist.gv to FILE
    outputBinding:
      glob: $(inputs.graph_file_path)
  - id: tsv_output
    type:
      - 'null'
      - File
    doc: write graph in TSV format to FILE
    outputBinding:
      glob: $(inputs.tsv_output_path)
  - id: barcode_counts_file
    type:
      - 'null'
      - File
    doc: write number of reads per barcode to FILE
    outputBinding:
      glob: $(inputs.barcode_counts_file_path)
  - id: dist_tsv
    type:
      - 'null'
      - File
    doc: write min/max distance estimates to FILE
    outputBinding:
      glob: $(inputs.dist_tsv_path)
  - id: samples_tsv
    type:
      - 'null'
      - File
    doc: write intra-contig distance/barcode samples to FILE
    outputBinding:
      glob: $(inputs.samples_tsv_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/arcs:1.2.8--hdcf5f25_0
