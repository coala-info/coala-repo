cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/igraph_extract_clusters.R
label: scran-cli_igraph_extract_clusters.R
doc: "Extracts cluster annotations from an igraph object and adds them to a SingleCellExperiment
  object.\n\nTool homepage: https://github.com/ebi-gene-expression-group/scran-cli"
inputs:
  - id: input_igraph_object
    type: File
    doc: Path to the input igraph object in rds format.
    inputBinding:
      position: 101
      prefix: --input-igraph-object
  - id: input_sce_object
    type: File
    doc: Path to the input SCE object where to add the cluster annotation 
      extracted from the igraph objecti.
    inputBinding:
      position: 101
      prefix: --input-sce-object
outputs:
  - id: output_sce_object
    type: File
    doc: Path to the output SCE object in rds format with cluster annotation in 
      $cluster.
    outputBinding:
      glob: $(inputs.output_sce_object)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scran-cli:v0.0.1--hdfd78af_1
