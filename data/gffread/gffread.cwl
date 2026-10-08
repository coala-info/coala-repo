cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gffread
label: gffread
doc: Filter, convert or cluster GFF/GTF/BED records, extract the sequence of 
  transcripts (exon or CDS) and more.
inputs:
  - id: input_gff
    type:
      - 'null'
      - File
    doc: Input GFF/GTF/BED file
    inputBinding:
      position: 1
  - id: genomic_seqs
    type:
      - 'null'
      - File
    doc: Full path to a multi-fasta file with the genomic sequences for all 
      input mappings, OR a directory with single-fasta files (one per genomic 
      sequence, with file names matching sequence names)
    inputBinding:
      position: 102
      prefix: -g
  - id: seq_info
    type:
      - 'null'
      - File
    doc: '<seq_info.fsize> is a tab-delimited file providing info for each of the
      mapped sequences: <seq-name> <seq-length> <seq-description>'
    inputBinding:
      position: 102
      prefix: -s
  - id: outfile
    type:
      - 'null'
      - string
    doc: Write the output records into <outfile> instead of stdout
    inputBinding:
      position: 102
      prefix: -o
  - id: trackname
    type:
      - 'null'
      - string
    doc: Use <trackname> in the 2nd column of each GFF/GTF output line
    inputBinding:
      position: 102
      prefix: -t
  - id: range
    type:
      - 'null'
      - string
    doc: Only show transcripts overlapping coordinate range <start>..<end> (on 
      chromosome/contig <chr>, strand <strand> if provided)
    inputBinding:
      position: 102
      prefix: -r
  - id: range_fully_contained
    type:
      - 'null'
      - boolean
    doc: For -r option, discard all transcripts that are not fully contained 
      within the given range
    inputBinding:
      position: 102
      prefix: -R
  - id: jmatch
    type:
      - 'null'
      - string
    doc: Only output transcripts matching the given junction
    inputBinding:
      position: 102
      prefix: --jmatch
  - id: no_pseudo
    type:
      - 'null'
      - boolean
    doc: Filter out records matching the 'pseudo' keyword
    inputBinding:
      position: 102
      prefix: --no-pseudo
  - id: write_exons
    type:
      - 'null'
      - string
    doc: Write a fasta file with spliced exons for each transcript
    inputBinding:
      position: 102
      prefix: -w
  - id: write_cds
    type:
      - 'null'
      - string
    doc: Write a fasta file with spliced CDS for each GFF transcript
    inputBinding:
      position: 102
      prefix: -x
  - id: write_tr_cds
    type:
      - 'null'
      - string
    doc: Write a protein fasta file with the translation of CDS for each record
    inputBinding:
      position: 102
      prefix: -y
  - id: output_junctions
    type:
      - 'null'
      - boolean
    doc: Output the junctions and the corresponding transcripts
    inputBinding:
      position: 102
      prefix: -j
  - id: ids
    type:
      - 'null'
      - File
    doc: Discard records/transcripts if their IDs are not listed in <IDs.lst>
    inputBinding:
      position: 102
      prefix: --ids
  - id: nids
    type:
      - 'null'
      - File
    doc: Discard records/transcripts if their IDs are listed in <IDs.lst>
    inputBinding:
      position: 102
      prefix: --nids
  - id: attrs
    type:
      - 'null'
      - string
    doc: Only output the GTF/GFF attributes listed in <attr-list> which is a 
      comma delimited list of attribute names
    inputBinding:
      position: 102
      prefix: --attrs
  - id: max_intron
    type:
      - 'null'
      - int
    doc: Discard transcripts having an intron larger than <maxintron>
    inputBinding:
      position: 102
      prefix: -i
  - id: min_len
    type:
      - 'null'
      - int
    doc: Discard transcripts shorter than <minlen> bases
    inputBinding:
      position: 102
      prefix: -l
  - id: stream
    type:
      - 'null'
      - boolean
    doc: Fast processing of input GFF/BED transcripts as they are received (no 
      sorting, exons must be grouped by transcript in the input data)
    inputBinding:
      position: 102
      prefix: --stream
  - id: bed
    type:
      - 'null'
      - boolean
    doc: Output records in BED format instead of default GFF3
    inputBinding:
      position: 102
      prefix: --bed
  - id: gtf
    type:
      - 'null'
      - boolean
    doc: Main output will be GTF instead of GFF3
    inputBinding:
      position: 102
      prefix: -T
  - id: tlf
    type:
      - 'null'
      - boolean
    doc: Output "transcript line format" which is like GFF but with exons and 
      CDS related features stored as GFF attributes in the transcript feature 
      line
    inputBinding:
      position: 102
      prefix: --tlf
  - id: table
    type:
      - 'null'
      - string
    doc: Output a simple tab delimited format instead of GFF, with columns 
      having the values of GFF attributes given in <attrlist>
    inputBinding:
      position: 102
      prefix: --table
  - id: sort_by
    type:
      - 'null'
      - File
    doc: Sort the reference sequences by the order in which their names are 
      given in the <refseq.lst> file
    inputBinding:
      position: 102
      prefix: --sort-by
  - id: discard_single_exon
    type:
      - 'null'
      - boolean
    doc: Discard single-exon transcripts
    inputBinding:
      position: 102
      prefix: -U
  - id: coding_only
    type:
      - 'null'
      - boolean
    doc: 'Coding only: discard mRNAs that have no CDS features'
    inputBinding:
      position: 102
      prefix: -C
  - id: non_coding_only
    type:
      - 'null'
      - boolean
    doc: 'Non-coding only: discard mRNAs that have CDS features'
    inputBinding:
      position: 102
      prefix: --nc
  - id: ignore_locus
    type:
      - 'null'
      - boolean
    doc: Discard locus features and attributes found in the input
    inputBinding:
      position: 102
      prefix: --ignore-locus
  - id: use_seq_descr
    type:
      - 'null'
      - boolean
    doc: Use the description field from <seq_info.fsize> and add it as the value
      for a 'descr' attribute to the GFF record
    inputBinding:
      position: 102
      prefix: -A
  - id: sort_alpha
    type:
      - 'null'
      - boolean
    doc: Chromosomes (reference sequences) are sorted alphabetically
    inputBinding:
      position: 102
      prefix: --sort-alpha
  - id: keep_all_attrs
    type:
      - 'null'
      - boolean
    doc: Keep all GFF attributes (for non-exon features)
    inputBinding:
      position: 102
      prefix: -F
  - id: keep_exon_attrs
    type:
      - 'null'
      - boolean
    doc: For -F option, do not attempt to reduce redundant exon/CDS attributes
    inputBinding:
      position: 102
      prefix: --keep-exon-attrs
  - id: move_exon_attrs
    type:
      - 'null'
      - boolean
    doc: Do not keep exon attributes, move them to the transcript feature (for 
      GFF3 output)
    inputBinding:
      position: 102
      prefix: -G
  - id: keep_genes
    type:
      - 'null'
      - boolean
    doc: In transcript-only mode (default), also preserve gene records
    inputBinding:
      position: 102
      prefix: --keep-genes
  - id: keep_comments
    type:
      - 'null'
      - boolean
    doc: For GFF3 input/output, try to preserve comments
    inputBinding:
      position: 102
      prefix: --keep-comments
  - id: process_non_transcript
    type:
      - 'null'
      - boolean
    doc: Process other non-transcript GFF records (by default non-transcript 
      records are ignored)
    inputBinding:
      position: 102
      prefix: -O
  - id: discard_inframe_stop
    type:
      - 'null'
      - boolean
    doc: Discard any mRNAs with CDS having in-frame stop codons (requires -g)
    inputBinding:
      position: 102
      prefix: -V
  - id: adjust_phase
    type:
      - 'null'
      - boolean
    doc: For -V option, check and adjust the starting CDS phase if the original 
      phase leads to a translation with an in-frame stop codon
    inputBinding:
      position: 102
      prefix: -H
  - id: check_opposite_strand
    type:
      - 'null'
      - boolean
    doc: For -V option, single-exon transcripts are also checked on the opposite
      strand (requires -g)
    inputBinding:
      position: 102
      prefix: -B
  - id: add_coding_status
    type:
      - 'null'
      - boolean
    doc: Add transcript level GFF attributes about the coding status of each 
      transcript, including partialness or in-frame stop codons (requires -g)
    inputBinding:
      position: 102
      prefix: -P
  - id: add_has_cds
    type:
      - 'null'
      - boolean
    doc: Add a "hasCDS" attribute with value "true" for transcripts that have 
      CDS features
    inputBinding:
      position: 102
      prefix: --add-hasCDS
  - id: adj_stop
    type:
      - 'null'
      - boolean
    doc: 'Stop codon adjustment: enables -P and performs automatic adjustment of the
      CDS stop coordinate if premature or downstream'
    inputBinding:
      position: 102
      prefix: --adj-stop
  - id: discard_non_canonical
    type:
      - 'null'
      - boolean
    doc: Discard multi-exon mRNAs that have any intron with a non-canonical 
      splice site consensus (i.e. not GT-AG, GC-AG or AT-AC)
    inputBinding:
      position: 102
      prefix: -N
  - id: complete_cds_only
    type:
      - 'null'
      - boolean
    doc: Discard any mRNAs that either lack initial START codon or the terminal 
      STOP codon, or have an in-frame stop codon (i.e. only print mRNAs with a 
      complete CDS)
    inputBinding:
      position: 102
      prefix: -J
  - id: in_bed
    type:
      - 'null'
      - boolean
    doc: Input should be parsed as BED format (automatic if the input filename 
      ends with .bed*)
    inputBinding:
      position: 102
      prefix: --in-bed
  - id: in_tlf
    type:
      - 'null'
      - boolean
    doc: Input GFF-like one-line-per-transcript format without exon/CDS features
      (see --tlf option below); automatic if the input filename ends with .tlf)
    inputBinding:
      position: 102
      prefix: --in-tlf
  - id: merge
    type:
      - 'null'
      - boolean
    doc: Cluster the input transcripts into loci, discarding "redundant" 
      transcripts (those with the same exact introns and fully contained or 
      equal boundaries)
    inputBinding:
      position: 102
      prefix: --merge
  - id: dupinfo
    type:
      - 'null'
      - string
    doc: For -M option, write duplication info to file <dupinfo>
    inputBinding:
      position: 102
      prefix: -d
  - id: cluster_only
    type:
      - 'null'
      - boolean
    doc: Same as -M/--merge but without discarding any of the "duplicate" 
      transcripts, only create "locus" features
    inputBinding:
      position: 102
      prefix: --cluster-only
  - id: discard_shorter_contained
    type:
      - 'null'
      - boolean
    doc: 'For -M option: also discard as redundant the shorter, fully contained transcripts
      (intron chains matching a part of the container)'
    inputBinding:
      position: 102
      prefix: -K
  - id: relax_boundary_containment
    type:
      - 'null'
      - boolean
    doc: For -M option, no longer require boundary containment when assessing 
      redundancy (can be combined with -K); only introns have to match for 
      multi-exon transcripts, and >=80% overlap for single-exon transcripts
    inputBinding:
      position: 102
      prefix: -Q
  - id: discard_overlapping_single_exon
    type:
      - 'null'
      - boolean
    doc: For -M option, enforce -Q but also discard overlapping single-exon 
      transcripts, even on the opposite strand (can be combined with -K)
    inputBinding:
      position: 102
      prefix: -Y
  - id: force_exons
    type:
      - 'null'
      - boolean
    doc: Make sure that the lowest level GFF features are considered "exon" 
      features
    inputBinding:
      position: 102
      prefix: --force-exons
  - id: gene2exon
    type:
      - 'null'
      - boolean
    doc: For single-line genes not parenting any transcripts, add an exon 
      feature spanning the entire gene (treat it as a transcript)
    inputBinding:
      position: 102
      prefix: --gene2exon
  - id: t_adopt
    type:
      - 'null'
      - boolean
    doc: Try to find a parent gene overlapping/containing a transcript that does
      not have any explicit gene Parent
    inputBinding:
      position: 102
      prefix: --t-adopt
  - id: decode_url
    type:
      - 'null'
      - boolean
    doc: Decode url encoded characters within attributes
    inputBinding:
      position: 102
      prefix: -D
  - id: merge_close_exons
    type:
      - 'null'
      - boolean
    doc: Merge very close exons into a single exon (when intron size<4)
    inputBinding:
      position: 102
      prefix: -Z
  - id: w_add
    type:
      - 'null'
      - int
    doc: For the -w option, extract additional <N> bases both upstream and 
      downstream of the transcript boundaries
    inputBinding:
      position: 102
      prefix: --w-add
  - id: w_nocds
    type:
      - 'null'
      - boolean
    doc: For -w, disable the output of CDS info in the FASTA file
    inputBinding:
      position: 102
      prefix: --w-nocds
  - id: project_exon_coords
    type:
      - 'null'
      - boolean
    doc: For -w, -x and -y options, write in the FASTA defline all the exon 
      coordinates projected onto the spliced sequence
    inputBinding:
      position: 102
      prefix: -W
  - id: stop_codon_asterisk
    type:
      - 'null'
      - boolean
    doc: For -y option, use '*' instead of '.' as stop codon translation
    inputBinding:
      position: 102
      prefix: -S
  - id: ensembl_conversion
    type:
      - 'null'
      - boolean
    doc: Ensembl GTF to GFF3 conversion, adds version to IDs
    inputBinding:
      position: 102
      prefix: -L
  - id: chr_replace
    type:
      - 'null'
      - File
    doc: '<chr_replace> is a name mapping table for converting reference sequence
      names, having this 2-column format: <original_ref_ID> <new_ref_ID>'
    inputBinding:
      position: 102
      prefix: -m
  - id: warn_duplicate_ids
    type:
      - 'null'
      - boolean
    doc: Expose (warn about) duplicate transcript IDs and other potential 
      problems with the given GFF/GTF records
    inputBinding:
      position: 102
      prefix: -E
outputs:
  - id: output_outfile
    type:
      - 'null'
      - File
    doc: Write the output records into <outfile> instead of stdout
    outputBinding:
      glob: $(inputs.outfile)
  - id: output_write_exons
    type:
      - 'null'
      - File
    doc: Write a fasta file with spliced exons for each transcript
    outputBinding:
      glob: $(inputs.write_exons)
  - id: output_write_cds
    type:
      - 'null'
      - File
    doc: Write a fasta file with spliced CDS for each GFF transcript
    outputBinding:
      glob: $(inputs.write_cds)
  - id: output_write_tr_cds
    type:
      - 'null'
      - File
    doc: Write a protein fasta file with the translation of CDS for each record
    outputBinding:
      glob: $(inputs.write_tr_cds)
  - id: output_dupinfo
    type:
      - 'null'
      - File
    doc: For -M option, write duplication info to file <dupinfo>
    outputBinding:
      glob: $(inputs.dupinfo)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gffread:0.12.7--h077b44d_6
s:url: https://ccb.jhu.edu/software/stringtie/gff.shtml
$namespaces:
  s: https://schema.org/
