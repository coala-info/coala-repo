cwlVersion: v1.2
class: CommandLineTool
baseCommand: ./ngsngs
label: ngsngs
doc: "Next Generation Simulator for Next Generator Sequencing Data\n\nTool homepage:
  https://github.com/rahenriksen/ngsngs"
inputs:
  - id: adapter1
    type:
      - 'null'
      - string
    doc: Adapter sequence to add for simulated reads (SE) or first read pair 
      (PE).
    inputBinding:
      position: 101
      prefix: --adapter1
  - id: adapter2
    type:
      - 'null'
      - string
    doc: Adapter sequence to add for second read pair (PE).
    inputBinding:
      position: 101
      prefix: --adapter2
  - id: adapter_sequence1
    type:
      - 'null'
      - string
    doc: Adapter sequence to add for simulated reads (SE) or first read pair 
      (PE).
    inputBinding:
      position: 101
      prefix: -a1
  - id: adapter_sequence1_option
    type:
      - 'null'
      - string
    doc: Adapter sequence to add for simulated reads (SE) or first read pair 
      (PE).
    inputBinding:
      position: 101
      prefix: -a1
  - id: adapter_sequence2
    type:
      - 'null'
      - string
    doc: Adapter sequence to add for second read pair (PE).
    inputBinding:
      position: 101
      prefix: -a2
  - id: adapter_sequence2_option
    type:
      - 'null'
      - string
    doc: Adapter sequence to add for second read pair (PE).
    inputBinding:
      position: 101
      prefix: -a2
  - id: buffer_length
    type:
      - 'null'
      - int
    doc: Buffer length for generated sequence reads stored in the output files, 
      default = 30000000.
    default: 30000000
    inputBinding:
      position: 101
      prefix: --bufferlength
  - id: buffer_length_for_reads
    type:
      - 'null'
      - int
    doc: Buffer length for generated sequence reads
    inputBinding:
      position: 101
      prefix: -bl
  - id: buffer_length_for_reads_option
    type:
      - 'null'
      - int
    doc: Buffer length for generated sequence reads
    inputBinding:
      position: 101
      prefix: -bl
  - id: chromosomes
    type:
      - 'null'
      - type: array
        items: string
    doc: Specific chromosomes from input reference file to simulate from.
    inputBinding:
      position: 101
      prefix: --chromosomes
  - id: compression_threads
    type:
      - 'null'
      - int
    doc: Number of compression threads
    inputBinding:
      position: 101
      prefix: -t2
  - id: compression_threads_option
    type:
      - 'null'
      - int
    doc: Number of compression threads
    inputBinding:
      position: 101
      prefix: -t2
  - id: coverage
    type:
      - 'null'
      - int
    doc: Depth of Coverage to simulate, conflics with -r option.
    inputBinding:
      position: 101
      prefix: --coverage
  - id: cycle_length
    type:
      - 'null'
      - int
    doc: Read cycle length, the maximum length of sequence reads, if not 
      provided the cycle length will be inferred from quality profiles (q1,q2).
    inputBinding:
      position: 101
      prefix: --cycle
  - id: deamination_model
    type:
      - 'null'
      - string
    doc: Choice of deamination model.
    inputBinding:
      position: 101
      prefix: --model
  - id: deamination_model_params
    type:
      - 'null'
      - string
    doc: Choice of deamination model parameters
    inputBinding:
      position: 101
      prefix: -m
  - id: deamination_model_params_option
    type:
      - 'null'
      - string
    doc: Choice of deamination model parameters
    inputBinding:
      position: 101
      prefix: -m
  - id: depth_of_coverage
    type:
      - 'null'
      - int
    doc: Depth of Coverage to simulate
    inputBinding:
      position: 101
      prefix: -c
  - id: disable_sequencing_errors
    type:
      - 'null'
      - boolean
    doc: Disabling the sequencing error substitutions
    inputBinding:
      position: 101
      prefix: -ne
  - id: disable_sequencing_errors_option
    type:
      - 'null'
      - boolean
    doc: Disabling the sequencing error substitutions
    inputBinding:
      position: 101
      prefix: -ne
  - id: dump_indel
    type:
      - 'null'
      - string
    doc: The prefix of an internally generated txt file, containing the the read
      id, number of indels, the number of indel operations saving the position 
      before and after and length of the indel, simulated read length before and
      after, see supplementary material for detailed example and description.
    inputBinding:
      position: 101
      prefix: -DumpIndel
  - id: dump_indel_file_prefix
    type:
      - 'null'
      - string
    doc: The prefix of an internally generated txt file, containing the the read
      id, number of indels, etc.
    inputBinding:
      position: 101
      prefix: -DumpIndel
  - id: dump_indel_file_prefix_option
    type:
      - 'null'
      - string
    doc: The prefix of an internally generated txt file, containing the the read
      id, number of indels, etc.
    inputBinding:
      position: 101
      prefix: -DumpIndel
  - id: dump_vcf_fasta_prefix
    type:
      - 'null'
      - string
    doc: The prefix of an internally generated fasta file, containing the 
      sequences representing the haplotypes with the variations from the 
      provided vcf file
    inputBinding:
      position: 101
      prefix: -DumpVCF
  - id: dump_vcf_fasta_prefix_option
    type:
      - 'null'
      - string
    doc: The prefix of an internally generated fasta file, containing the 
      sequences representing the haplotypes with the variations from the 
      provided vcf file
    inputBinding:
      position: 101
      prefix: -DumpVCF
  - id: dump_vcf_prefix
    type:
      - 'null'
      - string
    doc: The prefix of an internally generated fasta file, containing the 
      sequences representing the haplotypes with the variations from the 
      provided vcf file (-vcf|-bcf), for diploid individuals the fasta file 
      contains two copies of the reference genome with the each allelic 
      genotype.
    inputBinding:
      position: 101
      prefix: -DumpVCF
  - id: duplicates
    type:
      - 'null'
      - int
    doc: Number of PCR duplicates, used in conjunction with briggs modern 
      library prep -m <b,nv,Lambda,Delta_s,Delta_d>
    default: 1
    inputBinding:
      position: 101
      prefix: --duplicates
  - id: fixed_fragment_length
    type:
      - 'null'
      - int
    doc: Fixed length of simulated fragments
    inputBinding:
      position: 101
      prefix: -l
  - id: fixed_fragment_length_option
    type:
      - 'null'
      - int
    doc: Fixed length of simulated fragments
    inputBinding:
      position: 101
      prefix: -l
  - id: fixed_length
    type:
      - 'null'
      - int
    doc: Fixed length of simulated fragments, conflicts with -lf & -ld option.
    inputBinding:
      position: 101
      prefix: --length
  - id: fixed_quality_score
    type:
      - 'null'
      - int
    doc: Fixed quality score
    inputBinding:
      position: 101
      prefix: -qs
  - id: fixed_quality_score_option
    type:
      - 'null'
      - int
    doc: Fixed quality score
    inputBinding:
      position: 101
      prefix: -qs
  - id: header_only
    type:
      - 'null'
      - boolean
    doc: print SAM header only (no alignments)
    inputBinding:
      position: 101
      prefix: -H
  - id: include_header
    type:
      - 'null'
      - boolean
    doc: include header in SAM output
    inputBinding:
      position: 101
      prefix: -h
  - id: indel_params
    type:
      - 'null'
      - string
    doc: Input probabilities and lambda values for a geometric distribution 
      randomly generating insertions and deletions of a random length.
    inputBinding:
      position: 101
      prefix: -indel
  - id: indel_probabilities
    type:
      - 'null'
      - string
    doc: Input probabilities and lambda values for a geometric distribution 
      randomly generating insertions and deletions
    inputBinding:
      position: 101
      prefix: -indel
  - id: indel_probabilities_option
    type:
      - 'null'
      - string
    doc: Input probabilities and lambda values for a geometric distribution 
      randomly generating insertions and deletions
    inputBinding:
      position: 101
      prefix: -indel
  - id: individual_index
    type:
      - 'null'
      - int
    doc: Integer value (0 - index) for the number of a specific individual 
      defined in bcf header from -vcf/-bcf input file, default = -1 (no 
      individual selected).
    default: -1
    inputBinding:
      position: 101
      prefix: --indiv
  - id: individual_index_for_vcf
    type:
      - 'null'
      - int
    doc: Integer value (0 - index) for the number of a specific individual 
      defined in bcf header
    inputBinding:
      position: 101
      prefix: -id
  - id: individual_index_for_vcf_option
    type:
      - 'null'
      - int
    doc: Integer value (0 - index) for the number of a specific individual 
      defined in bcf header
    inputBinding:
      position: 101
      prefix: -id
  - id: input_reference
    type: File
    doc: Reference file in fasta format (.fa,.fasta) to sample reads.
    inputBinding:
      position: 101
      prefix: --input
  - id: length_distribution
    type:
      - 'null'
      - string
    doc: Discrete or continuous probability distributions, given their 
      Probability density function, conflicts with -l & -lf option.
    inputBinding:
      position: 101
      prefix: --lengthdist
  - id: length_distribution_file
    type:
      - 'null'
      - File
    doc: CDF of a length distribution
    inputBinding:
      position: 101
      prefix: -lf
  - id: length_distribution_file_option
    type:
      - 'null'
      - File
    doc: CDF of a length distribution
    inputBinding:
      position: 101
      prefix: -lf
  - id: length_distribution_type
    type:
      - 'null'
      - string
    doc: Discrete or continuous probability distributions
    inputBinding:
      position: 101
      prefix: -ld
  - id: length_distribution_type_option
    type:
      - 'null'
      - string
    doc: Discrete or continuous probability distributions
    inputBinding:
      position: 101
      prefix: -ld
  - id: length_file
    type:
      - 'null'
      - File
    doc: CDF of a length distribution, conflicts with -l & -ld option.
    inputBinding:
      position: 101
      prefix: --lengthfile
  - id: lower_fragment_limit
    type:
      - 'null'
      - int
    doc: Lower fragment length limit, default = 30. The minimum fragment length 
      for deamination is 30, so simulated fragments below will be fixed at 30.
    default: 30
    inputBinding:
      position: 101
      prefix: --lowerlimit
  - id: lower_fragment_limit_for_deamination
    type:
      - 'null'
      - int
    doc: Lower fragment length limit for deamination
    inputBinding:
      position: 101
      prefix: -ll
  - id: lower_fragment_limit_for_deamination_option
    type:
      - 'null'
      - int
    doc: Lower fragment length limit for deamination
    inputBinding:
      position: 101
      prefix: -ll
  - id: mismatch_file
    type:
      - 'null'
      - File
    doc: Nucleotide substitution frequency file.
    inputBinding:
      position: 101
      prefix: --mismatch
  - id: no_align
    type:
      - 'null'
      - boolean
    doc: Using the SAM output as a sequence container without alignment 
      information.
    inputBinding:
      position: 101
      prefix: --noalign
  - id: no_error
    type:
      - 'null'
      - boolean
    doc: Disabling the sequencing error substitutions based on nucleotide 
      qualities from the provided quality profiles -q1 and -q2.
    inputBinding:
      position: 101
      prefix: --noerror
  - id: nucleotide_substitution_file
    type:
      - 'null'
      - File
    doc: Nucleotide substitution frequency file.
    inputBinding:
      position: 101
      prefix: -mf
  - id: nucleotide_substitution_file_option
    type:
      - 'null'
      - File
    doc: Nucleotide substitution frequency file.
    inputBinding:
      position: 101
      prefix: -mf
  - id: num_reads
    type:
      - 'null'
      - int
    doc: Number of reads to simulate, conflicts with -c option.
    inputBinding:
      position: 101
      prefix: --reads
  - id: number_of_reads
    type:
      - 'null'
      - int
    doc: Number of reads to simulate
    inputBinding:
      position: 101
      prefix: -r
  - id: output_bam_file
    type:
      - 'null'
      - boolean
    doc: output BAM
    inputBinding:
      position: 101
      prefix: -b
  - id: output_cram_file
    type:
      - 'null'
      - boolean
    doc: output CRAM
    inputBinding:
      position: 101
      prefix: -C
  - id: output_format
    type: string
    doc: File format of the simulated output reads.
    inputBinding:
      position: 101
      prefix: --format
  - id: output_format_option
    type:
      - 'null'
      - string
    doc: File format of the simulated output reads
    inputBinding:
      position: 101
      prefix: -f
  - id: output_format_type
    type:
      - 'null'
      - string
    doc: File format of the simulated output reads
    inputBinding:
      position: 101
      prefix: -f
  - id: output_name_prefix
    type:
      - 'null'
      - string
    doc: Prefix of output file name
    inputBinding:
      position: 101
      prefix: -o
  - id: output_name_prefix_option
    type:
      - 'null'
      - string
    doc: Prefix of output file name
    inputBinding:
      position: 101
      prefix: -o
  - id: output_prefix
    type: string
    doc: Prefix of output file name.
    inputBinding:
      position: 101
      prefix: --output
  - id: pcr_duplicates
    type:
      - 'null'
      - int
    doc: Number of PCR duplicates
    inputBinding:
      position: 101
      prefix: -dup
  - id: pcr_duplicates_option
    type:
      - 'null'
      - int
    doc: Number of PCR duplicates
    inputBinding:
      position: 101
      prefix: -dup
  - id: poly
    type:
      - 'null'
      - string
    doc: Create Poly(X) tails for reads, containing adapters with lengths below 
      the inferred readcycle length.
    inputBinding:
      position: 101
      prefix: --poly
  - id: poly_tail_sequence
    type:
      - 'null'
      - string
    doc: Create Poly(X) tails for reads
    inputBinding:
      position: 101
      prefix: -p
  - id: poly_tail_sequence_option
    type:
      - 'null'
      - string
    doc: Create Poly(X) tails for reads
    inputBinding:
      position: 101
      prefix: -p
  - id: pseudo_random_number_generator
    type:
      - 'null'
      - int
    doc: Pseudo-random number generator
    inputBinding:
      position: 101
      prefix: -rng
  - id: pseudo_random_number_generator_option
    type:
      - 'null'
      - int
    doc: Pseudo-random number generator
    inputBinding:
      position: 101
      prefix: -rng
  - id: quality1
    type:
      - 'null'
      - File
    doc: Read Quality profile for single-end reads (SE) or first read pair (PE) 
      for fastq or sequence alignment map formats.
    inputBinding:
      position: 101
      prefix: --quality1
  - id: quality2
    type:
      - 'null'
      - File
    doc: Read Quality profile for for second read pair (PE) for fastq or 
      sequence alignment map formats.
    inputBinding:
      position: 101
      prefix: --quality2
  - id: quality_profile1
    type:
      - 'null'
      - File
    doc: Read Quality profile for single-end reads (SE) or first read pair (PE)
    inputBinding:
      position: 101
      prefix: -q1
  - id: quality_profile1_option
    type:
      - 'null'
      - File
    doc: Read Quality profile for single-end reads (SE) or first read pair (PE)
    inputBinding:
      position: 101
      prefix: -q1
  - id: quality_profile2
    type:
      - 'null'
      - File
    doc: Read Quality profile for for second read pair (PE)
    inputBinding:
      position: 101
      prefix: -q2
  - id: quality_profile2_option
    type:
      - 'null'
      - File
    doc: Read Quality profile for for second read pair (PE)
    inputBinding:
      position: 101
      prefix: -q2
  - id: quality_score
    type:
      - 'null'
      - int
    doc: Fixed quality score, for both read pairs in fastq or sequence alignment
      map formats. It overwrites the quality profiles.
    inputBinding:
      position: 101
      prefix: --qualityscore
  - id: random_number_generator
    type:
      - 'null'
      - int
    doc: Pseudo-random number generator, OS specific
    inputBinding:
      position: 101
      prefix: --rand
  - id: random_seed
    type:
      - 'null'
      - int
    doc: Random seed
    inputBinding:
      position: 101
      prefix: -s
  - id: random_seed_option
    type:
      - 'null'
      - int
    doc: Random seed
    inputBinding:
      position: 101
      prefix: -s
  - id: read_cycle_length
    type:
      - 'null'
      - int
    doc: Read cycle length
    inputBinding:
      position: 101
      prefix: -cl
  - id: read_cycle_length_option
    type:
      - 'null'
      - int
    doc: Read cycle length
    inputBinding:
      position: 101
      prefix: -cl
  - id: sampling_threads
    type:
      - 'null'
      - int
    doc: Number of sampling threads
    inputBinding:
      position: 101
      prefix: -t
  - id: sampling_threads_option
    type:
      - 'null'
      - int
    doc: Number of sampling threads
    inputBinding:
      position: 101
      prefix: -t
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed, default = current calendar time (s).
    inputBinding:
      position: 101
      prefix: --seed
  - id: sequencing
    type: string
    doc: Simulate single-end or paired-end reads.
    inputBinding:
      position: 101
      prefix: --sequencing
  - id: sequencing_type
    type:
      - 'null'
      - string
    doc: Simulate single-end or paired-end reads
    inputBinding:
      position: 101
      prefix: -seq
  - id: sequencing_type_option
    type:
      - 'null'
      - string
    doc: Simulate single-end or paired-end reads
    inputBinding:
      position: 101
      prefix: -seq
  - id: specific_chromosomes
    type:
      - 'null'
      - type: array
        items: string
    doc: Specific chromosomes from input reference file to simulate from.
    inputBinding:
      position: 101
      prefix: -chr
  - id: specific_chromosomes_option
    type:
      - 'null'
      - type: array
        items: string
    doc: Specific chromosomes from input reference file to simulate from.
    inputBinding:
      position: 101
      prefix: -chr
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of sampling threads, default = 1.
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: threads2
    type:
      - 'null'
      - int
    doc: Number of compression threads, default = 0.
    default: 0
    inputBinding:
      position: 101
      prefix: --threads2
  - id: use_sequence_container_without_alignment
    type:
      - 'null'
      - boolean
    doc: Using the SAM output as a sequence container without alignment 
      information.
    inputBinding:
      position: 101
      prefix: -na
  - id: use_sequence_container_without_alignment_option
    type:
      - 'null'
      - boolean
    doc: Using the SAM output as a sequence container without alignment 
      information.
    inputBinding:
      position: 101
      prefix: -na
  - id: variant_calling_file
    type:
      - 'null'
      - File
    doc: Variant Calling Format (.vcf) or binary format (.bcf)
    inputBinding:
      position: 101
      prefix: -vcf
  - id: variant_calling_file_option
    type:
      - 'null'
      - File
    doc: Variant Calling Format (.vcf) or binary format (.bcf)
    inputBinding:
      position: 101
      prefix: -vcf
  - id: vcf_bcf
    type:
      - 'null'
      - File
    doc: Variant Calling Format (.vcf) or binary format (.bcf)
    inputBinding:
      position: 101
      prefix: -bcf
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngsngs:0.9.2--hce60e53_0
