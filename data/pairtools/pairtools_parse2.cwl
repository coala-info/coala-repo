cwlVersion: v1.2
class: CommandLineTool
baseCommand: pairtools_parse2
label: pairtools_parse2
doc: "Extracts pairs from .sam/.bam data with complex walks, make .pairs. SAM_PATH
  : an input .sam/.bam file with paired-end or single-end sequence alignments of Hi-C
  (or Hi-C-like) molecules. If the path ends with .bam, the input is decompressed
  from bam with samtools. By default, the input is read from stdin.\n\nTool homepage:
  https://github.com/mirnylab/pairtools"
inputs:
  - id: sam_path
    type:
      - 'null'
      - File
    doc: an input .sam/.bam file with paired-end or single-end sequence 
      alignments of Hi-C (or Hi-C-like) molecules. If the path ends with .bam, 
      the input is decompressed from bam with samtools. By default, the input is
      read from stdin.
    inputBinding:
      position: 1
  - id: add_columns
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Report extra columns describing alignments Possible values (can take multiple
      values as a comma-separated list): a SAM tag (any pair of uppercase letters)
      or mapq, pos5, pos3, cigar, read_len, matched_bp, algn_ref_span, algn_read_span,
      dist_to_5, dist_to_3, seq, mismatches, read_side, algn_idx, same_side_algn_count.'
    inputBinding:
      position: 102
      prefix: --add-columns
  - id: add_pair_index
    type:
      - 'null'
      - boolean
    doc: 'If specified, parse2 will report pair index in the walk as additional columns
      (R1, R2, R1&R2 or R1-R2). See documentation: https://pairtools.readthedocs.io/en/latest/parsing.html#rescuing-complex-walks
      For combinatorial expanded pairs, two numbers will be reported: original pair
      index of the left and right segments.'
    inputBinding:
      position: 102
      prefix: --add-pair-index
  - id: assembly
    type:
      - 'null'
      - string
    doc: Name of genome assembly (e.g. hg19, mm10) to store in the pairs header.
    inputBinding:
      position: 102
      prefix: --assembly
  - id: chroms_path
    type: string
    doc: 'Chromosome order used to flip interchromosomal mates: path to a chromosomes
      file (e.g. UCSC chrom.sizes or similar) whose first column lists scaffold names.
      Any scaffolds not listed will be ordered lexicographically following the names
      provided.'
    inputBinding:
      position: 102
      prefix: --chroms-path
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
  - id: dedup_max_mismatch
    type:
      - 'null'
      - string
    doc: Allowed mismatch between intramolecular alignments to detect 
      readthrough duplicates. Pairs with both sides mapped within this distance 
      (bp) from each other are considered duplicates.
    default: 3
    inputBinding:
      position: 102
      prefix: --dedup-max-mismatch
  - id: drop_readid
    type:
      - 'null'
      - boolean
    doc: If specified, do not add read ids to the output. By default, keep read 
      ids. Useful for long walks analysis.
    inputBinding:
      position: 102
      prefix: --drop-readid
  - id: drop_sam
    type:
      - 'null'
      - boolean
    doc: Do not add sams to the output by default. Kept otherwise.
    inputBinding:
      position: 102
      prefix: --drop-sam
  - id: drop_seq
    type:
      - 'null'
      - boolean
    doc: Remove sequences and PHREDs from the sam fields by default. Kept 
      otherwise.
    inputBinding:
      position: 102
      prefix: --drop-seq
  - id: expand
    type:
      - 'null'
      - boolean
    doc: If specified, perform combinatorial expansion on the pairs. 
      Combinatorial expansion is a way to increase the number of contacts in you
      data, assuming that all DNA fragments in the same molecule (read) are in 
      contact. Expanded pairs have modified pair type, 'E{separation}_{pair 
      type}'
    inputBinding:
      position: 102
      prefix: --expand
  - id: flip
    type:
      - 'null'
      - boolean
    doc: If specified, flip pairs in genomic order and instead preserve the 
      order in which they were sequenced. Note that no flip is recommended for 
      analysis of walks because it will override the order of alignments in 
      pairs. Flip is required for appropriate deduplication of sorted pairs. 
      Flip is not required for cooler cload, which runs flipping internally.
    inputBinding:
      position: 102
      prefix: --flip
  - id: keep_readid
    type:
      - 'null'
      - boolean
    doc: If specified, do not add read ids to the output. By default, keep read 
      ids. Useful for long walks analysis.
    inputBinding:
      position: 102
      prefix: --keep-readid
  - id: keep_sam
    type:
      - 'null'
      - boolean
    doc: Do not add sams to the output by default. Kept otherwise.
    inputBinding:
      position: 102
      prefix: --keep-sam
  - id: keep_seq
    type:
      - 'null'
      - boolean
    doc: Remove sequences and PHREDs from the sam fields by default. Kept 
      otherwise.
    inputBinding:
      position: 102
      prefix: --keep-seq
  - id: max_expansion_depth
    type:
      - 'null'
      - string
    doc: Works in combination with --expand. Maximum number of segments 
      separating pair. By default, expanding all possible pairs.Setting the 
      number will limit the expansion depth and enforce contacts from the same 
      side of the read.
    inputBinding:
      position: 102
      prefix: --max-expansion-depth
  - id: max_insert_size
    type:
      - 'null'
      - string
    doc: When searching for overlapping ends of left and right read (R1 and R2),
      this sets the minimal distance when two alignments on the same strand and 
      chromosome are considered part of the same fragment (and thus reported as 
      the same alignment and not a pair). For traditional Hi-C with long 
      restriction fragments and shorter molecules after ligation+sonication, 
      this can be the expected molecule size. For complex walks with short 
      restriction fragments, this can be the expected restriction fragment size.
      Note that unsequenced insert is *terra incognita* and might contain 
      unsequenced DNA (including ligations) in it. This parameter is ignored in 
      --single-end mode.
    default: 500
    inputBinding:
      position: 102
      prefix: --max-insert-size
  - id: max_inter_align_gap
    type:
      - 'null'
      - string
    doc: Read segments that are not covered by any alignment and longer than the
      specified value are treated as "null" alignments. These null alignments 
      convert otherwise linear alignments into walks, and affect how they get 
      reported as a Hi-C pair.
    default: 20
    inputBinding:
      position: 102
      prefix: --max-inter-align-gap
  - id: min_mapq
    type:
      - 'null'
      - string
    doc: The minimal MAPQ score to consider a read as uniquely mapped.
    default: 1
    inputBinding:
      position: 102
      prefix: --min-mapq
  - id: no_expand
    type:
      - 'null'
      - boolean
    doc: If specified, perform combinatorial expansion on the pairs. 
      Combinatorial expansion is a way to increase the number of contacts in you
      data, assuming that all DNA fragments in the same molecule (read) are in 
      contact. Expanded pairs have modified pair type, 'E{separation}_{pair 
      type}'
    inputBinding:
      position: 102
      prefix: --no-expand
  - id: no_flip
    type:
      - 'null'
      - boolean
    doc: If specified, flip pairs in genomic order and instead preserve the 
      order in which they were sequenced. Note that no flip is recommended for 
      analysis of walks because it will override the order of alignments in 
      pairs. Flip is required for appropriate deduplication of sorted pairs. 
      Flip is not required for cooler cload, which runs flipping internally.
    inputBinding:
      position: 102
      prefix: --no-flip
  - id: nproc_in
    type:
      - 'null'
      - string
    doc: Number of processes used by the auto-guessed input decompressing 
      command.
    default: 3
    inputBinding:
      position: 102
      prefix: --nproc-in
  - id: nproc_out
    type:
      - 'null'
      - string
    doc: Number of processes used by the auto-guessed output compressing 
      command.
    default: 8
    inputBinding:
      position: 102
      prefix: --nproc-out
  - id: readid_transform
    type:
      - 'null'
      - string
    doc: A Python expression to modify read IDs. Useful when read IDs differ 
      between the two reads of a pair. Must be a valid Python expression that 
      uses variables called readID and/or i (the 0-based index of the read pair 
      in the bam file) and returns a new value, e.g. "readID[:-2]+'_'+str(i)". 
      Make sure that transformed readIDs remain unique!
    inputBinding:
      position: 102
      prefix: --readid-transform
  - id: report_orientation
    type:
      - 'null'
      - string
    doc: "Reported orientataion of pairs in complex walk (strand columns). Each alignment
      in .bam/.sam Hi-C-like data has orientation, and you can report it relative
      to the read, pair or whole walk coordinate system.\n\n\"pair\" - orientation
      as if each pair in complex walk was sequenced independently from the outer ends
      or molecule (as in traditional Hi-C, also complex walks default), \"read\" -
      orientation defined by the read (R1 or R2 read coordinate system), \"walk\"\
      \ - orientation defined by the walk coordinate system, \"junction\" - reversed
      \"pair\" orientation, as if pair was sequenced in both directions starting from
      the junction"
    inputBinding:
      position: 102
      prefix: --report-orientation
  - id: report_position
    type:
      - 'null'
      - string
    doc: "Reported position of alignments in pairs of complex walks (pos columns).
      Each alignment in .bam/.sam Hi-C-like data has two ends, and you can report
      one or another depending of the position of alignment on a read or in a pair.\n\
      \n\"junction\" - inner ends of sequential alignments in each pair, aka ligation
      junctions, \"read\" - 5'-end of alignments relative to R1 or R2 read coordinate
      system (as in traditional Hi-C), \"walk\" - 5'-end of alignments relative to
      the whole walk coordinate system, \"outer\" - outer ends of sequential alignments
      in each pair (parse2 default)."
    inputBinding:
      position: 102
      prefix: --report-position
  - id: single_end
    type:
      - 'null'
      - boolean
    doc: If specified, the input is single-end. Never use this for paired-end 
      data, because R1 read will be omitted. If single-end data is provided, but
      parameter is unset, the pairs will be generated, but may contain 
      artificial UN pairs.
    inputBinding:
      position: 102
      prefix: --single-end
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file with pairs. If the path ends with .gz or .lz4, the output 
      is bgzip-/lz4-compressed.By default, the output is printed into stdout.
    outputBinding:
      glob: $(inputs.output_file)
  - id: output_parsed_alignments
    type:
      - 'null'
      - File
    doc: output file with all parsed alignments (one alignment per line). Useful
      for debugging and analysis of walks. If file exists, it will be open in 
      the append mode. If the path ends with .gz or .lz4, the output is 
      bgzip-/lz4-compressed. By default, not used.
    outputBinding:
      glob: $(inputs.output_parsed_alignments)
  - id: output_stats
    type:
      - 'null'
      - File
    doc: output file for various statistics of pairs file. By default, 
      statistics is not generated.
    outputBinding:
      glob: $(inputs.output_stats)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pairtools:1.1.3--py310h4e61836_0
