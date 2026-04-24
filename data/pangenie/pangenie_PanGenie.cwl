cwlVersion: v1.2
class: CommandLineTool
baseCommand: PanGenie
label: pangenie_PanGenie
doc: "Genotyping based on kmer-counting and known haplotype sequences.\n\nTool homepage:
  https://github.com/eblerjana/pangenie"
inputs:
  - id: count_all_kmers
    type:
      - 'null'
      - boolean
    doc: count all read kmers instead of only those located in graph
    inputBinding:
      position: 101
      prefix: -c
  - id: effective_population_size
    type:
      - 'null'
      - float
    doc: effective population size for sampling step.
    inputBinding:
      position: 101
      prefix: -b
  - id: hash_size
    type:
      - 'null'
      - int
    doc: size of hash used by jellyfish
    inputBinding:
      position: 101
      prefix: -e
  - id: index_prefix
    type:
      - 'null'
      - string
    doc: Filename prefix of files computed by PanGenie-index (i.e. option -o used
      with PanGenie-index).
    inputBinding:
      position: 101
      prefix: -f
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: kmer size
    inputBinding:
      position: 101
      prefix: -k
  - id: kmer_threads
    type:
      - 'null'
      - int
    doc: number of threads to use for kmer-counting
    inputBinding:
      position: 101
      prefix: -j
  - id: output_null_genotypes
    type:
      - 'null'
      - boolean
    doc: output genotype ./. for variants not covered by any unique kmers
    inputBinding:
      position: 101
      prefix: -u
  - id: reads
    type: File
    doc: 'sequencing reads in FASTA/FASTQ format or Jellyfish database in jf format.
      NOTE: INPUT FASTA/Q FILE MUST NOT BE COMPRESSED.'
    inputBinding:
      position: 101
      prefix: -i
  - id: reduce_panel_size
    type:
      - 'null'
      - int
    doc: to which size the input panel shall be reduced.
    inputBinding:
      position: 101
      prefix: -x
  - id: reference
    type:
      - 'null'
      - File
    doc: 'reference genome in FASTA format. NOTE: INPUT FASTA FILE MUST NOT BE COMPRESSED.'
    inputBinding:
      position: 101
      prefix: -r
  - id: run_genotyping
    type:
      - 'null'
      - boolean
    doc: run genotyping (Forward backward algorithm, default behaviour)
    inputBinding:
      position: 101
      prefix: -g
  - id: run_phasing
    type:
      - 'null'
      - boolean
    doc: run phasing (Viterbi algorithm). Experimental feature
    inputBinding:
      position: 101
      prefix: -p
  - id: sample_name
    type:
      - 'null'
      - string
    doc: name of the sample (will be used in the output VCFs)
    inputBinding:
      position: 101
      prefix: -s
  - id: sample_subsets
    type:
      - 'null'
      - int
    doc: sample subsets of paths of this size
    inputBinding:
      position: 101
      prefix: -a
  - id: sampling_penalty
    type:
      - 'null'
      - int
    doc: Penality used for already selected alleles in sampling step.
    inputBinding:
      position: 101
      prefix: -y
  - id: serialize_results
    type:
      - 'null'
      - boolean
    doc: instead of writing an output vcf, serialize genotyping results.
    inputBinding:
      position: 101
      prefix: -w
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use for core algorithm. Largest number of threads possible
      is the number of chromosomes given in the VCF
    inputBinding:
      position: 101
      prefix: -t
  - id: variants
    type:
      - 'null'
      - File
    doc: 'variants in VCF format. NOTE: INPUT VCF FILE MUST NOT BE COMPRESSED.'
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: write_sampled_panel
    type:
      - 'null'
      - File
    doc: write sampled panel to additional output VCF.
    outputBinding:
      glob: $(inputs.write_sampled_panel)
  - id: output_prefix
    type: File
    doc: 'prefix of the output files. NOTE: the given path must not include non-existent
      folders'
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangenie:4.2.1--h077b44d_0
