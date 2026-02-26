cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tooldistillator.py
  - bakta
label: tooldistillator_bakta
doc: "Extract information from output(s) of bakta (OUTPUT.json)\n\nTool homepage:
  https://gitlab.com/ifb-elixirfr/abromics"
inputs:
  - id: report
    type: File
    doc: Path to report(s)
    inputBinding:
      position: 1
  - id: amino_acid_annotation_hid
    type:
      - 'null'
      - string
    doc: historic ID for amino acide sequence file from galaxy for bakta
    inputBinding:
      position: 102
      prefix: --amino_acid_annotation_hid
  - id: amino_acid_annotation_path
    type:
      - 'null'
      - File
    doc: amino acid file of the annotation for bakta
    inputBinding:
      position: 102
      prefix: --amino_acid_annotation_path
  - id: analysis_software_version
    type:
      - 'null'
      - string
    doc: bakta version for bakta
    inputBinding:
      position: 102
      prefix: --analysis_software_version
  - id: annotation_embl_hid
    type:
      - 'null'
      - string
    doc: historic ID for annotation embl file from galaxy for bakta
    inputBinding:
      position: 102
      prefix: --annotation_embl_hid
  - id: annotation_embl_path
    type:
      - 'null'
      - File
    doc: annotation file in embl format for bakta
    inputBinding:
      position: 102
      prefix: --annotation_embl_path
  - id: annotation_genbank_hid
    type:
      - 'null'
      - string
    doc: historic ID for annotation genbank file from galaxy for bakta
    inputBinding:
      position: 102
      prefix: --annotation_genbank_hid
  - id: annotation_genbank_path
    type:
      - 'null'
      - File
    doc: annotation file in genbank format for bakta
    inputBinding:
      position: 102
      prefix: --annotation_genbank_path
  - id: annotation_tabular_hid
    type:
      - 'null'
      - string
    doc: historic ID for annotation tsv file from galaxy for bakta
    inputBinding:
      position: 102
      prefix: --annotation_tabular_hid
  - id: annotation_tabular_path
    type:
      - 'null'
      - File
    doc: annotation file in TSV format for bakta
    inputBinding:
      position: 102
      prefix: --annotation_tabular_path
  - id: contig_sequences_hid
    type:
      - 'null'
      - string
    doc: historic ID for contigs fasta file from galaxy for bakta
    inputBinding:
      position: 102
      prefix: --contig_sequences_hid
  - id: contig_sequences_path
    type:
      - 'null'
      - File
    doc: contig sequences in fasta ([output].fna) for bakta
    inputBinding:
      position: 102
      prefix: --contig_sequences_path
  - id: gff_file_hid
    type:
      - 'null'
      - string
    doc: historic ID for gff file from galaxy for bakta
    inputBinding:
      position: 102
      prefix: --gff_file_hid
  - id: gff_file_path
    type:
      - 'null'
      - File
    doc: annotation file result in gff3 format for bakta
    inputBinding:
      position: 102
      prefix: --gff_file_path
  - id: hid
    type:
      - 'null'
      - string
    doc: historic ID to bakta result file from galaxy for bakta
    inputBinding:
      position: 102
      prefix: --hid
  - id: hypothetical_protein_hid
    type:
      - 'null'
      - string
    doc: historic ID for hypothetical protein file file from galaxy for bakta
    inputBinding:
      position: 102
      prefix: --hypothetical_protein_hid
  - id: hypothetical_protein_path
    type:
      - 'null'
      - File
    doc: hypothetical protein CDS amino acid sequences as fasta for bakta
    inputBinding:
      position: 102
      prefix: --hypothetical_protein_path
  - id: hypothetical_tabular_hid
    type:
      - 'null'
      - string
    doc: historic ID for hypothetical tabular file from galaxy for bakta
    inputBinding:
      position: 102
      prefix: --hypothetical_tabular_hid
  - id: hypothetical_tabular_path
    type:
      - 'null'
      - File
    doc: hypothetical protein CDS for bakta
    inputBinding:
      position: 102
      prefix: --hypothetical_tabular_path
  - id: nucleotide_annotation_hid
    type:
      - 'null'
      - string
    doc: historic ID for nucleotide file from galaxy for bakta
    inputBinding:
      position: 102
      prefix: --nucleotide_annotation_hid
  - id: nucleotide_annotation_path
    type:
      - 'null'
      - File
    doc: nuleotide file ([output].ffn) of the annotation for bakta
    inputBinding:
      position: 102
      prefix: --nucleotide_annotation_path
  - id: plot_file_hid
    type:
      - 'null'
      - string
    doc: historic ID for plot file from galaxy for bakta
    inputBinding:
      position: 102
      prefix: --plot_file_hid
  - id: plot_file_path
    type:
      - 'null'
      - File
    doc: genome annotation plot file path for bakta
    inputBinding:
      position: 102
      prefix: --plot_file_path
  - id: reference_database_version
    type:
      - 'null'
      - string
    doc: DB version for bakta
    inputBinding:
      position: 102
      prefix: --reference_database_version
  - id: summary_result_hid
    type:
      - 'null'
      - string
    doc: historic ID for summary file from galaxy for bakta
    inputBinding:
      position: 102
      prefix: --summary_result_hid
  - id: summary_result_path
    type:
      - 'null'
      - File
    doc: summary file of the bakta analysis in txt format for bakta
    inputBinding:
      position: 102
      prefix: --summary_result_path
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output location
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
