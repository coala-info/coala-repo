cwlVersion: v1.2
class: CommandLineTool
baseCommand: ntm-profiler profile
label: ntm-profiler_profile
doc: "Profile NTM samples\n\nTool homepage: https://github.com/jodyphelan/NTM-Profiler"
inputs:
  - id: add_columns
    type:
      - 'null'
      - string
    doc: Add additional columns found in the mutation database to the text and 
      csv results
    inputBinding:
      position: 101
      prefix: --add_columns
  - id: af
    type:
      - 'null'
      - string
    doc: Minimum allele frequency hard and soft cutoff specified as comma 
      separated values
    inputBinding:
      position: 101
      prefix: --af
  - id: bam
    type:
      - 'null'
      - File
    doc: BAM file. Make sure it has been generated using the H37Rv genome 
      (GCA_000195955.2)
    inputBinding:
      position: 101
      prefix: --bam
  - id: barcode_caller
    type:
      - 'null'
      - string
    doc: Variant calling tool to use
    inputBinding:
      position: 101
      prefix: --barcode_caller
  - id: barcode_snps
    type:
      - 'null'
      - string
    doc: Dump barcoding mutations to a file
    inputBinding:
      position: 101
      prefix: --barcode_snps
  - id: call_whole_genome
    type:
      - 'null'
      - boolean
    doc: Call whole genome
    inputBinding:
      position: 101
      prefix: --call_whole_genome
  - id: caller
    type:
      - 'null'
      - string
    doc: Variant calling tool to use
    inputBinding:
      position: 101
      prefix: --caller
  - id: calling_params
    type:
      - 'null'
      - string
    doc: Override default parameters for variant calling
    inputBinding:
      position: 101
      prefix: --calling_params
  - id: consensus
    type:
      - 'null'
      - boolean
    doc: Create consensus sequence
    inputBinding:
      position: 101
      prefix: --consensus
  - id: coverage_tool
    type:
      - 'null'
      - string
    doc: Coverage tool to use
    inputBinding:
      position: 101
      prefix: --coverage_tool
  - id: csv
    type:
      - 'null'
      - boolean
    doc: Add CSV output
    inputBinding:
      position: 101
      prefix: --csv
  - id: db_dir
    type:
      - 'null'
      - Directory
    doc: Storage directory
    inputBinding:
      position: 101
      prefix: --db_dir
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable debug logging
    inputBinding:
      position: 101
      prefix: --debug
  - id: depth
    type:
      - 'null'
      - string
    doc: Minimum depth hard and soft cutoff specified as comma separated values
    inputBinding:
      position: 101
      prefix: --depth
  - id: dir
    type:
      - 'null'
      - Directory
    doc: Storage directory
    inputBinding:
      position: 101
      prefix: --dir
  - id: dist_db_name
    type:
      - 'null'
      - string
    doc: Default name for SNP-dist DB
    inputBinding:
      position: 101
      prefix: --dist_db_name
  - id: fasta
    type:
      - 'null'
      - File
    doc: Fasta file
    inputBinding:
      position: 101
      prefix: --fasta
  - id: kmer_counter
    type:
      - 'null'
      - string
    doc: Kmer counting tool to use
    inputBinding:
      position: 101
      prefix: --kmer_counter
  - id: logging
    type:
      - 'null'
      - string
    doc: Logging level
    inputBinding:
      position: 101
      prefix: --logging
  - id: mapper
    type:
      - 'null'
      - string
    doc: Mapping tool to use. If you are using nanopore data it will default to 
      minimap2
    inputBinding:
      position: 101
      prefix: --mapper
  - id: min_species_relative_abundance
    type:
      - 'null'
      - float
    doc: Minimum abundance (percent) for a species to be reported in the 
      collated output
    inputBinding:
      position: 101
      prefix: --min_species_relative_abundance
  - id: no_cleanup
    type:
      - 'null'
      - boolean
    doc: Don't remove temporary files after run
    inputBinding:
      position: 101
      prefix: --no_cleanup
  - id: no_clip
    type:
      - 'null'
      - boolean
    doc: Don't clip reads
    inputBinding:
      position: 101
      prefix: --no_clip
  - id: no_coverage_qc
    type:
      - 'null'
      - boolean
    doc: Don't collect coverage statistics
    inputBinding:
      position: 101
      prefix: --no_coverage_qc
  - id: no_delly
    type:
      - 'null'
      - boolean
    doc: Don't run delly
    inputBinding:
      position: 101
      prefix: --no_delly
  - id: no_mash
    type:
      - 'null'
      - boolean
    doc: Don't run mash if kmers speciation fails
    inputBinding:
      position: 101
      prefix: --no_mash
  - id: no_samclip
    type:
      - 'null'
      - boolean
    doc: Don't run mash if kmers speciation fails
    inputBinding:
      position: 101
      prefix: --no_samclip
  - id: no_species
    type:
      - 'null'
      - boolean
    doc: Skip species prediction
    inputBinding:
      position: 101
      prefix: --no_species
  - id: no_trim
    type:
      - 'null'
      - boolean
    doc: Don't trim files using trimmomatic
    inputBinding:
      position: 101
      prefix: --no_trim
  - id: platform
    type:
      - 'null'
      - string
    doc: NGS Platform used to generate data
    inputBinding:
      position: 101
      prefix: --platform
  - id: prefix
    type:
      - 'null'
      - string
    doc: Sample prefix for all results generated
    inputBinding:
      position: 101
      prefix: --prefix
  - id: ram
    type:
      - 'null'
      - int
    doc: Max memory to use
    inputBinding:
      position: 101
      prefix: --ram
  - id: read1
    type:
      - 'null'
      - File
    doc: First read file
    inputBinding:
      position: 101
      prefix: --read1
  - id: read2
    type:
      - 'null'
      - File
    doc: Second read file
    inputBinding:
      position: 101
      prefix: --read2
  - id: resistance_db
    type:
      - 'null'
      - string
    doc: Mutation panel name
    inputBinding:
      position: 101
      prefix: --resistance_db
  - id: snp_dist
    type:
      - 'null'
      - string
    doc: Store variant set and get all samples with snp distance less than this 
      cutoff (experimental feature)
    inputBinding:
      position: 101
      prefix: --snp_dist
  - id: species_db
    type:
      - 'null'
      - string
    doc: Mutation panel name
    inputBinding:
      position: 101
      prefix: --species_db
  - id: species_only
    type:
      - 'null'
      - boolean
    doc: Predict species and quit
    inputBinding:
      position: 101
      prefix: --species_only
  - id: strand
    type:
      - 'null'
      - string
    doc: Minimum read number per strand hard and soft cutoff specified as comma 
      separated values
    inputBinding:
      position: 101
      prefix: --strand
  - id: sv_af
    type:
      - 'null'
      - string
    doc: Structural variant minimum allele frequency hard cutoff specified as 
      comma separated values
    inputBinding:
      position: 101
      prefix: --sv_af
  - id: sv_depth
    type:
      - 'null'
      - string
    doc: Structural variant minimum depth hard and soft cutoff specified as 
      comma separated values
    inputBinding:
      position: 101
      prefix: --sv_depth
  - id: sv_len
    type:
      - 'null'
      - string
    doc: Structural variant maximum size hard and soft cutoff specified as comma
      separated values
    inputBinding:
      position: 101
      prefix: --sv_len
  - id: taxonomic_software
    type:
      - 'null'
      - string
    doc: Variant calling tool to use
    inputBinding:
      position: 101
      prefix: --taxonomic_software
  - id: temp
    type:
      - 'null'
      - Directory
    doc: Temp directory to process all files
    inputBinding:
      position: 101
      prefix: --temp
  - id: threads
    type:
      - 'null'
      - int
    doc: Threads to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: txt
    type:
      - 'null'
      - boolean
    doc: Add text output
    inputBinding:
      position: 101
      prefix: --txt
  - id: vcf
    type:
      - 'null'
      - File
    doc: VCF file
    inputBinding:
      position: 101
      prefix: --vcf
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ntm-profiler:0.8.1--pyhdfd78af_0
stdout: ntm-profiler_profile.out
