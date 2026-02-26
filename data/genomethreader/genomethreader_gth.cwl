cwlVersion: v1.2
class: CommandLineTool
baseCommand: gth
label: genomethreader_gth
doc: "Compute similarity-based gene structure predictions (spliced alignments) using
  cDNA/EST and/or protein sequences and assemble the resulting spliced alignments
  to consensus spliced alignments.\n\nTool homepage: http://genomethreader.org/"
inputs:
  - id: genomic_files
    type:
      type: array
      items: File
    doc: specify input files containing genomic sequences
    inputBinding:
      position: 1
  - id: cdna_files
    type:
      type: array
      items: File
    doc: specify input files containing cDNA/EST sequences
    inputBinding:
      position: 2
  - id: protein_files
    type:
      type: array
      items: File
    doc: specify input files containing protein sequences
    inputBinding:
      position: 3
  - id: align_cdna_forward_strand
    type:
      - 'null'
      - boolean
    doc: align only forward strand of cDNAs
    default: no
    inputBinding:
      position: 104
      prefix: -cdnaforward
  - id: analyze_forward_strand
    type:
      - 'null'
      - boolean
    doc: analyze only forward strand of genomic sequences
    default: no
    inputBinding:
      position: 104
      prefix: -f
  - id: analyze_reverse_strand
    type:
      - 'null'
      - boolean
    doc: analyze only reverse strand of genomic sequences
    default: no
    inputBinding:
      position: 104
      prefix: -r
  - id: autointroncutout_matrix_size
    type:
      - 'null'
      - int
    doc: set the automatic intron cutout matrix size in megabytes and enable the
      automatic intron cutout technique
    default: 0
    inputBinding:
      position: 104
      prefix: --autointroncutout
  - id: bssm
    type:
      - 'null'
      - string
    doc: read bssm parameter from file in the path given by the environment 
      variable BSSMDIR
    default: undefined
    inputBinding:
      position: 104
      prefix: --bssm
  - id: bzip2_compressed_output
    type:
      - 'null'
      - boolean
    doc: write bzip2 compressed output file
    default: no
    inputBinding:
      position: 104
      prefix: --bzip2
  - id: compute_paralogs
    type:
      - 'null'
      - boolean
    doc: compute paralogous genes (different chaining procedure)
    default: no
    inputBinding:
      position: 104
      prefix: --paralogs
  - id: enable_intron_cutout
    type:
      - 'null'
      - boolean
    doc: enable the intron cutout technique
    default: no
    inputBinding:
      position: 104
      prefix: --introncutout
  - id: force_output
    type:
      - 'null'
      - boolean
    doc: force writing to output file
    default: no
    inputBinding:
      position: 104
      prefix: --force
  - id: from_position
    type:
      - 'null'
      - int
    doc: analyze genomic sequence from this position; requires -topos or -width;
      counting from 1 on
    default: 0
    inputBinding:
      position: 104
      prefix: --frompos
  - id: gene_seqer2_output
    type:
      - 'null'
      - boolean
    doc: output in old GeneSeqer2 format
    default: no
    inputBinding:
      position: 104
      prefix: --gs2out
  - id: gff3_output
    type:
      - 'null'
      - boolean
    doc: show output in GFF3 format
    default: no
    inputBinding:
      position: 104
      prefix: --gff3out
  - id: gzip_compressed_output
    type:
      - 'null'
      - boolean
    doc: write gzip compressed output file
    default: no
    inputBinding:
      position: 104
      prefix: --gzip
  - id: hamming_distance_protein
    type:
      - 'null'
      - int
    doc: specify Hamming distance (protein matching)
    default: 4
    inputBinding:
      position: 104
      prefix: --prhdist
  - id: intermediate_output
    type:
      - 'null'
      - boolean
    doc: stop after calculation of spliced alignments and output results in 
      reusable XML format. Do not process this output yourself, use the 
      ``normal'' XML output instead!
    default: no
    inputBinding:
      position: 104
      prefix: --intermediate
  - id: max_gap_width_global_chains
    type:
      - 'null'
      - int
    doc: set the maximum gap width for global chains; defines approximately the 
      maximum intron length; set to 0 to allow for unlimited length; in order to
      avoid false-positive exons (lonely exons) at the sequence ends, it is very
      important to set this parameter appropriately!
    default: 1000000
    inputBinding:
      position: 104
      prefix: --gcmaxgapwidth
  - id: max_spliced_alignments_per_genomic
    type:
      - 'null'
      - int
    doc: set the maximum number of spliced alignments per genomic DNA input. Set
      to 0 for unlimited number.
    default: 0
    inputBinding:
      position: 104
      prefix: --first
  - id: md5_fingerprints_as_ids
    type:
      - 'null'
      - boolean
    doc: show MD5 fingerprints as sequence IDs
    default: no
    inputBinding:
      position: 104
      prefix: --md5ids
  - id: min_coverage_global_chains
    type:
      - 'null'
      - int
    doc: set the minimum coverage of global chains regarding to the reference 
      sequence
    default: 50
    inputBinding:
      position: 104
      prefix: --gcmincoverage
  - id: min_match_length_cdna
    type:
      - 'null'
      - int
    doc: specify minimum match length (cDNA matching)
    default: 20
    inputBinding:
      position: 104
      prefix: --minmatchlen
  - id: min_match_length_protein
    type:
      - 'null'
      - int
    doc: specify minimum match length (protein matches)
    default: 24
    inputBinding:
      position: 104
      prefix: --prminmatchlen
  - id: scorematrix
    type:
      - 'null'
      - string
    doc: read amino acid substitution scoring matrix from file in the path given
      by the environment variable GTHDATADIR
    default: BLOSUM62
    inputBinding:
      position: 104
      prefix: --scorematrix
  - id: seed_length_cdna
    type:
      - 'null'
      - int
    doc: specify the seed length (cDNA matching)
    default: 18
    inputBinding:
      position: 104
      prefix: --seedlength
  - id: seed_length_protein
    type:
      - 'null'
      - int
    doc: specify seed length (protein matching)
    default: 10
    inputBinding:
      position: 104
      prefix: --prseedlength
  - id: species
    type:
      - 'null'
      - string
    doc: 'specify species to select splice site model which is most appropriate; possible
      species: "human" "mouse" "rat" "chicken" "drosophila" "nematode" "fission_yeast"
      "aspergillus" "arabidopsis" "maize" "rice" "medicago"'
    default: undefined
    inputBinding:
      position: 104
      prefix: --species
  - id: to_position
    type:
      - 'null'
      - int
    doc: analyze genomic sequence to this position; requires -frompos; counting 
      from 1 on
    default: 0
    inputBinding:
      position: 104
      prefix: --topos
  - id: translationtable
    type:
      - 'null'
      - int
    doc: set the codon translation table used for codon translation in matching,
      DP, and output
    default: 1
    inputBinding:
      position: 104
      prefix: --translationtable
  - id: use_fast_dp
    type:
      - 'null'
      - boolean
    doc: use jump table to increase speed of DP calculation
    default: no
    inputBinding:
      position: 104
      prefix: --fastdp
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: be verbose
    default: no
    inputBinding:
      position: 104
      prefix: -v
  - id: width
    type:
      - 'null'
      - int
    doc: analyze only this width of genomic sequence; requires -frompos
    default: 0
    inputBinding:
      position: 104
      prefix: --width
  - id: xdrop_extension_cdna
    type:
      - 'null'
      - int
    doc: specify the Xdrop value for edit distance extension (cDNA matching)
    default: 2
    inputBinding:
      position: 104
      prefix: --exdrop
  - id: xml_output
    type:
      - 'null'
      - boolean
    doc: show output in XML format
    default: no
    inputBinding:
      position: 104
      prefix: --xmlout
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: redirect output to specified file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomethreader:1.7.1--h87f3376_4
