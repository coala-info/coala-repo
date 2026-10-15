cwlVersion: v1.2
class: CommandLineTool
baseCommand: trident
label: poseidon-trident_validate
doc: 'Check Poseidon packages or package components for structural correctness


  Tool homepage: https://poseidon-framework.github.io/#/'
arguments:
  - position: 50
    valueFrom: validate
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
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Short for --logMode VerboseLog.
    inputBinding:
      position: 2
      prefix: --debug
  - id: err_length
    type:
      - 'null'
      - string
    doc: 'After how many characters should a potential genotype data parsing error
      message be truncated. "Inf" for no truncation. (default: CharCount 1500)'
    inputBinding:
      position: 3
      prefix: --errLength
  - id: in_plink_pop_name
    type:
      - 'null'
      - string
    doc: 'Where to read the population/group name from the FAM file in Plink-format:
      asFamily (default) | asPhenotype | asBoth.'
    inputBinding:
      position: 4
      prefix: --inPlinkPopName
  - id: base_dir
    type:
      - 'null'
      - Directory
    doc: A base directory to search for Poseidon packages.
    inputBinding:
      position: 100
      prefix: --baseDir
  - id: ignore_geno
    type:
      - 'null'
      - boolean
    doc: Ignore snp and geno file.
    inputBinding:
      position: 100
      prefix: --ignoreGeno
  - id: full_geno
    type:
      - 'null'
      - boolean
    doc: Test parsing of all SNPs (by default only the first 100 SNPs are probed).
    inputBinding:
      position: 100
      prefix: --fullGeno
  - id: ignore_duplicates
    type:
      - 'null'
      - boolean
    doc: Do not stop on duplicated individual names in the package collection.
    inputBinding:
      position: 100
      prefix: --ignoreDuplicates
  - id: ignore_checksums
    type:
      - 'null'
      - boolean
    doc: Ignore checksums. Useful for speedup in debugging.
    inputBinding:
      position: 100
      prefix: --ignoreChecksums
  - id: ignore_poseidon_version
    type:
      - 'null'
      - boolean
    doc: Read packages even if their poseidonVersion is not compatible with trident.
    inputBinding:
      position: 100
      prefix: --ignorePoseidonVersion
  - id: pyml
    type:
      - 'null'
      - File
    doc: Path to a POSEIDON.yml file.
    inputBinding:
      position: 100
      prefix: --pyml
  - id: geno_one
    type:
      - 'null'
      - File
    doc: One of the input genotype data files (.bed, .bim, .fam for PLINK; .geno,
      .snp, .ind for EIGENSTRAT; .vcf or .vcf.gz for VCF). The other files of the
      set are staged beside it.
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
      - pattern: ^.snp.gz
        required: false
      - pattern: ^.geno.gz
        required: false
      - pattern: ^.bim.gz
        required: false
      - pattern: ^.bed.gz
        required: false
  - id: geno_file
    type:
      - 'null'
      - File
    doc: Eigenstrat genotype matrix, optionally gzipped (.geno, .geno.gz).
    inputBinding:
      position: 100
      prefix: --genoFile
  - id: snp_file
    type:
      - 'null'
      - File
    doc: Eigenstrat snp positions file, optionally gzipped (.snp, .snp.gz).
    inputBinding:
      position: 100
      prefix: --snpFile
  - id: ind_file
    type:
      - 'null'
      - File
    doc: Eigenstrat individual file (.ind).
    inputBinding:
      position: 100
      prefix: --indFile
  - id: bed_file
    type:
      - 'null'
      - File
    doc: Plink genotype matrix, optionally gzipped (.bed, .bed.gz).
    inputBinding:
      position: 100
      prefix: --bedFile
  - id: bim_file
    type:
      - 'null'
      - File
    doc: Plink snp positions file, optionally gzipped (.bim, .bim.gz).
    inputBinding:
      position: 100
      prefix: --bimFile
  - id: fam_file
    type:
      - 'null'
      - File
    doc: Plink individual file (.fam).
    inputBinding:
      position: 100
      prefix: --famFile
  - id: vcf_file
    type:
      - 'null'
      - File
    doc: VCF (Variant Call Format) file, optionally gzipped (.vcf, .vcf.gz).
    inputBinding:
      position: 100
      prefix: --vcfFile
  - id: janno
    type:
      - 'null'
      - File
    doc: Path to a .janno file.
    inputBinding:
      position: 100
      prefix: --janno
  - id: ssf
    type:
      - 'null'
      - File
    doc: Path to a .ssf file.
    inputBinding:
      position: 100
      prefix: --ssf
  - id: bib
    type:
      - 'null'
      - File
    doc: Path to a .bib file.
    inputBinding:
      position: 100
      prefix: --bib
  - id: no_exit_code
    type:
      - 'null'
      - boolean
    doc: Do not produce an explicit exit code.
    inputBinding:
      position: 100
      prefix: --noExitCode
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
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poseidon-trident:1.6.7.1--hebebf5b_0
stderr: poseidon-trident_validate.err
