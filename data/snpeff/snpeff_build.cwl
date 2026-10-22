cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - snpEff
  - build
label: snpeff_build
doc: "Build a SnpEff database from a genome annotation (GFF3, GTF, GenBank, EMBL, ...) and its sequence.\n\nTool homepage: http://snpeff.sourceforge.net/"
inputs:
  - id: embl
    type:
      - 'null'
      - boolean
    doc: "Use Embl format."
    inputBinding:
      position: 1
      prefix: -embl
  - id: genbank
    type:
      - 'null'
      - boolean
    doc: "Use GenBank format."
    inputBinding:
      position: 1
      prefix: -genbank
  - id: gff2
    type:
      - 'null'
      - boolean
    doc: "Use GFF2 format (obsolete)."
    inputBinding:
      position: 1
      prefix: -gff2
  - id: gff3
    type:
      - 'null'
      - boolean
    doc: "Use GFF3 format."
    inputBinding:
      position: 1
      prefix: -gff3
  - id: gtf22
    type:
      - 'null'
      - boolean
    doc: "Use GTF 2.2 format."
    inputBinding:
      position: 1
      prefix: -gtf22
  - id: knowngenes
    type:
      - 'null'
      - boolean
    doc: "Use KnownGenes table from UCSC."
    inputBinding:
      position: 1
      prefix: -knowngenes
  - id: refseq
    type:
      - 'null'
      - boolean
    doc: "Use RefSeq table from UCSC."
    inputBinding:
      position: 1
      prefix: -refseq
  - id: cell_type
    type:
      - 'null'
      - string
    doc: "Only build regulation tracks for cellType <type>."
    inputBinding:
      position: 1
      prefix: -cellType
  - id: max_error_rate
    type:
      - 'null'
      - float
    doc: "Maximum allowed error rate (number between 0.0 and 1.0). Default: 0.05"
    inputBinding:
      position: 1
      prefix: -maxErrorRate
  - id: no_check_cds
    type:
      - 'null'
      - boolean
    doc: "Skip CDS sequences check."
    inputBinding:
      position: 1
      prefix: -noCheckCds
  - id: no_check_protein
    type:
      - 'null'
      - boolean
    doc: "Skip Protein sequences check."
    inputBinding:
      position: 1
      prefix: -noCheckProtein
  - id: no_store_seqs
    type:
      - 'null'
      - boolean
    doc: "Do not store sequence in binary files. Default: false"
    inputBinding:
      position: 1
      prefix: -noStoreSeqs
  - id: only_reg_build
    type:
      - 'null'
      - boolean
    doc: "Only build regulation tracks."
    inputBinding:
      position: 1
      prefix: -onlyReg
  - id: reg_sorted_by_type
    type:
      - 'null'
      - boolean
    doc: "The 'regulation.gff' file is sorted by 'regulation type' instead of sorted by chromosome:pos. Default: false"
    inputBinding:
      position: 1
      prefix: -regSortedByType
  - id: store_seqs
    type:
      - 'null'
      - boolean
    doc: "Store sequence in binary files. Default: true"
    inputBinding:
      position: 1
      prefix: -storeSeqs
  - id: data_dir_build
    type: Directory
    doc: "Data directory holding the genome folder (genes file and sequences); it is staged writable and returned with the built database (-dataDir)"
    inputBinding:
      position: 1
      prefix: -dataDir
  - id: genome_version
    type: string
    doc: "Genome version (database name)"
    inputBinding:
      position: 2
  - id: config_file
    type:
      - 'null'
      - File
    doc: Specify config file
    inputBinding:
      position: 104
      prefix: -c
  - id: config_option
    type:
      - 'null'
      - string
    doc: Override a config file option
    inputBinding:
      position: 104
      prefix: -configOption
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug mode (very verbose).
    inputBinding:
      position: 104
      prefix: -d
  - id: no_download
    type:
      - 'null'
      - boolean
    doc: Do not download a SnpEff database, if not available locally.
    inputBinding:
      position: 104
      prefix: -nodownload
  - id: no_log
    type:
      - 'null'
      - boolean
    doc: Do not report usage statistics to server
    inputBinding:
      position: 104
      prefix: -noLog
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet mode (do not show any messages or errors)
    inputBinding:
      position: 104
      prefix: -q
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode
    inputBinding:
      position: 104
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Standard error (messages)
  - id: database_dir
    type: Directory
    doc: The data directory including the built database (snpEffectPredictor.bin)
    outputBinding:
      glob: $(inputs.data_dir_build.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.data_dir_build)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snpeff:5.4.0a--hdfd78af_0
stdout: snpeff_build.out
stderr: snpeff_build.err
