cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pepsirf
  - link
label: pepsirf_link
doc: "The link module is used to create the \"--linked\" input file for the deconv
  module. The output file from this module defines linkages between taxonomic groups
  (or other groups of interest) and peptides based on shared kmers.\n\nTool homepage:
  https://github.com/LadnerLab/PepSIRF"
inputs:
  - id: kmer_redundancy_control
    type:
      - 'null'
      - boolean
    doc: Optional modification to the way scores are calculated. If this flag is used,
      then instead of a peptide receiving one point for each kmer it shares with proteins
      of a given taxonomic group, it receives 1 / ( the number of times the kmer appears
      in the provided peptides ) points.
    inputBinding:
      position: 101
      prefix: --kmer_redundancy_control
  - id: kmer_size
    type: int
    doc: Kmer size to use when creating the linkage map.
    inputBinding:
      position: 101
      prefix: --kmer_size
  - id: meta
    type:
      - 'null'
      - string
    doc: 'Optional method for providing taxonomic information for each protein contained
      in "--protein_file". Three comma-separated strings should be provided: 1) name
      of tab-delimited metadata file, 2) header for column containing protein sequence
      name and 3) header for column containing ID to be used in creating the linkage
      map.'
    inputBinding:
      position: 101
      prefix: --meta
  - id: peptide_file
    type: File
    doc: Name of fasta file containing aa peptides of interest. These will generally
      be peptides that are contained in a particular assay.
    inputBinding:
      position: 101
      prefix: --peptide_file
  - id: protein_file
    type: File
    doc: Name of fasta file containing protein sequences of interest.
    inputBinding:
      position: 101
      prefix: --protein_file
  - id: tax_id_index
    type:
      - 'null'
      - int
    doc: Optional method for parsing taxonomic information from the names of the protein
      sequences. This is an alternative to the "--meta" argument and will only work
      if the protein names contain "OXX" tags of the form "OXX=variableID,speciesID,genusID,familyID".
    inputBinding:
      position: 101
      prefix: --tax_id_index
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: 'Name of the file to which output is written. Output will be in the form
      of a tab-delimited file with a header. Each entry/row will be of the form: peptide_name
      TAB id:score,id:score, and so on.'
    outputBinding:
      glob: $(inputs.output)
  - id: logfile
    type:
      - 'null'
      - File
    doc: Designated file to which the module's processes are logged.
    outputBinding:
      glob: $(inputs.logfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pepsirf:1.7.1--h077b44d_0
