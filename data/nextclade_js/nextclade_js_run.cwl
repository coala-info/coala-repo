cwlVersion: v1.2
class: CommandLineTool
baseCommand: [nextclade, run]
label: nextclade_js_run
doc: "Run sequence analysis: alignment, mutation calling, clade assignment, quality checks and phylogenetic placement.

Tool homepage: https://github.com/nextstrain/nextclade"
inputs:
  - id: input_fastas
    type:
      - 'null'
      - type: array
        items: File
    doc: "Path to one or multiple FASTA files with input sequences"
    inputBinding:
      position: 100
  - id: input_dataset
    type:
      - 'null'
      - File
      - Directory
    doc: "Path to a directory or a zip file containing a dataset."
    inputBinding:
      position: 10
      prefix: --input-dataset
  - id: dataset_name
    type:
      - 'null'
      - string
    doc: "Name of the dataset to download and use during the run"
    inputBinding:
      position: 11
      prefix: --dataset-name
  - id: input_ref
    type:
      - 'null'
      - File
    doc: "Path to a FASTA file containing reference sequence. This file should contain exactly 1 sequence."
    inputBinding:
      position: 12
      prefix: --input-ref
  - id: input_tree
    type:
      - 'null'
      - File
    doc: "Path to Auspice JSON v2 file containing reference tree."
    inputBinding:
      position: 13
      prefix: --input-tree
  - id: input_pathogen_json
    type:
      - 'null'
      - File
    doc: "Path to a JSON file containing configuration and data specific to a pathogen."
    inputBinding:
      position: 14
      prefix: --input-pathogen-json
  - id: input_annotation
    type:
      - 'null'
      - File
    doc: "Path to a file containing genome annotation in GFF3 format."
    inputBinding:
      position: 15
      prefix: --input-annotation
  - id: cds_selection
    type:
      - 'null'
      - type: array
        items: string
    doc: "Comma-separated list of names of coding sequences (CDSes) to use."
    inputBinding:
      position: 16
      prefix: --cds-selection
      itemSeparator: ','
  - id: input_pcr_primers
    type:
      - 'null'
      - File
    doc: "Path to a CSV file containing a list of custom PCR primer sites. This information is used to report mutations in these sites."
    inputBinding:
      position: 17
      prefix: --input-pcr-primers
  - id: server
    type:
      - 'null'
      - string
    doc: "Use custom dataset server"
    inputBinding:
      position: 18
      prefix: --server
  - id: output_all
    type:
      - 'null'
      - string
    doc: "Produce all of the output files into this directory, using default basename and predefined suffixes and extensions. This is equivalent to specifying each of the individual `--output-*` flags. Convenient when you want to receive all or most of the output files into the same directory and don't care about their filenames."
    inputBinding:
      position: 19
      prefix: --output-all
  - id: output_basename
    type:
      - 'null'
      - string
    doc: "Set the base filename to use for output files."
    inputBinding:
      position: 20
      prefix: --output-basename
  - id: output_selection
    type:
      - 'null'
      - type: array
        items: string
    doc: "Restricts outputs for `--output-all` flag."
    inputBinding:
      position: 21
      prefix: --output-selection
      itemSeparator: ','
  - id: output_fasta
    type:
      - 'null'
      - string
    doc: "Path to output FASTA file with aligned sequences."
    inputBinding:
      position: 22
      prefix: --output-fasta
  - id: output_translations
    type:
      - 'null'
      - string
    doc: "Template string for path to output fasta files containing translated and aligned peptides. A separate file will be generated for every gene."
    inputBinding:
      position: 23
      prefix: --output-translations
  - id: output_ndjson
    type:
      - 'null'
      - string
    doc: "Path to output Newline-delimited JSON (NDJSON) results file."
    inputBinding:
      position: 24
      prefix: --output-ndjson
  - id: output_json
    type:
      - 'null'
      - string
    doc: "Path to output JSON results file."
    inputBinding:
      position: 25
      prefix: --output-json
  - id: output_csv
    type:
      - 'null'
      - string
    doc: "Path to output CSV results file (delimiter: semicolon)"
    inputBinding:
      position: 26
      prefix: --output-csv
  - id: output_tsv
    type:
      - 'null'
      - string
    doc: "Path to output TSV results file (delimiter: tab)"
    inputBinding:
      position: 27
      prefix: --output-tsv
  - id: output_columns_selection
    type:
      - 'null'
      - type: array
        items: string
    doc: "Restricts columns written into tabular output files (CSV and TSV)."
    inputBinding:
      position: 28
      prefix: --output-columns-selection
      itemSeparator: ','
  - id: output_graph
    type:
      - 'null'
      - string
    doc: "Path to output phylogenetic graph with input sequences placed onto it, in Nextclade graph JSON format."
    inputBinding:
      position: 29
      prefix: --output-graph
  - id: output_tree
    type:
      - 'null'
      - string
    doc: "Path to output phylogenetic tree with input sequences placed onto it, in Auspice JSON V2 format."
    inputBinding:
      position: 30
      prefix: --output-tree
  - id: output_tree_nwk
    type:
      - 'null'
      - string
    doc: "Path to output phylogenetic tree with input sequences placed onto it, in Newick format (New Hampshire tree format)"
    inputBinding:
      position: 31
      prefix: --output-tree-nwk
  - id: output_annotation_gff
    type:
      - 'null'
      - string
    doc: "Path to output annotation for query sequences in GFF3 format (EXPERIMENTAL)"
    inputBinding:
      position: 32
      prefix: --output-annotation-gff
  - id: output_annotation_tbl
    type:
      - 'null'
      - string
    doc: "Path to output annotation for query sequences in Genbank TBL format (EXPERIMENTAL)"
    inputBinding:
      position: 33
      prefix: --output-annotation-tbl
  - id: include_reference
    type:
      - 'null'
      - boolean
    doc: "Whether to include aligned reference nucleotide sequence into output nucleotide sequence FASTA file and reference peptides into output peptide FASTA files"
    inputBinding:
      position: 34
      prefix: --include-reference
  - id: include_nearest_node_info
    type:
      - 'null'
      - boolean
    doc: "Whether to include the list of nearest nodes to the outputs"
    inputBinding:
      position: 35
      prefix: --include-nearest-node-info
  - id: in_order
    type:
      - 'null'
      - boolean
    doc: "Emit output sequences in-order."
    inputBinding:
      position: 36
      prefix: --in-order
  - id: replace_unknown
    type:
      - 'null'
      - boolean
    doc: "Replace unknown nucleotide characters with 'N'"
    inputBinding:
      position: 37
      prefix: --replace-unknown
  - id: without_greedy_tree_builder
    type:
      - 'null'
      - boolean
    doc: "Disable greedy tree builder algorithm"
    inputBinding:
      position: 38
      prefix: --without-greedy-tree-builder
  - id: masked_muts_weight
    type:
      - 'null'
      - float
    doc: ""
    inputBinding:
      position: 39
      prefix: --masked-muts-weight
  - id: alignment_preset
    type:
      - 'null'
      - string
    doc: "Alignment parameter presets. EXPERIMENTAL feature subject to adjustments Possible values: - default:         Suitable for very similar sequences (this is the default) - high-diversity:  Suitable for more diverse viruses - short-sequences: Suitable for short and partial sequences"
    inputBinding:
      position: 40
      prefix: --alignment-preset
  - id: min_length
    type:
      - 'null'
      - int
    doc: "Minimum length of nucleotide sequence to consider for alignment."
    inputBinding:
      position: 41
      prefix: --min-length
  - id: penalty_gap_extend
    type:
      - 'null'
      - int
    doc: "Penalty for extending a gap in alignment. If zero, all gaps regardless of length incur the same penalty"
    inputBinding:
      position: 42
      prefix: --penalty-gap-extend
  - id: penalty_gap_open
    type:
      - 'null'
      - int
    doc: "Penalty for opening of a gap in alignment. A higher penalty results in fewer gaps and more mismatches. Should be less than `--penalty-gap-open-in-frame` to avoid gaps in genes"
    inputBinding:
      position: 43
      prefix: --penalty-gap-open
  - id: penalty_gap_open_in_frame
    type:
      - 'null'
      - int
    doc: "As `--penalty-gap-open`, but for opening gaps at the beginning of a codon. Should be greater than `--penalty-gap-open` and less than `--penalty-gap-open-out-of-frame`, to avoid gaps in genes, but favor gaps that align with codons"
    inputBinding:
      position: 44
      prefix: --penalty-gap-open-in-frame
  - id: penalty_gap_open_out_of_frame
    type:
      - 'null'
      - int
    doc: "As `--penalty-gap-open`, but for opening gaps in the body of a codon. Should be greater than `--penalty-gap-open-in-frame` to favor gaps that align with codons"
    inputBinding:
      position: 45
      prefix: --penalty-gap-open-out-of-frame
  - id: penalty_mismatch
    type:
      - 'null'
      - int
    doc: "Penalty for aligned nucleotides or amino acids that differ in state during alignment. Note that this is redundantly parameterized with `--score-match`"
    inputBinding:
      position: 46
      prefix: --penalty-mismatch
  - id: score_match
    type:
      - 'null'
      - int
    doc: "Score for matching states in nucleotide or amino acid alignments"
    inputBinding:
      position: 47
      prefix: --score-match
  - id: max_band_area
    type:
      - 'null'
      - int
    doc: "Maximum area of the band in the alignment matrix. Alignments with large bands are slow to compute and require substantial memory. Alignment of sequences requiring bands with area larger than this value, will not be attempted and a warning will be emitted"
    inputBinding:
      position: 48
      prefix: --max-band-area
  - id: retry_reverse_complement
    type:
      - 'null'
      - boolean
    doc: "Retry seed matching step with a reverse complement if the first attempt failed"
    inputBinding:
      position: 49
      prefix: --retry-reverse-complement
  - id: no_translate_past_stop
    type:
      - 'null'
      - boolean
    doc: "If this flag is present, the amino acid sequences will be truncated at the first stop codon, if mutations or sequencing errors cause premature stop codons to be present. No amino acid mutations in the truncated region will be recorded"
    inputBinding:
      position: 50
      prefix: --no-translate-past-stop
  - id: excess_bandwidth
    type:
      - 'null'
      - int
    doc: "Excess bandwidth for internal stripes"
    inputBinding:
      position: 51
      prefix: --excess-bandwidth
  - id: terminal_bandwidth
    type:
      - 'null'
      - int
    doc: "Excess bandwidth for terminal stripes"
    inputBinding:
      position: 52
      prefix: --terminal-bandwidth
  - id: gap_alignment_side
    type:
      - 'null'
      - string
    doc: "Whether to align gaps on the left or right side if equally parsimonious. Default: left"
    inputBinding:
      position: 53
      prefix: --gap-alignment-side
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: "Length of exactly matching k-mers used in the seed alignment of the query to the reference"
    inputBinding:
      position: 54
      prefix: --kmer-length
  - id: kmer_distance
    type:
      - 'null'
      - int
    doc: "Interval of successive k-mers on the query sequence. Should be small compared to the query length"
    inputBinding:
      position: 55
      prefix: --kmer-distance
  - id: allowed_mismatches
    type:
      - 'null'
      - int
    doc: "Exactly matching k-mers are extended to the left and right until more than `allowed_mismatches` are observed in a sliding window (`window_size`)"
    inputBinding:
      position: 56
      prefix: --allowed-mismatches
  - id: window_size
    type:
      - 'null'
      - int
    doc: "Size of the window within which mismatches are accumulated during seed extension"
    inputBinding:
      position: 57
      prefix: --window-size
  - id: min_match_length
    type:
      - 'null'
      - int
    doc: "Minimum length of extended k-mers"
    inputBinding:
      position: 58
      prefix: --min-match-length
  - id: min_seed_cover
    type:
      - 'null'
      - float
    doc: "Fraction of the query sequence that has to be covered by extended seeds to proceed with the banded alignment"
    inputBinding:
      position: 59
      prefix: --min-seed-cover
  - id: max_alignment_attempts
    type:
      - 'null'
      - int
    doc: "Number of times Nextclade will retry alignment with more relaxed results if alignment band boundaries are hit"
    inputBinding:
      position: 60
      prefix: --max-alignment-attempts
  - id: jobs
    type:
      - 'null'
      - int
    doc: "Number of processing jobs. If not specified, all available CPU threads will be used"
    inputBinding:
      position: 61
      prefix: --jobs
