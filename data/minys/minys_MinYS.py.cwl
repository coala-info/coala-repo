cwlVersion: v1.2
class: CommandLineTool
baseCommand: minys_MinYS.py
label: minys_MinYS.py
doc: "MinYS: A pipeline for de novo assembly of circular DNA molecules\n\nTool homepage:
  https://github.com/cguyomar/MinYS"
inputs:
  - id: assembly_abundance_min
    type:
      - 'null'
      - string
    doc: Minimal abundance of kmers used for assembly
    default: auto
    inputBinding:
      position: 101
      prefix: -assembly-abundance-min
  - id: assembly_kmer_size
    type:
      - 'null'
      - int
    doc: Kmer size used for Minia assembly (should be given even if bypassing 
      minia assembly step, usefull knowledge for gap-filling)
    default: 31
    inputBinding:
      position: 101
      prefix: -assembly-kmer-size
  - id: bwa_index
    type:
      - 'null'
      - File
    doc: Bwa index
    inputBinding:
      position: 101
      prefix: -ref
  - id: contigs_fasta
    type:
      - 'null'
      - File
    doc: Contigs in fasta format - override mapping and assembly
    inputBinding:
      position: 101
      prefix: -contigs
  - id: gapfilling_abundance_min
    type:
      - 'null'
      - string
    doc: Minimal abundance of kmers used for gap-filling
    default: auto
    inputBinding:
      position: 101
      prefix: -gapfilling-abundance-min
  - id: gapfilling_kmer_size
    type:
      - 'null'
      - int
    doc: Kmer size used for gap-filling
    default: 31
    inputBinding:
      position: 101
      prefix: -gapfilling-kmer-size
  - id: graph_h5
    type:
      - 'null'
      - File
    doc: Graph in h5 format - override graph creation
    inputBinding:
      position: 101
      prefix: -graph
  - id: input_file_of_read_files
    type:
      - 'null'
      - File
    doc: Input file of read files (if paired files, 2 columns tab-separated)
    inputBinding:
      position: 101
      prefix: -fof
  - id: input_reads_file
    type:
      - 'null'
      - File
    doc: Input reads file
    inputBinding:
      position: 101
      prefix: -in
  - id: input_reads_first_file
    type:
      - 'null'
      - File
    doc: Input reads first file
    inputBinding:
      position: 101
      prefix: '-1'
  - id: input_reads_second_file
    type:
      - 'null'
      - File
    doc: Input reads second file
    inputBinding:
      position: 101
      prefix: '-2'
  - id: mask_bed_file
    type:
      - 'null'
      - File
    doc: Bed file for region removed from mapping
    inputBinding:
      position: 101
      prefix: -mask
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum length of gap-filling (nt)
    default: 50000
    inputBinding:
      position: 101
      prefix: -max-length
  - id: max_nodes
    type:
      - 'null'
      - int
    doc: Maximum number of nodes in contig graph
    default: 300
    inputBinding:
      position: 101
      prefix: -max-nodes
  - id: min_contig_size
    type:
      - 'null'
      - int
    doc: Minimal size for a contig to be used in gap-filling
    default: 400
    inputBinding:
      position: 101
      prefix: -min-contig-size
  - id: min_prefix_length
    type:
      - 'null'
      - int
    doc: Length of minimum prefix for node merging, default should work for most
      cases
    default: 100
    inputBinding:
      position: 101
      prefix: -l
  - id: mindthegap_build_directory
    type:
      - 'null'
      - Directory
    doc: Path to MindTheGap build directory (if not in $PATH)
    inputBinding:
      position: 101
      prefix: -mtg-dir
  - id: minia_binary_path
    type:
      - 'null'
      - File
    doc: Path to Minia binary (if not in $PATH
    inputBinding:
      position: 101
      prefix: -minia-bin
  - id: num_cores
    type:
      - 'null'
      - int
    doc: Number of cores
    default: 0
    inputBinding:
      position: 101
      prefix: -nb-cores
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: output directory for result files
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minys:1.1--hc9558a2_1
