cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taranys
  - reference-alleles
label: taranys_reference-alleles
doc: "Select the representative reference allele or alleles of each locus in a core gene schema (Mash distances and Leiden clustering).\n\nTool homepage: https://github.com/BU-ISCIII/taranys"
inputs:
  - id: schema
    type: Directory
    doc: "Directory where the schema with the core gene files are located."
    inputBinding:
      position: 1
      prefix: --schema
  - id: output
    type: string
    doc: "Output folder to save reference alleles"
    inputBinding:
      position: 1
      prefix: --output
  - id: eval_cluster
    type: ['null', boolean]
    doc: "Evaluate if the reference alleles match against blast with the identity set in eval-identity param"
    inputBinding:
      position: 1
      prefix: --eval-cluster
  - id: no_eval_cluster
    type: ['null', boolean]
    doc: "Negation of --eval-cluster. Evaluate if the reference alleles match against blast with the identity set in eval-identity param"
    inputBinding:
      position: 1
      prefix: --no-eval-cluster
  - id: kmer_size
    type: ['null', int]
    doc: "Mash parameter for K-mer size. Default 21."
    inputBinding:
      position: 1
      prefix: --kmer-size
  - id: sketch_size
    type: ['null', int]
    doc: "Mash parameter for Sketch size. Default 2000."
    inputBinding:
      position: 1
      prefix: --sketch-size
  - id: cluster_resolution
    type: ['null', float]
    doc: "Resolution value used for clustering. Default 0.75."
    inputBinding:
      position: 1
      prefix: --cluster-resolution
  - id: eval_identity
    type: ['null', float]
    doc: "Blast percentage identity to use for evaluation of identification. Default 85."
    inputBinding:
      position: 1
      prefix: --eval-identity
  - id: seed
    type: ['null', int]
    doc: "Seed value for clustering"
    inputBinding:
      position: 1
      prefix: --seed
  - id: cpus
    type: ['null', int]
    doc: "Number of cpus used for execution. Default 1."
    inputBinding:
      position: 1
      prefix: --cpus
  - id: force
    type: ['null', boolean]
    doc: "Overwrite the output folder if it exists"
    inputBinding:
      position: 1
      prefix: --force
  - id: no_force
    type: ['null', boolean]
    doc: "Negation of --force. Overwrite the output folder if it exists"
    inputBinding:
      position: 1
      prefix: --no-force
outputs:
  - id: output_dir
    type: Directory
    doc: "Output folder with the reference alleles."
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taranys:3.0.1--pyhdfd78af_0
