cwlVersion: v1.2
class: CommandLineTool
baseCommand: hybpiper retrieve_sequences
label: hybpiper_retrieve_sequences
doc: "Type of sequence to extract.\n\nTool homepage: https://github.com/mossmatters/HybPiper"
inputs:
  - id: sequence_type
    type: string
    doc: Type of sequence to extract.
    inputBinding:
      position: 1
  - id: cpu
    type:
      - 'null'
      - int
    doc: Limit the number of CPUs. Default is to use all cores available minus 
      one.
    inputBinding:
      position: 102
      prefix: --cpu
  - id: fasta_dir
    type:
      - 'null'
      - Directory
    doc: Specify directory for output FASTA files.
    inputBinding:
      position: 102
      prefix: --fasta_dir
  - id: filter_by
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Provide three space-separated arguments: 1) column of the stats_file to
      filter by, 2) "greater" or "smaller", 3) a threshold - either an integer (raw
      number of genes) or float (percentage of genes in analysis). This parameter
      can be supplied more than once to filter by multiple criteria.'
    inputBinding:
      position: 102
      prefix: --filter_by
  - id: hybpiper_dir
    type:
      - 'null'
      - Directory
    doc: Specify directory containing HybPiper output sample folders. Default is
      the current working directory.
    inputBinding:
      position: 102
      prefix: --hybpiper_dir
  - id: run_profiler
    type:
      - 'null'
      - boolean
    doc: If supplied, run the subcommand using cProfile. Saves a *.csv file of 
      results.
    inputBinding:
      position: 102
      prefix: --run_profiler
  - id: sample_names
    type: File
    doc: Text file with names of HybPiper output directories, one per line.
    inputBinding:
      position: 102
      prefix: --sample_names
  - id: single_sample_name
    type: string
    doc: A single sample name to recover sequences for
    inputBinding:
      position: 102
      prefix: --single_sample_name
  - id: skip_chimeric_genes
    type:
      - 'null'
      - boolean
    doc: Do not recover sequences for putative chimeric genes. This only has an 
      effect for a given sample if the option "--chimeric_stitched_contig_check"
      was provided to command "hybpiper assemble".
    inputBinding:
      position: 102
      prefix: --skip_chimeric_genes
  - id: stats_file
    type:
      - 'null'
      - File
    doc: Stats file produced by "hybpiper stats", required for selective 
      filtering of retrieved sequences.
    inputBinding:
      position: 102
      prefix: --stats_file
  - id: targetfile_aa
    type: File
    doc: 'FASTA file containing amino-acid target sequences for each gene. The fasta
      headers must follow the naming convention: >TaxonID-geneName'
    inputBinding:
      position: 102
      prefix: --targetfile_aa
  - id: targetfile_dna
    type: File
    doc: 'FASTA file containing DNA target sequences for each gene. The fasta headers
      must follow the naming convention: >TaxonID-geneName'
    inputBinding:
      position: 102
      prefix: --targetfile_dna
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hybpiper:2.3.4--pyhdfd78af_0
stdout: hybpiper_retrieve_sequences.out
