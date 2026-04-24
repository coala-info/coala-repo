cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pairtools
  - select
label: pairtools_select
doc: "Select pairs according to some condition.\n\nTool homepage: https://github.com/mirnylab/pairtools"
inputs:
  - id: condition
    type: string
    doc: 'A Python expression; if it returns True, select the read pair. Any column
      declared in the #columns line of the pairs header can be accessed by its name.
      If the header lacks the #columns line, the columns are assumed to follow the
      .pairs/.pairsam standard (readID, chrom1, chrom2, pos1, pos2, strand1, strand2,
      pair_type). Finally, CONDITION has access to COLS list which contains the string
      values of columns. In Bash, quote CONDITION with single quotes, and use double
      quotes for string variables inside CONDITION.'
    inputBinding:
      position: 1
  - id: pairs_path
    type:
      - 'null'
      - File
    doc: input .pairs/.pairsam file. If the path ends with .gz or .lz4, the 
      input is decompressed by bgzip/lz4c. By default, the input is read from 
      stdin.
    inputBinding:
      position: 2
  - id: chrom_subset
    type:
      - 'null'
      - File
    doc: 'A path to a chromosomes file (tab-separated, 1st column contains chromosome
      names) containing a chromosome subset of interest. If provided, additionally
      filter pairs with both sides originating from the provided subset of chromosomes.
      This operation modifies the #chromosomes: and #chromsize: header fields accordingly.'
    inputBinding:
      position: 103
      prefix: --chrom-subset
  - id: cmd_in
    type:
      - 'null'
      - string
    doc: 'A command to decompress the input file. If provided, fully overrides the
      auto-guessed command. Does not work with stdin and pairtools parse. Must read
      input from stdin and print output into stdout. EXAMPLE: pbgzip -dc -n 3'
    inputBinding:
      position: 103
      prefix: --cmd-in
  - id: cmd_out
    type:
      - 'null'
      - string
    doc: 'A command to compress the output file. If provided, fully overrides the
      auto-guessed command. Does not work with stdout. Must read input from stdin
      and print output into stdout. EXAMPLE: pbgzip -c -n 8'
    inputBinding:
      position: 103
      prefix: --cmd-out
  - id: nproc_in
    type:
      - 'null'
      - int
    doc: Number of processes used by the auto-guessed input decompressing 
      command.
    inputBinding:
      position: 103
      prefix: --nproc-in
  - id: nproc_out
    type:
      - 'null'
      - int
    doc: Number of processes used by the auto-guessed output compressing 
      command.
    inputBinding:
      position: 103
      prefix: --nproc-out
  - id: remove_columns
    type:
      - 'null'
      - string
    doc: 'Comma-separated list of columns to be removed, e.g.: readID,chrom1,pos1,chrom2,pos2,strand1,strand2,pair_type,sam1,sam2,walk_pair_index,walk_pair_type'
    inputBinding:
      position: 103
      prefix: --remove-columns
  - id: startup_code
    type:
      - 'null'
      - string
    doc: An auxiliary code to execute before filtering. Use to define functions 
      that can be evaluated in the CONDITION statement
    inputBinding:
      position: 103
      prefix: --startup-code
  - id: type_cast
    type:
      - 'null'
      - type: array
        items: string
    doc: Cast a given column to a given type. By default, only pos and mapq are 
      cast to int, other columns are kept as str. Provide as -t <column_name> 
      <type>, e.g. -t read_len1 int. Multiple entries are allowed.
    inputBinding:
      position: 103
      prefix: --type-cast
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file. If the path ends with .gz or .lz4, the output is 
      bgzip-/lz4c-compressed. By default, the output is printed into stdout.
    outputBinding:
      glob: $(inputs.output_file)
  - id: output_rest
    type:
      - 'null'
      - File
    doc: output file for pairs of other types. If the path ends with .gz or 
      .lz4, the output is bgzip-/lz4c-compressed. By default, such pairs are 
      dropped.
    outputBinding:
      glob: $(inputs.output_rest)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pairtools:1.1.3--py310h4e61836_0
