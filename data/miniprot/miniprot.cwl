cwlVersion: v1.2
class: CommandLineTool
baseCommand: miniprot
label: miniprot
doc: "Align protein sequences to a reference database.\n\nTool homepage: https://github.com/lh3/miniprot"
inputs:
  - id: reference_fasta
    type: File
    doc: Reference protein FASTA file
    inputBinding:
      position: 1
  - id: query_fasta
    type: File
    doc: Query protein FASTA file
    inputBinding:
      position: 2
  - id: query_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Additional query FASTA files
    inputBinding:
      position: 3
  - id: bits_per_block
    type:
      - 'null'
      - int
    doc: bits per block
    inputBinding:
      position: 104
      prefix: -b
  - id: bonus_score_reaching_ends
    type:
      - 'null'
      - int
    doc: bonus score for alignment reaching query ends
    inputBinding:
      position: 104
      prefix: -B
  - id: frameshift_penalty
    type:
      - 'null'
      - int
    doc: penalty for frameshifts or in-frame stop codons
    inputBinding:
      position: 104
      prefix: -F
  - id: gap_extension_penalty
    type:
      - 'null'
      - int
    doc: gap extension (a k-long gap costs O+k*E)
    inputBinding:
      position: 104
      prefix: -E
  - id: gap_open_penalty
    type:
      - 'null'
      - int
    doc: gap open penalty
    inputBinding:
      position: 104
      prefix: -O
  - id: gff3_id_prefix
    type:
      - 'null'
      - string
    doc: prefix for IDs in GFF3
    inputBinding:
      position: 104
      prefix: -P
  - id: intron_open_penalty
    type:
      - 'null'
      - int
    doc: intron open penalty
    inputBinding:
      position: 104
      prefix: -J
  - id: kmer_size_indexing
    type:
      - 'null'
      - int
    doc: k-mer size for indexing
    inputBinding:
      position: 104
      prefix: -k
  - id: kmer_size_second_chaining
    type:
      - 'null'
      - int
    doc: k-mer size for the second round of chaining
    inputBinding:
      position: 104
      prefix: -l
  - id: max_alignments_per_query
    type:
      - 'null'
      - string
    doc: output up to min{NUM,-N} alignments per query
    inputBinding:
      position: 104
      prefix: --outn
  - id: max_extension_second_round
    type:
      - 'null'
      - string
    doc: max extension for 2nd round of chaining and alignment
    inputBinding:
      position: 104
      prefix: -e
  - id: max_intron_size
    type:
      - 'null'
      - string
    doc: max intron size; override -I
    inputBinding:
      position: 104
      prefix: -G
  - id: max_kmer_occurrence
    type:
      - 'null'
      - string
    doc: max k-mer occurrence
    inputBinding:
      position: 104
      prefix: -c
  - id: max_secondary_alignments
    type:
      - 'null'
      - string
    doc: consider at most INT secondary alignments
    inputBinding:
      position: 104
      prefix: -N
  - id: min_chaining_score
    type:
      - 'null'
      - string
    doc: min chaining score
    inputBinding:
      position: 104
      prefix: -m
  - id: min_fraction_aligned_for_output
    type:
      - 'null'
      - float
    doc: output if at least FLOAT fraction of query is aligned
    inputBinding:
      position: 104
      prefix: --outc
  - id: min_orf_length_index
    type:
      - 'null'
      - int
    doc: min ORF length to index
    inputBinding:
      position: 104
      prefix: -L
  - id: min_score_ratio_for_output
    type:
      - 'null'
      - float
    doc: output if score at least FLOAT*bestScore
    inputBinding:
      position: 104
      prefix: --outs
  - id: min_secondary_to_primary_score_ratio
    type:
      - 'null'
      - float
    doc: min secondary-to-primary score ratio
    inputBinding:
      position: 104
      prefix: -p
  - id: min_syncmers_in_chain
    type:
      - 'null'
      - string
    doc: minimum number of syncmers in a chain
    inputBinding:
      position: 104
      prefix: -n
  - id: modimisers_bit
    type:
      - 'null'
      - int
    doc: modimisers bit (sample rate = 1/2**M)
    inputBinding:
      position: 104
      prefix: -M
  - id: ncbi_translation_table
    type:
      - 'null'
      - int
    doc: NCBI translation table (1 through 33)
    inputBinding:
      position: 104
      prefix: -T
  - id: no_splicing
    type:
      - 'null'
      - boolean
    doc: no splicing (applying -G1k -J1k -e1k)
    inputBinding:
      position: 104
      prefix: -S
  - id: output_alignment
    type:
      - 'null'
      - boolean
    doc: output residue alignment
    inputBinding:
      position: 104
      prefix: --aln
  - id: output_gff3
    type:
      - 'null'
      - boolean
    doc: output in the GFF3 format
    inputBinding:
      position: 104
      prefix: --gff
  - id: output_gtf
    type:
      - 'null'
      - boolean
    doc: basic GTF output without detailed alignment
    inputBinding:
      position: 104
      prefix: --gtf
  - id: output_translated_sequences
    type:
      - 'null'
      - boolean
    doc: output translated protein sequences (skipping frameshift)
    inputBinding:
      position: 104
      prefix: --trans
  - id: print_unmapped_query_proteins_paf
    type:
      - 'null'
      - boolean
    doc: print unmapped query proteins in PAF
    inputBinding:
      position: 104
      prefix: -u
  - id: query_batch_size
    type:
      - 'null'
      - string
    doc: query batch size
    inputBinding:
      position: 104
      prefix: -K
  - id: set_max_intron_size_to_sqrt
    type:
      - 'null'
      - boolean
    doc: set max intron size to 3.6*sqrt(refLen)
    inputBinding:
      position: 104
      prefix: -I
  - id: splice_model
    type:
      - 'null'
      - int
    doc: 'splice model: 2=vertebrate/insect, 1=general, 0=none (see manual)'
    inputBinding:
      position: 104
      prefix: -j
  - id: splice_score_default
    type:
      - 'null'
      - int
    doc: splice score for sites not in --spsc
    inputBinding:
      position: 104
      prefix: --spsc0
  - id: splice_score_file
    type:
      - 'null'
      - File
    doc: splice score file in format "ctg offset +|- D|A score"
    inputBinding:
      position: 104
      prefix: --spsc
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 104
      prefix: -t
  - id: weight_log_gap_penalty
    type:
      - 'null'
      - float
    doc: weight of log gap penalty
    inputBinding:
      position: 104
      prefix: -w
  - id: weight_splice_penalty
    type:
      - 'null'
      - float
    doc: weight of splice penalty; 0 to ignore splice signals
    inputBinding:
      position: 104
      prefix: -C
outputs:
  - id: save_index_to_file
    type:
      - 'null'
      - File
    doc: save index to FILE
    outputBinding:
      glob: $(inputs.save_index_to_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/miniprot:0.18--h577a1d6_0
