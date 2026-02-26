cwlVersion: v1.2
class: CommandLineTool
baseCommand: mimick
label: mimick
doc: "Simulate linked-read FASTQ data for one or many individuals\n\nTool homepage:
  https://github.com/pdimens/mimick"
inputs:
  - id: fasta_files
    type:
      type: array
      items: File
    doc: One or more FASTA files (haplotypes) to simulate linked reads for a 
      single individual.
    inputBinding:
      position: 1
  - id: circular
    type:
      - 'null'
      - boolean
    doc: contigs are circular/prokaryotic
    inputBinding:
      position: 102
      prefix: --circular
  - id: format
    type:
      - 'null'
      - string
    doc: FASTQ output format
    default: standard:haplotagging
    inputBinding:
      position: 102
      prefix: --format
  - id: genomic_coverage
    type:
      - 'null'
      - float
    doc: mean coverage (depth) target for simulated data
    default: 30.0
    inputBinding:
      position: 102
      prefix: --genomic-coverage
  - id: insert_size
    type:
      - 'null'
      - int
    doc: outer distance between the two read ends in bp
    default: 500
    inputBinding:
      position: 102
      prefix: --insert-size
  - id: insert_stdev
    type:
      - 'null'
      - int
    doc: standard deviation for --insert-size
    default: 50
    inputBinding:
      position: 102
      prefix: --insert-stdev
  - id: molecule_attempts
    type:
      - 'null'
      - int
    doc: how many tries to create a molecule with <70% ambiguous bases
    default: 300
    inputBinding:
      position: 102
      prefix: --molecule-attempts
  - id: molecule_coverage
    type:
      - 'null'
      - float
    doc: mean percent coverage per molecule if <1, else mean number of reads per
      molecule
    default: 0.2
    inputBinding:
      position: 102
      prefix: --molecule-coverage
  - id: molecule_length
    type:
      - 'null'
      - int
    doc: mean length of molecules in bp
    default: 80000
    inputBinding:
      position: 102
      prefix: --molecule-length
  - id: molecules_per
    type:
      - 'null'
      - int
    doc: mean number of unrelated molecules per barcode per chromosome, where a 
      negative number (e.g. -2) will use a fixed number of unrelated molecules 
      and a positive one will draw from a distribution
    default: 2
    inputBinding:
      position: 102
      prefix: --molecules-per
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: output file prefix
    default: simulated/
    inputBinding:
      position: 102
      prefix: --output-prefix
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: toggle to hide progress bar
    inputBinding:
      position: 102
      prefix: --quiet
  - id: read_lengths
    type:
      - 'null'
      - string
    doc: length of R1,R2 sequences in bp
    default: 150,150
    inputBinding:
      position: 102
      prefix: --read-lengths
  - id: seed
    type:
      - 'null'
      - int
    doc: random seed for simulation
    inputBinding:
      position: 102
      prefix: --seed
  - id: singletons
    type:
      - 'null'
      - float
    doc: proportion of barcodes that will only have one read pair
    default: 0
    inputBinding:
      position: 102
      prefix: --singletons
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use for multi-sample simulation
    default: 2
    inputBinding:
      position: 102
      prefix: --threads
  - id: vcf_file
    type:
      - 'null'
      - File
    doc: VCF-formatted file containing genotypes from which to create per-sample
      haplotypes
    inputBinding:
      position: 102
      prefix: --vcf
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimick:3.0.1--pyh7e72e81_0
stdout: mimick.out
