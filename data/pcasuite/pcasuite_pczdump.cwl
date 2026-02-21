cwlVersion: v1.2
class: CommandLineTool
baseCommand: pczdump
label: pcasuite_pczdump
doc: "Extract information and perform calculations on PCZ files\n\nTool homepage:
  https://mmb.irbbarcelona.org/gitlab/andrio/pcasuite"
inputs:
  - id: anim
    type:
      - 'null'
      - int
    doc: Animate the average structure along <iv> eigenvector
    inputBinding:
      position: 101
      prefix: --anim
  - id: avg
    type:
      - 'null'
      - boolean
    doc: Show the average structure
    inputBinding:
      position: 101
      prefix: --avg
  - id: bfactor
    type:
      - 'null'
      - boolean
    doc: Give the fluctuation values as B-factors
    inputBinding:
      position: 101
      prefix: --bfactor
  - id: collectivity
    type:
      - 'null'
      - int
    doc: Compute a collectivity coefficient for <iv> evec
    inputBinding:
      position: 101
      prefix: --collectivity
  - id: evals
    type:
      - 'null'
      - boolean
    doc: Show the eigenvalues
    inputBinding:
      position: 101
      prefix: --evals
  - id: evec
    type:
      - 'null'
      - int
    doc: Show the <iv> eigenvector
    inputBinding:
      position: 101
      prefix: --evec
  - id: fluc
    type:
      - 'null'
      - int
    doc: Compute atomic fluctuations for <iv> evec (0 for all)
    inputBinding:
      position: 101
      prefix: --fluc
  - id: forcecte
    type:
      - 'null'
      - float
    doc: Compute force constants for temperature <temp>
    inputBinding:
      position: 101
      prefix: --forcecte
  - id: hinge
    type:
      - 'null'
      - boolean
    doc: Look for hinge points (need a file with atom names and gaussian RMS applied)
    inputBinding:
      position: 101
      prefix: --hinge
  - id: info
    type:
      - 'null'
      - boolean
    doc: Show general information about the file
    inputBinding:
      position: 101
      prefix: --info
  - id: input_file
    type: File
    doc: Input PCZ file
    inputBinding:
      position: 101
      prefix: -i
  - id: lindemann
    type:
      - 'null'
      - boolean
    doc: Compute Lindemann coefficient
    inputBinding:
      position: 101
      prefix: --lindemann
  - id: mahnev
    type:
      - 'null'
      - int
    doc: Number of eigenvectors to use in the Mahalanobis distance calculus
    inputBinding:
      position: 101
      prefix: --mahnev
  - id: mahref
    type:
      - 'null'
      - File
    doc: Trajectory file to use in the Mahalanobis distance calculus
    inputBinding:
      position: 101
      prefix: --mahref
  - id: mask
    type:
      - 'null'
      - string
    doc: ptraj-like selection mask
    inputBinding:
      position: 101
      prefix: --mask
  - id: pdb
    type:
      - 'null'
      - boolean
    doc: Ask for output in PDB format (if suitable)
    inputBinding:
      position: 101
      prefix: --pdb
  - id: proj
    type:
      - 'null'
      - int
    doc: Show the projections for <iv> eigenvector
    inputBinding:
      position: 101
      prefix: --proj
  - id: rms
    type:
      - 'null'
      - int
    doc: Compute the RMS of the traj. against frame <iref>
    inputBinding:
      position: 101
      prefix: --rms
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Show info about progress
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pcasuite:1.0.0--h7baada4_6
