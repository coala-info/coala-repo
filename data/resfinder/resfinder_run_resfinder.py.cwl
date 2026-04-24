cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_resfinder.py
label: resfinder_run_resfinder.py
doc: "Run resfinder for acquired resistance genes\n\nTool homepage: https://bitbucket.org/genomicepidemiology/resfinder"
inputs:
  - id: acq_overlap
    type:
      - 'null'
      - int
    doc: 'Genes are allowed to overlap this number of nucleotides. Default: 30.'
    inputBinding:
      position: 101
      prefix: --acq_overlap
  - id: acquired
    type:
      - 'null'
      - boolean
    doc: Run resfinder for acquired resistance genes
    inputBinding:
      position: 101
      prefix: --acquired
  - id: blast_path
    type:
      - 'null'
      - string
    doc: Path to blastn
    inputBinding:
      position: 101
      prefix: --blastPath
  - id: db_path_disinf
    type:
      - 'null'
      - Directory
    doc: Path to the databases for DisinFinder.
    inputBinding:
      position: 101
      prefix: --db_path_disinf
  - id: db_path_disinf_kma
    type:
      - 'null'
      - Directory
    doc: Path to the DisinFinder databases indexed with KMA. Defaults to the 
      value of the --db_res flag.
    inputBinding:
      position: 101
      prefix: --db_path_disinf_kma
  - id: db_path_point
    type:
      - 'null'
      - Directory
    doc: Path to the databases for PointFinder
    inputBinding:
      position: 101
      prefix: --db_path_point
  - id: db_path_point_kma
    type:
      - 'null'
      - Directory
    doc: Path to the PointFinder databases indexed with KMA. Defaults to the 
      value of the --db_path_point flag.
    inputBinding:
      position: 101
      prefix: --db_path_point_kma
  - id: db_path_res
    type:
      - 'null'
      - Directory
    doc: Path to the databases for ResFinder.
    inputBinding:
      position: 101
      prefix: --db_path_res
  - id: db_path_res_kma
    type:
      - 'null'
      - Directory
    doc: Path to the ResFinder databases indexed with KMA. Defaults to the value
      of the --db_res flag.
    inputBinding:
      position: 101
      prefix: --db_path_res_kma
  - id: disinfectant
    type:
      - 'null'
      - boolean
    doc: Run resfinder for disinfectant resistance genes
    inputBinding:
      position: 101
      prefix: --disinfectant
  - id: ignore_indels
    type:
      - 'null'
      - boolean
    doc: Ignore frameshift-causing indels in Pointfinder.
    inputBinding:
      position: 101
      prefix: --ignore_indels
  - id: ignore_missing_species
    type:
      - 'null'
      - boolean
    doc: If set, species is provided and --point flag is set, will not throw an 
      error if no database is found for the provided species. If species is not 
      found. Point mutations will silently be ignored.
    inputBinding:
      position: 101
      prefix: --ignore_missing_species
  - id: ignore_stop_codons
    type:
      - 'null'
      - boolean
    doc: Ignore premature stop codons in Pointfinder.
    inputBinding:
      position: 101
      prefix: --ignore_stop_codons
  - id: input_fasta
    type:
      - 'null'
      - File
    doc: Input fasta file.
    inputBinding:
      position: 101
      prefix: --inputfasta
  - id: input_fastq
    type:
      - 'null'
      - type: array
        items: File
    doc: Input fastq file(s). Assumed to be single-end fastq if only one file is
      provided, and assumed to be paired-end data if two files are provided.
    inputBinding:
      position: 101
      prefix: --inputfastq
  - id: kma_path
    type:
      - 'null'
      - string
    doc: Path to KMA
    inputBinding:
      position: 101
      prefix: --kmaPath
  - id: kma_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use with KMA
    inputBinding:
      position: 101
      prefix: --kma_threads
  - id: min_cov
    type:
      - 'null'
      - float
    doc: Minimum (breadth-of) coverage of ResFinder within the range 0-1.
    inputBinding:
      position: 101
      prefix: --min_cov
  - id: min_cov_point
    type:
      - 'null'
      - float
    doc: Minimum (breadth-of) coverage of Pointfinder within the range 0-1. If 
      None is selected, the minimum coverage of ResFinder will be used.
    inputBinding:
      position: 101
      prefix: --min_cov_point
  - id: nanopore
    type:
      - 'null'
      - boolean
    doc: If nanopore data is used
    inputBinding:
      position: 101
      prefix: --nanopore
  - id: out_json
    type:
      - 'null'
      - File
    doc: Specify JSON filename and output directory. If the directory doesn't 
      exist, it will be created.
    inputBinding:
      position: 101
      prefix: --out_json
  - id: output_aln
    type:
      - 'null'
      - boolean
    doc: will add the alignments in the json output.
    inputBinding:
      position: 101
      prefix: --output_aln
  - id: output_path
    type: Directory
    doc: Output directory. If it doesn't exist, it will be created.
    inputBinding:
      position: 101
      prefix: --outputPath
  - id: pickle
    type:
      - 'null'
      - boolean
    doc: Create a pickle dump of the Isolate object. Currently needed in the CGE
      webserver. Dependency and this option is being removed.
    inputBinding:
      position: 101
      prefix: --pickle
  - id: point
    type:
      - 'null'
      - boolean
    doc: Run pointfinder for chromosomal mutations
    inputBinding:
      position: 101
      prefix: --point
  - id: species
    type:
      - 'null'
      - string
    doc: Species in the sample
    inputBinding:
      position: 101
      prefix: --species
  - id: specific_gene
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify genes existing in the database to search for - if none is 
      specified all genes are included in the search.
    inputBinding:
      position: 101
      prefix: --specific_gene
  - id: threshold
    type:
      - 'null'
      - float
    doc: Threshold for identity of ResFinder within the range 0-1.
    inputBinding:
      position: 101
      prefix: --threshold
  - id: threshold_point
    type:
      - 'null'
      - float
    doc: Threshold for identity of Pointfinder within the range 0-1. If None is 
      selected, the minimum coverage of ResFinder will be used.
    inputBinding:
      position: 101
      prefix: --threshold_point
  - id: unknown_mut
    type:
      - 'null'
      - boolean
    doc: Show all mutations found even if in unknown to the resistance database
    inputBinding:
      position: 101
      prefix: --unknown_mut
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/resfinder:4.7.2--pyhdfd78af_0
stdout: resfinder_run_resfinder.py.out
