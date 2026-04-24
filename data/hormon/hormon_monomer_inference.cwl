cwlVersion: v1.2
class: CommandLineTool
baseCommand: monomer_inference
label: hormon_monomer_inference
doc: "Monomer Inference Problem: complement monomers set\n\nTool homepage: https://github.com/ablab/HORmon"
inputs:
  - id: continue
    type:
      - 'null'
      - boolean
    doc: continue run from output dir
    inputBinding:
      position: 101
      prefix: --continue
  - id: max_divergence
    type:
      - 'null'
      - int
    doc: max divergence in identity for monomeric-block
    inputBinding:
      position: 101
      prefix: --max-divergence
  - id: max_resolved_divergence
    type:
      - 'null'
      - int
    doc: max divergence in identity for resolve block
    inputBinding:
      position: 101
      prefix: --max-resolved-divergence
  - id: min_cluster_size
    type:
      - 'null'
      - int
    doc: When maximum size of cluster will be less MIN_CLST the monomer 
      inferense will finished
    inputBinding:
      position: 101
      prefix: --min-cluster-size
  - id: monomers
    type:
      - 'null'
      - File
    doc: fasta-file with monomers
    inputBinding:
      position: 101
      prefix: --monomers
  - id: sequences
    type:
      - 'null'
      - File
    doc: fasta-file with long reads or genomic sequences
    inputBinding:
      position: 101
      prefix: --sequences
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hormon:1.0.0--pyhdfd78af_0
