cwlVersion: v1.2
class: CommandLineTool
baseCommand: cluster_filters.py
label: frogs_cluster_filters
doc: "Filters an abundance file\n\nTool homepage: https://github.com/geraldinepascal/FROGS"
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
  - id: nb_biggest_clusters
    type: ['null', int]
    doc: "Number of most abundant clusters you want to keep, after all others filters applied."
    inputBinding:
      position: 3
      prefix: --nb-biggest-clusters
  - id: min_sample_presence
    type: ['null', int]
    doc: "Keep cluster present in at least this number of samples."
    inputBinding:
      position: 4
      prefix: --min-sample-presence
  - id: min_replicate_presence
    type: ['null', float]
    doc: "Keep cluster present in at least this proportion of replicates in at least one group (please indicate a proportion between 0 and 1). Replicates must be defined with --replicate_file REPLICATE FILE"
    inputBinding:
      position: 5
      prefix: --min-replicate-presence
  - id: min_abundance
    type: ['null', float]
    doc: "Minimum percentage/number of sequences, comparing to the total number of sequences, of a cluster (between 0 and 1 if percentage desired)."
    inputBinding:
      position: 6
      prefix: --min-abundance
  - id: input_biom
    type: File
    doc: "The input BIOM file. (format: BIOM)"
    inputBinding:
      position: 7
      prefix: --input-biom
  - id: input_fasta
    type: File
    doc: "The input FASTA file. (format: FASTA)"
    inputBinding:
      position: 8
      prefix: --input-fasta
  - id: contaminant
    type: ['null', File]
    doc: "Use this databank to filter sequence before affiliation. (format: FASTA)"
    inputBinding:
      position: 9
      prefix: --contaminant
  - id: replicate_tsv
    type: ['null', File]
    doc: "Sample replicate tsv file must be specified if --min- replicate-presence is set. First column indicates the sample name, and the second column the group name."
    inputBinding:
      position: 10
      prefix: --replicate-tsv
  - id: output_biom_path
    type: ['null', string]
    doc: "The BIOM file output. (format: BIOM) [Default: cluster_filters_abundance.biom]"
    inputBinding:
      position: 11
      prefix: --output-biom
  - id: output_fasta_path
    type: ['null', string]
    doc: "The FASTA output file. (format: FASTA) [Default: cluster_filters.fasta]"
    inputBinding:
      position: 12
      prefix: --output-fasta
  - id: html_path
    type: ['null', string]
    doc: "The HTML file containing the graphs. [Default: cluster_filters.html]"
    inputBinding:
      position: 13
      prefix: --html
  - id: excluded_path
    type: ['null', string]
    doc: "The TSV file that summarizes all the discarded clusters. (format: TSV) [Default: cluster_filters_excluded.tsv]"
    inputBinding:
      position: 14
      prefix: --excluded
  - id: log_file_path
    type: ['null', string]
    doc: "This output file will contain several information on executed commands. [Default: stdout]"
    inputBinding:
      position: 15
      prefix: --log-file
outputs:
  - id: output_biom
    type: ['null', File]
    doc: "The BIOM file output. (format: BIOM) [Default: cluster_filters_abundance.biom]"
    outputBinding:
      glob: '${ return inputs.output_biom_path ? inputs.output_biom_path : ''cluster_filters_abundance.biom''; }'
  - id: output_fasta
    type: ['null', File]
    doc: "The FASTA output file. (format: FASTA) [Default: cluster_filters.fasta]"
    outputBinding:
      glob: '${ return inputs.output_fasta_path ? inputs.output_fasta_path : ''cluster_filters.fasta''; }'
  - id: html
    type: ['null', File]
    doc: "The HTML file containing the graphs. [Default: cluster_filters.html]"
    outputBinding:
      glob: '${ return inputs.html_path ? inputs.html_path : ''cluster_filters.html''; }'
  - id: excluded
    type: ['null', File]
    doc: "The TSV file that summarizes all the discarded clusters. (format: TSV) [Default: cluster_filters_excluded.tsv]"
    outputBinding:
      glob: '${ return inputs.excluded_path ? inputs.excluded_path : ''cluster_filters_excluded.tsv''; }'
  - id: log_file
    type: ['null', File]
    doc: "This output file will contain several information on executed commands. [Default: stdout]"
    outputBinding:
      glob: '${ return inputs.log_file_path ? inputs.log_file_path : ''cluster_filters_stdout.txt''; }'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
stdout: cluster_filters_stdout.txt
