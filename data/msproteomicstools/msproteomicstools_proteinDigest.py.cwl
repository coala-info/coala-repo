cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - proteinDigest.py
label: msproteomicstools_proteinDigest.py
doc: "In-silico digestion of the proteins of FASTA files; the peptides are written next to each FASTA file as <name>_digest.tsv.\n\nTool homepage: https://github.com/msproteomicstools/msproteomicstools"
inputs:
  - id: fasta_files
    type: 'File[]'
    doc: "FASTA file(s)"
    inputBinding:
      position: 20
      valueFrom: $(self.map(function(f){return f.basename;}))
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
  - id: missed_cleavages
    type: ['null', int]
    doc: "Allowed missed cleavages (default 0)"
    inputBinding:
      prefix: -m
outputs:
  - id: digest_tables
    type: 'File[]'
    doc: "Digest tables"
    outputBinding:
      glob: "*_digest.tsv"
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
stdout: msproteomicstools_proteinDigest.py.out
