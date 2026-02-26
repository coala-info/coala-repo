cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtotree_gtt-hmms
label: gtotree_gtt-hmms
doc: "GToTree pre-packaged HMM SCG-sets. See github.com/AstrobioMike/GToTree/wiki/SCG-sets
  for more info\n\nTool homepage: https://github.com/AstrobioMike/GToTree/wiki/what-is-gtotree%3F"
inputs:
  - id: hmm_dir
    type:
      - 'null'
      - Directory
    doc: Directory containing HMM SCG-sets. Defaults to GToTree_HMM_dir 
      environment variable.
    inputBinding:
      position: 101
      prefix: --hmm-dir
  - id: hmm_source_info
    type:
      - 'null'
      - File
    doc: Path to the HMM sources and info TSV file. Defaults to 
      /usr/local/share/gtotree/hmm_sets/hmm-sources-and-info.tsv
    inputBinding:
      position: 101
      prefix: --hmm-source-info
  - id: set
    type:
      - 'null'
      - string
    doc: 'Name of the HMM SCG-set to use. Available sets: Actinobacteria, Alphaproteobacteria,
      Archaea, Bacteria, Bacteria_and_Archaea, Bacteroidetes, Betaproteobacteria,
      Chlamydiae, Cyanobacteria, Epsilonproteobacteria, Firmicutes, Gammaproteobacteria,
      Proteobacteria, Tenericutes, Universal-Hug-et-al'
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtotree:1.8.16--h9ee0642_2
stdout: gtotree_gtt-hmms.out
