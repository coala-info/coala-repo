cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gget
  - mutate
label: gget_mutate
doc: 'Mutate nucleotide sequences based on provided mutations.


  Tool homepage: https://github.com/pachterlab/gget'
inputs:
  - id: sequences
    type:
      type: array
      items: &id001
        - string
        - File
    doc: 'Path to the fasta file containing the sequences to be mutated, e.g., ''seqs.fa''.
      Sequence identifiers following the ''>'' character must correspond to the identifiers
      in the seq_ID column of ''mutations''. Alternatively: input sequence(s) as a
      string or list, e.g. ''AGCTAGCT'' or ''ACTGCTAGCT'' ''AGCTAGCT''.'
    inputBinding:
      position: 1
  - id: mutations
    type:
      type: array
      items: *id001
    doc: 'Path to csv or tsv file (e.g., ''mutations.csv'') containing the columns
      ''mutation'', ''mut_ID'' (optional) and ''seq_ID''. Alternatively: input mutation(s)
      as a string or list, e.g. ''c.2C>T'' or ''c.2C>T'' ''c.1A>C''. If a list is
      passed, the number of mutations must equal the number of input sequences.'
    inputBinding:
      position: 101
      prefix: --mutations
  - id: gtf
    type:
      - 'null'
      - File
    doc: Path to a .gtf file. When providing a genome fasta file as input for 'sequences',
      you can provide a .gtf file here and the input sequences will be defined according
      to the transcript boundaries, e.g. 'path/to/genome_annotation.gtf'.
    inputBinding:
      position: 102
      prefix: --gtf
  - id: gtf_transcript_id_column
    type:
      - 'null'
      - string
    doc: Column name in the input 'mutations' file containing the transcript ID. In
      this case, column 'seq_id_column' should contain the chromosome number. Required
      when 'gtf' is provided.
    inputBinding:
      position: 102
      prefix: --gtf_transcript_id_column
  - id: k
    type:
      - 'null'
      - int
    doc: 'Length of sequences flanking the mutation. If k > total length of the sequence,
      the entire sequence will be kept. (default: 30)'
    inputBinding:
      position: 102
      prefix: --k
  - id: max_ambiguous
    type:
      - 'null'
      - int
    doc: 'Maximum number of ''N'' (or ''n'') characters allowed in the output sequence,
      e.g. 10. Default: None (no ambiguous character filter will be applied).'
    inputBinding:
      position: 102
      prefix: --max_ambiguous
  - id: merge_identical_off
    type:
      - 'null'
      - boolean
    doc: Do not merge identical mutant sequences in the output (by default, identical
      sequences will be merged by concatenating the sequence headers for all identical
      sequences).
    inputBinding:
      position: 102
      prefix: --merge_identical_off
  - id: min_seq_len
    type:
      - 'null'
      - int
    doc: Minimum length of the mutant output sequence, e.g. 100. Mutant sequences
      smaller than this will be dropped.
    inputBinding:
      position: 102
      prefix: --min_seq_len
  - id: mut_column
    type:
      - 'null'
      - string
    doc: 'Name of the column containing the mutations to be performed in ''mutations''.
      (default: mutation)'
    inputBinding:
      position: 102
      prefix: --mut_column
  - id: mut_id_column
    type:
      - 'null'
      - string
    doc: 'Name of the column containing the IDs of each mutation in ''mutations''.
      Default: Same as ''mut_column''.'
    inputBinding:
      position: 102
      prefix: --mut_id_column
  - id: optimize_flanking_regions
    type:
      - 'null'
      - boolean
    doc: Removes nucleotides from either end of the mutant sequence to ensure (when
      possible) that the mutant sequence does not contain any k-mers also found in
      the wildtype/input sequence.
    inputBinding:
      position: 102
      prefix: --optimize_flanking_regions
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not print progress information.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: remove_seqs_with_wt_kmers
    type:
      - 'null'
      - boolean
    doc: Removes output sequences where at least one k-mer is also present in the
      wildtype/input sequence in the same region. When used with `--optimize_flanking_regions`,
      only sequences for which a wildtpye kmer is still present after optimization
      will be removed.
    inputBinding:
      position: 102
      prefix: --remove_seqs_with_wt_kmers
  - id: seq_id_column
    type:
      - 'null'
      - string
    doc: 'Name of the column containing the IDs of the sequences to be mutated in
      ''mutations''. (default: seq_ID)'
    inputBinding:
      position: 102
      prefix: --seq_id_column
  - id: store_full_sequences
    type:
      - 'null'
      - boolean
    doc: Includes the complete wildtype and mutant sequences in the updated `mutations`
      DataFrame (not just the sub-sequence with k-length flanks). Only valid when
      used with `--update_df`.
    inputBinding:
      position: 102
      prefix: --store_full_sequences
  - id: translate
    type:
      - 'null'
      - boolean
    doc: Adds additional columns to the updated `mutations` DataFrame containing the
      wildtype and mutant amino acid sequences. Only valid when used with `--store_full_sequences`.
    inputBinding:
      position: 102
      prefix: --translate
  - id: translate_end
    type:
      - 'null'
      - string
    doc: '(int or str) The position in the input nucleotide sequence to end translating,
      e.g. 35. If a string is provided, it should correspond to a column name in `mutations`
      containing the open reading frame end positions for each sequence/mutation.
      Only valid when used with `--translate`. Default: translates until the end of
      each sequence.'
    inputBinding:
      position: 102
      prefix: --translate_end
  - id: translate_start
    type:
      - 'null'
      - string
    doc: '(int or str) The position in the input nucleotide sequence to start translating,
      e.g. 5. If a string is provided, it should correspond to a column name in `mutations`
      containing the open reading frame start positions for each sequence/mutation.
      Only valid when used with `--translate`. Default: translates from the beginning
      of each sequence.'
    inputBinding:
      position: 102
      prefix: --translate_start
  - id: update_df
    type:
      - 'null'
      - boolean
    doc: Updates the input `mutations` DataFrame to include additional columns with
      the mutation type, wildtype nucleotide sequence, and mutant nucleotide sequence
      (only valid if `mutations` is a .csv or .tsv file).
    inputBinding:
      position: 102
      prefix: --update_df
  - id: update_df_out
    type:
      - 'null'
      - string
    doc: 'Path to output csv file containing the updated DataFrame, e.g. ''path/to/mutations_updated.csv''.
      Only valid when used with `--update_df`. Default: None -> the new csv file will
      be saved in the same directory as the `mutations` DataFrame with appendix ''_updated''.'
    inputBinding:
      position: 102
      prefix: --update_df_out
  - id: out_path
    type: string
    default: mutated.fa
    doc: Path to output fasta file containing the mutated sequences, e.g., 'path/to/output_fasta.fa'.
      The identifiers (following the '>') of the mutated sequences in the output fasta
      will be '>[seq_ID]_[mut_ID]'.
    inputBinding:
      position: 103
      prefix: --out
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: FASTA file with the mutated sequences.
    outputBinding:
      glob: $(inputs.out_path)
  - id: updated_df
    type:
      - 'null'
      - File
    doc: Updated mutations table (only with update_df and update_df_out).
    outputBinding:
      glob: $(inputs.update_df_out)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
