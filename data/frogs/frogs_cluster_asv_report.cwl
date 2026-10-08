cwlVersion: v1.2
class: CommandLineTool
baseCommand: cluster_asv_report.py
label: frogs_cluster_asv_report
doc: "Process several metrics on abundance from BIOM file.\n\nTool homepage: https://github.com/geraldinepascal/FROGS"
inputs:
  - id: debug
    type: ['null', boolean]
    doc: "Keep temporary files to debug program."
    inputBinding:
      position: 1
      prefix: --debug
  - id: hierarchical_clustering
    type: ['null', boolean]
    doc: "Perform Hierarchical classification on observation proportions. [Default: False]"
    inputBinding:
      position: 2
      prefix: --hierarchical-clustering
  - id: distance_method
    type: ['null', {type: enum, symbols: [euclidean, cityblock, seuclidean, sqeuclidean, cosine, correlation, hamming, jaccard, chebyshev, canberra, braycurtis, mahalanobis, yule, matching, dice, kulsinski, rogerstanimoto, russellrao, sokalmichener, sokalsneath, wminkowski]}]
    doc: "Used distance method for classify (see http://docs.sci py.org/doc/scipy-0.14.0/reference/generated/generated/ scipy.spatial.distance.pdist.html#scipy.spatial.distan ce.pdist). [Default: braycurtis]"
    inputBinding:
      position: 3
      prefix: --distance-method
  - id: linkage_method
    type: ['null', {type: enum, symbols: [single, complete, average, weighted, centroid, median, ward]}]
    doc: "Used linkage method for classify (see http://docs.scip y.org/doc/scipy-0.14.0/reference/generated/scipy.clust er.hierarchy.linkage.html). [Default: average]"
    inputBinding:
      position: 4
      prefix: --linkage-method
  - id: input_biom
    type: File
    doc: "The BIOM file to process."
    inputBinding:
      position: 5
      prefix: --input-biom
  - id: html_path
    type: ['null', string]
    doc: "The HTML file containing the graphs. [Default: cluster_asv_report.html]"
    inputBinding:
      position: 6
      prefix: --html
  - id: log_file_path
    type: ['null', string]
    doc: "This output file will contain several informations on executed commands. [Default: stdout]"
    inputBinding:
      position: 7
      prefix: --log-file
outputs:
  - id: html
    type: ['null', File]
    doc: "The HTML file containing the graphs. [Default: cluster_asv_report.html]"
    outputBinding:
      glob: '${ return inputs.html_path ? inputs.html_path : ''cluster_asv_report.html''; }'
  - id: log_file
    type: ['null', File]
    doc: "This output file will contain several informations on executed commands. [Default: stdout]"
    outputBinding:
      glob: '${ return inputs.log_file_path ? inputs.log_file_path : ''cluster_asv_report_stdout.txt''; }'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
stdout: cluster_asv_report_stdout.txt
