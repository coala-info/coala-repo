cwlVersion: v1.2
class: CommandLineTool
baseCommand: gffcompare
label: gffcompare
doc: "GffCompare provides classification and reference annotation mapping and matching statistics for RNA-Seq assemblies (transfrags) or other generic GFF/GTF files. It also clusters and tracks transcripts across multiple GFF/GTF files, writing matching transcripts into <outprefix>.tracking and a nonredundant combined GTF.\n\nTool homepage: https://github.com/gpertea/gffcompare"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Query GTF/GFF files (use this or input_list)."
    inputBinding:
      position: 200
  - id: input_list
    type:
      - 'null'
      - File
    doc: "text file with a list of query GTF files to process instead of expecting them as command line arguments"
    inputBinding:
      position: 101
      prefix: -i
  - id: reference_annotation
    type:
      - 'null'
      - File
    doc: reference annotation file (GTF/GFF)
    inputBinding:
      position: 101
      prefix: -r
  - id: output_prefix
    type: string
    default: gffcmp
    doc: "prefix of the output files (default gffcmp)"
    inputBinding:
      position: 101
      prefix: -o
  - id: genome_sequences
    type:
      - 'null'
      - File
    doc: "genome sequences as a multi-FASTA file (repeats must be soft-masked to classify transfrags as repeats)"
    inputBinding:
      position: 101
      prefix: -s
  - id: genome_directory
    type:
      - 'null'
      - Directory
    doc: "directory containing single-fasta files, one for each contig (use instead of genome_sequences)"
    inputBinding:
      position: 101
      prefix: -s
  - id: terminal_exon_range
    type:
      - 'null'
      - int
    doc: "maximum range variation allowed for the free ends of terminal exons when estimating exon level accuracy (default 100)"
    inputBinding:
      position: 101
      prefix: -e
  - id: tss_distance
    type:
      - 'null'
      - int
    doc: "max. distance (range) for grouping transcript start sites (default 100)"
    inputBinding:
      position: 101
      prefix: -d
  - id: novel_junctions_file
    type:
      - 'null'
      - string
    doc: "if a reference is given, write novel junctions to this file"
    inputBinding:
      position: 101
      prefix: -j
  - id: consensus_prefix
    type:
      - 'null'
      - string
    doc: "name prefix for consensus transcripts in the combined GTF file (default TCONS)"
    inputBinding:
      position: 101
      prefix: -p
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "verbose processing mode (also shows GFF parser warnings)"
    inputBinding:
      position: 101
      prefix: -V
  - id: only_overlapping_reference
    type:
      - 'null'
      - boolean
    doc: "for -r option, consider only the reference transcripts that overlap any of the input transfrags (Sn correction)"
    inputBinding:
      position: 101
      prefix: -R
  - id: only_overlapping_query
    type:
      - 'null'
      - boolean
    doc: "for -r option, consider only the input transcripts that overlap any of the reference transcripts (Precision correction); this discards all novel loci"
    inputBinding:
      position: 101
      prefix: -Q
  - id: discard_single_exon
    type:
      - 'null'
      - boolean
    doc: "discard (ignore) single-exon transfrags and reference transcripts"
    inputBinding:
      position: 101
      prefix: -M
  - id: discard_single_exon_reference
    type:
      - 'null'
      - boolean
    doc: "discard (ignore) single-exon reference transcripts"
    inputBinding:
      position: 101
      prefix: -N
  - id: discard_duplicates
    type:
      - 'null'
      - boolean
    doc: "discard duplicate query transfrags (same intron chain) within a single sample; automatically enabled when multiple query files are given"
    inputBinding:
      position: 101
      prefix: -D
  - id: strict_duplicates
    type:
      - 'null'
      - boolean
    doc: "when -D is enabled (or multiple query files are given), perform a more strict duplicate check: only discard matching query transcripts from the same sample if their boundaries are contained within (or same with) matching transcripts"
    inputBinding:
      position: 101
      prefix: -S
  - id: no_exon_merge
    type:
      - 'null'
      - boolean
    doc: "disable close-exon merging (by default exons separated by introns shorter than 5 bases are merged)"
    inputBinding:
      position: 101
      prefix: --no-exon-merge
  - id: strict_match
    type:
      - 'null'
      - boolean
    doc: "transcript matching takes into account the -e range for terminal exons; code '=' is only assigned if transcript ends are within that range, otherwise code '~'"
    inputBinding:
      position: 101
      prefix: --strict-match
  - id: cds_match
    type:
      - 'null'
      - boolean
    doc: "validate CDS chain matching for '=' and '~' cases; adds classification codes ':' and '_'"
    inputBinding:
      position: 101
      prefix: --cds-match
  - id: no_tmap_refmap
    type:
      - 'null'
      - boolean
    doc: "do not generate .tmap and .refmap files for each input file"
    inputBinding:
      position: 101
      prefix: -T
  - id: chr_stats
    type:
      - 'null'
      - boolean
    doc: "the .stats file shows summary and accuracy data per reference contig/chromosome"
    inputBinding:
      position: 101
      prefix: --chr-stats
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "enables -V and generates additional files: Q_discarded.lst, missed_introns.gff, R_missed.lst"
    inputBinding:
      position: 101
      prefix: --debug
  - id: collapse_contained
    type:
      - 'null'
      - boolean
    doc: "discard matching and contained transfrags in the combined GTF output (collapse intron-redundant transfrags across all query files)"
    inputBinding:
      position: 101
      prefix: -C
  - id: collapse_keep_alt_tss
    type:
      - 'null'
      - boolean
    doc: "like -C but does not discard intron-redundant transfrags if they start with a different 5' exon (possible alternate TSS)"
    inputBinding:
      position: 101
      prefix: -A
  - id: collapse_contained_sticking_out
    type:
      - 'null'
      - boolean
    doc: "like -C but also discard contained transfrags even when transfrag ends stick out within the container's introns (by at most 50 bases)"
    inputBinding:
      position: 101
      prefix: -X
  - id: cset
    type:
      - 'null'
      - boolean
    doc: "for -C/-A/-X also discard single exon transfrags when fully contained in an exon of a multi-exon transfrag"
    inputBinding:
      position: 101
      prefix: --cset
  - id: keep_reference_matches
    type:
      - 'null'
      - boolean
    doc: "for -C/-A/-X, do not discard any redundant transfrag matching a reference"
    inputBinding:
      position: 101
      prefix: -K
outputs:
  - id: stats_file
    type: File
    doc: summary statistics
    outputBinding:
      glob: $(inputs.output_prefix).stats
  - id: loci_file
    type:
      - 'null'
      - File
    doc: super-loci file
    outputBinding:
      glob: $(inputs.output_prefix).loci
  - id: tracking_file
    type:
      - 'null'
      - File
    doc: transcript tracking across the query files
    outputBinding:
      glob: $(inputs.output_prefix).tracking
  - id: combined_gtf
    type:
      - 'null'
      - File
    doc: nonredundant set of transcripts across all query files
    outputBinding:
      glob: $(inputs.output_prefix).combined.gtf
  - id: novel_junctions
    type:
      - 'null'
      - File
    doc: novel junctions, written with novel_junctions_file when a reference is given
    outputBinding:
      glob: $(inputs.novel_junctions_file)
  - id: output_files
    type:
      type: array
      items: File
    doc: all files written with the output prefix, including .tmap, .refmap and .annotated.gtf files
    outputBinding:
      glob: $(inputs.output_prefix).*
  - id: stdout
    type: stdout
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gffcompare:0.12.10--h9948957_0
stdout: gffcompare.out
