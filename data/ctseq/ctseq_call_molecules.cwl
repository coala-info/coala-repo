cwlVersion: v1.2
class: CommandLineTool
baseCommand: ctseq call_molecules
label: ctseq_call_molecules
doc: "Call methylation states for molecules based on UMIs and consensus threshold.\n\
  \nTool homepage: https://github.com/ryanhmiller/ctseq"
inputs:
  - id: consensus
    type:
      - 'null'
      - float
    doc: consensus threshold to make consensus methylation call from all the 
      reads with the same UMI
    inputBinding:
      position: 101
      prefix: --consensus
  - id: dir
    type:
      - 'null'
      - Directory
    doc: Full path to directory where your .sam files are located. If no '--dir'
      is specified, ctseq will look in your current directory.
    inputBinding:
      position: 101
      prefix: --dir
  - id: processes
    type:
      - 'null'
      - int
    doc: number of processes (default=1; default settings could take a long time
      to run)
    inputBinding:
      position: 101
      prefix: --processes
  - id: ref_dir
    type:
      - 'null'
      - Directory
    doc: Full path to directory where you have already built your methylation 
      reference files. If no '--refDir' is specified, ctseq will look in your 
      current directory.
    inputBinding:
      position: 101
      prefix: --refDir
  - id: umi_collapse_alg
    type:
      - 'null'
      - string
    doc: 'algorithm used to collapse UMIs, options: default=directional'
    inputBinding:
      position: 101
      prefix: --umiCollapseAlg
  - id: umi_threshold
    type:
      - 'null'
      - int
    doc: UMIs with this edit distance will be collapsed together, default=0 
      (don't collapse)
    inputBinding:
      position: 101
      prefix: --umiThreshold
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ctseq:0.0.2--py_0
stdout: ctseq_call_molecules.out
