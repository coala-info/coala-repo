cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ctseq
  - call_methylation
label: ctseq_call_methylation
doc: "Call methylation status for molecules.\n\nTool homepage: https://github.com/ryanhmiller/ctseq"
inputs:
  - id: cis_cg_threshold
    type:
      - 'null'
      - float
    doc: cis-CG threshold to determine if a molecule is methylated
    inputBinding:
      position: 101
      prefix: --cisCG
  - id: input_directory
    type:
      - 'null'
      - Directory
    doc: Full path to directory where your '*allMolecules.txt' files are 
      located. If no '--dir' is specified, ctseq will look in your current 
      directory.
    inputBinding:
      position: 101
      prefix: --dir
  - id: molecule_threshold
    type:
      - 'null'
      - int
    doc: number of reads needed to be counted as a unique molecule
    inputBinding:
      position: 101
      prefix: --moleculeThreshold
  - id: processes
    type:
      - 'null'
      - int
    doc: number of processes
    inputBinding:
      position: 101
      prefix: --processes
  - id: reference_directory
    type:
      - 'null'
      - Directory
    doc: Full path to directory where you have already built your methylation 
      reference files. If no '--refDir' is specified, ctseq will look in your 
      current directory.
    inputBinding:
      position: 101
      prefix: --refDir
  - id: run_name
    type: string
    doc: number of reads needed to be counted as a unique molecule (required)
    inputBinding:
      position: 101
      prefix: --nameRun
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ctseq:0.0.2--py_0
stdout: ctseq_call_methylation.out
