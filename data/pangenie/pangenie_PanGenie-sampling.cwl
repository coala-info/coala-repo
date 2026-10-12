cwlVersion: v1.2
class: CommandLineTool
baseCommand: PanGenie-sampling
label: pangenie_PanGenie-sampling
doc: "PanGenie - genotyping based on kmer-counting and known haplotype sequences.
  Sampling step: reduces the haplotype panel to the paths that best fit the reads.\n\nTool
  homepage: https://github.com/eblerjana/pangenie"
inputs:
  - id: effective_population_size
    type:
      - 'null'
      - float
    doc: effective population size for sampling step.
    inputBinding:
      position: 101
      prefix: -b
  - id: count_all_kmers
    type:
      - 'null'
      - boolean
    doc: count all read kmers instead of only those located in graph
    inputBinding:
      position: 101
      prefix: -c
  - id: hash_size
    type:
      - 'null'
      - int
    doc: size of hash used by jellyfish
    inputBinding:
      position: 101
      prefix: -e
  - id: index_prefix
    type: string
    doc: Filename prefix of files computed by PanGenie-index (i.e. option -o 
      used with PanGenie-index).
    inputBinding:
      position: 101
      prefix: -f
  - id: reads
    type: File
    doc: 'sequencing reads in FASTA/FASTQ format or Jellyfish database in jf format.
      NOTE: INPUT FASTA/Q FILE MUST NOT BE COMPRESSED.'
    inputBinding:
      position: 101
      prefix: -i
  - id: kmer_threads
    type:
      - 'null'
      - int
    doc: number of threads to use for kmer-counting
    inputBinding:
      position: 101
      prefix: -j
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: kmer size
    inputBinding:
      position: 101
      prefix: -k
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use for core algorithm. Largest number of threads 
      possible is the number of chromosomes given in the VCF
    inputBinding:
      position: 101
      prefix: -t
  - id: reduce_panel_size
    type:
      - 'null'
      - int
    doc: to which size the input panel shall be reduced.
    inputBinding:
      position: 101
      prefix: -x
  - id: sampling_penalty
    type:
      - 'null'
      - int
    doc: Penality used for already selected alleles in sampling step.
    inputBinding:
      position: 101
      prefix: -y
  - id: index_files
    type:
      type: array
      items: File
    doc: Index files written by PanGenie-index (all files starting with the index prefix); staged in the working directory so the -f prefix resolves
  - id: output_prefix_path
    type: string
    doc: 'prefix of the output files. NOTE: the given path must not include non-existent
      folders (default: result).'
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: output_prefix
    type:
      type: array
      items: File
    doc: 'prefix of the output files. NOTE: the given path must not include non-existent
      folders.'
    outputBinding:
      glob: $(inputs.output_prefix_path)*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.index_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangenie:4.2.1--h077b44d_0
