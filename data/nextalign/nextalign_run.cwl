cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nextalign
  - run
label: nextalign_run
doc: "Run alignment and translation.\n\nTool homepage: https://github.com/nextstrain/nextclade/tree/master/packages/nextalign_cli"
inputs:
  - id: input_fastas
    type:
      - 'null'
      - type: array
        items: File
    doc: "Path to one or multiple FASTA files with input sequences\n\nSupports the
      following compression formats: \"gz\", \"bz2\", \"xz\", \"zstd\". If no files\n\
      provided, the plain fasta input is read from standard input (stdin).\n\nSee:
      https://en.wikipedia.org/wiki/FASTA_format"
    inputBinding:
      position: 1
  - id: excess_bandwidth
    type:
      - 'null'
      - int
    doc: Excess bandwidth for internal stripes
    inputBinding:
      position: 102
      prefix: --excess-bandwidth
  - id: gap_alignment_side
    type:
      - 'null'
      - string
    doc: "Whether to align gaps on the left or right side if equally parsimonious.
      Left aligning\ngaps is the convention, right align is Nextclade's historic default\n\
      \n[possible values: left, right]"
    inputBinding:
      position: 102
      prefix: --gap-alignment-side
  - id: genes
    type:
      - 'null'
      - type: array
        items: string
    doc: "Comma-separated list of names of genes to use.\n\nThis defines which peptides
      will be written into outputs, and which genes will be taken\ninto account during
      codon-aware alignment. Must only contain gene names present in the\ngene map.
      If this flag is not supplied or its value is an empty string, then all genes\n\
      found in the gene map will be used.\n\nRequires `--input-gene-map` to be specified."
    inputBinding:
      position: 102
      prefix: --genes
  - id: in_order
    type:
      - 'null'
      - boolean
    doc: "Emit output sequences in-order.\n\nWith this flag the program will wait
      for results from the previous sequences to be\nwritten to the output files before
      writing the results of the next sequences, preserving\nthe same order as in
      the input file. Due to variable sequence processing times, this\nmight introduce
      unnecessary waiting times, but ensures that the resulting sequences are\nwritten
      in the same order as they occur in the inputs (except for sequences which have\n\
      errors). By default, without this flag, processing might happen out of order,
      which is\nfaster, due to the elimination of waiting, but might also lead to
      results written out of\norder - the order of results is not specified and depends
      on thread scheduling and\nprocessing times of individual sequences.\n\nThis
      option is only relevant when `--jobs` is greater than 1 or is omitted.\n\nNote:
      the sequences which trigger errors during processing will be omitted from outputs,\n\
      regardless of this flag."
    inputBinding:
      position: 102
      prefix: --in-order
  - id: include_reference
    type:
      - 'null'
      - boolean
    doc: "Whether to include aligned reference nucleotide sequence into output nucleotide
      sequence\nFASTA file and reference peptides into output peptide FASTA files"
    inputBinding:
      position: 102
      prefix: --include-reference
  - id: input_gene_map
    type:
      - 'null'
      - File
    doc: "Path to a .gff file containing the gene map (genome annotation).\n\nGene
      map (sometimes also called 'genome annotation') is used to find coding regions.
      If\nnot supplied, coding regions will not be translated, amino acid sequences
      will not be\noutput, and nucleotide sequence alignment will not be informed
      by codon boundaries\n\nList of genes can be restricted using `--genes` flag.
      Otherwise all genes found in the\ngene map will be used.\n\nLearn more about
      Generic Feature Format Version 3 (GFF3):\nhttps://github.com/The-Sequence-Ontology/Specifications/blob/master/gff3.md\n\
      \nSupports the following compression formats: \"gz\", \"bz2\", \"xz\", \"zstd\"\
      . Use \"-\" to read\nuncompressed data from standard input (stdin)."
    inputBinding:
      position: 102
      prefix: --input-gene-map
  - id: input_ref
    type: File
    doc: "Path to a FASTA file containing reference sequence. This file should contain
      exactly 1\nsequence.\n\nSupports the following compression formats: \"gz\",
      \"bz2\", \"xz\", \"zstd\". Use \"-\" to read\nuncompressed data from standard
      input (stdin)."
    inputBinding:
      position: 102
      prefix: --input-ref
  - id: jobs
    type:
      - 'null'
      - int
    doc: Number of processing jobs. If not specified, all available CPU threads 
      will be used
    default: 20
    inputBinding:
      position: 102
      prefix: --jobs
  - id: max_indel
    type:
      - 'null'
      - int
    doc: "Maximum length of insertions or deletions allowed to proceed with alignment.
      Alignments\nwith long indels are slow to compute and require substantial memory
      in the current\nimplementation. Alignment of sequences with indels longer that
      this value, will not be\nattempted and a warning will be emitted"
    inputBinding:
      position: 102
      prefix: --max-indel
  - id: min_length
    type:
      - 'null'
      - int
    doc: "Minimum length of nucleotide sequence to consider for alignment.\n\nIf a
      sequence is shorter than that, alignment will not be attempted and a warning
      will\nbe emitted. When adjusting this parameter, note that alignment of short
      sequences can be\nunreliable."
    inputBinding:
      position: 102
      prefix: --min-length
  - id: min_match_rate
    type:
      - 'null'
      - float
    doc: Minimum seed mathing rate (a ratio of seed matches to total number of 
      attempted seeds)
    inputBinding:
      position: 102
      prefix: --min-match-rate
  - id: min_seeds
    type:
      - 'null'
      - int
    doc: "Minimum number of seeds to search for during nucleotide alignment. Relevant
      for short\nsequences. In long sequences, the number of seeds is determined by
      `--seed-spacing`"
    inputBinding:
      position: 102
      prefix: --min-seeds
  - id: mismatches_allowed
    type:
      - 'null'
      - int
    doc: Maximum number of mismatching nucleotides allowed for a seed to be 
      considered a match
    inputBinding:
      position: 102
      prefix: --mismatches-allowed
  - id: no_translate_past_stop
    type:
      - 'null'
      - boolean
    doc: "If this flag is present, the amino acid sequences will be truncated at the
      first stop\ncodon, if mutations or sequencing errors cause premature stop codons
      to be present. No\namino acid mutations in the truncated region will be recorded"
    inputBinding:
      position: 102
      prefix: --no-translate-past-stop
  - id: output_basename
    type:
      - 'null'
      - string
    doc: "Set the base filename to use for output files.\n\nBy default the base filename
      is extracted from the input sequences file (provided with\n`--input-fasta`).\n\
      \nOnly valid together with `--output-all` flag."
    inputBinding:
      position: 102
      prefix: --output-basename
  - id: output_selection
    type:
      - 'null'
      - type: array
        items: string
    doc: "Restricts outputs for `--output-all` flag.\n\nShould contain a comma-separated
      list of names of output files to produce.\n\nIf 'all' is present in the list,
      then all other entries are ignored and all outputs are\nproduced.\n\nOnly valid
      together with `--output-all` flag.\n\n[possible values: all, fasta, translations,
      insertions, errors]"
    inputBinding:
      position: 102
      prefix: --output-selection
  - id: penalty_gap_extend
    type:
      - 'null'
      - float
    doc: "Penalty for extending a gap in alignment. If zero, all gaps regardless of
      length incur\nthe same penalty"
    inputBinding:
      position: 102
      prefix: --penalty-gap-extend
  - id: penalty_gap_open
    type:
      - 'null'
      - float
    doc: "Penalty for opening of a gap in alignment. A higher penalty results in fewer
      gaps and\nmore mismatches. Should be less than `--penalty-gap-open-in-frame`
      to avoid gaps in\ngenes"
    inputBinding:
      position: 102
      prefix: --penalty-gap-open
  - id: penalty_gap_open_in_frame
    type:
      - 'null'
      - float
    doc: "As `--penalty-gap-open`, but for opening gaps at the beginning of a codon.
      Should be\ngreater than `--penalty-gap-open` and less than `--penalty-gap-open-out-of-frame`,
      to\navoid gaps in genes, but favor gaps that align with codons"
    inputBinding:
      position: 102
      prefix: --penalty-gap-open-in-frame
  - id: penalty_gap_open_out_of_frame
    type:
      - 'null'
      - float
    doc: "As `--penalty-gap-open`, but for opening gaps in the body of a codon. Should
      be greater\nthan `--penalty-gap-open-in-frame` to favor gaps that align with
      codons"
    inputBinding:
      position: 102
      prefix: --penalty-gap-open-out-of-frame
  - id: penalty_mismatch
    type:
      - 'null'
      - float
    doc: "Penalty for aligned nucleotides or amino acids that differ in state during
      alignment.\nNote that this is redundantly parameterized with `--score-match`"
    inputBinding:
      position: 102
      prefix: --penalty-mismatch
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Make console output more quiet. Add multiple occurrences to make output
      even more quiet
    inputBinding:
      position: 102
      prefix: --quiet
  - id: replace_unknown
    type:
      - 'null'
      - boolean
    doc: "Replace unknown nucleotide characters with 'N'\n\nBy default, the sequences
      containing unknown nucleotide nucleotide characters are\nskipped with a warning
      - they are not aligned and not included into results. If this\nflag is provided,
      then before the alignment, all unknown characters are replaced with\n'N'. This
      replacement allows to align these sequences.\n\nThe following characters are
      considered known:  '-', 'A', 'B', 'C', 'D', 'G', 'H', 'K',\n'M', 'N', 'R', 'S',
      'T', 'V', 'W', 'Y'"
    inputBinding:
      position: 102
      prefix: --replace-unknown
  - id: retry_reverse_complement
    type:
      - 'null'
      - boolean
    doc: Retry seed matching step with a reverse complement if the first attempt
      failed
    inputBinding:
      position: 102
      prefix: --retry-reverse-complement
  - id: score_match
    type:
      - 'null'
      - float
    doc: Score for matching states in nucleotide or amino acid alignments
    inputBinding:
      position: 102
      prefix: --score-match
  - id: seed_length
    type:
      - 'null'
      - int
    doc: "k-mer length to determine approximate alignments between query and reference
      and\ndetermine the bandwidth of the banded alignment"
    inputBinding:
      position: 102
      prefix: --seed-length
  - id: seed_spacing
    type:
      - 'null'
      - int
    doc: Spacing between seeds during nucleotide alignment
    inputBinding:
      position: 102
      prefix: --seed-spacing
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Disable all console output. Same as `--verbosity=off`
    inputBinding:
      position: 102
      prefix: --silent
  - id: terminal_bandwidth
    type:
      - 'null'
      - int
    doc: Excess bandwidth for terminal stripes
    inputBinding:
      position: 102
      prefix: --terminal-bandwidth
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Make console output more verbose. Add multiple occurrences to increase 
      verbosity further
    inputBinding:
      position: 102
      prefix: --verbose
  - id: verbosity
    type:
      - 'null'
      - string
    doc: "Set verbosity level of console output [default: warn]\n\n[possible values:
      off, error, warn, info, debug, trace]"
    default: warn
    inputBinding:
      position: 102
      prefix: --verbosity
