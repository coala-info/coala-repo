cwlVersion: v1.2
class: CommandLineTool
baseCommand: pairtools_phase
label: pairtools_phase
doc: "Phase pairs mapped to a diploid genome. Diploid genome is the genome with\n\
  two set of the chromosome variants, where each chromosome has one of two\nsuffixes
  (phase-suffixes) corresponding to the genome version (phase-\nsuffixes).\n\nBy default,
  phasing adds two additional columns with phase 0, 1 or \".\"\n(unpahsed).\n\nPhasing
  is based on detection of chromosome origin of each mapped fragment.\nThree scores
  are considered: best alignment score (S1), suboptimal alignment\n(S2) and second
  suboptimal alignment (S3) scores. Each fragment can be: 1)\nuniquely mapped and
  phased (S1>S2>S3, first alignment is the best hit), 2)\nuniquely mapped but unphased
  (S1=S2>S3, cannot distinguish between\nchromosome variants), 3) multiply mapped
  (S1=S2=S3) or unmapped.\n\nTool homepage: https://github.com/mirnylab/pairtools"
inputs:
  - id: pairs_path
    type:
      - 'null'
      - File
    doc: input .pairs/.pairsam file. If the path ends with .gz or .lz4, the 
      input is decompressed by bgzip/lz4c. By default, the input is read from 
      stdin.
    inputBinding:
      position: 1
  - id: clean_output
    type:
      - 'null'
      - boolean
    doc: Drop all columns besides the standard ones and phase1/2
    inputBinding:
      position: 102
      prefix: --clean-output
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
  - id: no_report_scores
    type:
      - 'null'
      - boolean
    doc: Report scores of optional, suboptimal and second suboptimal alignments.
      NM (edit distance) with --tag-mode XA and AS (alfn score) with --tag-mode 
      XB
    inputBinding:
      position: 102
      prefix: --no-report-scores
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
  - id: phase_suffixes
    type:
      - 'null'
      - type: array
        items: string
    doc: Phase suffixes (of the chrom names), always a pair.
    inputBinding:
      position: 102
      prefix: --phase-suffixes
  - id: report_scores
    type:
      - 'null'
      - boolean
    doc: Report scores of optional, suboptimal and second suboptimal alignments.
      NM (edit distance) with --tag-mode XA and AS (alfn score) with --tag-mode 
      XB
    inputBinding:
      position: 102
      prefix: --report-scores
  - id: tag_mode
    type:
      - 'null'
      - string
    doc: "Specifies the mode of bwa reporting. XA will parse 'XA', the input should
      be generated with: --add-columns XA,NM,AS,XS --min-mapq 0 XB will parse 'XB'
      tag, the input should be generated with: --add-columns XB,AS,XS --min-mapq 0
      Note that XB tag is added by running bwa with -u tag, present in github version.
      Both modes report similar results: XB reports 0.002% contacts more for phased
      data, while XA can report ~1-2% more unphased contacts because its definition
      multiple mappers is more premissive."
    inputBinding:
      position: 102
      prefix: --tag-mode
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file. If the path ends with .gz or .lz4, the output is 
      bgzip-/lz4c-compressed. By default, the output is printed into stdout.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pairtools:1.1.3--py310h4e61836_0
