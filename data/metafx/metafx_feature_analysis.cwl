cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metafx
  - feature_analysis
label: metafx_feature_analysis
doc: "pipeline to build de Bruijn graphs for samples with selected feature and visualize them in BandageNG\n\nTool homepage: https://github.com/ctlab/metafx"
requirements:
  - class: ShellCommandRequirement
arguments:
  - position: 102
    shellQuote: false
    valueFrom: "> metafx_feature_analysis.out && find $(inputs.work_dir) -type l -exec sh -c 't=`readlink -f \"$0\"`; rm \"$0\"; cp -r \"$t\" \"$0\"' {} \\;"
inputs:
  - id: k
    type: int
    doc: "k-mer size (in nucleotides, maximum value is 31)"
    inputBinding:
      position: 101
      prefix: --k
  - id: feature_dir
    type: Directory
    doc: "directory containing folders with contigs for each category, feature_table.tsv and categories_samples.tsv files. Usually, it is workDir from other MetaFX modules (unique, stats, colored, metafast, metaspades)"
    inputBinding:
      position: 101
      prefix: --feature-dir
  - id: feature_name
    type: string
    doc: "name of the feature of interest (should be one of the values from first column of feature_table.tsv)"
    inputBinding:
      position: 101
      prefix: --feature-name
  - id: reads_dir
    type: Directory
    doc: "directory containing files with reads for samples. FASTQ, FASTA, gzip- or bzip2-compressed"
    inputBinding:
      position: 101
      prefix: --reads-dir
  - id: relab
    type: ['null', float]
    doc: "minimal relative abundance of feature in sample to include sample for further analysis [default: 0.1]"
    inputBinding:
      position: 101
      prefix: --relab
  - id: threads
    type: ['null', int]
    doc: "number of threads to use"
    inputBinding:
      position: 101
      prefix: --threads
  - id: memory
    type: ['null', string]
    doc: "memory to use (values with suffix: 1500M, 4G, etc.)"
    inputBinding:
      position: 101
      prefix: --memory
  - id: work_dir
    type: string
    doc: "working directory (created by the tool, it must not exist before the run)"
    default: workDir
    inputBinding:
      position: 101
      prefix: --work-dir
outputs:
  - id: results_dir
    type: Directory
    doc: "Working directory with the results"
    outputBinding:
      glob: $(inputs.work_dir)
  - id: stdout
    type: File
    doc: Standard output
    outputBinding:
      glob: metafx_feature_analysis.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metafx:1.1.0--hdfd78af_0
