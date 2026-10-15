cwlVersion: v1.2
class: CommandLineTool
baseCommand: trident
label: poseidon-trident_forge
doc: 'Select packages, groups or individuals and create a new Poseidon package from
  them


  Tool homepage: https://poseidon-framework.github.io/#/'
arguments:
  - position: 50
    valueFrom: forge
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
  - id: snp_set
    type:
      - 'null'
      - string
    doc: 'The snpSet of the package: 1240K, HumanOrigins or Other. Only relevant for
      data input with --genoOne or --genoFile + --snpFile + --indFile. (default: Other)'
    inputBinding:
      position: 100
      prefix: --snpSet
  - id: forge_file
    type:
      - 'null'
      - File
    doc: A file with a list of packages, groups or individual samples. Works as --forgeString,
      but multiple values can also be separated by newline. Empty lines are ignored
      and comments start with "#".
    inputBinding:
      position: 100
      prefix: --forgeFile
  - id: forge_string
    type:
      - 'null'
      - string
    doc: 'List of packages, groups or individual samples to be combined in the output
      package. Packages: *package_title*, groups: group_id, individuals: <individual_id>.
      Combine values with commas; prepend "-" to exclude an entity.'
    inputBinding:
      position: 100
      prefix: --forgeString
  - id: select_snps
    type:
      - 'null'
      - File
    doc: A SNP file (Eigenstrat .snp or Plink .bim, optionally gzipped) listing the
      SNPs that the output package must have.
    inputBinding:
      position: 100
      prefix: --selectSnps
  - id: intersect
    type:
      - 'null'
      - boolean
    doc: Output the intersection of the genotype files to be forged instead of the
      union.
    inputBinding:
      position: 100
      prefix: --intersect
  - id: out_format
    type:
      - 'null'
      - string
    doc: 'The format of the output genotype data: EIGENSTRAT, PLINK or VCF. (default:
      PLINK)'
    inputBinding:
      position: 100
      prefix: --outFormat
  - id: only_geno
    type:
      - 'null'
      - boolean
    doc: Return only the resulting genotype data, not a Poseidon package.
    inputBinding:
      position: 100
      prefix: --onlyGeno
  - id: minimal
    type:
      - 'null'
      - boolean
    doc: Reduce the output Poseidon package to a necessary minimum.
    inputBinding:
      position: 100
      prefix: --minimal
  - id: preserve_pyml
    type:
      - 'null'
      - boolean
    doc: Copy some fields of the source POSEIDON.yml, README and CHANGELOG to the
      output package. Only works for a single source package.
    inputBinding:
      position: 100
      prefix: --preservePyml
  - id: zip
    type:
      - 'null'
      - boolean
    doc: Gzip the resulting genotype and snp files.
    inputBinding:
      position: 100
      prefix: --zip
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
  - id: packagewise
    type:
      - 'null'
      - boolean
    doc: 'Skip the within-package selection step: output all individuals of the relevant
      packages.'
    inputBinding:
      position: 100
      prefix: --packagewise
  - id: out_plink_pop_name
    type:
      - 'null'
      - string
    doc: 'Where to write the population/group name into the FAM file in Plink-format:
      asFamily (default) | asPhenotype | asBoth.'
    inputBinding:
      position: 100
      prefix: --outPlinkPopName
  - id: ordered
    type:
      - 'null'
      - boolean
    doc: Order the output according to the entities given.
    inputBinding:
      position: 100
      prefix: --ordered
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
    dockerPull: quay.io/biocontainers/poseidon-trident:1.6.7.1--hebebf5b_0
stderr: poseidon-trident_forge.err
