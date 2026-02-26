cwlVersion: v1.2
class: CommandLineTool
baseCommand: centreseq extract
label: centreseq_extract
doc: "Given the path to the centreseq core directory and the ID of a cluster representative,
  will create a multi-FASTA containing the sequences for all members of that cluster.
  Generates both an .ffn and .faa file.\n\nTool homepage: https://github.com/bfssi-forest-dussault/centreseq"
inputs:
  - id: cluster_representative
    type: string
    doc: "Name of the target cluster representative\ne.g. \"Typhi.2299.BMH_00195\""
    inputBinding:
      position: 101
      prefix: --cluster_representative
  - id: indir
    type: Directory
    doc: Path to your centreseq output directory
    inputBinding:
      position: 101
      prefix: --indir
  - id: outdir
    type: Directory
    doc: Root directory to store all output files
    inputBinding:
      position: 101
      prefix: --outdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/centreseq:0.3.8--py_0
stdout: centreseq_extract.out
