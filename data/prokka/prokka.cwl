cwlVersion: v1.2
class: CommandLineTool
baseCommand: prokka
label: prokka
doc: "rapid bacterial genome annotation\n\nTool homepage: https://github.com/tseemann/prokka"
inputs:
  - id: contigs_fasta
    type: File
    doc: Input contigs FASTA file
    inputBinding:
      position: 1
  - id: accver
    type:
      - 'null'
      - int
    doc: Version to put in Genbank file
    inputBinding:
      position: 102
      prefix: --accver
  - id: addgenes
    type:
      - 'null'
      - boolean
    doc: Add 'gene' features for each 'CDS' feature
    inputBinding:
      position: 102
      prefix: --addgenes
  - id: addmrna
    type:
      - 'null'
      - boolean
    doc: Add 'mRNA' features for each 'CDS' feature
    inputBinding:
      position: 102
      prefix: --addmrna
  - id: cdsrnaolap
    type:
      - 'null'
      - boolean
    doc: Allow [tr]RNA to overlap CDS
    inputBinding:
      position: 102
      prefix: --cdsrnaolap
  - id: centre
    type:
      - 'null'
      - string
    doc: Sequencing centre ID.
    inputBinding:
      position: 102
      prefix: --centre
  - id: citation
    type:
      - 'null'
      - boolean
    doc: Print citation for referencing Prokka
    inputBinding:
      position: 102
      prefix: --citation
  - id: cleandb
    type:
      - 'null'
      - boolean
    doc: Remove all database indices
    inputBinding:
      position: 102
      prefix: --cleandb
  - id: compliant
    type:
      - 'null'
      - boolean
    doc: 'Force Genbank/ENA/DDJB compliance: --addgenes --mincontiglen 200 --centre
      XXX'
    inputBinding:
      position: 102
      prefix: --compliant
  - id: coverage
    type:
      - 'null'
      - float
    doc: Minimum coverage on query protein
    inputBinding:
      position: 102
      prefix: --coverage
  - id: cpus
    type:
      - 'null'
      - int
    doc: Number of CPUs to use [0=all]
    inputBinding:
      position: 102
      prefix: --cpus
  - id: dbdir
    type:
      - 'null'
      - Directory
    doc: Prokka database root folders
    inputBinding:
      position: 102
      prefix: --dbdir
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'Debug mode: keep all temporary files (default OFF)'
    inputBinding:
      position: 102
      prefix: --debug
  - id: depends
    type:
      - 'null'
      - boolean
    doc: List all software dependencies
    inputBinding:
      position: 102
      prefix: --depends
  - id: evalue
    type:
      - 'null'
      - float
    doc: Similarity e-value cut-off
    inputBinding:
      position: 102
      prefix: --evalue
  - id: fast
    type:
      - 'null'
      - boolean
    doc: Fast mode - only use basic BLASTP databases
    inputBinding:
      position: 102
      prefix: --fast
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwriting existing output folder
    inputBinding:
      position: 102
      prefix: --force
  - id: gcode
    type:
      - 'null'
      - int
    doc: Genetic code / Translation table (set if --kingdom is set)
    inputBinding:
      position: 102
      prefix: --gcode
  - id: genus
    type:
      - 'null'
      - string
    doc: Genus name
    inputBinding:
      position: 102
      prefix: --genus
  - id: gffver
    type:
      - 'null'
      - int
    doc: GFF version
    inputBinding:
      position: 102
      prefix: --gffver
  - id: gram
    type:
      - 'null'
      - string
    doc: 'Gram: -/neg +/pos'
    inputBinding:
      position: 102
      prefix: --gram
  - id: hmms
    type:
      - 'null'
      - File
    doc: Trusted HMM to first annotate from
    inputBinding:
      position: 102
      prefix: --hmms
  - id: increment
    type:
      - 'null'
      - int
    doc: Locus tag counter increment
    inputBinding:
      position: 102
      prefix: --increment
  - id: kingdom
    type:
      - 'null'
      - string
    doc: 'Annotation mode: Archaea|Bacteria|Mitochondria|Viruses'
    inputBinding:
      position: 102
      prefix: --kingdom
  - id: listdb
    type:
      - 'null'
      - boolean
    doc: List all configured databases
    inputBinding:
      position: 102
      prefix: --listdb
  - id: locustag
    type:
      - 'null'
      - string
    doc: Locus tag prefix
    inputBinding:
      position: 102
      prefix: --locustag
  - id: metagenome
    type:
      - 'null'
      - boolean
    doc: Improve gene predictions for highly fragmented genomes
    inputBinding:
      position: 102
      prefix: --metagenome
  - id: mincontiglen
    type:
      - 'null'
      - int
    doc: Minimum contig size [NCBI needs 200]
    inputBinding:
      position: 102
      prefix: --mincontiglen
  - id: noanno
    type:
      - 'null'
      - boolean
    doc: For CDS just set /product="unannotated protein"
    inputBinding:
      position: 102
      prefix: --noanno
  - id: norrna
    type:
      - 'null'
      - boolean
    doc: Don't run rRNA search
    inputBinding:
      position: 102
      prefix: --norrna
  - id: notrna
    type:
      - 'null'
      - boolean
    doc: Don't run tRNA search
    inputBinding:
      position: 102
      prefix: --notrna
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output folder
    inputBinding:
      position: 102
      prefix: --outdir
  - id: plasmid
    type:
      - 'null'
      - string
    doc: Plasmid name or identifier
    inputBinding:
      position: 102
      prefix: --plasmid
  - id: prefix
    type:
      - 'null'
      - string
    doc: Filename output prefix
    inputBinding:
      position: 102
      prefix: --prefix
  - id: prodigaltf
    type:
      - 'null'
      - string
    doc: Prodigal training file
    inputBinding:
      position: 102
      prefix: --prodigaltf
  - id: proteins
    type:
      - 'null'
      - File
    doc: FASTA or GBK file to use as 1st priority
    inputBinding:
      position: 102
      prefix: --proteins
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: No screen output (default OFF)
    inputBinding:
      position: 102
      prefix: --quiet
  - id: rawproduct
    type:
      - 'null'
      - boolean
    doc: Do not clean up /product annotation
    inputBinding:
      position: 102
      prefix: --rawproduct
  - id: rfam
    type:
      - 'null'
      - boolean
    doc: Enable searching for ncRNAs with Infernal+Rfam (SLOW!)
    inputBinding:
      position: 102
      prefix: --rfam
  - id: rnammer
    type:
      - 'null'
      - boolean
    doc: Prefer RNAmmer over Barrnap for rRNA prediction
    inputBinding:
      position: 102
      prefix: --rnammer
  - id: setupdb
    type:
      - 'null'
      - boolean
    doc: Index all installed databases
    inputBinding:
      position: 102
      prefix: --setupdb
  - id: species
    type:
      - 'null'
      - string
    doc: Species name
    inputBinding:
      position: 102
      prefix: --species
  - id: strain
    type:
      - 'null'
      - string
    doc: Strain name
    inputBinding:
      position: 102
      prefix: --strain
  - id: usegenus
    type:
      - 'null'
      - boolean
    doc: Use genus-specific BLAST databases (needs --genus)
    inputBinding:
      position: 102
      prefix: --usegenus
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prokka:1.15.6--pl5321hdfd78af_0
stdout: prokka.out
