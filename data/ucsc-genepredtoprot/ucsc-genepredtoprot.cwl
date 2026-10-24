cwlVersion: v1.2
class: CommandLineTool
baseCommand: genePredToProt
label: ucsc-genepredtoprot
doc: "Create protein sequences by translating gene annotations. Honors the frame if the genePred has frames, dropping partial codons. genomeSeqs is a 2bit file or a directory of nib files.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: gene_pred_file
    type: File
    doc: Input genePred file
    inputBinding:
      position: 10
  - id: genome_seqs
    type: File
    doc: Genome sequence in 2bit format
    inputBinding:
      position: 11
  - id: prot_fa
    type: string
    doc: Output protein FASTA file name
    inputBinding:
      position: 12
  - id: cds_fa
    type: ['null', string]
    doc: Output FASTA with the CDS that was used to generate the protein (does not include dropped partial codons)
    inputBinding:
      prefix: -cdsFa=
      separate: false
      position: 1
  - id: prot_id_suffix
    type: ['null', string]
    doc: Add this string to the end of the name for the protein FASTA
    inputBinding:
      prefix: -protIdSuffix=
      separate: false
      position: 2
  - id: cds_id_suffix
    type: ['null', string]
    doc: Add this string to the end of the name for the CDS FASTA
    inputBinding:
      prefix: -cdsIdSuffix=
      separate: false
      position: 3
  - id: translate_seleno
    type: ['null', boolean]
    doc: Assume internal TGA codes for selenocysteine and translate to U
    inputBinding:
      prefix: -translateSeleno
      position: 4
  - id: include_stop
    type: ['null', boolean]
    doc: If the CDS ends with a stop codon, represent it as a *
    inputBinding:
      prefix: -includeStop
      position: 5
  - id: star_for_inframe_stops
    type: ['null', boolean]
    doc: Use * instead of X for in-frame stop codons
    inputBinding:
      prefix: -starForInframeStops
      position: 6
outputs:
  - id: prot_fa_out
    type: File
    doc: Output protein FASTA
    outputBinding:
      glob: $(inputs.prot_fa)
  - id: cds_fa_out
    type: ['null', File]
    doc: Output CDS FASTA
    outputBinding:
      glob: $(inputs.cds_fa)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-genepredtoprot:482--h0b57e2e_0
