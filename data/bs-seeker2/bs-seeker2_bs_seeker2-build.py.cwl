cwlVersion: v1.2
class: CommandLineTool
baseCommand: bs_seeker2_bs_seeker2-build.py
label: bs-seeker2_bs_seeker2-build.py
doc: "Build index for BS-Seeker2\n\nTool homepage: http://pellegrini.mcdb.ucla.edu/BS_Seeker2/"
inputs:
  - id: aligner
    type:
      - 'null'
      - string
    doc: 'Aligner program to perform the analysis: bowtie, bowtie2, soap, rmap'
    default: bowtie
    inputBinding:
      position: 101
      prefix: --aligner
  - id: aligner_path
    type:
      - 'null'
      - Directory
    doc: 'Path to the aligner program. Detected: bowtie: None, bowtie2: /usr/local/bin,
      rmap: None, soap: None'
    inputBinding:
      position: 101
      prefix: --path
  - id: cut_site
    type:
      - 'null'
      - string
    doc: 'Cut sites of restriction enzyme. Ex: MspI(C-CGG), Mael:(C-TAG), double-enzyme
      MspI&Mael:(C-CGG,C-TAG).'
    default: C-CGG
    inputBinding:
      position: 101
      prefix: --cut-site
  - id: low_bound
    type:
      - 'null'
      - int
    doc: lower bound of fragment length (excluding recognition sequence such as 
      C-CGG)
    default: 20
    inputBinding:
      position: 101
      prefix: --low
  - id: reference_genome_file
    type: File
    doc: Input your reference genome file (fasta)
    inputBinding:
      position: 101
      prefix: --file
  - id: reference_genome_library_path
    type:
      - 'null'
      - Directory
    doc: Path to the reference genome library (generated in preprocessing 
      genome)
    default: /usr/local/bin/bs_utils/reference_genomes
    inputBinding:
      position: 101
      prefix: --db
  - id: rrbs
    type:
      - 'null'
      - boolean
    doc: Build index specially for Reduced Representation Bisulfite Sequencing 
      experiments. Genome other than certain fragments will be masked.
    default: false
    inputBinding:
      position: 101
      prefix: --rrbs
  - id: up_bound
    type:
      - 'null'
      - int
    doc: upper bound of fragment length (excluding recognition sequence such as 
      C-CGG ends)
    default: 500
    inputBinding:
      position: 101
      prefix: --up
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bs-seeker2:2.1.7--0
stdout: bs-seeker2_bs_seeker2-build.py.out
