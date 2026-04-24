cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - checkm
  - taxonomy_wf
label: checkm-genome_checkm taxonomy_wf
doc: "Runs taxon_set, analyze, qa\n\nTool homepage: https://github.com/Ecogenomics/CheckM"
inputs:
  - id: taxonomic_rank
    type: string
    doc: taxonomic rank
    inputBinding:
      position: 1
  - id: taxon
    type: string
    doc: taxon of interest
    inputBinding:
      position: 2
  - id: bin_input
    type: string
    doc: directory containing bins (fasta format) or path to file describing 
      genomes/genes - tab separated in 2 or 3 columns [genome ID, genome fna, 
      genome translation file (pep)]
    inputBinding:
      position: 3
  - id: output_dir
    type: Directory
    doc: directory to write output files
    inputBinding:
      position: 4
  - id: aai_strain
    type:
      - 'null'
      - float
    doc: 'AAI threshold used to identify strain heterogeneity (default: 0.9)'
    inputBinding:
      position: 105
      prefix: --aai_strain
  - id: alignment_file
    type:
      - 'null'
      - File
    doc: produce file showing alignment of multi-copy genes and their AAI 
      identity
    inputBinding:
      position: 105
      prefix: --alignment_file
  - id: bins_contain_genes
    type:
      - 'null'
      - boolean
    doc: bins contain genes as amino acids instead of nucleotide contigs
    inputBinding:
      position: 105
      prefix: --genes
  - id: coverage_file
    type:
      - 'null'
      - File
    doc: file containing coverage of each sequence; coverage information added 
      to table type 2 (see coverage command)
    inputBinding:
      position: 105
      prefix: --coverage_file
  - id: e_value
    type:
      - 'null'
      - float
    doc: 'e-value cut off (default: 1e-10)'
    inputBinding:
      position: 105
      prefix: --e_value
  - id: extension
    type:
      - 'null'
      - string
    doc: 'extension of bins (other files in directory are ignored) (default: fna)'
    inputBinding:
      position: 105
      prefix: --extension
  - id: generate_hmmer_alignment
    type:
      - 'null'
      - boolean
    doc: generate HMMER alignment file for each bin
    inputBinding:
      position: 105
      prefix: --ali
  - id: generate_nucleotide_sequences
    type:
      - 'null'
      - boolean
    doc: generate nucleotide gene sequences for each bin
    inputBinding:
      position: 105
      prefix: --nt
  - id: ignore_thresholds
    type:
      - 'null'
      - boolean
    doc: ignore model-specific score thresholds
    inputBinding:
      position: 105
      prefix: --ignore_thresholds
  - id: individual_markers
    type:
      - 'null'
      - boolean
    doc: treat marker as independent (i.e., ignore co-located set structure)
    inputBinding:
      position: 105
      prefix: --individual_markers
  - id: length
    type:
      - 'null'
      - float
    doc: 'percent overlap between target and query (default: 0.7)'
    inputBinding:
      position: 105
      prefix: --length
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'print results to file (default: stdout)'
    inputBinding:
      position: 105
      prefix: --file
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: suppress console output
    inputBinding:
      position: 105
      prefix: --quiet
  - id: skip_adj_correction
    type:
      - 'null'
      - boolean
    doc: do not exclude adjacent marker genes when estimating contamination
    inputBinding:
      position: 105
      prefix: --skip_adj_correction
  - id: skip_pseudogene_correction
    type:
      - 'null'
      - boolean
    doc: skip identification and filtering of pseudogenes
    inputBinding:
      position: 105
      prefix: --skip_pseudogene_correction
  - id: tab_table
    type:
      - 'null'
      - boolean
    doc: print tab-separated values table
    inputBinding:
      position: 105
      prefix: --tab_table
  - id: threads
    type:
      - 'null'
      - int
    doc: 'number of threads (default: 1)'
    inputBinding:
      position: 105
      prefix: --threads
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: specify an alternative directory for temporary files
    inputBinding:
      position: 105
      prefix: --tmpdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
stdout: checkm-genome_checkm taxonomy_wf.out
