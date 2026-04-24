cwlVersion: v1.2
class: CommandLineTool
baseCommand: varvamp qpcr
label: varvamp_qpcr
doc: "Performs qPCR primer and probe design.\n\nTool homepage: https://github.com/jonas-fuchs/varVAMP"
inputs:
  - id: alignment
    type: File
    doc: Input alignment file
    inputBinding:
      position: 1
  - id: output_dir
    type: Directory
    doc: Output directory
    inputBinding:
      position: 2
  - id: compatible_primers
    type:
      - 'null'
      - File
    doc: FASTA primer file with which new primers should not form dimers. 
      Sequences >40 nt are ignored. Can significantly increase runtime.
    inputBinding:
      position: 103
      prefix: --compatible-primers
  - id: database
    type:
      - 'null'
      - string
    doc: location of the BLAST db
    inputBinding:
      position: 103
      prefix: --database
  - id: deltaG
    type:
      - 'null'
      - float
    doc: minimum free energy (kcal/mol/K) cutoff at the lowest primer melting 
      temperature
    inputBinding:
      position: 103
      prefix: --deltaG
  - id: n_ambig
    type:
      - 'null'
      - int
    doc: max number of ambiguous characters in a primer
    inputBinding:
      position: 103
      prefix: --n-ambig
  - id: pn_ambig
    type:
      - 'null'
      - int
    doc: max number of ambiguous characters in a probe
    inputBinding:
      position: 103
      prefix: --pn-ambig
  - id: scheme_name
    type:
      - 'null'
      - string
    doc: name of the scheme
    inputBinding:
      position: 103
      prefix: --name
  - id: test_n
    type:
      - 'null'
      - int
    doc: test the top n qPCR amplicons for secondary structures at the minimal 
      primer temperature
    inputBinding:
      position: 103
      prefix: --test-n
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 103
      prefix: --th
  - id: threshold
    type: float
    doc: consensus threshold (0-1) - higher values result in higher specificity 
      at the expense of found primers
    inputBinding:
      position: 103
      prefix: --threshold
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varvamp:1.3--pyhdfd78af_0
stdout: varvamp_qpcr.out
