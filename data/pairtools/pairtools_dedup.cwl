cwlVersion: v1.2
class: CommandLineTool
baseCommand: pairtools dedup
label: pairtools_dedup
doc: "Find and remove PCR/optical duplicates.\n\nTool homepage: https://github.com/mirnylab/pairtools"
inputs:
  - id: pairs_path
    type:
      - 'null'
      - File
    doc: input triu-flipped sorted .pairs or .pairsam file. If the path ends 
      with .gz/.lz4, the input is decompressed by bgzip/lz4c. By default, the 
      input is read from stdin.
    inputBinding:
      position: 1
  - id: backend
    type:
      - 'null'
      - string
    doc: "What backend to use: scipy and sklearn are based on KD-trees, cython is
      online indexed list-based algorithm. With cython backend, duplication is not
      transitive with non-zero max mismatch (e.g. pairs A and B are duplicates, and
      B and C are duplicates, then A and C are not necessary duplicates of each other),
      while with scipy and sklearn it's transitive (i.e. A and C are necessarily duplicates).
      Cython is the original version used in pairtools since its beginning. It is
      available for backwards compatibility and to allow specification of the column
      order. Now the default scipy backend is generally the fastest, and with chunksize
      below 1 mln has the lowest memory requirements. [dedup option]"
    inputBinding:
      position: 102
      prefix: --backend
  - id: c1
    type:
      - 'null'
      - string
    doc: Chrom 1 column; default chrom1[input format option]
    default: chrom1
    inputBinding:
      position: 102
      prefix: --c1
  - id: c2
    type:
      - 'null'
      - string
    doc: Chrom 2 column; default chrom2[input format option]
    default: chrom2
    inputBinding:
      position: 102
      prefix: --c2
  - id: carryover
    type:
      - 'null'
      - int
    doc: Number of deduped pairs to carry over from previous chunk to the new 
      chunk to avoid breaking duplicate clusters. Only works with '--backend 
      scipy or sklearn'. [dedup option]
    default: 100
    inputBinding:
      position: 102
      prefix: --carryover
  - id: chrom_subset
    type:
      - 'null'
      - File
    doc: 'A path to a chromosomes file (tab-separated, 1st column contains chromosome
      names) containing a chromosome subset of interest for stats filter. If provided,
      additionally filter pairs with both sides originating from the provided subset
      of chromosomes. This operation modifies the #chromosomes: and #chromsize: header
      fields accordingly. Note that this will not change the deduplicated output pairs.
      [output stats filtering option]'
    inputBinding:
      position: 102
      prefix: --chrom-subset
  - id: chunksize
    type:
      - 'null'
      - int
    doc: Number of pairs in each chunk. Reduce for lower memory footprint. Below
      10,000 performance starts suffering significantly and the algorithm might 
      miss a few duplicates with non-zero --max-mismatch. Only works with 
      '--backend scipy or sklearn'. [dedup option]
    default: 10000
    inputBinding:
      position: 102
      prefix: --chunksize
  - id: cmd_in
    type:
      - 'null'
      - string
    doc: 'A command to decompress the input file. If provided, fully overrides the
      auto-guessed command. Does not work with stdin and pairtools parse. Must read
      input from stdin and print output into stdout. EXAMPLE: pbgzip -dc -n 3'
    inputBinding:
      position: 102
      prefix: --cmd-in
  - id: cmd_out
    type:
      - 'null'
      - string
    doc: 'A command to compress the output file. If provided, fully overrides the
      auto-guessed command. Does not work with stdout. Must read input from stdin
      and print output into stdout. EXAMPLE: pbgzip -c -n 8'
    inputBinding:
      position: 102
      prefix: --cmd-out
  - id: engine
    type:
      - 'null'
      - string
    doc: Engine for regular expression parsing for stats filtering. Python will 
      provide you regex functionality, while pandas does not accept custom 
      funtctions and works faster. [output stats filtering option]
    inputBinding:
      position: 102
      prefix: --engine
  - id: extra_col_pair
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Extra columns that also must match for two pairs to be marked as duplicates.
      Can be either provided as 0-based column indices or as column names (requires
      the "#columns" header field). The option can be provided multiple times if multiple
      column pairs must match. Example: --extra-col-pair "phase1" "phase2". [output
      format option]'
    inputBinding:
      position: 102
      prefix: --extra-col-pair
  - id: filter
    type:
      - 'null'
      - type: array
        items: string
    doc: "Filter stats with condition to apply to the data (similar to `pairtools
      select` or `pairtools stats`). For non-YAML output only the first filter will
      be reported. [output stats filtering option] Note that this will not change
      the deduplicated output pairs. Example: pairtools dedup --yaml --filter 'unique:(pair_type==\"\
      UU\")' --filter 'close:(pair_type==\"UU\") and (abs(pos1-pos2)<10)' --output-stats
      - test.pairs"
    inputBinding:
      position: 102
      prefix: --filter
  - id: keep_parent_id
    type:
      - 'null'
      - boolean
    doc: If specified, duplicate pairs are marked with the readID of the 
      retained deduped read in the 'parent_readID' field. [output format option]
    inputBinding:
      position: 102
      prefix: --keep-parent-id
  - id: mark_dups
    type:
      - 'null'
      - boolean
    doc: Specify if duplicate pairs should be marked as DD in "pair_type" and as
      a duplicate in the sam entries. True by default. [output format option]
    inputBinding:
      position: 102
      prefix: --mark-dups
  - id: max_mismatch
    type:
      - 'null'
      - int
    doc: Pairs with both sides mapped within this distance (bp) from each other 
      are considered duplicates. [dedup option]
    default: 3
    inputBinding:
      position: 102
      prefix: --max-mismatch
  - id: method
    type:
      - 'null'
      - string
    doc: define the mismatch as either the max or the sum of the mismatches 
      ofthe genomic locations of the both sides of the two compared molecules. 
      [dedup option]
    default: max
    inputBinding:
      position: 102
      prefix: --method
  - id: n_proc
    type:
      - 'null'
      - int
    doc: Number of cores to use. Only applies with sklearn backend.Still needs 
      testing whether it is ever useful. [dedup option]
    inputBinding:
      position: 102
      prefix: --n-proc
  - id: no_mark_dups
    type:
      - 'null'
      - boolean
    doc: Specify if duplicate pairs should be marked as DD in "pair_type" and as
      a duplicate in the sam entries. True by default. [output format option]
    inputBinding:
      position: 102
      prefix: --no-mark-dups
  - id: no_yaml
    type:
      - 'null'
      - boolean
    doc: Output stats in yaml format instead of table. [output stats format 
      option]
    inputBinding:
      position: 102
      prefix: --no-yaml
  - id: nproc_in
    type:
      - 'null'
      - int
    doc: Number of processes used by the auto-guessed input decompressing 
      command.
    default: 3
    inputBinding:
      position: 102
      prefix: --nproc-in
  - id: nproc_out
    type:
      - 'null'
      - int
    doc: Number of processes used by the auto-guessed output compressing 
      command.
    default: 8
    inputBinding:
      position: 102
      prefix: --nproc-out
  - id: p1
    type:
      - 'null'
      - string
    doc: Position 1 column; default pos1[input format option]
    default: pos1
    inputBinding:
      position: 102
      prefix: --p1
  - id: p2
    type:
      - 'null'
      - string
    doc: Position 2 column; default pos2[input format option]
    default: pos2
    inputBinding:
      position: 102
      prefix: --p2
  - id: s1
    type:
      - 'null'
      - string
    doc: Strand 1 column; default strand1[input format option]
    default: strand1
    inputBinding:
      position: 102
      prefix: --s1
  - id: s2
    type:
      - 'null'
      - string
    doc: Strand 2 column; default strand2[input format option]
    default: strand2
    inputBinding:
      position: 102
      prefix: --s2
  - id: send_header_to
    type:
      - 'null'
      - string
    doc: Which of the outputs should receive header and comment lines. [input 
      format option]
    inputBinding:
      position: 102
      prefix: --send-header-to
  - id: sep
    type:
      - 'null'
      - string
    doc: Separator (\t, \v, etc. characters are supported, pass them in quotes).
      [input format option]
    inputBinding:
      position: 102
      prefix: --sep
  - id: startup_code
    type:
      - 'null'
      - string
    doc: An auxiliary code to execute before filteringfor stats. Use to define 
      functions that can be evaluated in the CONDITION statement. [output stats 
      filtering option]
    inputBinding:
      position: 102
      prefix: --startup-code
  - id: type_cast
    type:
      - 'null'
      - type: array
        items: string
    doc: Cast a given column to a given type for stats filtering. By default, 
      only pos and mapq are cast to int, other columns are kept as str. Provide 
      as -t <column_name> <type>, e.g. -t read_len1 int. Multiple entries are 
      allowed. [output stats filtering option]
    inputBinding:
      position: 102
      prefix: --type-cast
  - id: unmapped_chrom
    type:
      - 'null'
      - string
    doc: Placeholder for a chromosome on an unmapped side; default !
    default: '!'
    inputBinding:
      position: 102
      prefix: --unmapped-chrom
  - id: yaml
    type:
      - 'null'
      - boolean
    doc: Output stats in yaml format instead of table. [output stats format 
      option]
    inputBinding:
      position: 102
      prefix: --yaml
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file for pairs after duplicate removal. If the path ends with 
      .gz or .lz4, the output is bgzip-/lz4c-compressed. By default, the output 
      is printed into stdout.
    outputBinding:
      glob: $(inputs.output_file)
  - id: output_dups
    type:
      - 'null'
      - File
    doc: output file for duplicated pairs. If the path ends with .gz or .lz4, 
      the output is bgzip-/lz4c-compressed. If the path is the same as in 
      --output or -, output duplicates together with deduped pairs. By default, 
      duplicates are dropped.
    outputBinding:
      glob: $(inputs.output_dups)
  - id: output_unmapped
    type:
      - 'null'
      - File
    doc: output file for unmapped pairs. If the path ends with .gz or .lz4, the 
      output is bgzip-/lz4c-compressed. If the path is the same as in --output 
      or -, output unmapped pairs together with deduped pairs. If the path is 
      the same as --output-dups, output unmapped reads together with dups. By 
      default, unmapped pairs are dropped.
    outputBinding:
      glob: $(inputs.output_unmapped)
  - id: output_stats
    type:
      - 'null'
      - File
    doc: output file for duplicate statistics. If file exists, it will be open 
      in the append mode. If the path ends with .gz or .lz4, the output is 
      bgzip-/lz4c-compressed. By default, statistics are not printed.
    outputBinding:
      glob: $(inputs.output_stats)
  - id: output_bytile_stats
    type:
      - 'null'
      - File
    doc: output file for duplicate statistics. Note that the readID should be 
      provided and contain tile information for this option. This analysis is 
      possible when pairtools is run on a dataset with original 
      Illumina-generated read IDs, because SRA does not store original read IDs 
      from the sequencer. By default, by-tile duplicate statistics are not 
      printed. If file exists, it will be open in the append mode. If the path 
      ends with .gz or .lz4, the output is bgzip-/lz4c-compressed.
    outputBinding:
      glob: $(inputs.output_bytile_stats)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pairtools:1.1.3--py310h4e61836_0
