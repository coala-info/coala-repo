cwlVersion: v1.2
class: CommandLineTool
baseCommand: btyper3
label: btyper3
doc: "Assigns genomes to species, subspecies, and biovars using various genomic analyses.\n\
  \nTool homepage: https://github.com/lmc297/BTyper3"
inputs:
  - id: ani_geneflow
    type:
      - 'null'
      - boolean
    doc: Optional argument; True or False; assign genome to a pseudo-gene flow 
      unit using the method described by Carroll, et al. using FastANI
    inputBinding:
      position: 101
      prefix: --ani_geneflow
  - id: ani_species
    type:
      - 'null'
      - boolean
    doc: Optional argument; True or False; assign genome to a species using 
      FastANI
    inputBinding:
      position: 101
      prefix: --ani_species
  - id: ani_subspecies
    type:
      - 'null'
      - boolean
    doc: Optional argument; True or False; assign genome to a subspecies, if 
      relevant, using FastANI
    inputBinding:
      position: 101
      prefix: --ani_subspecies
  - id: ani_typestrains
    type:
      - 'null'
      - boolean
    doc: Optional argument; True or False; calculate ANI values between the 
      query genome relative to all B. cereus s.l. species type strain genomes 
      using FastANI, and report the closest species type strain/highest ANI 
      value
    inputBinding:
      position: 101
      prefix: --ani_typestrains
  - id: bt
    type:
      - 'null'
      - boolean
    doc: Optional argument; True or False; perform Bt toxin gene detection for 
      cry, cyt, and vip genes (required if one wants to assign genomes to biovar
      Thuringiensis)
    inputBinding:
      position: 101
      prefix: --bt
  - id: bt_coverage
    type:
      - 'null'
      - int
    doc: Optional argument for use with --bt True; integer from 0 to 100; 
      minimum percent coverage threshold for a Bt toxin gene to be considered 
      present
    inputBinding:
      position: 101
      prefix: --bt_coverage
  - id: bt_identity
    type:
      - 'null'
      - int
    doc: Optional argument for use with --bt True; integer from 0 to 100; 
      minimum percent amino acid identity threshold for a Bt toxin gene to be 
      considered present
    inputBinding:
      position: 101
      prefix: --bt_identity
  - id: bt_overlap
    type:
      - 'null'
      - float
    doc: Optional argument for use with --bt True; float from 0 to 1; specify 
      maximum proportion of overlap for overlapping Bt toxin genes to be 
      considered separate genes; Bt toxin genes below this threshold will be 
      considered separate, while those above it will be considered overlapping, 
      and only the top hit will be reported
    inputBinding:
      position: 101
      prefix: --bt_overlap
  - id: download_mlst_latest
    type:
      - 'null'
      - boolean
    doc: Optional argument for use with --mlst True; True or False; download the
      latest version of the seven-gene multi-locus sequence typing (MLST) scheme
      available in PubMLST; if this is False, BTyper3 will search for the 
      appropriate files in the seq_mlst_db directory
    inputBinding:
      position: 101
      prefix: --download_mlst_latest
  - id: evalue
    type:
      - 'null'
      - float
    doc: Optional argument for use with --virulence True and/or --bt True; float
      >= 0; maximum blast e-value for a hit to be saved; note that if both 
      --virulence True and --bt True, this e-value threshold will be applied to 
      both analyses
    inputBinding:
      position: 101
      prefix: --evalue
  - id: input_genome
    type: File
    doc: Path to input genome in fasta format
    inputBinding:
      position: 101
      prefix: --input
  - id: mlst
    type:
      - 'null'
      - boolean
    doc: Optional argument; True or False; assign genome to a sequence type (ST)
      using the seven-gene multi-locus sequence typing (MLST) scheme available 
      in PubMLST
    inputBinding:
      position: 101
      prefix: --mlst
  - id: panC
    type:
      - 'null'
      - boolean
    doc: Optional argument; True or False; assign genome to a phylogenetic group
      (Group I-VIII) using an adjusted, eight-group panC group assignment scheme
    inputBinding:
      position: 101
      prefix: --panC
  - id: virulence
    type:
      - 'null'
      - boolean
    doc: Optional argument; True or False; perform virulence gene detection 
      (required if one wants to assign genomes to biovars Anthracis or Emeticus)
    inputBinding:
      position: 101
      prefix: --virulence
  - id: virulence_coverage
    type:
      - 'null'
      - int
    doc: Optional argument for use with --virulence True; integer from 0 to 100;
      minimum percent coverage threshold for a virulence gene to be considered 
      present
    inputBinding:
      position: 101
      prefix: --virulence_coverage
  - id: virulence_db
    type:
      - 'null'
      - string
    doc: 'Optional argument for use with --virulence True; aa or nuc; database to
      use for virulence factor detection: aa for the amino acid sequence database,
      or nuc for the nucleotide sequence database; option aa uses translated nucleotide
      blast and allows for the detection of more remote homologs, but is slower than
      nuc, which uses blastn'
    inputBinding:
      position: 101
      prefix: --virulence_db
  - id: virulence_identity
    type:
      - 'null'
      - int
    doc: Optional argument for use with --virulence True; integer from 0 to 100;
      minimum percent amino acid/nucleotide identity threshold for a virulence 
      gene to be considered present, depending on choice of --virulence_db aa or
      nuc, respectively
    inputBinding:
      position: 101
      prefix: --virulence_identity
outputs:
  - id: output_directory
    type: Directory
    doc: Path to desired output directory
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/btyper3:3.4.0--pyhdfd78af_0
