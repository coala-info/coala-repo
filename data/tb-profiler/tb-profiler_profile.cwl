cwlVersion: v1.2
class: CommandLineTool
baseCommand: tb-profiler profile
label: tb-profiler_profile
doc: "Profile TB samples\n\nTool homepage: https://github.com/jodyphelan/TBProfiler"
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
    doc: BAM file (make sure it has been generated using the H37Rv genome 
      (GCA_000195955.2))
    inputBinding:
      position: 101
      prefix: --bam
  - id: call_whole_genome
    type:
      - 'null'
      - boolean
    doc: Call variant across the whole genome
    inputBinding:
      position: 101
      prefix: --call_whole_genome
  - id: caller
    type:
      - 'null'
      - string
    doc: Variant calling tool to use.
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
  - id: coverage_tool
    type:
      - 'null'
      - string
    doc: Kmer counter
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
  - id: db
    type:
      - 'null'
      - string
    doc: Mutation panel name
    inputBinding:
      position: 101
      prefix: --db
  - id: db_dir
    type:
      - 'null'
      - Directory
    doc: Database directory
    inputBinding:
      position: 101
      prefix: --db_dir
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
  - id: docx
    type:
      - 'null'
      - boolean
    doc: Add docx output
    inputBinding:
      position: 101
      prefix: --docx
  - id: docx_plugin
    type:
      - 'null'
      - string
    doc: Use a plugin template for --docx output
    inputBinding:
      position: 101
      prefix: --docx_plugin
  - id: docx_template
    type:
      - 'null'
      - string
    doc: Supply custom template for --docx output
    inputBinding:
      position: 101
      prefix: --docx_template
  - id: external_db
    type:
      - 'null'
      - string
    doc: Path to db files prefix (overrides --db parameter)
    inputBinding:
      position: 101
      prefix: --external_db
  - id: fasta
    type:
      - 'null'
      - File
    doc: Fasta file
    inputBinding:
      position: 101
      prefix: --fasta
  - id: implement_rules
    type:
      - 'null'
      - boolean
    doc: Use rules implemented in the resistance library (by default only a note
      will be made)
    inputBinding:
      position: 101
      prefix: --implement_rules
  - id: kmer_counter
    type:
      - 'null'
      - string
    doc: Kmer counter
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
    doc: Mapping tool to use. If you are using nanopore or pacbio data it will 
      default to minimap2
    inputBinding:
      position: 101
      prefix: --mapper
  - id: no_coverage_qc
    type:
      - 'null'
      - boolean
    doc: Don't collect flagstats
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
  - id: no_samclip
    type:
      - 'null'
      - boolean
    doc: Don't remove clipped reads from variant calling
    inputBinding:
      position: 101
      prefix: --no_samclip
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
    doc: Maximum memory to use
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
  - id: snp_dist
    type:
      - 'null'
      - string
    doc: Store variant set and get all samples with snp distance less than this 
      cutoff (experimental feature)
    inputBinding:
      position: 101
      prefix: --snp_dist
  - id: snpeff_config
    type:
      - 'null'
      - string
    doc: Set the config filed used by snpEff
    inputBinding:
      position: 101
      prefix: --snpeff_config
  - id: spoligotype
    type:
      - 'null'
      - boolean
    doc: Perform in-silico spoligotyping
    inputBinding:
      position: 101
      prefix: --spoligotype
  - id: strand
    type:
      - 'null'
      - string
    doc: Minimum read number per strand hard and soft cutoff specified as comma 
      separated values
    inputBinding:
      position: 101
      prefix: --strand
  - id: suspect
    type:
      - 'null'
      - boolean
    doc: Use the suspect suite of tools to add ML predictions
    inputBinding:
      position: 101
      prefix: --suspect
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
  - id: temp
    type:
      - 'null'
      - Directory
    doc: Temp firectory to process all files
    inputBinding:
      position: 101
      prefix: --temp
  - id: text_template
    type:
      - 'null'
      - string
    doc: Jinja2 formatted template for output
    inputBinding:
      position: 101
      prefix: --text_template
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
    dockerPull: quay.io/biocontainers/tb-profiler:6.6.6--pyhdfd78af_0
stdout: tb-profiler_profile.out
