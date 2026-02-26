cwlVersion: v1.2
class: CommandLineTool
baseCommand: hybpiper check_targetfile
label: hybpiper_check_targetfile
doc: "Check target files for issues such as stop codons and low complexity regions.\n\
  \nTool homepage: https://github.com/mossmatters/HybPiper"
inputs:
  - id: complexity_minimum_threshold
    type:
      - 'null'
      - float
    doc: Minimum threshold value. Beneath this value, the sequence in the 
      sliding window is flagged as low complexity, and the corresponding target 
      file sequence is reported as having low-complexity regions.
    inputBinding:
      position: 101
      prefix: --complexity_minimum_threshold
  - id: no_terminal_stop_codons
    type:
      - 'null'
      - boolean
    doc: When testing for open reading frames, do not allow a translated frame 
      to have a single stop codon at the C-terminus of the translated protein 
      sequence. Default is False.
    default: false
    inputBinding:
      position: 101
      prefix: --no_terminal_stop_codons
  - id: run_profiler
    type:
      - 'null'
      - boolean
    doc: If supplied, run the subcommand using cProfile. Saves a *.csv file of 
      results
    inputBinding:
      position: 101
      prefix: --run_profiler
  - id: sliding_window_size
    type:
      - 'null'
      - int
    doc: Number of characters (single-letter DNA or amino-acid codes) to include
      in the sliding window when checking for sequences with 
      low-complexity-regions.
    inputBinding:
      position: 101
      prefix: --sliding_window_size
  - id: targetfile_aa
    type:
      - 'null'
      - File
    doc: 'FASTA file containing amino-acid target sequences for each gene. The fasta
      headers must follow the naming convention: >TaxonID-geneName'
    inputBinding:
      position: 101
      prefix: --targetfile_aa
  - id: targetfile_dna
    type:
      - 'null'
      - File
    doc: 'FASTA file containing DNA target sequences for each gene. The fasta headers
      must follow the naming convention: >TaxonID-geneName'
    inputBinding:
      position: 101
      prefix: --targetfile_dna
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hybpiper:2.3.4--pyhdfd78af_0
stdout: hybpiper_check_targetfile.out
