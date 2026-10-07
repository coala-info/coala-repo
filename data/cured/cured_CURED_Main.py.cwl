cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - CURED_Main.py
label: cured_CURED_Main.py
doc: "This script is part of the CURED pipeline. This script is used for finding
  unique clonal biomarkers in your cases.\n\nTool homepage: https://github.com/microbialARC/CURED"
inputs:
  - id: number_of_cases
    type:
      - 'null'
      - int
    doc: Add in the number of cases to be used in each iteration.
    inputBinding:
      position: 101
      prefix: --number_of_cases
  - id: number_of_controls
    type:
      - 'null'
      - int
    doc: Add in the number of controls to be used in each iteration.
    inputBinding:
      position: 101
      prefix: --number_of_controls
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to be used for unitig-caller. Default = 1.
    inputBinding:
      position: 101
      prefix: --threads
  - id: case_control_file
    type:
      - 'null'
      - File
    doc: Csv file of genomes to be used with case or control designation.
    inputBinding:
      position: 101
      prefix: --case_control_file
  - id: sensitivity
    type:
      - 'null'
      - int
    doc: Specifiy sensitivity. Default = 100.
    inputBinding:
      position: 101
      prefix: --sensitivity
  - id: specificity
    type:
      - 'null'
      - int
    doc: Specify specificity. Default = 100.
    inputBinding:
      position: 101
      prefix: --specificity
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: Specify minimum length of k-mer to search for. Default is 20.
    inputBinding:
      position: 101
      prefix: --kmer_length
  - id: species
    type:
      - 'null'
      - type: array
        items: string
    doc: Genus or species of interest (e.g. Staphylococcus aureus); genomes are 
      downloaded from NCBI.
    inputBinding:
      position: 101
      prefix: --species
  - id: sequence_type
    type:
      - 'null'
      - int
    doc: sequence type of interest
    inputBinding:
      position: 101
      prefix: --sequence_type
  - id: case_accession_list
    type:
      - 'null'
      - File
    doc: List of case accessions.
    inputBinding:
      position: 101
      prefix: --case_accession_list
  - id: extension
    type:
      - 'null'
      - string
    doc: extension of assembly inputs. Ignore if using --species/--sequence_type
      options. Default = fna
    inputBinding:
      position: 101
      prefix: --extension
  - id: database
    type:
      - 'null'
      - string
    doc: Choose to download genomes from RefSeq, GenBank, or both. Default = 
      both.
    inputBinding:
      position: 101
      prefix: --database
  - id: summary
    type:
      - 'null'
      - boolean
    doc: Check to see how many genomes will be downloaded if you use the 
      --species option. Use this option with --database and --species options.
    inputBinding:
      position: 101
      prefix: --summary
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: No screen output. Default = OFF
    inputBinding:
      position: 101
      prefix: --quiet
  - id: genomes_folder
    type:
      - 'null'
      - Directory
    doc: Path to genomes (passed with a trailing slash, which the tool needs to
      build file paths).
    inputBinding:
      position: 101
      prefix: --genomes_folder
      valueFrom: $(self.path + "/")
  - id: case_genomes
    type:
      - 'null'
      - boolean
    doc: Option if you have local sequencing data to serve as the cases. Use 
      --species to download control genomes.
    inputBinding:
      position: 101
      prefix: --case_genomes
  - id: use_datasets
    type:
      - 'null'
      - boolean
    doc: Option to provide CURED with a case and control file of ncbi accessions
      and downloaded them. Use with --case_control_file
    inputBinding:
      position: 101
      prefix: --use_datasets
  - id: use_simple
    type:
      - 'null'
      - boolean
    doc: Option to run unitig-caller simple mode. This is useful for when you 
      already have a list of k-mers that you want to query against a set of 
      genomes.
    inputBinding:
      position: 101
      prefix: --use_simple
  - id: kmer_list
    type:
      - 'null'
      - File
    doc: List of k-mers to be used as query in running unitig-caller simple mode
    inputBinding:
      position: 101
      prefix: --kmer_list
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: unique_kmers
    type:
      - 'null'
      - File
    doc: List of unique k-mers (input for CURED_FindREs.py)
    outputBinding:
      glob: UniqueKmers.txt
  - id: unique_kmers_report
    type:
      - 'null'
      - File
    doc: Report of unique k-mers with the number of cases and controls each is 
      found in
    outputBinding:
      glob: Unique_Kmers_Report.txt
  - id: similarity_matrix
    type:
      - 'null'
      - File
    doc: Control genomes ranked by putative similarity to the case genomes
    outputBinding:
      glob: Genome_Similarity_Matrix.csv
  - id: logs
    type: File[]
    doc: Log reports
    outputBinding:
      glob: '*.log'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cured:1.05--hdfd78af_0
stdout: cured_CURED_Main.py.out
