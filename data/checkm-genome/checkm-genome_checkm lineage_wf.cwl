cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - checkm
  - lineage_wf
label: checkm-genome_checkm lineage_wf
doc: "Runs tree, lineage_set, analyze, qa\n\nTool homepage: https://github.com/Ecogenomics/CheckM"
inputs:
  - id: bin_input
    type: string
    doc: directory containing bins (fasta format) or path to file describing 
      genomes/genes - tab separated in 2 or 3 columns [genome ID, genome fna, 
      genome translation file (pep)]
    inputBinding:
      position: 1
  - id: output_dir
    type: Directory
    doc: directory to write output files
    inputBinding:
      position: 2
  - id: aai_strain_threshold
    type:
      - 'null'
      - float
    doc: AAI threshold used to identify strain heterogeneity
    default: 0.9
    inputBinding:
      position: 103
      prefix: --aai_strain
  - id: alignment_file
    type:
      - 'null'
      - File
    doc: produce file showing alignment of multi-copy genes and their AAI 
      identity
    inputBinding:
      position: 103
      prefix: --alignment_file
  - id: bin_extension
    type:
      - 'null'
      - string
    doc: extension of bins (other files in directory are ignored)
    default: fna
    inputBinding:
      position: 103
      prefix: --extension
  - id: bins_contain_genes
    type:
      - 'null'
      - boolean
    doc: bins contain genes as amino acids instead of nucleotide contigs
    inputBinding:
      position: 103
      prefix: --genes
  - id: e_value
    type:
      - 'null'
      - float
    doc: e-value cut off
    default: '1e-10'
    inputBinding:
      position: 103
      prefix: --e_value
  - id: force_domain
    type:
      - 'null'
      - boolean
    doc: use domain-level sets for all bins
    inputBinding:
      position: 103
      prefix: --force_domain
  - id: generate_hmmer_alignment
    type:
      - 'null'
      - boolean
    doc: generate HMMER alignment file for each bin
    inputBinding:
      position: 103
      prefix: --ali
  - id: generate_nucleotide_sequences
    type:
      - 'null'
      - boolean
    doc: generate nucleotide gene sequences for each bin
    inputBinding:
      position: 103
      prefix: --nt
  - id: ignore_thresholds
    type:
      - 'null'
      - boolean
    doc: ignore model-specific score thresholds
    inputBinding:
      position: 103
      prefix: --ignore_thresholds
  - id: individual_markers
    type:
      - 'null'
      - boolean
    doc: treat marker as independent (i.e., ignore co-located set structure)
    inputBinding:
      position: 103
      prefix: --individual_markers
  - id: length_overlap
    type:
      - 'null'
      - float
    doc: percent overlap between target and query
    default: 0.7
    inputBinding:
      position: 103
      prefix: --length
  - id: multi_copy_markers
    type:
      - 'null'
      - int
    doc: maximum number of multi-copy phylogenetic markers before defaulting to 
      domain-level marker set
    default: 10
    inputBinding:
      position: 103
      prefix: --multi
  - id: no_refinement
    type:
      - 'null'
      - boolean
    doc: do not perform lineage-specific marker set refinement
    inputBinding:
      position: 103
      prefix: --no_refinement
  - id: output_file
    type:
      - 'null'
      - File
    doc: print results to file
    inputBinding:
      position: 103
      prefix: --file
  - id: pplacer_threads
    type:
      - 'null'
      - int
    doc: number of threads used by pplacer (memory usage increases linearly with
      additional threads)
    default: 1
    inputBinding:
      position: 103
      prefix: --pplacer_threads
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: suppress console output
    inputBinding:
      position: 103
      prefix: --quiet
  - id: reduced_tree
    type:
      - 'null'
      - boolean
    doc: use reduced tree (requires <16GB of memory) for determining lineage of 
      each bin
    inputBinding:
      position: 103
      prefix: --reduced_tree
  - id: skip_adj_correction
    type:
      - 'null'
      - boolean
    doc: do not exclude adjacent marker genes when estimating contamination
    inputBinding:
      position: 103
      prefix: --skip_adj_correction
  - id: skip_pseudogene_correction
    type:
      - 'null'
      - boolean
    doc: skip identification and filtering of pseudogenes
    inputBinding:
      position: 103
      prefix: --skip_pseudogene_correction
  - id: tab_table
    type:
      - 'null'
      - boolean
    doc: print tab-separated values table
    inputBinding:
      position: 103
      prefix: --tab_table
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: 1
    inputBinding:
      position: 103
      prefix: --threads
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: specify an alternative directory for temporary files
    inputBinding:
      position: 103
      prefix: --tmpdir
  - id: unique_markers
    type:
      - 'null'
      - int
    doc: minimum number of unique phylogenetic markers required to use 
      lineage-specific marker set
    default: 10
    inputBinding:
      position: 103
      prefix: --unique
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
stdout: checkm-genome_checkm lineage_wf.out
