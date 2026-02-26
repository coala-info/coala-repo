cwlVersion: v1.2
class: CommandLineTool
baseCommand: metafx feature_analysis
label: metafx_feature_analysis
doc: "MetaFX feature_analysis module – pipeline to build de Bruijn graphs for samples
  with selected feature and visualize them in BandageNG (https://github.com/ctlab/BandageNG)\n\
  \nTool homepage: https://github.com/ctlab/metafx"
inputs:
  - id: feature_dir
    type: Directory
    doc: directory containing folders with contigs for each category, 
      feature_table.tsv and categories_samples.tsv files. Usually, it is workDir
      from other MetaFX modules (unique, stats, colored, metafast, metaspades)
    inputBinding:
      position: 101
      prefix: --feature-dir
  - id: feature_name
    type: string
    doc: name of the feature of interest (should be one of the values from first
      column of feature_table.tsv)
    inputBinding:
      position: 101
      prefix: --feature-name
  - id: k
    type: int
    doc: k-mer size to build de Bruij graphs (in nucleotides, maximum value is 
      31)
    inputBinding:
      position: 101
      prefix: --k
  - id: memory
    type:
      - 'null'
      - string
    doc: 'memory to use (values with suffix: 1500M, 4G, etc.)'
    inputBinding:
      position: 101
      prefix: --memory
  - id: reads_dir
    type: Directory
    doc: directory containing files with reads for samples. FASTQ, FASTA, gzip- 
      or bzip2-compressed
    inputBinding:
      position: 101
      prefix: --reads-dir
  - id: relab
    type:
      - 'null'
      - float
    doc: minimal relative abundance of feature in sample to include sample for 
      further analysis
    default: 0.1
    inputBinding:
      position: 101
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: work_dir
    type:
      - 'null'
      - Directory
    doc: working directory
    inputBinding:
      position: 101
      prefix: --work-dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metafx:1.1.0--hdfd78af_0
stdout: metafx_feature_analysis.out
