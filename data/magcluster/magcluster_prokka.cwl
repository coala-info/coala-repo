cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - magcluster
  - prokka
label: magcluster_prokka
doc: "Prokka: rapid prokaryotic genome annotation\n\nTool homepage: https://github.com/runjiaji/magcluster"
inputs:
  - id: genome_files
    type:
      type: array
      items: File
    doc: Genome files need to be annotated
    inputBinding:
      position: 1
  - id: accver
    type:
      - 'null'
      - string
    doc: Version to put in Genbank file
    inputBinding:
      position: 102
      prefix: --accver
  - id: add_genes
    type:
      - 'null'
      - boolean
    doc: Add 'gene' features for each 'CDS' feature
    inputBinding:
      position: 102
      prefix: --addgenes
  - id: add_mrna
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
  - id: compliant
    type:
      - 'null'
      - boolean
    doc: 'Force Genbank/ENA/DDJB compliance: --genes --mincontiglen 200 --centre XXX'
    inputBinding:
      position: 102
      prefix: --compliant
  - id: cpus
    type:
      - 'null'
      - int
    doc: Number of CPUs to use [0=all]
    inputBinding:
      position: 102
      prefix: --cpus
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'Debug mode: keep all temporary files'
    inputBinding:
      position: 102
      prefix: --debug
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
    doc: Fast mode - skip CDS /product searching
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
      - string
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
      - string
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
      - string
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
    doc: 'Annotation mode: Archaea|Bacteria|Viruses'
    inputBinding:
      position: 102
      prefix: --kingdom
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
  - id: proteins
    type:
      - 'null'
      - File
    doc: Fasta file of trusted proteins to first annotate from
    inputBinding:
      position: 102
      prefix: --proteins
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: No screen output
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
    dockerPull: quay.io/biocontainers/magcluster:0.2.5--pyhdfd78af_0
stdout: magcluster_prokka.out
