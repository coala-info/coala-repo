cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - proteinDBmasses.py
label: msproteomicstools_proteinDBmasses.py
doc: "Retrieve the protein weights and in-silico peptide counts for the proteins of FASTA files. The result is written next to each FASTA file as <name>_mass.tsv (and <name>_simulation.tsv with --dynamic-range).\n\nTool homepage: https://github.com/msproteomicstools/msproteomicstools"
inputs:
  - id: fasta_files
    type: 'File[]'
    doc: "FASTA file(s)"
    inputBinding:
      position: 20
      valueFrom: $(self.map(function(f){return f.basename;}))
  - id: abundance_file
    type: ['null', File]
    doc: "Protein abundance file"
    inputBinding:
      prefix: -a
  - id: dynamic_range
    type: ['null', float]
    doc: "Simulation of peptide intensity by using the peptide detectability dynamic range specified"
    inputBinding:
      prefix: -d
  - id: enzyme
    type: ['null', string]
    doc: "Enzyme used for in-silico digestion: trypsin, Asp-N, Arg-C, Chymotrypsin, Lys-C, Lys-N (default trypsin)"
    inputBinding:
      prefix: -e
  - id: pep_length
    type: ['null', int]
    doc: "Minimum peptide length for the in-silico digestion (default 5)"
    inputBinding:
      prefix: -l
  - id: min_peptides
    type: ['null', int]
    doc: "Minimum number of peptides to identify a protein (use with -n)"
    inputBinding:
      prefix: -m
  - id: peptides_identified
    type: ['null', int]
    doc: "Number of identified peptides to estimate the number of proteins identified"
    inputBinding:
      prefix: -n
outputs:
  - id: mass_tables
    type: 'File[]'
    doc: "Tables written beside the FASTA files"
    outputBinding:
      glob: "*_mass.tsv"
  - id: simulation_tables
    type: 'File[]'
    doc: "Simulation tables"
    outputBinding:
      glob: "*_simulation.tsv"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.fasta_files)
        writable: true
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
stdout: msproteomicstools_proteinDBmasses.py.out
