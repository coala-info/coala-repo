cwlVersion: v1.2
class: CommandLineTool
baseCommand: pneumo-typer.pl
label: pneumo-typer
doc: "A comprehensive prediction and visualization of serotype and sequence type for
  streptococcus pneumoniae using assembled genomes.\n\nTool homepage: https://www.microbialgenomic.cn/Pneumo-Typer.html"
inputs:
  - id: cgmlst
    type:
      - 'null'
      - boolean
    doc: Perform cgmlst analysis. It needs about 3 mins for one genome
    inputBinding:
      position: 101
      prefix: --cgmlst
  - id: genbank_file_directory
    type: Directory
    doc: A directory containing files in GenBank format, FASTA format, or a 
      combination of both.
    inputBinding:
      position: 101
      prefix: --genbank_file_directory
  - id: homologous_gene_cutoff
    type:
      - 'null'
      - string
    doc: Set E-value, Identify, Coverage (Query and Subject), Match_length 
      (alignment length) cutoff in Blastn analysis
    inputBinding:
      position: 101
      prefix: --homologous_gene_cutoff
  - id: mlst
    type:
      - 'null'
      - boolean
    doc: Perform mlst analysis
    inputBinding:
      position: 101
      prefix: --mlst
  - id: multiple_threads
    type:
      - 'null'
      - int
    doc: Set thread number
    inputBinding:
      position: 101
      prefix: --multiple_threads
  - id: phylogenetic_tree
    type:
      - 'null'
      - File
    doc: A Newick format tree file is used by Pneumo-Typer to automatically 
      associate the genomes with their phylogeny. Meanwhile, Pneumo-Typer will 
      output a file named "temp_strain_reorder_file-svg.txt", which contains the
      order information of genomes in the tree from up to down. It should be 
      noted that all node names in the provided tree must completely match the 
      input file names of all genomes.
    inputBinding:
      position: 101
      prefix: --phylogenetic_tree
  - id: prodigal_annotation
    type:
      - 'null'
      - boolean
    doc: Annotate all genomes using prodigal
    inputBinding:
      position: 101
      prefix: --prodigal_annotation
  - id: recreate_figure
    type:
      - 'null'
      - boolean
    doc: Re-create the figure of the genetic organization of cps gene cluster 
      for genomes. At this step, users can add a parameter "phylogenetic_tree" 
      or "strain_reorder_file".
    inputBinding:
      position: 101
      prefix: --recreate_figure
  - id: recreate_heatmap
    type:
      - 'null'
      - boolean
    doc: Re-create the heatmap of cps gene distribution in genomes. At this 
      step, users can add a parameter "phylogenetic_tree" or 
      "strain_reorder_file".
    inputBinding:
      position: 101
      prefix: --recreate_heatmap
  - id: skip_blastn
    type:
      - 'null'
      - boolean
    doc: Skip the process of doing blastn during serotype analysis.
    inputBinding:
      position: 101
      prefix: --skip_blastn
  - id: skip_sequence_processing
    type:
      - 'null'
      - boolean
    doc: Skip the process of sequence processing (STEP-1)
    inputBinding:
      position: 101
      prefix: --skip_sequence_processing
  - id: strain_reorder_file
    type:
      - 'null'
      - File
    doc: A two-column tab-delimited text file is used to sort genomes from up to
      down according to users' requirements. Each row must consist of a strain 
      name followed by the numerical order that is used for sorting genomes. It 
      should be noted that all strain names must completely match the input file
      names of all genomes.
    inputBinding:
      position: 101
      prefix: --strain_reorder_file
  - id: test
    type:
      - 'null'
      - boolean
    doc: Run pneumo-typer using Test_data as input to check whether Pneumo-Typer
      is installed successfully
    inputBinding:
      position: 101
      prefix: --test
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: An output directory holding all the generated files by pneumo-typer.pl.
      if this option is not set,  a directory named "pneumo-typer_workplace" 
      will be created in the bin directory from where pneumo-typer.pl was 
      invoked.
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pneumo-typer:2.0.1--hdfd78af_0
