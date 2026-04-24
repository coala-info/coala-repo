cwlVersion: v1.2
class: CommandLineTool
baseCommand: haystac database
label: haystac_database
doc: "Build a database of target species\n\nTool homepage: https://github.com/antonisdim/haystac"
inputs:
  - id: accessions_file
    type:
      - 'null'
      - File
    doc: 'Tab delimited file containing one record per row: the name of the taxon,
      and a valid NCBI accession code from the nucleotide, assembly or WGS databases.'
    inputBinding:
      position: 101
      prefix: --accessions-file
  - id: batch
    type:
      - 'null'
      - string
    doc: Batch number for large`haystac database` workflows (e.g. --batch 
      index_all_accessions=1/3). You will need to execute all batches before 
      haystac is able to finish its workflow to the end.
    inputBinding:
      position: 101
      prefix: --batch
  - id: bowtie2_scaling
    type:
      - 'null'
      - float
    doc: Rescaling factor to keep the bowtie2 mutlifasta index below the maximum
      memory limit
    inputBinding:
      position: 101
      prefix: --bowtie2-scaling
  - id: bowtie2_threads
    type:
      - 'null'
      - int
    doc: Number of threads bowtie2 will use to index every individual genome in 
      the database
    inputBinding:
      position: 101
      prefix: --bowtie2-threads
  - id: cores
    type:
      - 'null'
      - int
    doc: Maximum number of CPU cores to use
    inputBinding:
      position: 101
      prefix: --cores
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable debugging mode
    inputBinding:
      position: 101
      prefix: --debug
  - id: exclude_accessions
    type:
      - 'null'
      - type: array
        items: string
    doc: List of NCBI accessions to exclude.
    inputBinding:
      position: 101
      prefix: --exclude-accessions
  - id: force_accessions
    type:
      - 'null'
      - boolean
    doc: Disable validation checks for 'anomalous' assembly flags in NCBI
    inputBinding:
      position: 101
      prefix: --force-accessions
  - id: genera
    type:
      - 'null'
      - type: array
        items: string
    doc: List of genera to restrict the abundance calculations.
    inputBinding:
      position: 101
      prefix: --genera
  - id: mem
    type:
      - 'null'
      - int
    doc: Maximum memory (MB) to use
    inputBinding:
      position: 101
      prefix: --mem
  - id: mode
    type: string
    doc: Database creation mode for haystac [fetch, index, build]
    inputBinding:
      position: 101
      prefix: --mode
  - id: mt_dna
    type:
      - 'null'
      - boolean
    doc: For eukaryotes, download mitochondrial genomes only. Not to be used 
      with --refseq-rep or queries containing prokaryotes
    inputBinding:
      position: 101
      prefix: --mtDNA
  - id: query
    type:
      - 'null'
      - string
    doc: Database query in the NCBI query language. Please refer to the 
      documentation for assistance with constructing a valid query.
    inputBinding:
      position: 101
      prefix: --query
  - id: query_file
    type:
      - 'null'
      - File
    doc: File containing a database query in the NCBI query language.
    inputBinding:
      position: 101
      prefix: --query-file
  - id: rank
    type:
      - 'null'
      - string
    doc: Taxonomic rank to perform the identifications on [genus, species, 
      subspecies, serotype]
    inputBinding:
      position: 101
      prefix: --rank
  - id: refseq_rep
    type:
      - 'null'
      - string
    doc: Use one of the RefSeq curated tables to construct a DB. Includes all 
      prokaryotic species (excluding strains) from the representative RefSeq DB,
      or all the species and strains from the viruses DB, or all the species and
      subspecies from the eukaryotes DB. If multiple accessions exist for a 
      given species/strain, the first pair of species/accession is kept. 
      Available RefSeq tables to use [prokaryote_rep, viruses, eukaryotes].
    inputBinding:
      position: 101
      prefix: --refseq-rep
  - id: resolve_accessions
    type:
      - 'null'
      - boolean
    doc: Pick the first accession when two accessions for a taxon can be found 
      in user provided input files
    inputBinding:
      position: 101
      prefix: --resolve-accessions
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed for database indexing
    inputBinding:
      position: 101
      prefix: --seed
  - id: sequences_file
    type:
      - 'null'
      - File
    doc: 'Tab delimited file containing one record per row: the name of the taxon,
      a user defined accession code, and the path to the fasta file (optionally compressed).'
    inputBinding:
      position: 101
      prefix: --sequences-file
  - id: snakemake
    type:
      - 'null'
      - string
    doc: Pass additional flags to the `snakemake` scheduler.
    inputBinding:
      position: 101
      prefix: --snakemake
  - id: unlock
    type:
      - 'null'
      - boolean
    doc: Unlock the output directory following a crash or hard restart
    inputBinding:
      position: 101
      prefix: --unlock
outputs:
  - id: output
    type: Directory
    doc: Path to the database output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haystac:0.4.12--pyhcf36b3e_0
