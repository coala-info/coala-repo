cwlVersion: v1.2
class: CommandLineTool
baseCommand: frogsfunc_placeseqs.py
label: frogs_frogsfunc_placeseqs
doc: "place studies sequences (i.e. ASVs) into a reference tree.\n\nTool homepage: https://github.com/geraldinepascal/FROGS"
inputs:
  - id: debug
    type: ['null', boolean]
    doc: "Keep temporary files to debug program. [Default: False]"
    inputBinding:
      position: 1
      prefix: --debug
  - id: nb_cpus
    type: ['null', int]
    doc: "The maximum number of CPUs used. [Default: 1]"
    inputBinding:
      position: 2
      prefix: --nb-cpus
  - id: placement_tool
    type: ['null', {type: enum, symbols: [epa-ng, sepp]}]
    doc: "Tool to place sequences into reference tree. Note that epa-ng is more sensitiv but very memory and computing power intensive. Warning : sepp is not usable for ITS and 18S analysis [Default: epa-ng]"
    inputBinding:
      position: 3
      prefix: --placement-tool
  - id: min_align
    type: ['null', float]
    doc: "Proportion of the total length of an input query sequence that must align with reference sequences. Any sequences with lengths below this value after making an alignment with reference sequences will be excluded from the placement and all subsequent steps. [Default: 0.8]."
    inputBinding:
      position: 4
      prefix: --min-align
  - id: hsp_method
    type: ['null', {type: enum, symbols: [mp, emp_prob, pic, scp, subtree_average]}]
    doc: "HSP method to use. mp: predict discrete traits using max parsimony. emp_prob: predict discrete traits based on empirical state probabilities across tips. subtree_average: predict continuous traits using subtree averaging. pic: predict continuous traits with phylogentic independent contrast. scp: reconstruct continuous traits using squared-change parsimony [Default: mp]."
    inputBinding:
      position: 5
      prefix: --hsp-method
  - id: input_fasta
    type: File
    doc: "Input fasta file of unaligned studies sequences."
    inputBinding:
      position: 6
      prefix: --input-fasta
  - id: input_biom
    type: File
    doc: "Input biom file of unaligned studies sequences."
    inputBinding:
      position: 7
      prefix: --input-biom
  - id: ref_dir
    type: ['null', string]
    doc: "If marker studied is not 16S, the directory containing reference sequence files (for ITS, see: $PICRUST2_PATH/default_files/fungi/fungi_ITS"
    inputBinding:
      position: 8
      prefix: --ref-dir
  - id: input_marker_table
    type: ['null', File]
    doc: "If marker studied is not 16S, the marker table describing copy number by genome assembly. (ex: $PICRUSt2_PATH/default_files/fungi/ITS_counts.txt.gz)."
    inputBinding:
      position: 9
      prefix: --input-marker-table
  - id: output_tree_path
    type: ['null', string]
    doc: "Reference and ASV phylogentic tree (format: newick). [Default: frogsfunc_placeseqs_tree.nwk]"
    inputBinding:
      position: 10
      prefix: --output-tree
  - id: excluded_path
    type: ['null', string]
    doc: "Excluded ASV list. [Default: frogsfunc_placeseqs_asv_excluded.txt]"
    inputBinding:
      position: 11
      prefix: --excluded
  - id: output_fasta_path
    type: ['null', string]
    doc: "Kept ASV sequence file. (format: FASTA). [Default: frogsfunc_placeseqs.fasta]"
    inputBinding:
      position: 12
      prefix: --output-fasta
  - id: output_biom_path
    type: ['null', string]
    doc: "Kept ASV abundance file. (format: BIOM) [Default: frogsfunc_placeseqs.biom]"
    inputBinding:
      position: 13
      prefix: --output-biom
  - id: closests_ref_path
    type: ['null', string]
    doc: "Informations about Clusters (i.e ASVs) and PICRUSt2 closest reference from cluster sequences (identifiants, taxonomies, phylogenetic distance from reference, nucleotidics sequences). [Default: frogsfunc_placeseqs_closests_ref_sequences.txt]"
    inputBinding:
      position: 14
      prefix: --closests-ref
  - id: html_path
    type: ['null', string]
    doc: "HTML report. [Default: frogsfunc_placeseqs_summary.html]"
    inputBinding:
      position: 15
      prefix: --html
  - id: output_marker_copy_path
    type: ['null', string]
    doc: "Predicted marker gene copy numbers per kept ASV. If the extension \".gz\" is added the table will automatically be gzipped. [Default: frogsfunc_marker_copy_per_asv.tsv]"
    inputBinding:
      position: 16
      prefix: --output-marker-copy
  - id: log_file_path
    type: ['null', string]
    doc: "List of commands executed. [Default: stdout]"
    inputBinding:
      position: 17
      prefix: --log-file
outputs:
  - id: output_tree
    type: ['null', File]
    doc: "Reference and ASV phylogentic tree (format: newick). [Default: frogsfunc_placeseqs_tree.nwk]"
    outputBinding:
      glob: '${ return inputs.output_tree_path ? inputs.output_tree_path : ''frogsfunc_placeseqs_tree.nwk''; }'
  - id: excluded
    type: ['null', File]
    doc: "Excluded ASV list. [Default: frogsfunc_placeseqs_asv_excluded.txt]"
    outputBinding:
      glob: '${ return inputs.excluded_path ? inputs.excluded_path : ''frogsfunc_placeseqs_asv_excluded.txt''; }'
  - id: output_fasta
    type: ['null', File]
    doc: "Kept ASV sequence file. (format: FASTA). [Default: frogsfunc_placeseqs.fasta]"
    outputBinding:
      glob: '${ return inputs.output_fasta_path ? inputs.output_fasta_path : ''frogsfunc_placeseqs.fasta''; }'
  - id: output_biom
    type: ['null', File]
    doc: "Kept ASV abundance file. (format: BIOM) [Default: frogsfunc_placeseqs.biom]"
    outputBinding:
      glob: '${ return inputs.output_biom_path ? inputs.output_biom_path : ''frogsfunc_placeseqs.biom''; }'
  - id: closests_ref
    type: ['null', File]
    doc: "Informations about Clusters (i.e ASVs) and PICRUSt2 closest reference from cluster sequences (identifiants, taxonomies, phylogenetic distance from reference, nucleotidics sequences). [Default: frogsfunc_placeseqs_closests_ref_sequences.txt]"
    outputBinding:
      glob: '${ return inputs.closests_ref_path ? inputs.closests_ref_path : ''frogsfunc_placeseqs_closests_ref_sequences.txt''; }'
  - id: html
    type: ['null', File]
    doc: "HTML report. [Default: frogsfunc_placeseqs_summary.html]"
    outputBinding:
      glob: '${ return inputs.html_path ? inputs.html_path : ''frogsfunc_placeseqs_summary.html''; }'
  - id: output_marker_copy
    type: ['null', File]
    doc: "Predicted marker gene copy numbers per kept ASV. If the extension \".gz\" is added the table will automatically be gzipped. [Default: frogsfunc_marker_copy_per_asv.tsv]"
    outputBinding:
      glob: '${ return inputs.output_marker_copy_path ? inputs.output_marker_copy_path : ''frogsfunc_marker_copy_per_asv.tsv''; }'
  - id: log_file
    type: ['null', File]
    doc: "List of commands executed. [Default: stdout]"
    outputBinding:
      glob: '${ return inputs.log_file_path ? inputs.log_file_path : ''frogsfunc_placeseqs_stdout.txt''; }'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
stdout: frogsfunc_placeseqs_stdout.txt
