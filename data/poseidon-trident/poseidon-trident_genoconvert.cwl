cwlVersion: v1.2
class: CommandLineTool
baseCommand: trident
label: poseidon-trident_genoconvert
doc: 'Convert the genotype data in a Poseidon package to a different file format


  Tool homepage: https://poseidon-framework.github.io/#/'
arguments:
  - position: 50
    valueFrom: genoconvert
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
    doc: A base directory to search for Poseidon packages. It is staged writable so
      that the conversion can also run in place.
    inputBinding:
      position: 100
      prefix: --baseDir
      valueFrom: $(self.basename)
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
  - id: out_format
    type: string
    doc: 'The format of the output genotype data: EIGENSTRAT, PLINK or VCF.'
    inputBinding:
      position: 100
      prefix: --outFormat
  - id: out_package_path
    type:
      - 'null'
      - string
    doc: Path for the converted genotype files to be written to. If not given, the
      genotype files are converted in place and the POSEIDON.yml file is updated.
    inputBinding:
      position: 100
      prefix: --outPackagePath
  - id: remove_old
    type:
      - 'null'
      - boolean
    doc: Remove the old genotype files when creating the new ones.
    inputBinding:
      position: 100
      prefix: --removeOld
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
    doc: Consider only the latest versions of packages.
    inputBinding:
      position: 100
      prefix: --onlyLatest
  - id: zip
    type:
      - 'null'
      - boolean
    doc: Gzip the resulting genotype and snp files.
    inputBinding:
      position: 100
      prefix: --zip
outputs:
  - id: stderr
    type: stderr
    doc: Log messages written by the tool
  - id: converted
    type:
      - 'null'
      - Directory
    doc: Directory with the converted genotype files (when --outPackagePath is given).
    outputBinding:
      glob: $(inputs.out_package_path)
  - id: base_dir_out
    type:
      - 'null'
      - Directory
    doc: The base directory after an in-place conversion.
    outputBinding:
      glob: '$(inputs.base_dir ? inputs.base_dir.basename : ''no_base_dir'')'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.base_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poseidon-trident:1.6.7.1--hebebf5b_0
stderr: poseidon-trident_genoconvert.err
