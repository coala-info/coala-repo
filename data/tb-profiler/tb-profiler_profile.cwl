cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tb-profiler
  - profile
label: tb-profiler_profile
doc: "Profile a TB sample: map reads, call variants and predict drug resistance and lineage\n\nTool homepage: https://github.com/jodyphelan/TBProfiler"
inputs:
  - id: read1
    type:
      - 'null'
      - File
    doc: 'First read file'
    inputBinding:
      position: 101
      prefix: --read1
  - id: read2
    type:
      - 'null'
      - File
    doc: 'Second read file'
    inputBinding:
      position: 101
      prefix: --read2
  - id: bam
    type:
      - 'null'
      - File
    secondaryFiles:
      - pattern: .bai
        required: false
    doc: 'BAM file (make sure it has been generated using the H37Rv genome GCA_000195955.2)'
    inputBinding:
      position: 101
      prefix: --bam
  - id: fasta
    type:
      - 'null'
      - File
    doc: 'Fasta file'
    inputBinding:
      position: 101
      prefix: --fasta
  - id: vcf
    type:
      - 'null'
      - File
    doc: 'VCF file'
    inputBinding:
      position: 101
      prefix: --vcf
  - id: platform
    type:
      - 'null'
      - string
    doc: 'NGS platform used to generate data: illumina, nanopore or pacbio (default: illumina)'
    inputBinding:
      position: 101
      prefix: --platform
  - id: db
    type:
      - 'null'
      - string
    doc: 'Mutation panel name (default: tbdb)'
    inputBinding:
      position: 101
      prefix: --db
  - id: external_db
    type:
      - 'null'
      - string
    doc: 'Path to db files prefix (overrides the db option)'
    inputBinding:
      position: 101
      prefix: --external_db
  - id: prefix
    type:
      - 'null'
      - string
    doc: 'Sample prefix for all results generated (default: tbprofiler)'
    inputBinding:
      position: 101
      prefix: --prefix
  - id: csv
    type:
      - 'null'
      - boolean
    doc: 'Add CSV output'
    inputBinding:
      position: 101
      prefix: --csv
  - id: txt
    type:
      - 'null'
      - boolean
    doc: 'Add text output'
    inputBinding:
      position: 101
      prefix: --txt
  - id: text_template
    type:
      - 'null'
      - File
    doc: 'Jinja2 formatted template for output'
    inputBinding:
      position: 101
      prefix: --text_template
  - id: docx
    type:
      - 'null'
      - boolean
    doc: 'Add docx output'
    inputBinding:
      position: 101
      prefix: --docx
  - id: docx_template
    type:
      - 'null'
      - File
    doc: 'Supply custom template for docx output'
    inputBinding:
      position: 101
      prefix: --docx_template
  - id: docx_plugin
    type:
      - 'null'
      - string
    doc: 'Use a plugin template for docx output (default)'
    inputBinding:
      position: 101
      prefix: --docx_plugin
  - id: add_columns
    type:
      - 'null'
      - string
    doc: 'Add additional columns found in the mutation database to the text and csv results'
    inputBinding:
      position: 101
      prefix: --add_columns
  - id: depth
    type:
      - 'null'
      - string
    doc: 'Minimum depth hard and soft cutoff specified as comma separated values (default: 0,10)'
    inputBinding:
      position: 101
      prefix: --depth
  - id: af
    type:
      - 'null'
      - string
    doc: 'Minimum allele frequency hard and soft cutoff specified as comma separated values (default: 0,0.1)'
    inputBinding:
      position: 101
      prefix: --af
  - id: strand
    type:
      - 'null'
      - string
    doc: 'Minimum read number per strand hard and soft cutoff specified as comma separated values (default: 0,3)'
    inputBinding:
      position: 101
      prefix: --strand
  - id: sv_depth
    type:
      - 'null'
      - string
    doc: 'Structural variant minimum depth hard and soft cutoff specified as comma separated values (default: 0,10)'
    inputBinding:
      position: 101
      prefix: --sv_depth
  - id: sv_af
    type:
      - 'null'
      - string
    doc: 'Structural variant minimum allele frequency hard cutoff specified as comma separated values (default: 0.5,0.9)'
    inputBinding:
      position: 101
      prefix: --sv_af
  - id: sv_len
    type:
      - 'null'
      - string
    doc: 'Structural variant maximum size hard and soft cutoff specified as comma separated values (default: 100000,50000)'
    inputBinding:
      position: 101
      prefix: --sv_len
  - id: mapper
    type:
      - 'null'
      - string
    doc: 'Mapping tool to use: bwa, minimap2, bowtie2 or bwa-mem2 (default: bwa; minimap2 for nanopore and pacbio)'
    inputBinding:
      position: 101
      prefix: --mapper
  - id: caller
    type:
      - 'null'
      - string
    doc: 'Variant calling tool to use: bcftools, freebayes, gatk, pilon, lofreq or freebayes-haplotype (default: freebayes)'
    inputBinding:
      position: 101
      prefix: --caller
  - id: calling_params
    type:
      - 'null'
      - string
    doc: 'Override default parameters for variant calling'
    inputBinding:
      position: 101
      prefix: --calling_params
  - id: kmer_counter
    type:
      - 'null'
      - string
    doc: 'Kmer counter: FastK, kmc or dsk (default: FastK)'
    inputBinding:
      position: 101
      prefix: --kmer_counter
  - id: coverage_tool
    type:
      - 'null'
      - string
    doc: 'Coverage tool: samtools or bedtools (default: samtools)'
    inputBinding:
      position: 101
      prefix: --coverage_tool
  - id: suspect
    type:
      - 'null'
      - boolean
    doc: 'Use the suspect suite of tools to add ML predictions'
    inputBinding:
      position: 101
      prefix: --suspect
  - id: spoligotype
    type:
      - 'null'
      - boolean
    doc: 'Perform in-silico spoligotyping'
    inputBinding:
      position: 101
      prefix: --spoligotype
  - id: call_whole_genome
    type:
      - 'null'
      - boolean
    doc: 'Call variant across the whole genome'
    inputBinding:
      position: 101
      prefix: --call_whole_genome
  - id: snp_dist
    type:
      - 'null'
      - int
    doc: 'Store variant set and get all samples with snp distance less than this cutoff (experimental feature)'
    inputBinding:
      position: 101
      prefix: --snp_dist
  - id: no_trim
    type:
      - 'null'
      - boolean
    doc: 'Do not trim files using trimmomatic'
    inputBinding:
      position: 101
      prefix: --no_trim
  - id: no_coverage_qc
    type:
      - 'null'
      - boolean
    doc: 'Do not collect flagstats'
    inputBinding:
      position: 101
      prefix: --no_coverage_qc
  - id: no_samclip
    type:
      - 'null'
      - boolean
    doc: 'Do not remove clipped reads from variant calling'
    inputBinding:
      position: 101
      prefix: --no_samclip
  - id: no_delly
    type:
      - 'null'
      - boolean
    doc: 'Do not run delly'
    inputBinding:
      position: 101
      prefix: --no_delly
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Threads to use (default: 1)'
    inputBinding:
      position: 101
      prefix: --threads
  - id: ram
    type:
      - 'null'
      - int
    doc: 'Maximum memory to use in Gb (default: 2)'
    inputBinding:
      position: 101
      prefix: --ram
  - id: implement_rules
    type:
      - 'null'
      - boolean
    doc: 'Use rules implemented in the resistance library (by default only a note will be made)'
    inputBinding:
      position: 101
      prefix: --implement_rules
  - id: snpeff_config
    type:
      - 'null'
      - File
    doc: 'Set the config file used by snpEff'
    inputBinding:
      position: 101
      prefix: --snpeff_config
  - id: dir
    type:
      - 'null'
      - string
    doc: 'Storage directory for results (default: current directory)'
    inputBinding:
      position: 101
      prefix: --dir
  - id: temp
    type:
      - 'null'
      - string
    doc: 'Temp directory to process all files (default: .)'
    inputBinding:
      position: 101
      prefix: --temp
  - id: db_dir
    type:
      - 'null'
      - Directory
    doc: 'Database directory (default: bundled database in the image)'
    inputBinding:
      position: 101
      prefix: --db_dir
  - id: logging
    type:
      - 'null'
      - string
    doc: 'Logging level: DEBUG, INFO, WARNING, ERROR or CRITICAL (default: INFO)'
    inputBinding:
      position: 101
      prefix: --logging
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: results_json
    type:
      - 'null'
      - File
    doc: 'Result file in JSON format'
    outputBinding:
      glob: $((inputs.dir || '.') + '/results/' + (inputs.prefix || 'tbprofiler') + '.results.json')
  - id: results_files
    type:
      type: array
      items: File
    doc: 'All result files of the sample (json, txt, csv, docx)'
    outputBinding:
      glob: $((inputs.dir || '.') + '/results/' + (inputs.prefix || 'tbprofiler') + '.results.*')
  - id: bam_file
    type:
      - 'null'
      - File
    doc: 'Mapped reads'
    outputBinding:
      glob: $((inputs.dir || '.') + '/bam/' + (inputs.prefix || 'tbprofiler') + '.bam')
  - id: results_dir
    type:
      - 'null'
      - Directory
    doc: 'Results directory'
    outputBinding:
      glob: $((inputs.dir || '.') + '/results')
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.bam)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tb-profiler:6.6.6--pyhdfd78af_0
stdout: tb-profiler_profile.out
