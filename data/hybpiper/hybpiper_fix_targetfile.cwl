cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hybpiper
  - fix_targetfile
label: hybpiper_fix_targetfile
doc: "Fixes DNA and amino-acid target files by testing for open reading frames, removing
  stop codons, and filtering sequences.\n\nTool homepage: https://github.com/mossmatters/HybPiper"
inputs:
  - id: control_file
    type: string
    doc: The *.ctl file, as output by the command "hybpiper check_targetfile".
    inputBinding:
      position: 1
  - id: alignments
    type:
      - 'null'
      - boolean
    doc: Create per-gene alignments from the final fixed/filtered target file 
      sequences. Note that DNA sequences will be translated prior to alignment.
    inputBinding:
      position: 102
      prefix: --alignments
  - id: allow_gene_removal
    type:
      - 'null'
      - boolean
    doc: Allow frame-correction and filtering steps to remove all representative
      sequences for a given gene. Default is False; HybPiper will exit with an 
      information message instead. If supplied, this parameter will override the
      setting in the *.ctl file.
    inputBinding:
      position: 102
      prefix: --allow_gene_removal
  - id: concurrent_alignments
    type:
      - 'null'
      - int
    doc: Number of alignments to run concurrently. Default is 1.
    inputBinding:
      position: 102
      prefix: --concurrent_alignments
  - id: filter_by_length_percentage
    type:
      - 'null'
      - float
    doc: If more than one representative sequence is present for a given gene, 
      filter out sequences shorter than this percentage of the longest gene 
      sequence length. Default is 0.0 (all sequences retained).
    inputBinding:
      position: 102
      prefix: --filter_by_length_percentage
  - id: keep_low_complexity_sequences
    type:
      - 'null'
      - boolean
    doc: Keep sequences that contain regions of low complexity, as identified by
      the command "hybpiper check_targetfile". Default is to remove these 
      sequences.
    inputBinding:
      position: 102
      prefix: --keep_low_complexity_sequences
  - id: maximum_distance
    type:
      - 'null'
      - float
    doc: When comparing candidate DNA translation frames to a reference protein,
      the maximum distance allowed between the translated frame and the 
      reference sequence for any candidate translation frame to be selected. 
      Useful to filter out sequences with frameshifts that do NOT introduce stop
      codons. 0.0 means identical sequences, 1.0 means completely different 
      sequences. Default is 0.5
    inputBinding:
      position: 102
      prefix: --maximum_distance
  - id: no_terminal_stop_codons
    type:
      - 'null'
      - boolean
    doc: When testing for open reading frames, do not allow a translated frame 
      to have a single stop codon at the C-terminus of the translated protein 
      sequence. Default is False. If supplied, this parameter will override the 
      setting in the *.ctl file.
    inputBinding:
      position: 102
      prefix: --no_terminal_stop_codons
  - id: reference_protein_file
    type:
      - 'null'
      - File
    doc: 'If a given DNA sequence can be translated in more than one forward frame
      without stop codons, choose the translation that best matches the corresponding
      reference protein provided in this fasta file. The fasta headers must follow
      the naming convention: >TaxonID-geneName'
    inputBinding:
      position: 102
      prefix: --reference_protein_file
  - id: run_profiler
    type:
      - 'null'
      - boolean
    doc: If supplied, run the subcommand using cProfile. Saves a *.csv file of 
      results
    inputBinding:
      position: 102
      prefix: --run_profiler
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
  - id: threads_per_concurrent_alignment
    type:
      - 'null'
      - int
    doc: Number of threads to run each concurrent alignment with. Default is 1.
    inputBinding:
      position: 102
      prefix: --threads_per_concurrent_alignment
  - id: verbose_logging
    type:
      - 'null'
      - boolean
    doc: 'If supplied, enable verbose logging. NOTE: this will increase the size of
      the log files.'
    inputBinding:
      position: 102
      prefix: --verbose_logging
  - id: write_all_fasta_files
    type:
      - 'null'
      - boolean
    doc: If provided, *.fasta files will be written for sequences removed from 
      the fixed/filtered target file, according to filtering categories (length 
      threshold, low-complexity regions, etc.). By default, these files will not
      be written.
    inputBinding:
      position: 102
      prefix: --write_all_fasta_files
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hybpiper:2.3.4--pyhdfd78af_0
stdout: hybpiper_fix_targetfile.out
