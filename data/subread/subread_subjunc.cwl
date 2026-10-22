cwlVersion: v1.2
class: CommandLineTool
baseCommand: subjunc
label: subread_subjunc
doc: "Align RNA-seq reads and detect exon-exon junctions and gene fusions (Subjunc).\n\nTool homepage: http://subread.sourceforge.net/"
inputs:
  - id: index_basename
    type: string
    doc: Base name of the index.
    inputBinding:
      position: 1
      prefix: -i
  - id: index_files
    type:
      type: array
      items: File
    doc: Index files built by subread-buildindex (staged in the working directory so the base name resolves)
  - id: reads
    type: File
    doc: "Name of an input read file. If paired-end, this should be the first read file. Acceptable formats include gzipped FASTQ, FASTQ, gzipped FASTA and FASTA."
    inputBinding:
      position: 1
      prefix: -r
  - id: output_file
    type: string
    doc: "Name of an output file. By default, the output is in BAM format. Omitting this option makes the output be written to STDOUT."
    inputBinding:
      position: 1
      prefix: -o
  - id: reads2
    type:
      - 'null'
      - File
    doc: Name of the second read file in paired-end data.
    inputBinding:
      position: 1
      prefix: -R
  - id: sam_input
    type:
      - 'null'
      - boolean
    doc: Input reads are in SAM format.
    inputBinding:
      position: 1
      prefix: --SAMinput
  - id: bam_input
    type:
      - 'null'
      - boolean
    doc: Input reads are in BAM format.
    inputBinding:
      position: 1
      prefix: --BAMinput
  - id: sam_output
    type:
      - 'null'
      - boolean
    doc: Save mapping results in SAM format.
    inputBinding:
      position: 1
      prefix: --SAMoutput
  - id: phred_offset
    type:
      - 'null'
      - int
    doc: Offset value added to the Phred quality score of each read base. 3 for phred+33 and 6 for phred+64. 3 by default.
    inputBinding:
      position: 1
      prefix: -P
  - id: n_subreads
    type:
      - 'null'
      - int
    doc: "Number of selected subreads, 14 by default."
    inputBinding:
      position: 1
      prefix: -n
  - id: consensus_threshold
    type:
      - 'null'
      - int
    doc: "Consensus threshold for reporting a hit (minimal number of subreads that map in consensus). If paired-end, this gives the consensus threshold for the anchor read. 1 by default."
    inputBinding:
      position: 1
      prefix: -m
  - id: consensus_threshold_nonanchor
    type:
      - 'null'
      - int
    doc: Consensus threshold for the non-anchor read in a pair. 1 by default.
    inputBinding:
      position: 1
      prefix: -p
  - id: max_mismatches
    type:
      - 'null'
      - int
    doc: Maximum number of mis-matched bases allowed in each reported alignment. 3 by default.
    inputBinding:
      position: 1
      prefix: -M
  - id: multi_mapping
    type:
      - 'null'
      - boolean
    doc: Report multi-mapping reads in addition to uniquely mapped reads.
    inputBinding:
      position: 1
      prefix: --multiMapping
  - id: max_best_alignments
    type:
      - 'null'
      - int
    doc: Maximum number of equally-best alignments to be reported for a multi-mapping read. 1 by default.
    inputBinding:
      position: 1
      prefix: -B
  - id: max_indel_length
    type:
      - 'null'
      - int
    doc: Maximum length (in bp) of indels that can be detected. 5 by default.
    inputBinding:
      position: 1
      prefix: -I
  - id: complex_indels
    type:
      - 'null'
      - boolean
    doc: Detect multiple short indels that are in close proximity.
    inputBinding:
      position: 1
      prefix: --complexIndels
  - id: trim5
    type:
      - 'null'
      - int
    doc: "Trim off this number of bases from 5' end of each read. 0 by default."
    inputBinding:
      position: 1
      prefix: --trim5
  - id: trim3
    type:
      - 'null'
      - int
    doc: "Trim off this number of bases from 3' end of each read. 0 by default."
    inputBinding:
      position: 1
      prefix: --trim3
  - id: min_fragment_length
    type:
      - 'null'
      - int
    doc: "Minimum fragment/insert length, 50bp by default."
    inputBinding:
      position: 1
      prefix: -d
  - id: max_fragment_length
    type:
      - 'null'
      - int
    doc: "Maximum fragment/insert length, 600bp by default."
    inputBinding:
      position: 1
      prefix: -D
  - id: orientation
    type:
      - 'null'
      - string
    doc: "Orientation of first and second reads (ff, fr or rf), 'fr' by default."
    inputBinding:
      position: 1
      prefix: -S
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of CPU threads used, 1 by default."
    inputBinding:
      position: 1
      prefix: -T
  - id: rg_id
    type:
      - 'null'
      - string
    doc: Add read group ID to the output.
    inputBinding:
      position: 1
      prefix: --rg-id
  - id: rg
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --rg
    doc: Add tag:value to the read group (RG) header in the output; can be given several times.
  - id: keep_read_order
    type:
      - 'null'
      - boolean
    doc: Keep order of reads in BAM output the same as that in the input file.
    inputBinding:
      position: 1
      prefix: --keepReadOrder
  - id: sort_by_coordinates
    type:
      - 'null'
      - boolean
    doc: Output location-sorted reads (BAM only); a BAI index file is also generated.
    inputBinding:
      position: 1
      prefix: --sortReadsByCoordinates
  - id: color_space
    type:
      - 'null'
      - boolean
    doc: Convert color-space read bases to base-space read bases in the mapping output.
    inputBinding:
      position: 1
      prefix: -b
  - id: dp_gap_open
    type:
      - 'null'
      - int
    doc: Penalty for gap opening in short indel detection. -1 by default.
    inputBinding:
      position: 1
      prefix: --DPGapOpen
  - id: dp_gap_ext
    type:
      - 'null'
      - int
    doc: Penalty for gap extension in short indel detection. 0 by default.
    inputBinding:
      position: 1
      prefix: --DPGapExt
  - id: dp_mismatch
    type:
      - 'null'
      - int
    doc: Penalty for mismatches in short indel detection. 0 by default.
    inputBinding:
      position: 1
      prefix: --DPMismatch
  - id: dp_match
    type:
      - 'null'
      - int
    doc: Score for matched bases in short indel detection. 2 by default.
    inputBinding:
      position: 1
      prefix: --DPMatch
  - id: all_junctions
    type:
      - 'null'
      - boolean
    doc: Detect exon-exon junctions (both canonical and non-canonical junctions) and structural variants in RNA-seq data.
    inputBinding:
      position: 1
      prefix: --allJunctions
  - id: annotation
    type:
      - 'null'
      - File
    doc: Name of an annotation file (gzipped file is accepted). GTF/GFF format by default.
    inputBinding:
      position: 1
      prefix: -a
  - id: annotation_format
    type:
      - 'null'
      - string
    doc: "Format of the provided annotation file: GTF (or compatible GFF format) or SAF. GTF by default."
    inputBinding:
      position: 1
      prefix: -F
  - id: chr_alias
    type:
      - 'null'
      - File
    doc: Chromosome name alias file (two-column comma-delimited text) to match chr names in annotation with those in the index.
    inputBinding:
      position: 1
      prefix: -A
  - id: gtf_feature
    type:
      - 'null'
      - string
    doc: "Feature type in GTF annotation. 'exon' by default."
    inputBinding:
      position: 1
      prefix: --gtfFeature
  - id: gtf_attribute
    type:
      - 'null'
      - string
    doc: "Attribute type in GTF annotation. 'gene_id' by default."
    inputBinding:
      position: 1
      prefix: --gtfAttr
outputs:
  - id: alignment
    type: File
    doc: "Mapping results (BAM, or SAM with --SAMoutput)"
    outputBinding:
      glob: $(inputs.output_file)
  - id: extra_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files written next to the alignment (index, indel VCF, junction BED, breakpoint VCF)"
    outputBinding:
      glob:
        - $(inputs.output_file).bai
        - $(inputs.output_file).indel.vcf
        - $(inputs.output_file).junction.bed
        - $(inputs.output_file).breakpoints.vcf
        - $(inputs.output_file).summary
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.index_files || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/subread:2.1.1--h577a1d6_0
