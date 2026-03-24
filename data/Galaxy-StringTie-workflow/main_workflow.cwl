class: Workflow
cwlVersion: v1.2.0-dev2
doc: 'Abstract CWL Automatically generated from the Galaxy workflow file: Copy of
  Genome-wide alternative splicing analysis'
inputs:
  Genome annotation:
    format: data
    type: File
  Reference genome:
    format: data
    type: File
outputs: {}
steps:
  10_IsoformSwitchAnalyzeR:
    in:
      functionMode|first_factor|trans_counts: 9_Filter collection/output_filtered
      functionMode|genomeAnnotation: Genome annotation
      functionMode|second_factor|trans_counts: 9_Filter collection/output_discarded
      functionMode|tool_source|novoisoforms|stringtieAnnotation: 4_StringTie merge/out_gtf
      functionMode|transcriptome: 5_gffread/output_exons
    out:
    - switchList
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_iuc_isoformswitchanalyzer_isoformswitchanalyzer_1_20_0+galaxy3
      inputs:
        functionMode|first_factor|trans_counts:
          format: Any
          type: File
        functionMode|genomeAnnotation:
          format: Any
          type: File
        functionMode|second_factor|trans_counts:
          format: Any
          type: File
        functionMode|tool_source|novoisoforms|stringtieAnnotation:
          format: Any
          type: File
        functionMode|transcriptome:
          format: Any
          type: File
      outputs:
        switchList:
          doc: rdata
          type: File
  1_RNA STAR:
    in: {}
    out:
    - output_log
    - splice_junctions
    - mapped_reads
    - signal_unique_str1
    - signal_uniquemultiple_str1
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_iuc_rgrnastar_rna_star_2_7_10b+galaxy3
      inputs: {}
      outputs:
        mapped_reads:
          doc: bam
          type: File
        output_log:
          doc: txt
          type: File
        signal_unique_str1:
          doc: bedgraph
          type: File
        signal_uniquemultiple_str1:
          doc: bedgraph
          type: File
        splice_junctions:
          doc: interval
          type: File
  3_StringTie:
    in:
      guide|guide_source|ref_hist: Genome annotation
      input_options|input_bam: 1_RNA STAR/mapped_reads
    out:
    - output_gtf
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_iuc_stringtie_stringtie_2_2_1+galaxy1
      inputs:
        guide|guide_source|ref_hist:
          format: Any
          type: File
        input_options|input_bam:
          format: Any
          type: File
      outputs:
        output_gtf:
          doc: gtf
          type: File
  4_StringTie merge:
    in:
      guide_gff: Genome annotation
      input_gtf: 3_StringTie/output_gtf
    out:
    - out_gtf
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_iuc_stringtie_stringtie_merge_2_2_1+galaxy1
      inputs:
        guide_gff:
          format: Any
          type: File
        input_gtf:
          format: Any
          type: File
      outputs:
        out_gtf:
          doc: gtf
          type: File
  5_gffread:
    in:
      input: 4_StringTie merge/out_gtf
      reference_genome|genome_fasta: Reference genome
    out:
    - output_exons
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_devteam_gffread_gffread_2_2_1_3+galaxy0
      inputs:
        input:
          format: Any
          type: File
        reference_genome|genome_fasta:
          format: Any
          type: File
      outputs:
        output_exons:
          doc: fasta
          type: File
  6_StringTie:
    in:
      guide|guide_source|ref_hist: 4_StringTie merge/out_gtf
      input_options|input_bam: 1_RNA STAR/mapped_reads
    out:
    - output_gtf
    - exon_expression
    - intron_expression
    - transcript_expression
    - exon_transcript_mapping
    - intron_transcript_mapping
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_iuc_stringtie_stringtie_2_2_1+galaxy1
      inputs:
        guide|guide_source|ref_hist:
          format: Any
          type: File
        input_options|input_bam:
          format: Any
          type: File
      outputs:
        exon_expression:
          doc: tabular
          type: File
        exon_transcript_mapping:
          doc: tabular
          type: File
        intron_expression:
          doc: tabular
          type: File
        intron_transcript_mapping:
          doc: tabular
          type: File
        output_gtf:
          doc: gtf
          type: File
        transcript_expression:
          doc: tabular
          type: File
  7_Extract element identifiers:
    in:
      input_collection: 6_StringTie/transcript_expression
    out:
    - output
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_iuc_collection_element_identifiers_collection_element_identifiers_0_0_2
      inputs:
        input_collection:
          format: Any
          type: File
      outputs:
        output:
          doc: txt
          type: File
  8_Search in textfiles:
    in:
      infile: 7_Extract element identifiers/output
    out:
    - output
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_bgruening_text_processing_tp_grep_tool_1_1_1
      inputs:
        infile:
          format: Any
          type: File
      outputs:
        output:
          doc: input
          type: File
  9_Filter collection:
    in:
      how|filter_source: 8_Search in textfiles/output
      input: 6_StringTie/transcript_expression
    out:
    - output_filtered
    - output_discarded
    run:
      class: Operation
      id: __FILTER_FROM_FILE__
      inputs:
        how|filter_source:
          format: Any
          type: File
        input:
          format: Any
          type: File
      outputs:
        output_discarded:
          doc: input
          type: File
        output_filtered:
          doc: input
          type: File

