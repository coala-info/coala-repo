cwlVersion: v1.2
class: CommandLineTool
baseCommand: protmapper
label: protmapper
doc: "Run Protmapper on a list of proteins with residues and sites provided in a text
  file.\n\nTool homepage: https://github.com/indralab/protmapper"
inputs:
  - id: input
    type: File
    doc: Path to an input file. The input file is a text file in which each row 
      consists of four comma separated values, with the first element being a 
      protein ID, the second, the namespace in which that ID is valid (uniprot 
      or hgnc), third, an amino acid represented as a single capital letter, and
      fourth, a site position on the protein.
    inputBinding:
      position: 1
  - id: no_isoform_mapping
    type:
      - 'null'
      - boolean
    doc: If given, will not check sequence positions for known modifications in 
      other human isoforms of the protein (based on PhosphoSitePlus data).
    inputBinding:
      position: 102
      prefix: --no_isoform_mapping
  - id: no_methionine_offset
    type:
      - 'null'
      - boolean
    doc: If given, will not check for off-by-one errors in site position 
      (possibly) attributable to site numbering from mature proteins after 
      cleavage of the initial methionine.
    inputBinding:
      position: 102
      prefix: --no_methionine_offset
  - id: no_orthology_mapping
    type:
      - 'null'
      - boolean
    doc: If given, will not check sequence positions for known modification 
      sites in mouse or rat sequences (based on PhosphoSitePlus data).
    inputBinding:
      position: 102
      prefix: --no_orthology_mapping
  - id: peptide
    type:
      - 'null'
      - boolean
    doc: If given, the third element of each row of the input file is a peptide 
      (amino acid sequence) rather than a single amino acid residue. In this 
      case, peptide-oriented mappings are applied. In this mode the following 
      boolean arguments are ignored.
    inputBinding:
      position: 102
      prefix: --peptide
outputs:
  - id: output
    type: File
    doc: Path to the output file to be generated. Each line of the output file 
      corresponds to a line in the input file. Each line represents a mapped 
      site produced by Protmapper.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protmapper:0.0.29--pyhdfd78af_0
