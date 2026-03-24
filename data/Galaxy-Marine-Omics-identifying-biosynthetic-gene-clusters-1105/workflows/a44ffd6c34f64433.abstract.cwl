class: Workflow
doc: 'Secondary metabolite biosynthetic gene cluster (SMBGC) Annotation using Neural
  Networks Trained on Interpro Signatures '
label: Marine Omics identifying biosynthetic gene clusters
cwlVersion: v1.2
inputs:
  Fasta nucelotide file:
    doc: BGC0001472.fna
    id: Fasta nucelotide file
    type: File
outputs:
  Protein fasta file:
    outputSource: Prodigal Gene Predictor /output_faa
    type: File
  Genbank file:
    outputSource: 'Sanntis: Build Genbank /output_sanntis_gb'
    type: File
  Clean protein fasta file:
    outputSource: Regex Find And Replace/out_file1
    type: File
  Tabular file (.tsv):
    outputSource: ' InterProScan/outfile_tsv'
    type: File
  ' SMBGC Annotation':
    outputSource: 'Sanntis: identify biosynthetic gene clusters/output_sanntis'
    type: File
steps:
  'Prodigal Gene Predictor ':
    doc: Create the protein fasta file
    run:
      class: Operation
      doc: Create the protein fasta file
      inputs: {}
      outputs: {}
    in:
      input_fa:
        source: Fasta nucelotide file
    out:
    - output_faa
  'Sanntis: Build Genbank ':
    doc: Use of Sanntis
    run:
      class: Operation
      doc: Use of Sanntis
      inputs: {}
      outputs: {}
    in:
      selection|input_nuc:
        source: Fasta nucelotide file
      selection|input_prot:
        source: Prodigal Gene Predictor /output_faa
    out:
    - output_sanntis_gb
  Regex Find And Replace:
    doc: Remove useless * in the protein fasta file
    run:
      class: Operation
      doc: Remove useless * in the protein fasta file
      inputs: {}
      outputs: {}
    in:
      input:
        source: Prodigal Gene Predictor /output_faa
    out:
    - out_file1
  ' InterProScan':
    doc: Create TSV file for Sanntis
    run:
      class: Operation
      doc: Create TSV file for Sanntis
      inputs: {}
      outputs: {}
    in:
      input:
        source: Regex Find And Replace/out_file1
    out:
    - outfile_tsv
  'Sanntis: identify biosynthetic gene clusters':
    run:
      class: Operation
      doc: ''
      inputs: {}
      outputs: {}
    in:
      selection|input_genbank:
        source: 'Sanntis: Build Genbank /output_sanntis_gb'
      selection|input_interpro:
        source: ' InterProScan/outfile_tsv'
    out:
    - output_sanntis
