cwlVersion: v1.2
class: CommandLineTool
baseCommand: hgGoldGapGl
label: ucsc-hggoldgapgl_hgGoldGapGl
doc: "Put chromosome .agp and .gl files into a browser database. With gsDir and ooSubDir it creates split gold and gap tables; with a single agpFile it creates single gold and gap tables. With -noLoad the tables are not loaded and gold.tab and gap.tab are left in the working directory; otherwise the program reads the MySQL server login from ~/.hg.conf (give it as hg_conf).\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
requirements:
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing:
      - entryname: .hg.conf
        entry: $(inputs.hg_conf)
inputs:
  - id: hg_conf
    type: ['null', File]
    doc: "hg.conf file with db.host, db.user and db.password of a writable UCSC MySQL server (staged as ~/.hg.conf); not needed with -noLoad"
  - id: no_gl
    type: ['null', boolean]
    doc: Do not do the gl bits
    inputBinding:
      prefix: -noGl
      position: 1
  - id: chrom
    type: ['null', string]
    doc: Just do a single chromosome (chrN). Do not delete old tables
    inputBinding:
      prefix: -chrom=
      separate: false
      position: 2
  - id: chrom_lst
    type: ['null', File]
    doc: File listing the chromosome subdirectories (1, 2, ...)
    inputBinding:
      prefix: -chromLst=
      separate: false
      position: 3
  - id: no_load
    type: ['null', boolean]
    doc: Do not load the tables, leave the SQL files instead
    inputBinding:
      prefix: -noLoad
      position: 4
  - id: verbose
    type: ['null', int]
    doc: "2 gives brief information and the SQL table create statements; 3 shows all gaps"
    inputBinding:
      prefix: -verbose=
      separate: false
      position: 5
  - id: database
    type: string
    doc: Database name
    inputBinding:
      position: 10
  - id: gs_dir_or_agp_file
    type: [File, Directory]
    doc: gsDir (to create split tables) or agpFile (to create single tables)
    inputBinding:
      position: 11
  - id: oo_sub_dir
    type: ['null', string]
    doc: ooSubDir (only used with gsDir)
    inputBinding:
      position: 12
outputs:
  - id: gold_tab
    type: ['null', File]
    doc: gold table data left by -noLoad
    outputBinding:
      glob: gold.tab
  - id: gap_tab
    type: ['null', File]
    doc: gap table data left by -noLoad
    outputBinding:
      glob: gap.tab
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hggoldgapgl:377--h199ee4e_0
stdout: ucsc-hggoldgapgl_hgGoldGapGl.out
