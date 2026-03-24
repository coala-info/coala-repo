class: Workflow
cwlVersion: v1.2.0-dev2
doc: 'Abstract CWL Automatically generated from the Galaxy workflow file: VGP purge
  assembly with purge_dups pipeline'
inputs:
  Genomescope model parameters:
    format: data
    type: File
  Hifiasm Alternate assembly:
    doc: From the Hifiasm workflow. In fasta format.
    format: data
    type: File
  Hifiasm Primary assembly:
    doc: 'From the Hifiasm workflow. In fasta format. '
    format: data
    type: File
  Pacbio Reads Collection - Trimmed:
    doc: Collection of trimmed reads (from cutadapt in the Hifiasm workflow) in fastq
      format.
    format: data
    type: File
outputs: {}
steps:
  10_Cut:
    in:
      input: 8_Compute/out_file1
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
  11_Parse parameter value:
    in:
      input1: 9_Cut/out_file1
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
  12_Parse parameter value:
    in:
      input1: 10_Cut/out_file1
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
  13_Purge overlaps:
    in:
      function_select|input: 4_Map with minimap2/alignment_output
      function_select|section_calcuts|transition: 12_Parse parameter value/integer_param
      function_select|section_calcuts|upper_depth: 11_Parse parameter value/integer_param
    out:
    - stat_file
    - pbcstat_cov
    - pbcstat_wig
    - hist
    - calcuts_log
    - calcuts_cutoff
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_iuc_purge_dups_purge_dups_1_2_5+galaxy4
      inputs:
        function_select|input:
          format: Any
          type: File
        function_select|section_calcuts|transition:
          format: Any
          type: File
        function_select|section_calcuts|upper_depth:
          format: Any
          type: File
      outputs:
        calcuts_cutoff:
          doc: tabular
          type: File
        calcuts_log:
          doc: txt
          type: File
        hist:
          doc: png
          type: File
        pbcstat_cov:
          doc: tabular
          type: File
        pbcstat_wig:
          doc: wig
          type: File
        stat_file:
          doc: tabular
          type: File
  14_Purge overlaps:
    in:
      function_select|coverage: 13_Purge overlaps/pbcstat_cov
      function_select|cutoffs: 13_Purge overlaps/calcuts_cutoff
      function_select|input: 7_Map with minimap2/alignment_output
    out:
    - purge_dups_log
    - purge_dups_bed
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_iuc_purge_dups_purge_dups_1_2_5+galaxy4
      inputs:
        function_select|coverage:
          format: Any
          type: File
        function_select|cutoffs:
          format: Any
          type: File
        function_select|input:
          format: Any
          type: File
      outputs:
        purge_dups_bed:
          doc: bed
          type: File
        purge_dups_log:
          doc: txt
          type: File
  15_Purge overlaps:
    in:
      function_select|bed_input: 14_Purge overlaps/purge_dups_bed
      function_select|fasta_input: Hifiasm Primary assembly
    out:
    - get_seqs_hap
    - get_seqs_purged
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_iuc_purge_dups_purge_dups_1_2_5+galaxy4
      inputs:
        function_select|bed_input:
          format: Any
          type: File
        function_select|fasta_input:
          format: Any
          type: File
      outputs:
        get_seqs_hap:
          doc: fasta
          type: File
        get_seqs_purged:
          doc: fasta
          type: File
  16_Concatenate datasets:
    in:
      input1: 15_Purge overlaps/get_seqs_hap
      queries_0|input2: Hifiasm Alternate assembly
    out:
    - out_file1
    run:
      class: Operation
      id: cat1
      inputs:
        input1:
          format: Any
          type: File
        queries_0|input2:
          format: Any
          type: File
      outputs:
        out_file1:
          doc: input
          type: File
  17_Map with minimap2:
    in:
      fastq_input|fastq_input1: Pacbio Reads Collection - Trimmed
      reference_source|ref_file: 16_Concatenate datasets/out_file1
    out:
    - alignment_output
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_iuc_minimap2_minimap2_2_24+galaxy0
      inputs:
        fastq_input|fastq_input1:
          format: Any
          type: File
        reference_source|ref_file:
          format: Any
          type: File
      outputs:
        alignment_output:
          doc: bam
          type: File
  18_Purge overlaps:
    in:
      function_select|input: 16_Concatenate datasets/out_file1
    out:
    - split_fasta
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_iuc_purge_dups_purge_dups_1_2_5+galaxy4
      inputs:
        function_select|input:
          format: Any
          type: File
      outputs:
        split_fasta:
          doc: fasta
          type: File
  19_Purge overlaps:
    in:
      function_select|input: 17_Map with minimap2/alignment_output
      function_select|section_calcuts|transition: 12_Parse parameter value/integer_param
      function_select|section_calcuts|upper_depth: 11_Parse parameter value/integer_param
    out:
    - stat_file
    - pbcstat_cov
    - pbcstat_wig
    - hist
    - calcuts_log
    - calcuts_cutoff
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_iuc_purge_dups_purge_dups_1_2_5+galaxy4
      inputs:
        function_select|input:
          format: Any
          type: File
        function_select|section_calcuts|transition:
          format: Any
          type: File
        function_select|section_calcuts|upper_depth:
          format: Any
          type: File
      outputs:
        calcuts_cutoff:
          doc: tabular
          type: File
        calcuts_log:
          doc: txt
          type: File
        hist:
          doc: png
          type: File
        pbcstat_cov:
          doc: tabular
          type: File
        pbcstat_wig:
          doc: wig
          type: File
        stat_file:
          doc: tabular
          type: File
  20_Map with minimap2:
    in:
      fastq_input|fastq_input1: 18_Purge overlaps/split_fasta
      reference_source|ref_file: 18_Purge overlaps/split_fasta
    out:
    - alignment_output
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_iuc_minimap2_minimap2_2_24+galaxy0
      inputs:
        fastq_input|fastq_input1:
          format: Any
          type: File
        reference_source|ref_file:
          format: Any
          type: File
      outputs:
        alignment_output:
          doc: bam
          type: File
  21_Purge overlaps:
    in:
      function_select|coverage: 19_Purge overlaps/pbcstat_cov
      function_select|cutoffs: 19_Purge overlaps/calcuts_cutoff
      function_select|input: 20_Map with minimap2/alignment_output
    out:
    - purge_dups_log
    - purge_dups_bed
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_iuc_purge_dups_purge_dups_1_2_5+galaxy4
      inputs:
        function_select|coverage:
          format: Any
          type: File
        function_select|cutoffs:
          format: Any
          type: File
        function_select|input:
          format: Any
          type: File
      outputs:
        purge_dups_bed:
          doc: bed
          type: File
        purge_dups_log:
          doc: txt
          type: File
  22_Purge overlaps:
    in:
      function_select|bed_input: 21_Purge overlaps/purge_dups_bed
      function_select|fasta_input: 16_Concatenate datasets/out_file1
    out:
    - get_seqs_hap
    - get_seqs_purged
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_iuc_purge_dups_purge_dups_1_2_5+galaxy4
      inputs:
        function_select|bed_input:
          format: Any
          type: File
        function_select|fasta_input:
          format: Any
          type: File
      outputs:
        get_seqs_hap:
          doc: fasta
          type: File
        get_seqs_purged:
          doc: fasta
          type: File
  4_Map with minimap2:
    in:
      fastq_input|fastq_input1: Pacbio Reads Collection - Trimmed
      reference_source|ref_file: Hifiasm Primary assembly
    out:
    - alignment_output
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_iuc_minimap2_minimap2_2_24+galaxy0
      inputs:
        fastq_input|fastq_input1:
          format: Any
          type: File
        reference_source|ref_file:
          format: Any
          type: File
      outputs:
        alignment_output:
          doc: bam
          type: File
  5_Purge overlaps:
    in:
      function_select|input: Hifiasm Primary assembly
    out:
    - split_fasta
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_iuc_purge_dups_purge_dups_1_2_5+galaxy4
      inputs:
        function_select|input:
          format: Any
          type: File
      outputs:
        split_fasta:
          doc: fasta
          type: File
  6_Compute:
    in:
      input: Genomescope model parameters
    out:
    - out_file1
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_devteam_column_maker_Add_a_column1_1_6
      inputs:
        input:
          format: Any
          type: File
      outputs:
        out_file1:
          doc: input
          type: File
  7_Map with minimap2:
    in:
      fastq_input|fastq_input1: 5_Purge overlaps/split_fasta
      reference_source|ref_file: 5_Purge overlaps/split_fasta
    out:
    - alignment_output
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_iuc_minimap2_minimap2_2_24+galaxy0
      inputs:
        fastq_input|fastq_input1:
          format: Any
          type: File
        reference_source|ref_file:
          format: Any
          type: File
      outputs:
        alignment_output:
          doc: bam
          type: File
  8_Compute:
    in:
      input: 6_Compute/out_file1
    out:
    - out_file1
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_devteam_column_maker_Add_a_column1_1_6
      inputs:
        input:
          format: Any
          type: File
      outputs:
        out_file1:
          doc: input
          type: File
  9_Cut:
    in:
      input: 8_Compute/out_file1
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

