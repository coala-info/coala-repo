cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pathoscope
  - REP
label: pathoscope_REP
doc: "PathoScope REP module for generating reports from SAM alignment files, including
  optional MySQL database integration for taxonomy mapping.\n\nTool homepage: https://github.com/PathoScope/PathoScope"
inputs:
  - id: contig
    type:
      - 'null'
      - boolean
    doc: Generate Contig Information (Needs samtools package installed)
    inputBinding:
      position: 101
      prefix: --contig
  - id: db
    type:
      - 'null'
      - string
    doc: 'mysql pathoscope database name (default: pathodb)'
    inputBinding:
      position: 101
      prefix: -db
  - id: db_host
    type:
      - 'null'
      - string
    doc: specify hostname running mysql if you want to use mysql instead of hash method
      in mapping gi to taxonomy id
    inputBinding:
      position: 101
      prefix: -dbhost
  - id: db_passwd
    type:
      - 'null'
      - string
    doc: provide password associate with user
    inputBinding:
      position: 101
      prefix: -dbpasswd
  - id: db_port
    type:
      - 'null'
      - int
    doc: provide mysql server port if different from default (3306)
    inputBinding:
      position: 101
      prefix: -dbport
  - id: db_user
    type:
      - 'null'
      - string
    doc: user name to access mysql
    inputBinding:
      position: 101
      prefix: -dbuser
  - id: no_display_cutoff
    type:
      - 'null'
      - boolean
    doc: Do not cutoff display of genomes, even if it is insignificant
    inputBinding:
      position: 101
      prefix: --noDisplayCutoff
  - id: sam_file
    type: File
    doc: SAM Alignment file path
    inputBinding:
      position: 101
      prefix: -samfile
  - id: samtools_home
    type:
      - 'null'
      - Directory
    doc: 'Full Path to samtools binary directory (Default: Uses samtools in system
      path)'
    inputBinding:
      position: 101
      prefix: -samtoolsHome
outputs:
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Output Directory
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pathoscope:2.0.7--pyhdfd78af_2
