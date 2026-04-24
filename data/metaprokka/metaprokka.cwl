cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaprokka
label: metaprokka
doc: "rapid bacterial genome annotation, adapted for large datasets\n\nTool homepage:
  https://github.com/telatin/metaprokka"
inputs:
  - id: contigs_fasta
    type: File
    doc: Input contigs FASTA file
    inputBinding:
      position: 1
  - id: cdsrnaolap
    type:
      - 'null'
      - boolean
    doc: Allow [tr]RNA to overlap CDS (default OFF)
    inputBinding:
      position: 102
      prefix: --cdsrnaolap
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
  - id: dotbl2asn
    type:
      - 'null'
      - boolean
    doc: Run tbl2asn (default OFF)
    inputBinding:
      position: 102
      prefix: --dotbl2asn
  - id: dotrna
    type:
      - 'null'
      - boolean
    doc: Run tRNA search (default OFF)
    inputBinding:
      position: 102
      prefix: --dotrna
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
    doc: Fast mode - only use basic BLASTP databases (default OFF)
    inputBinding:
      position: 102
      prefix: --fast
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwriting existing output folder (default OFF)
    inputBinding:
      position: 102
      prefix: --force
  - id: gffver
    type:
      - 'null'
      - int
    doc: GFF version
    inputBinding:
      position: 102
      prefix: --gffver
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
    doc: For CDS just set /product="unannotated protein" (default OFF)
    inputBinding:
      position: 102
      prefix: --noanno
  - id: norrna
    type:
      - 'null'
      - boolean
    doc: Don't run rRNA search (default OFF)
    inputBinding:
      position: 102
      prefix: --norrna
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output folder
    inputBinding:
      position: 102
      prefix: --outdir
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
      - File
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
    doc: Do not clean up /product annotation (default OFF)
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
    doc: Prefer RNAmmer over Barrnap for rRNA prediction (default OFF)
    inputBinding:
      position: 102
      prefix: --rnammer
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaprokka:1.15.0--pl5321hdfd78af_0
stdout: metaprokka.out
