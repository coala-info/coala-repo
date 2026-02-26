cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gemBS
  - extract
label: gembs_gemBS extract
doc: "Extracts summary files from BCF files generated for all or a subset of samples
  to produce a series of summary output files. The detailed formats of the output
  files are given in the gemBS docuemntation. The default output are CpG files. These
  are BED3+8 format files with information on methylation and genotypes. A list of
  non-CpG sites in the same basic format can also be produced. Various options on
  filtering these files on genotype quality and coverage are available. By default
  the CpG files have 1 output line per CpG (so the information from the two strands
  is combined). This can be changed to give strand specific information using the
  -s option. Standard filtering strategy is to only output sites where the sample
  genotype is called as being homozygous CG/CG with a phred score >= to the theshold
  set using the -q option (default 20). Using the --allow-het option will allow heterozygous
  CpG sites to be included in the output. The sitest can also be filtered on minimum
  informative coverage using the -I option (default = 1). For non-CpG sites the strategy
  is to only output sites with a minimum number of non-converted reads. This level
  can be set using the --min-nc option (default = 1). A second set of extracted outputs
  that correspond to the ENCODE WGBS pipeline are also available using the --bed-methyl
  and --bigwig options. The --bed-methyl option will produce three files per sample
  for all covered sites in CpG, CHG and CHH context in BED9+5 format. Each of the
  files will also be generated in bigBed format for display in genome browsers. In
  addition a bigWig format file will be generated giving the methylation percentage
  at all covered cytosine sites (informative coverage > 0). If the --strand-specific
  option is given then two bigWig files will be geenrated - one for each strand. For
  the ENCODE output files, not further filtering is performed. In addition to the
  methylation result, SNP genotypes can also be extracted with the --snps options.
  By default, this will return a file with genotypes on all SNPs covered by the experiment
  that were in the dbSNP_idx file used for the calling stage. This selection can be
  refined uwing the --snp-list option, which is a file with a list of SNP ids, one
  id per line. An alternate dbSNP_idx file can also be supplied using the --snp-db
  option, allowing SNPs that were not in the original dbSNP_idx file used for calling
  to be extracted. The --dry-run option will output a list of the merging operations
  that would be run by the merge- bcfs command without executing any of the commands.
  The --json <JSON OUTPUT> options is similar to --dry-run, but writes the commands
  to be executed in JSON format to the supplied output file, including information
  about the input and output files for the commands. The --ignore-db option modifies
  the --dry- run and --json options such that the database is not consulted (i.e.,
  gemBS assumes that no calling has already been completed but that all dependencies
  (i.e., BAM files) are available. The --ignore-dep option is similar - it ignores
  dependencies, but does check whether a task has already been completed.\n\nTool
  homepage: https://github.com/heathsc/gemBS"
inputs:
  - id: allow_het
    type:
      - 'null'
      - boolean
    doc: Allow both heterozygous and homozgyous sites.
    inputBinding:
      position: 101
      prefix: --allow-het
  - id: bed_methyl
    type:
      - 'null'
      - boolean
    doc: Output bedMethyl files (bed and bigBed)
    inputBinding:
      position: 101
      prefix: --bed-methyl
  - id: bigwig_strand_specific
    type:
      - 'null'
      - boolean
    doc: Output separate bigWig files for each strand.
    inputBinding:
      position: 101
      prefix: --bigwig-strand-specific
  - id: cpg
    type:
      - 'null'
      - boolean
    doc: Output gemBS bed with cpg sites.
    inputBinding:
      position: 101
      prefix: --cpg
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Output mapping commands without execution
    inputBinding:
      position: 101
      prefix: --dry-run
  - id: extract_threads
    type:
      - 'null'
      - int
    doc: Number of extra threads for extract step
    inputBinding:
      position: 101
      prefix: --extract-threads
  - id: ignore_db
    type:
      - 'null'
      - boolean
    doc: Ignore database for --dry-run and --json commands
    inputBinding:
      position: 101
      prefix: --ignore-db
  - id: ignore_dep
    type:
      - 'null'
      - boolean
    doc: Ignore dependencies for --dry-run and --json commands
    inputBinding:
      position: 101
      prefix: --ignore-dep
  - id: jobs
    type:
      - 'null'
      - int
    doc: Number of parallel jobs
    inputBinding:
      position: 101
      prefix: --jobs
  - id: min_inform
    type:
      - 'null'
      - int
    doc: Min threshold for informative reads.
    inputBinding:
      position: 101
      prefix: --min-inform
  - id: min_nc
    type:
      - 'null'
      - int
    doc: Min threshold for non-converted reads for non CpG sites.
    inputBinding:
      position: 101
      prefix: --min-nc
  - id: non_cpg
    type:
      - 'null'
      - boolean
    doc: Output gemBS bed with non-cpg sites.
    inputBinding:
      position: 101
      prefix: --non-cpg
  - id: phred_threshold
    type:
      - 'null'
      - int
    doc: Min threshold for genotype phred score.
    inputBinding:
      position: 101
      prefix: --phred-threshold
  - id: reference_bias
    type:
      - 'null'
      - string
    doc: Allow both heterozygous and homozgyous sites.
    inputBinding:
      position: 101
      prefix: --reference-bias
  - id: sample_barcode
    type:
      - 'null'
      - string
    doc: Barcode of sample to be filtered
    inputBinding:
      position: 101
      prefix: --barcode
  - id: sample_name
    type:
      - 'null'
      - string
    doc: Name of sample to be filtered
    inputBinding:
      position: 101
      prefix: --sample-name
  - id: snp_db
    type:
      - 'null'
      - File
    doc: dbSNP_idx processed SNP idx
    inputBinding:
      position: 101
      prefix: --snp-db
  - id: snp_list
    type:
      - 'null'
      - File
    doc: List of SNPs to output
    inputBinding:
      position: 101
      prefix: --snp-list
  - id: snps
    type:
      - 'null'
      - boolean
    doc: Output SNPs
    inputBinding:
      position: 101
      prefix: --snps
  - id: strand_specific
    type:
      - 'null'
      - boolean
    doc: Output separate lines in CpG file for each strand.
    inputBinding:
      position: 101
      prefix: --strand-specific
outputs:
  - id: json_file
    type:
      - 'null'
      - File
    doc: Output JSON file with details of pending commands
    outputBinding:
      glob: $(inputs.json_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gembs:3.5.5_IHEC--py39h6859054_8
