cwlVersion: v1.2
class: CommandLineTool
baseCommand: traitar annotate
label: traitar_annotate
doc: "Annotate genomes\n\nTool homepage: http://github.com/aweimann/traitar"
inputs:
  - id: pfam_dir
    type: Directory
    doc: Download directory of pfam subcommand
    inputBinding:
      position: 1
  - id: input_dir
    type: Directory
    doc: directory with the input data
    inputBinding:
      position: 2
  - id: sample2file
    type: string
    doc: 'Mapping from samples to fasta files (also see gitHub help): sample1_file_name{tab}sample1_name
      sample2_file_name{tab}sample2_name'
    inputBinding:
      position: 3
  - id: annotation_mode
    type: string
    doc: Either from_genes if gene prediction amino acid fasta is available in 
      otherwise from_nucleotides in this case Prodigal is used to determine the 
      ORFs from the nucleotide fasta files in input_dir
    inputBinding:
      position: 4
  - id: output_dir
    type: Directory
    doc: 'Output directory (default: phenolyzer_output)'
    default: phenolyzer_output
    inputBinding:
      position: 5
  - id: cpus
    type:
      - 'null'
      - int
    doc: 'CPUs used for running hmmsearch & other executables (default: 1)'
    default: 1
    inputBinding:
      position: 106
      prefix: --cpus
  - id: gene_gff_type
    type:
      - 'null'
      - string
    doc: 'If the input is amino acids the type of gene prediction GFF file can be
      specified for mapping the phenotype predictions to the genes (default: None)'
    default: None
    inputBinding:
      position: 106
      prefix: --gene_gff_type
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: 'Overwrite output directories (default: False)'
    default: false
    inputBinding:
      position: 106
      prefix: --overwrite
  - id: parallel
    type:
      - 'null'
      - int
    doc: 'Number of samples to process in parallel (default: 1)'
    default: 1
    inputBinding:
      position: 106
      prefix: --parallel
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/traitar:3.0.1--pyhdfd78af_0
stdout: traitar_annotate.out