outputs:
  - id: output_all
    type:
      - 'null'
      - Directory
    doc: "Produce all of the output files into this directory, using default basename
      and\npredefined suffixes and extensions. This is equivalent to specifying each
      of the\nindividual `--output-*` flags. Convenient when you want to receive all
      or most of output\nfiles into the same directory and don't care about their
      filenames.\n\nOutput files can be optionally included or excluded using `--output-selection`
      flag. The\nbase filename can be set using `--output-basename` flag.\n\nIf both
      the `--output-all` and individual `--output-*` flags are provided, each\nindividual
      flag overrides the corresponding default output path.\n\nAt least one of the
      output flags is required: `--output-all`, `--output-fasta`,\n`--output-translations`,
      `--output-insertions`, `--output-errors`\n\nIf the required directory tree does
      not exist, it will be created."
    outputBinding:
      glob: $(inputs.output_all)
  - id: output_fasta
    type:
      - 'null'
      - File
    doc: "Path to output FASTA file with aligned sequences.\n\nTakes precedence over
      paths configured with `--output-all`, `--output-basename` and\n`--output-selection`.\n\
      \nIf the provided file path ends with one of the supported extensions: \"gz\"\
      , \"bz2\", \"xz\",\n\"zstd\", then the file will be written compressed. Use
      \"-\" to write the uncompressed to\nstandard output (stdout).\n\nIf the required
      directory tree does not exist, it will be created."
    outputBinding:
      glob: $(inputs.output_fasta)
  - id: output_translations
    type:
      - 'null'
      - File
    doc: "Template string for path to output fasta files containing translated and
      aligned\npeptides. A separate file will be generated for every gene. The string
      should contain\ntemplate variable `{gene}`, where the gene name will be substituted.
      Make sure you\nproperly quote and/or escape the curly braces, so that your shell,
      programming language\nor pipeline manager does not attempt to substitute the
      variables.\n\nTakes precedence over paths configured with `--output-all`, `--output-basename`
      and\n`--output-selection`.\n\nIf the provided file path ends with one of the
      supported extensions: \"gz\", \"bz2\", \"xz\",\n\"zstd\", then the file will
      be written compressed. Use \"-\" to write the uncompressed to\nstandard output
      (stdout).\n\nIf the required directory tree does not exist, it will be created.\n\
      \nExample for bash shell:\n\n--output-translations='output_dir/gene_{gene}.translation.fasta'"
    outputBinding:
      glob: $(inputs.output_translations)
  - id: output_insertions
    type:
      - 'null'
      - File
    doc: "Path to output CSV file that contain insertions stripped from the reference
      alignment.\n\nTakes precedence over paths configured with `--output-all`, `--output-basename`
      and\n`--output-selection`.\n\nIf the provided file path ends with one of the
      supported extensions: \"gz\", \"bz2\", \"xz\",\n\"zstd\", then the file will
      be written compressed. Use \"-\" to write the uncompressed to\nstandard output
      (stdout).\n\nIf the required directory tree does not exist, it will be created."
    outputBinding:
      glob: $(inputs.output_insertions)
  - id: output_errors
    type:
      - 'null'
      - File
    doc: "Path to output CSV file containing errors and warnings occurred during processing\n\
      \nTakes precedence over paths configured with `--output-all`, `--output-basename`
      and\n`--output-selection`.\n\nIf the provided file path ends with one of the
      supported extensions: \"gz\", \"bz2\", \"xz\",\n\"zstd\", then the file will
      be written compressed. Use \"-\" to write the uncompressed to\nstandard output
      (stdout).\n\nIf the required directory tree does not exist, it will be created."
    outputBinding:
      glob: $(inputs.output_errors)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextalign:2.14.0--h9ee0642_1
