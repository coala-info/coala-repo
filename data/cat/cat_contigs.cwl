cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - CAT_pack
  - contigs
label: cat_contigs
doc: "Run Contig Annotation Tool (CAT).\n\nTool homepage: https://github.com/MGXlab/CAT_pack"
inputs:
  - id: contigs_fasta
    type: File
    doc: "Path to contigs fasta file."
    inputBinding:
      position: 101
      prefix: --contigs_fasta
  - id: database_folder
    type: Directory
    doc: "Path to directory that contains database files."
    inputBinding:
      position: 101
      prefix: --database_folder
  - id: taxonomy_folder
    type: Directory
    doc: "Path to directory that contains taxonomy files."
    inputBinding:
      position: 101
      prefix: --taxonomy_folder
  - id: range
    type:
      - 'null'
      - float
    doc: "r parameter [0-100] (default: 10)."
    inputBinding:
      position: 101
      prefix: --range
  - id: fraction
    type:
      - 'null'
      - float
    doc: "f parameter [0-0.99] (default: 0.50)."
    inputBinding:
      position: 101
      prefix: --fraction
  - id: out_prefix
    type:
      - 'null'
      - string
    doc: "Prefix for output files (default: ./out.CAT)."
    inputBinding:
      position: 101
      prefix: --out_prefix
  - id: proteins_fasta
    type:
      - 'null'
      - File
    doc: "Path to predicted proteins fasta file. If supplied, the protein prediction step is skipped."
    inputBinding:
      position: 101
      prefix: --proteins_fasta
  - id: diamond_alignment
    type:
      - 'null'
      - File
    doc: "Path to alignment table. If supplied, the alignment step is skipped and classification is carried out directly. A predicted proteins fasta file should also be supplied with argument [-p / --proteins]."
    inputBinding:
      position: 101
      prefix: --diamond_alignment
  - id: path_to_prodigal
    type:
      - 'null'
      - string
    doc: "Path to Prodigal binaries. Supply if CAT/BAT/RAT cannot find Prodigal"
    inputBinding:
      position: 101
      prefix: --path_to_prodigal
  - id: path_to_diamond
    type:
      - 'null'
      - string
    doc: "Path to DIAMOND binaries. Supply if CAT/BAT/RAT cannot find DIAMOND."
    inputBinding:
      position: 101
      prefix: --path_to_diamond
  - id: no_stars
    type:
      - 'null'
      - boolean
    doc: "Suppress marking of suggestive taxonomic assignments."
    inputBinding:
      position: 101
      prefix: --no_stars
  - id: i_know_what_im_doing
    type:
      - 'null'
      - boolean
    doc: "Flag for experimental features."
    inputBinding:
      position: 101
      prefix: --I_know_what_Im_doing
  - id: force
    type:
      - 'null'
      - boolean
    doc: "Force overwrite existing files."
    inputBinding:
      position: 101
      prefix: --force
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Suppress verbosity."
    inputBinding:
      position: 101
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Increase verbosity."
    inputBinding:
      position: 101
      prefix: --verbose
  - id: no_log
    type:
      - 'null'
      - boolean
    doc: "Suppress log file."
    inputBinding:
      position: 101
      prefix: --no_log
  - id: nproc
    type:
      - 'null'
      - int
    doc: "Number of cores to deploy by DIAMOND (default: maximum)."
    inputBinding:
      position: 101
      prefix: --nproc
  - id: sensitive
    type:
      - 'null'
      - boolean
    doc: "Run DIAMOND in sensitive mode (default: not enabled)."
    inputBinding:
      position: 101
      prefix: --sensitive
  - id: no_self_hits
    type:
      - 'null'
      - boolean
    doc: "Do not report identical self hits by DIAMOND (default: not enabled)."
    inputBinding:
      position: 101
      prefix: --no_self_hits
  - id: block_size
    type:
      - 'null'
      - float
    doc: "DIAMOND block-size parameter (default: 12.0). Lower numbers will decrease memory and temporary disk space usage."
    inputBinding:
      position: 101
      prefix: --block_size
  - id: index_chunks
    type:
      - 'null'
      - int
    doc: "DIAMOND index-chunks parameter (default: 1). Set to 4 on low memory machines."
    inputBinding:
      position: 101
      prefix: --index_chunks
  - id: tmpdir
    type:
      - 'null'
      - string
    doc: "Directory for temporary DIAMOND files (default: directory to which output files are written)."
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: compress
    type:
      - 'null'
      - boolean
    doc: "Compress DIAMOND alignment file (default: not enabled)."
    inputBinding:
      position: 101
      prefix: --compress
  - id: top
    type:
      - 'null'
      - float
    doc: "DIAMOND top parameter [0-100] (default: 11). Governs hits within range of best hit that are written to the alignment file."
    inputBinding:
      position: 101
      prefix: --top
outputs:
  - id: all_outputs
    type:
      type: array
      items: File
    doc: "All files written with the output prefix"
    outputBinding:
      glob: "$((inputs.out_prefix ? inputs.out_prefix : 'out.CAT') + '*')"
  - id: contig2classification
    type:
      - 'null'
      - File
    doc: "Contig classification table"
    outputBinding:
      glob: "$((inputs.out_prefix ? inputs.out_prefix : 'out.CAT') + '.contig2classification.txt')"
  - id: orf2lca
    type:
      - 'null'
      - File
    doc: "ORF to lowest common ancestor table"
    outputBinding:
      glob: "$((inputs.out_prefix ? inputs.out_prefix : 'out.CAT') + '.ORF2LCA.txt')"
  - id: predicted_proteins
    type:
      - 'null'
      - File
    doc: "Predicted proteins"
    outputBinding:
      glob: "$((inputs.out_prefix ? inputs.out_prefix : 'out.CAT') + '.predicted_proteins.faa')"
  - id: alignment
    type:
      - 'null'
      - File
    doc: "DIAMOND alignment table"
    outputBinding:
      glob: "$((inputs.out_prefix ? inputs.out_prefix : 'out.CAT') + '.alignment.diamond')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cat:6.0.1--hdfd78af_1
