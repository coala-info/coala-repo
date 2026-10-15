cwlVersion: v1.2
class: CommandLineTool
baseCommand: xerxes
label: poseidon-xerxes_admixpops
doc: 'Generate individuals with randomized genotype profiles based on admixture proportions
  (experimental)


  Tool homepage: https://poseidon-framework.github.io/#/'
arguments:
  - position: 50
    valueFrom: admixpops
inputs:
  - id: log_mode
    type:
      - 'null'
      - string
    doc: 'How information should be reported: NoLog, SimpleLog, DefaultLog, ServerLog
      or VerboseLog. (default: DefaultLog)'
    inputBinding:
      position: 1
      prefix: --logMode
  - id: err_length
    type:
      - 'null'
      - string
    doc: 'After how many characters should a potential error message be truncated.
      "Inf" for no truncation. (default: CharCount 1500)'
    inputBinding:
      position: 2
      prefix: --errLength
  - id: in_plink_pop_name
    type:
      - 'null'
      - string
    doc: 'Where to read the population/group name from the FAM file in Plink-format:
      asFamily (default) | asPhenotype | asBoth.'
    inputBinding:
      position: 3
      prefix: --inPlinkPopName
  - id: base_dir
    type:
      - 'null'
      - Directory
    doc: A base directory to search for Poseidon packages.
    inputBinding:
      position: 100
      prefix: --baseDir
  - id: geno_one
    type:
      - 'null'
      - File
    doc: One of the input genotype data files (.bed, .bim or .fam for PLINK; .geno,
      .snp or .ind for EIGENSTRAT). The other files must be in the same directory
      with the same base name.
    inputBinding:
      position: 100
      prefix: --genoOne
    secondaryFiles:
      - pattern: ^.snp
        required: false
      - pattern: ^.ind
        required: false
      - pattern: ^.geno
        required: false
      - pattern: ^.bim
        required: false
      - pattern: ^.fam
        required: false
      - pattern: ^.bed
        required: false
  - id: in_format
    type:
      - 'null'
      - string
    doc: 'The format of the input genotype data: EIGENSTRAT or PLINK. Only necessary
      for data input with --genoFile + --snpFile + --indFile.'
    inputBinding:
      position: 100
      prefix: --inFormat
  - id: geno_file
    type:
      - 'null'
      - File
    doc: Path to the input geno file.
    inputBinding:
      position: 100
      prefix: --genoFile
  - id: snp_file
    type:
      - 'null'
      - File
    doc: Path to the input snp file.
    inputBinding:
      position: 100
      prefix: --snpFile
  - id: ind_file
    type:
      - 'null'
      - File
    doc: Path to the input ind file.
    inputBinding:
      position: 100
      prefix: --indFile
  - id: snp_set
    type:
      - 'null'
      - string
    doc: 'The snpSet of the package: 1240K, HumanOrigins or Other. (default: Other)'
    inputBinding:
      position: 100
      prefix: --snpSet
  - id: admix_string
    type:
      - 'null'
      - string
    doc: Artificial individuals to generate. Each setup is a string of the form "[id:group](population1=10+population2=30+...)".
      Multiple setups can be listed separated by ;. The population fractions must
      be integers and sum to 100.
    inputBinding:
      position: 100
      prefix: --admixString
  - id: admix_file
    type:
      - 'null'
      - File
    doc: A file with admixStrings. Works as --admixString, but multiple values can
      be separated by newline.
    inputBinding:
      position: 100
      prefix: --admixFile
  - id: marginalize_missing
    type:
      - 'null'
      - boolean
    doc: Ignore missing SNPs in the per-population genotype frequency calculation
      (except where all individuals have missing information for a SNP).
    inputBinding:
      position: 100
      prefix: --marginalizeMissing
  - id: in_chunks
    type:
      - 'null'
      - boolean
    doc: Construct the artificial individuals by sampling contiguous stretches of
      SNPs (chunks) from random individuals in the source populations.
    inputBinding:
      position: 100
      prefix: --inChunks
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: 'The number of SNPs in one chunk. (default: 5000)'
    inputBinding:
      position: 100
      prefix: --chunkSize
  - id: out_format
    type:
      - 'null'
      - string
    doc: 'The format of the output genotype data: EIGENSTRAT or PLINK. (default: PLINK)'
    inputBinding:
      position: 100
      prefix: --outFormat
  - id: out_package_path
    type: string
    doc: Path to the output package directory.
    inputBinding:
      position: 100
      prefix: --outPackagePath
  - id: out_package_name
    type:
      - 'null'
      - string
    doc: The output package name. If no name is provided, the package name defaults
      to the basename of --outPackagePath.
    inputBinding:
      position: 100
      prefix: --outPackageName
  - id: out_plink_pop_name
    type:
      - 'null'
      - string
    doc: 'Where to write the population/group name into the FAM file in Plink-format:
      asFamily (default) | asPhenotype | asBoth.'
    inputBinding:
      position: 100
      prefix: --outPlinkPopName
  - id: only_latest
    type:
      - 'null'
      - boolean
    doc: Consider only the latest versions of packages, or the groups and individuals
      within them.
    inputBinding:
      position: 100
      prefix: --onlyLatest
outputs:
  - id: stderr
    type: stderr
    doc: Log messages written by the tool
  - id: out_package
    type:
      - 'null'
      - Directory
    doc: The output Poseidon package directory.
    outputBinding:
      glob: $(inputs.out_package_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poseidon-xerxes:1.0.1.1--hf48d1a7_0
stderr: poseidon-xerxes_admixpops.err
