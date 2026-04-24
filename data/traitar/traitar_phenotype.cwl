cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - traitar
  - phenotype
label: traitar_phenotype
doc: "Annotate genomes and then run phenotyping\n\nTool homepage: http://github.com/aweimann/traitar"
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
  - id: mode
    type: string
    doc: Either from_genes if gene prediction amino acid fasta is available in 
      otherwise from_nucleotides in this case Prodigal is used to determine the 
      ORFs from the nucleotide fasta files in input_dir
    inputBinding:
      position: 4
  - id: output_dir
    type: Directory
    doc: 'Output directory (default: phenolyzer_output)'
    inputBinding:
      position: 5
  - id: cpus
    type:
      - 'null'
      - int
    doc: 'CPUs used for running hmmsearch & other executables (default: 1)'
    inputBinding:
      position: 106
      prefix: --cpus
  - id: gene_gff_type
    type:
      - 'null'
      - string
    doc: 'If the input is amino acids the type of gene prediction GFF file can be
      specified for mapping the phenotype predictions to the genes (default: None)'
    inputBinding:
      position: 106
      prefix: --gene_gff_type
  - id: heatmap_format
    type:
      - 'null'
      - string
    doc: choose file format for the heatmap
    inputBinding:
      position: 106
      prefix: --heatmap_format
  - id: no_heatmap_phenotype_clustering
    type:
      - 'null'
      - boolean
    doc: if option is set, don't cluster the heatmaps by phenotype and keep 
      input ordering
    inputBinding:
      position: 106
      prefix: --no_heatmap_phenotype_clustering
  - id: no_heatmap_sample_clustering
    type:
      - 'null'
      - boolean
    doc: if option is set, don't cluster the phenotype heatmaps by samples and 
      keep input ordering
    inputBinding:
      position: 106
      prefix: --no_heatmap_sample_clustering
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: 'Overwrite output directories (default: False)'
    inputBinding:
      position: 106
      prefix: --overwrite
  - id: parallel
    type:
      - 'null'
      - int
    doc: 'Number of samples to process in parallel (default: 1)'
    inputBinding:
      position: 106
      prefix: --parallel
  - id: primary_models
    type:
      - 'null'
      - File
    doc: Primary phenotype models archive
    inputBinding:
      position: 106
      prefix: --primary_models
  - id: rearrange_heatmap
    type:
      - 'null'
      - string
    doc: 'Recompute the phenotype heatmaps based on a subset of previously annotated
      and phenotyped samples(default: None)'
    inputBinding:
      position: 106
      prefix: --rearrange_heatmap
  - id: secondary_models
    type:
      - 'null'
      - File
    doc: Secondary phenotype models archive
    inputBinding:
      position: 106
      prefix: --secondary_models
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/traitar:3.0.1--pyhdfd78af_0
stdout: traitar_phenotype.out