outputs:
  - id: output_all_dir
    type:
      - 'null'
      - Directory
    doc: Directory with all output files (output_all).
    outputBinding:
      glob: |-
        ${ return inputs.output_all ? inputs.output_all : null; }
  - id: aligned_fasta
    type:
      - 'null'
      - File
    doc: Aligned sequences.
    outputBinding:
      glob: |-
        ${ return inputs.output_fasta ? inputs.output_fasta : null; }
  - id: ndjson
    type:
      - 'null'
      - File
    doc: NDJSON results.
    outputBinding:
      glob: |-
        ${ return inputs.output_ndjson ? inputs.output_ndjson : null; }
  - id: json
    type:
      - 'null'
      - File
    doc: JSON results.
    outputBinding:
      glob: |-
        ${ return inputs.output_json ? inputs.output_json : null; }
  - id: csv
    type:
      - 'null'
      - File
    doc: CSV results.
    outputBinding:
      glob: |-
        ${ return inputs.output_csv ? inputs.output_csv : null; }
  - id: tsv
    type:
      - 'null'
      - File
    doc: TSV results.
    outputBinding:
      glob: |-
        ${ return inputs.output_tsv ? inputs.output_tsv : null; }
  - id: tree
    type:
      - 'null'
      - File
    doc: Auspice JSON tree with placed sequences.
    outputBinding:
      glob: |-
        ${ return inputs.output_tree ? inputs.output_tree : null; }
  - id: tree_nwk
    type:
      - 'null'
      - File
    doc: Newick tree.
    outputBinding:
      glob: |-
        ${ return inputs.output_tree_nwk ? inputs.output_tree_nwk : null; }
  - id: graph
    type:
      - 'null'
      - File
    doc: Auspice JSON graph.
    outputBinding:
      glob: |-
        ${ return inputs.output_graph ? inputs.output_graph : null; }
  - id: annotation_gff
    type:
      - 'null'
      - File
    doc: GFF annotation.
    outputBinding:
      glob: |-
        ${ return inputs.output_annotation_gff ? inputs.output_annotation_gff : null; }
  - id: annotation_tbl
    type:
      - 'null'
      - File
    doc: TBL annotation.
    outputBinding:
      glob: |-
        ${ return inputs.output_annotation_tbl ? inputs.output_annotation_tbl : null; }
  - id: translations
    type:
      - 'null'
      - type: array
        items: File
    doc: Translated peptide files (output_translations).
    outputBinding:
      glob: |-
        ${ return inputs.output_translations ? inputs.output_translations.replace('{cds}', '*') : null; }
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextclade:3.18.1--h9ee0642_0
stdout: nextclade_js_run.out
