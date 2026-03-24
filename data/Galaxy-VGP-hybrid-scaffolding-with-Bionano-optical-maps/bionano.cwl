class: Workflow
cwlVersion: v1.2.0-dev2
doc: 'Abstract CWL Automatically generated from the Galaxy workflow file: VGP hybrid
  scaffolding with Bionano optical maps'
inputs:
  Bionano Data:
    doc: Bionano data in Cmap format.
    format: data
    type: File
  'Conflict resolution files ':
    doc: 'Input a conflict resolution file indicating which NGS and BioNano conflicting
      contigs to be cut [optional] (-M)

      '
    format: data
    type: File
  Estimated genome size - Parameter File:
    doc: Parameter file generated in the VGP Hifiasm workflow. Estimated reference
      genome size (in bp) for computing NGx statistics
    format: data
    type: File
  Hifiasm Purged Assembly:
    doc: The assembly from "VGP-Hifiasm" workflow.
    format: data
    type: File
  Pacbio trimmed reads:
    format: data
    type: File
outputs: {}
steps:
  10_Quast:
    in:
      assembly|ref|est_ref_size: 6_Parse parameter value/integer_param
      in|inputs: 8_Concatenate datasets/out_file1
      large: 3_Input parameter/output
      reads|input_1: Pacbio trimmed reads
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
        reads|input_1:
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
  3_Input parameter:
    in: {}
    out: []
    run:
      class: Operation
      id: null
      inputs: {}
      outputs: {}
  6_Parse parameter value:
    in:
      input1: Estimated genome size - Parameter File
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
  7_Bionano Hybrid Scaffold:
    in:
      bionano_cmap: Bionano Data
      conflict_resolution: 'Conflict resolution files '
      ngs_fasta: Hifiasm Purged Assembly
    out:
    - ngs_contigs_scaffold_trimmed
    - ngs_contigs_not_scaffolded_trimmed
    - report
    - conflicts
    - ngs_contigs_scaffold_agp
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_bgruening_bionano_scaffold_bionano_scaffold_3_7_0+galaxy0
      inputs:
        bionano_cmap:
          format: Any
          type: File
        conflict_resolution:
          format: Any
          type: File
        ngs_fasta:
          format: Any
          type: File
      outputs:
        conflicts:
          doc: txt
          type: File
        ngs_contigs_not_scaffolded_trimmed:
          doc: fasta
          type: File
        ngs_contigs_scaffold_agp:
          doc: agp
          type: File
        ngs_contigs_scaffold_trimmed:
          doc: fasta
          type: File
        report:
          doc: txt
          type: File
  8_Concatenate datasets:
    in:
      input1: 7_Bionano Hybrid Scaffold/ngs_contigs_scaffold_trimmed
      queries_0|input2: 7_Bionano Hybrid Scaffold/ngs_contigs_not_scaffolded_trimmed
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
  9_Busco:
    in:
      input: 8_Concatenate datasets/out_file1
    out:
    - busco_sum
    - busco_table
    - summary_image
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_iuc_busco_busco_5_2_2+galaxy2
      inputs:
        input:
          format: Any
          type: File
      outputs:
        busco_sum:
          doc: txt
          type: File
        busco_table:
          doc: tabular
          type: File
        summary_image:
          doc: png
          type: File

