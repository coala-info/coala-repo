cwlVersion: v1.2
class: CommandLineTool
baseCommand: tRNAscan-SE
label: trnascan-se
doc: "Scan a sequence file for tRNAs (tRNAscan-SE 2.0.12, Infernal and tRNA covariance models).\n\nTool homepage: http://lowelab.ucsc.edu/tRNAscan-SE/"
inputs:
  - id: input_file
    type: File
    doc: "Input FASTA file"
    inputBinding:
      position: 1
  - id: eukaryotic
    type:
      - 'null'
      - boolean
    doc: "Search for eukaryotic tRNAs (default)"
    inputBinding:
      position: 102
      prefix: -E
  - id: bacterial
    type:
      - 'null'
      - boolean
    doc: "Search for bacterial tRNAs"
    inputBinding:
      position: 102
      prefix: -B
  - id: archaeal
    type:
      - 'null'
      - boolean
    doc: "Search for archaeal tRNAs"
    inputBinding:
      position: 102
      prefix: -A
  - id: mito_model
    type:
      - 'null'
      - string
    doc: "Search for mitochondrial tRNAs (options: mammal, vert)"
    inputBinding:
      position: 102
      prefix: -M
  - id: other_organellar
    type:
      - 'null'
      - boolean
    doc: "Search for other organellar tRNAs"
    inputBinding:
      position: 102
      prefix: -O
  - id: general
    type:
      - 'null'
      - boolean
    doc: "Use general tRNA model (cytosolic tRNAs from all 3 domains included)"
    inputBinding:
      position: 102
      prefix: -G
  - id: mt
    type:
      - 'null'
      - string
    doc: "Use mito tRNA models for cytosolic/mito determination"
    inputBinding:
      position: 102
      prefix: --mt
  - id: infernal
    type:
      - 'null'
      - boolean
    doc: "Search using Infernal"
    inputBinding:
      position: 102
      prefix: -I
  - id: max
    type:
      - 'null'
      - boolean
    doc: "Maximum sensitivity mode - search using Infernal without hmm filter (very slow)"
    inputBinding:
      position: 102
      prefix: --max
  - id: legacy
    type:
      - 'null'
      - boolean
    doc: "Search using the legacy method (tRNAscan, EufindtRNA, and COVE)"
    inputBinding:
      position: 102
      prefix: -L
  - id: cove
    type:
      - 'null'
      - boolean
    doc: "Search using COVE analysis only (legacy, extremely slow)"
    inputBinding:
      position: 102
      prefix: -C
  - id: breakdown
    type:
      - 'null'
      - boolean
    doc: "Show breakdown of primary and secondary structure components to covariance model bit scores"
    inputBinding:
      position: 102
      prefix: -H
  - id: nopseudo
    type:
      - 'null'
      - boolean
    doc: "Disable pseudogene checking"
    inputBinding:
      position: 102
      prefix: -D
  - id: detail
    type:
      - 'null'
      - boolean
    doc: "Display prediction outputs in detailed view"
    inputBinding:
      position: 102
      prefix: --detail
  - id: brief
    type:
      - 'null'
      - boolean
    doc: "Brief output format (no column headers)"
    inputBinding:
      position: 102
      prefix: --brief
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Use label prefix for all default output file names"
    inputBinding:
      position: 102
      prefix: -p
  - id: progress
    type:
      - 'null'
      - boolean
    doc: "Display program progress messages"
    inputBinding:
      position: 102
      prefix: -d
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Quiet mode (credits and run option selections suppressed)"
    inputBinding:
      position: 102
      prefix: -q
  - id: hitsrc
    type:
      - 'null'
      - boolean
    doc: "Show origin of hits"
    inputBinding:
      position: 102
      prefix: -y
  - id: score
    type:
      - 'null'
      - float
    doc: "Set cutoff score (in bits) for reporting tRNAs (default=20)"
    inputBinding:
      position: 102
      prefix: -X
  - id: gencode
    type:
      - 'null'
      - File
    doc: "Use alternate genetic codes specified in this file for determining tRNA type"
    inputBinding:
      position: 102
      prefix: -g
  - id: pad
    type:
      - 'null'
      - int
    doc: "Use this number of nucleotides padding when passing first-pass tRNA bounds predictions to CM analysis (default=8)"
    inputBinding:
      position: 102
      prefix: -z
  - id: len
    type:
      - 'null'
      - int
    doc: "Set max length of tRNA intron+variable region for legacy search mode (default=116bp)"
    inputBinding:
      position: 102
      prefix: --len
  - id: conf
    type:
      - 'null'
      - File
    doc: "tRNAscan-SE configuration file"
    inputBinding:
      position: 102
      prefix: -c
  - id: forceow
    type:
      - 'null'
      - boolean
    doc: "Do not prompt user before overwriting pre-existing result files"
    inputBinding:
      position: 102
      prefix: -Q
  - id: match
    type:
      - 'null'
      - string
    doc: "Search only sequences with names matching this string (may contain * or ? wildcards)"
    inputBinding:
      position: 102
      prefix: --match
  - id: search
    type:
      - 'null'
      - string
    doc: "Start search at sequence with name matching this string and continue to end of input"
    inputBinding:
      position: 102
      prefix: --search
  - id: alternate_models
    type:
      - 'null'
      - boolean
    doc: "Search for tRNAs with alternate models defined in configuration file"
    inputBinding:
      position: 102
      prefix: -U
  - id: tscan
    type:
      - 'null'
      - boolean
    doc: "Search using tRNAscan only (defaults to strict params)"
    inputBinding:
      position: 102
      prefix: -t
  - id: tmode
    type:
      - 'null'
      - string
    doc: "Explicitly set tRNAscan params: R (relaxed) or S (strict)"
    inputBinding:
      position: 102
      prefix: --tmode
  - id: nomerge
    type:
      - 'null'
      - boolean
    doc: "Keep redundant tRNAscan 1.3 hits"
    inputBinding:
      position: 102
      prefix: --nomerge
  - id: eufind
    type:
      - 'null'
      - boolean
    doc: "Search using Eukaryotic tRNA finder (EufindtRNA) only"
    inputBinding:
      position: 102
      prefix: -e
  - id: emode
    type:
      - 'null'
      - string
    doc: "Explicitly set EufindtRNA params: R, N, or S"
    inputBinding:
      position: 102
      prefix: --emode
  - id: iscore
    type:
      - 'null'
      - float
    doc: "Manually set intermediate cutoff score for EufindtRNA"
    inputBinding:
      position: 102
      prefix: --iscore
  - id: mid
    type:
      - 'null'
      - boolean
    doc: "Fast scan mode - search using Infernal with mid-level strictness of hmm filter"
    inputBinding:
      position: 102
      prefix: --mid
  - id: thread
    type:
      - 'null'
      - int
    doc: "Number of threads used for running infernal"
    inputBinding:
      position: 102
      prefix: --thread
  - id: output_path
    type:
      - 'null'
      - string
    doc: "Save final results in this file"
    inputBinding:
      position: 102
      prefix: -o
  - id: struct_path
    type:
      - 'null'
      - string
    doc: "Save tRNA secondary structures to this file"
    inputBinding:
      position: 102
      prefix: -f
  - id: isospecific_path
    type:
      - 'null'
      - string
    doc: "Save results using isotype-specific models in this file"
    inputBinding:
      position: 102
      prefix: -s
  - id: stats_path
    type:
      - 'null'
      - string
    doc: "Save statistics summary for run in this file"
    inputBinding:
      position: 102
      prefix: -m
  - id: bed_path
    type:
      - 'null'
      - string
    doc: "Save results in BED file format"
    inputBinding:
      position: 102
      prefix: -b
  - id: gff_path
    type:
      - 'null'
      - string
    doc: "Save results in GFF3 file format"
    inputBinding:
      position: 102
      prefix: -j
  - id: fasta_out_path
    type:
      - 'null'
      - string
    doc: "Save predicted tRNA sequences in FASTA file format"
    inputBinding:
      position: 102
      prefix: -a
  - id: log_path
    type:
      - 'null'
      - string
    doc: "Save log of program progress in this file"
    inputBinding:
      position: 102
      prefix: -l
  - id: verbose_out_path
    type:
      - 'null'
      - string
    doc: "Save verbose tRNAscan 1.3 output to this file"
    inputBinding:
      position: 102
      prefix: -v
  - id: fsres_path
    type:
      - 'null'
      - string
    doc: "Save first-pass scan results in tabular results format"
    inputBinding:
      position: 102
      prefix: -r
  - id: falsepos_path
    type:
      - 'null'
      - string
    doc: "Save first-pass candidate tRNAs found to be false positives by second-pass analysis"
    inputBinding:
      position: 102
      prefix: -F
  - id: missed_path
    type:
      - 'null'
      - string
    doc: "Save all seqs that do NOT have at least one tRNA prediction"
    inputBinding:
      position: 102
      prefix: --missed
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: "Save final results in this file"
    outputBinding:
      glob: $(inputs.output_path)
  - id: struct
    type:
      - 'null'
      - File
    doc: "Save tRNA secondary structures to this file"
    outputBinding:
      glob: $(inputs.struct_path)
  - id: isospecific
    type:
      - 'null'
      - File
    doc: "Save results using isotype-specific models in this file"
    outputBinding:
      glob: $(inputs.isospecific_path)
  - id: stats
    type:
      - 'null'
      - File
    doc: "Save statistics summary for run in this file"
    outputBinding:
      glob: $(inputs.stats_path)
  - id: bed
    type:
      - 'null'
      - File
    doc: "Save results in BED file format"
    outputBinding:
      glob: $(inputs.bed_path)
  - id: gff
    type:
      - 'null'
      - File
    doc: "Save results in GFF3 file format"
    outputBinding:
      glob: $(inputs.gff_path)
  - id: fasta_out
    type:
      - 'null'
      - File
    doc: "Save predicted tRNA sequences in FASTA file format"
    outputBinding:
      glob: $(inputs.fasta_out_path)
  - id: log
    type:
      - 'null'
      - File
    doc: "Save log of program progress in this file"
    outputBinding:
      glob: $(inputs.log_path)
  - id: verbose_out
    type:
      - 'null'
      - File
    doc: "Save verbose tRNAscan 1.3 output to this file"
    outputBinding:
      glob: $(inputs.verbose_out_path)
  - id: fsres
    type:
      - 'null'
      - File
    doc: "Save first-pass scan results in tabular results format"
    outputBinding:
      glob: $(inputs.fsres_path)
  - id: falsepos
    type:
      - 'null'
      - File
    doc: "Save first-pass candidate tRNAs found to be false positives by second-pass analysis"
    outputBinding:
      glob: $(inputs.falsepos_path)
  - id: missed
    type:
      - 'null'
      - File
    doc: "Save all seqs that do NOT have at least one tRNA prediction"
    outputBinding:
      glob: $(inputs.missed_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trnascan-se:2.0.12--pl5321h7b50bb2_2
