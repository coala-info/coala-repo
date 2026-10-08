cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - enrichm
  - enrichment
label: enrichm_enrichment
doc: "Calculate enrichment of functional genes between groups of genomes.\n\nTool homepage: https://github.com/geronimp/enrichM"
inputs:
  - id: log
    type:
      - 'null'
      - string
    doc: "Output logging information to this file."
    inputBinding:
      position: 1
      prefix: --log
  - id: verbosity
    type:
      - 'null'
      - int
    doc: "Level of verbosity (1 - 5 - default = 4) 5 = Very verbose, 1 = Silent"
    inputBinding:
      position: 1
      prefix: --verbosity
  - id: output
    type:
      - 'null'
      - string
    doc: "Output directory"
    inputBinding:
      position: 1
      prefix: --output
  - id: force
    type:
      - 'null'
      - boolean
    doc: "Overwrite previous run"
    inputBinding:
      position: 1
      prefix: --force
  - id: annotate_output
    type:
      - 'null'
      - Directory
    doc: "Output directory provided by enrichm annotate"
    inputBinding:
      position: 1
      prefix: --annotate_output
  - id: metadata
    type:
      - 'null'
      - File
    doc: "Metadata file with two columns, the first with the genome name, the second with the groupings to compare."
    inputBinding:
      position: 1
      prefix: --metadata
  - id: annotation_matrix
    type:
      - 'null'
      - File
    doc: "Annotation matrix to compare."
    inputBinding:
      position: 1
      prefix: --annotation_matrix
  - id: gff_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Gff files for genomes to compare."
    inputBinding:
      position: 1
      prefix: --gff_files
  - id: abundance
    type:
      - 'null'
      - File
    doc: "Genome abundance matrix."
    inputBinding:
      position: 1
      prefix: --abundance
  - id: abundance_metadata
    type:
      - 'null'
      - File
    doc: "Metadata grouping abundance samples."
    inputBinding:
      position: 1
      prefix: --abundance_metadata
  - id: transcriptome
    type:
      - 'null'
      - File
    doc: "Genome abundance matrix."
    inputBinding:
      position: 1
      prefix: --transcriptome
  - id: transcriptome_metadata
    type:
      - 'null'
      - File
    doc: "Metadata grouping abundance samples."
    inputBinding:
      position: 1
      prefix: --transcriptome_metadata
  - id: batchfile
    type:
      - 'null'
      - File
    doc: "metadata file to compare with."
    inputBinding:
      position: 1
      prefix: --batchfile
  - id: pval_cutoff
    type:
      - 'null'
      - float
    doc: "Only output results with a p-value below a this cutoff (default=0.05)."
    inputBinding:
      position: 1
      prefix: --pval_cutoff
  - id: proportions_cutoff
    type:
      - 'null'
      - float
    doc: "Proportion enrichment cutoff."
    inputBinding:
      position: 1
      prefix: --proportions_cutoff
  - id: threshold
    type:
      - 'null'
      - float
    doc: "The threshold to control for in false discovery rate of familywise error rate."
    inputBinding:
      position: 1
      prefix: --threshold
  - id: multi_test_correction
    type:
      - 'null'
      - string
    doc: "The form of mutiple test correction to use. Uses the statsmodel module and consequently has all of its options. Default: Benjamini-Hochberg FDR (fdr_bh)  Options: Bonferroni (b)  \t Sidak (s)  \t Holm (h)  \t Holm-Sidak (hs)  \t Simes-Hochberg (sh)  \t Hommel (ho)  \t FDR Benjamini-Yekutieli (fdr_by)  \t FDR 2-stage Benjamini-Hochberg (fdr_tsbh)  \t FDR 2-stage Benjamini-Krieger-Yekutieli (fdr_tsbky)  \t FDR adaptive Gavrilov-Benjamini-Sarkar (fdr_gbs))"
    inputBinding:
      position: 1
      prefix: --multi_test_correction
  - id: processes
    type:
      - 'null'
      - int
    doc: "Number of processes to use for enrichment."
    inputBinding:
      position: 1
      prefix: --processes
  - id: allow_negative_values
    type:
      - 'null'
      - boolean
    doc: "Allow negative values in input matrix."
    inputBinding:
      position: 1
      prefix: --allow_negative_values
  - id: ko
    type:
      - 'null'
      - boolean
    doc: "Compare KO ids (annotated with DIAMOND)"
    inputBinding:
      position: 1
      prefix: --ko
  - id: ko_hmm
    type:
      - 'null'
      - boolean
    doc: "Compare KO ids (annotated with HMMs)"
    inputBinding:
      position: 1
      prefix: --ko_hmm
  - id: pfam
    type:
      - 'null'
      - boolean
    doc: "Compare Pfam ids"
    inputBinding:
      position: 1
      prefix: --pfam
  - id: tigrfam
    type:
      - 'null'
      - boolean
    doc: "Compare TIGRFAM ids"
    inputBinding:
      position: 1
      prefix: --tigrfam
  - id: cluster
    type:
      - 'null'
      - boolean
    doc: "Compare cluster ids"
    inputBinding:
      position: 1
      prefix: --cluster
  - id: ortholog
    type:
      - 'null'
      - boolean
    doc: "Compare ortholog ids"
    inputBinding:
      position: 1
      prefix: --ortholog
  - id: cazy
    type:
      - 'null'
      - boolean
    doc: "Compare dbCAN ids"
    inputBinding:
      position: 1
      prefix: --cazy
  - id: ec
    type:
      - 'null'
      - boolean
    doc: "Compare EC ids"
    inputBinding:
      position: 1
      prefix: --ec
  - id: range
    type:
      - 'null'
      - int
    doc: "Base pair range to search for synteny within. Default = 2500."
    inputBinding:
      position: 1
      prefix: --range
  - id: subblock_size
    type:
      - 'null'
      - int
    doc: "Number of genes clustered in a row to be reported. Default = 2."
    inputBinding:
      position: 1
      prefix: --subblock_size
  - id: operon_mismatch_cutoff
    type:
      - 'null'
      - int
    doc: "Number of allowed mismatches when searching for operons across genomes. Default = 2."
    inputBinding:
      position: 1
      prefix: --operon_mismatch_cutoff
  - id: operon_match_score_cutoff
    type:
      - 'null'
      - float
    doc: "Score cutoff for operon matches"
    inputBinding:
      position: 1
      prefix: --operon_match_score_cutoff
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file written by the tool (named after the subcommand)
    outputBinding:
      glob: enrichment.log
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enrichm:0.6.6--pyhdfd78af_0
