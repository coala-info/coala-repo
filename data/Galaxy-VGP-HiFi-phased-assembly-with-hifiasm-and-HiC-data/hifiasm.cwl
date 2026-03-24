class: Workflow
cwlVersion: v1.2.0-dev2
doc: 'Abstract CWL Automatically generated from the Galaxy workflow file:  VGP HiFi
  phased assembly with hifiasm and HiC data'
inputs:
  HiC forward reads:
    format: data
    type: File
  HiC reverse reads:
    format: data
    type: File
  Meryl Database:
    doc: Database Generated from the "Meryl database creation" workflow.
    format: data
    type: File
  Pacbio Reads Collection:
    doc: Collection of Long reads in fastq format.
    format: data
    type: File
outputs: {}
steps:
  10_Hifiasm:
    in:
      hic_partition|h1: HiC forward reads
      hic_partition|h2: HiC reverse reads
      mode|reads: 8_Cutadapt/out1
    out:
    - hic_pcontig_graph
    - hic_acontig_graph
    - hic_balanced_contig_hap1_graph
    - hic_balanced_contig_hap2_graph
    - log_file
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_bgruening_hifiasm_hifiasm_0_16_1+galaxy2
      inputs:
        hic_partition|h1:
          format: Any
          type: File
        hic_partition|h2:
          format: Any
          type: File
        mode|reads:
          format: Any
          type: File
      outputs:
        hic_acontig_graph:
          doc: gfa1
          type: File
        hic_balanced_contig_hap1_graph:
          doc: gfa1
          type: File
        hic_balanced_contig_hap2_graph:
          doc: gfa1
          type: File
        hic_pcontig_graph:
          doc: gfa1
          type: File
        log_file:
          doc: txt
          type: File
  11_Search in textfiles:
    in:
      infile: 9_GenomeScope/summary
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
  12_GFA to FASTA:
    in:
      in_gfa: 10_Hifiasm/hic_balanced_contig_hap1_graph
    out:
    - out_fa
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_iuc_gfa_to_fa_gfa_to_fa_0_1_2
      inputs:
        in_gfa:
          format: Any
          type: File
      outputs:
        out_fa:
          doc: fasta
          type: File
  13_GFA to FASTA:
    in:
      in_gfa: 10_Hifiasm/hic_balanced_contig_hap2_graph
    out:
    - out_fa
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_iuc_gfa_to_fa_gfa_to_fa_0_1_2
      inputs:
        in_gfa:
          format: Any
          type: File
      outputs:
        out_fa:
          doc: fasta
          type: File
  14_gfastats:
    in:
      input_file: 10_Hifiasm/hic_balanced_contig_hap1_graph
    out:
    - stats
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_bgruening_gfastats_gfastats_1_2_0+galaxy0
      inputs:
        input_file:
          format: Any
          type: File
      outputs:
        stats:
          doc: tabular
          type: File
  15_gfastats:
    in:
      input_file: 10_Hifiasm/hic_balanced_contig_hap2_graph
    out:
    - stats
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_bgruening_gfastats_gfastats_1_2_0+galaxy0
      inputs:
        input_file:
          format: Any
          type: File
      outputs:
        stats:
          doc: tabular
          type: File
  16_Replace Text:
    in:
      infile: 11_Search in textfiles/output
    out:
    - outfile
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_bgruening_text_processing_tp_replace_in_line_1_1_2
      inputs:
        infile:
          format: Any
          type: File
      outputs:
        outfile:
          doc: input
          type: File
  17_Busco:
    in:
      input: 12_GFA to FASTA/out_fa
    out:
    - busco_sum
    - busco_table
    - busco_missing
    - summary_image
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_iuc_busco_busco_5_2_2+galaxy2
      inputs:
        input:
          format: Any
          type: File
      outputs:
        busco_missing:
          doc: tabular
          type: File
        busco_sum:
          doc: txt
          type: File
        busco_table:
          doc: tabular
          type: File
        summary_image:
          doc: png
          type: File
  18_Merqury:
    in:
      mode|assembly_options|assembly_01: 12_GFA to FASTA/out_fa
      mode|assembly_options|assembly_02: 13_GFA to FASTA/out_fa
      mode|meryldb_F1: Meryl Database
    out:
    - bed_files
    - wig_files
    - qv_files
    - png_files
    - sizes_files
    - stats_files
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_iuc_merqury_merqury_1_3+galaxy1
      inputs:
        mode|assembly_options|assembly_01:
          format: Any
          type: File
        mode|assembly_options|assembly_02:
          format: Any
          type: File
        mode|meryldb_F1:
          format: Any
          type: File
      outputs:
        bed_files:
          doc: input
          type: File
        png_files:
          doc: input
          type: File
        qv_files:
          doc: input
          type: File
        sizes_files:
          doc: input
          type: File
        stats_files:
          doc: input
          type: File
        wig_files:
          doc: input
          type: File
  19_Busco:
    in:
      input: 13_GFA to FASTA/out_fa
    out:
    - busco_sum
    - busco_table
    - busco_missing
    - summary_image
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_iuc_busco_busco_5_2_2+galaxy2
      inputs:
        input:
          format: Any
          type: File
      outputs:
        busco_missing:
          doc: tabular
          type: File
        busco_sum:
          doc: txt
          type: File
        busco_table:
          doc: tabular
          type: File
        summary_image:
          doc: png
          type: File
  20_Convert:
    in:
      input: 16_Replace Text/outfile
    out:
    - out_file1
    run:
      class: Operation
      id: Convert_characters1
      inputs:
        input:
          format: Any
          type: File
      outputs:
        out_file1:
          doc: tabular
          type: File
  21_Cut:
    in:
      input: 20_Convert/out_file1
    out:
    - out_file1
    run:
      class: Operation
      id: Cut1
      inputs:
        input:
          format: Any
          type: File
      outputs:
        out_file1:
          doc: tabular
          type: File
  22_Parse parameter value:
    in:
      input1: 21_Cut/out_file1
    out:
    - integer_param
    run:
      class: Operation
      id: param_value_from_file
      inputs:
        input1:
          format: Any
          type: File
      outputs:
        integer_param:
          doc: expression.json
          type: File
  23_Quast:
    in:
      assembly|ref|est_ref_size: 22_Parse parameter value/integer_param
      in|inputs: 13_GFA to FASTA/out_fa
      large: 2_Input parameter/output
    out:
    - quast_tabular
    - report_html
    - report_pdf
    - log
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_iuc_quast_quast_5_0_2+galaxy3
      inputs:
        assembly|ref|est_ref_size:
          format: Any
          type: File
        in|inputs:
          format: Any
          type: File
        large:
          format: Any
          type: File
      outputs:
        log:
          doc: txt
          type: File
        quast_tabular:
          doc: tabular
          type: File
        report_html:
          doc: html
          type: File
        report_pdf:
          doc: pdf
          type: File
  24_Quast:
    in:
      assembly|ref|est_ref_size: 22_Parse parameter value/integer_param
      in|inputs: 12_GFA to FASTA/out_fa
      large: 2_Input parameter/output
    out:
    - quast_tabular
    - report_html
    - report_pdf
    - log
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_iuc_quast_quast_5_0_2+galaxy3
      inputs:
        assembly|ref|est_ref_size:
          format: Any
          type: File
        in|inputs:
          format: Any
          type: File
        large:
          format: Any
          type: File
      outputs:
        log:
          doc: txt
          type: File
        quast_tabular:
          doc: tabular
          type: File
        report_html:
          doc: html
          type: File
        report_pdf:
          doc: pdf
          type: File
  25_gfastats:
    in:
      input_file: 10_Hifiasm/hic_balanced_contig_hap2_graph
      mode_condition|statistics_condition|expected_genomesize: 22_Parse parameter
        value/integer_param
    out:
    - stats
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_bgruening_gfastats_gfastats_1_2_0+galaxy0
      inputs:
        input_file:
          format: Any
          type: File
        mode_condition|statistics_condition|expected_genomesize:
          format: Any
          type: File
      outputs:
        stats:
          doc: tabular
          type: File
  26_gfastats:
    in:
      input_file: 10_Hifiasm/hic_balanced_contig_hap1_graph
      mode_condition|statistics_condition|expected_genomesize: 22_Parse parameter
        value/integer_param
    out:
    - stats
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_bgruening_gfastats_gfastats_1_2_0+galaxy0
      inputs:
        input_file:
          format: Any
          type: File
        mode_condition|statistics_condition|expected_genomesize:
          format: Any
          type: File
      outputs:
        stats:
          doc: tabular
          type: File
  2_Input parameter:
    in: {}
    out: []
    run:
      class: Operation
      id: null
      inputs: {}
      outputs: {}
  3_Input parameter:
    in: {}
    out: []
    run:
      class: Operation
      id: null
      inputs: {}
      outputs: {}
  4_Input parameter:
    in: {}
    out: []
    run:
      class: Operation
      id: null
      inputs: {}
      outputs: {}
  7_Meryl:
    in:
      operation_type|input_meryldb_02: Meryl Database
    out:
    - read_db_hist
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_iuc_meryl_meryl_1_3+galaxy4
      inputs:
        operation_type|input_meryldb_02:
          format: Any
          type: File
      outputs:
        read_db_hist:
          doc: tabular
          type: File
  8_Cutadapt:
    in:
      library|input_1: Pacbio Reads Collection
    out:
    - out1
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_lparsons_cutadapt_cutadapt_3_5+galaxy1
      inputs:
        library|input_1:
          format: Any
          type: File
      outputs:
        out1:
          doc: fastqsanger
          type: File
  9_GenomeScope:
    in:
      input: 7_Meryl/read_db_hist
      kmer_length: 3_Input parameter/output
      ploidy: 4_Input parameter/output
    out:
    - linear_plot
    - log_plot
    - transformed_linear_plot
    - transformed_log_plot
    - model
    - summary
    - model_params
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_iuc_genomescope_genomescope_2_0+galaxy1
      inputs:
        input:
          format: Any
          type: File
        kmer_length:
          format: Any
          type: File
        ploidy:
          format: Any
          type: File
      outputs:
        linear_plot:
          doc: png
          type: File
        log_plot:
          doc: png
          type: File
        model:
          doc: txt
          type: File
        model_params:
          doc: tabular
          type: File
        summary:
          doc: txt
          type: File
        transformed_linear_plot:
          doc: png
          type: File
        transformed_log_plot:
          doc: png
          type: File

