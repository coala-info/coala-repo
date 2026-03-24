#!/usr/bin/env cwltool

cwlVersion: v1.2
class: CommandLineTool

label: Liftoff, an accurate GFF3/GTF lift over pipeline

doc: |
  Liftoff is a tool that accurately maps annotations in GFF or GTF between assemblies of the same, or closely-related species.
  Unlike current coordinate lift-over tools which require a pre-generated “chain” file as input,
  Liftoff is a standalone tool that takes two genome assemblies and a reference annotation as input and outputs an annotation of the target genome.
  Documentation on how to install and run Liftoff can be found here:
  https://github.com/agshumate/Liftoff

requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement: # under the hood, liftoff creates a _db file next to the gff3 file, it is possible to capture this as output and have it be reusable for subsequent runs (then requires -db input flag)
    listing:
      - entryname: staging_folder
        writable: true
        entry: $(null)
      - entry: $(inputs.reference_genome)
      - entry: $(inputs.target_genome) 
      - entry: $(inputs.annotation_file)

hints:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/liftoff:1.6.3--pyhdfd78af_1
  SoftwareRequirement:
    packages:
      liftoff:
        version: ["1.6.3"]
        specs: ["identifiers.org/RRID:SCR_026535"]
  
baseCommand: [liftoff]

inputs:
  target_genome:
    type: File
    label: target file
    doc: Target fasta genome to which features will be lifted.
    inputBinding:
      position: -2
  reference_genome:
    type: File
    label: reference file
    doc: Reference fasta genome from which features are lifted.
    inputBinding:
      position: -1
  annotation_file:
    type: File?
    label: annotation file to lift over
    doc: GFF or GTF file containing the annotations to lift over.
    inputBinding:
      prefix: -g
  feature_database:
    type: File?
    label: database name
    doc: Name of the feature database; if not provided, one will be built automatically (with annotation file).
    inputBinding:
      prefix: -db
  output_file:
    type: string?
    label: output file
    doc: File to write the lifted features in GFF3 output.
    inputBinding:
      prefix: -o
  unmapped_features:
    type: string?
    label: unmapped features file
    doc: File to write unmapped features; the default is unmapped_features.txt.
    inputBinding:
      prefix: -u
  exclude_partial:
    type: boolean?
    label: exclude partial mappings
    doc: When set to true, partial or low sequence identity mappings will be written to the unmapped file.
    inputBinding:
      prefix: -exclude_partial
    default: false
  intermediate_dir:
    type: string?
    label: intermediate directory
    doc: Directory in which to save intermediate fasta and SAM files. Defaults to "intermediate_files"
    inputBinding:
      prefix: -dir
  include_intermediate_dir: # this is not an actual tool flag, but I'd prefer intermediate capture to be optional
    type: boolean
    label: include intermediate directory
    doc: Set to true to include the intermediate files directory.
    default: false
  # Alignment options
  mm2_options:
    type: string?
    label: minimap2 options
    doc: Space-delimited parameters to be passed to minimap2. Default is "-a --end-bonus 5 --eqx -N 50 -p 0.5".
    inputBinding:
      prefix: -mm2_options =
  min_coverage:
    type: float?
    label: minimum alignment coverage
    doc: A feature is mapped only if it aligns with coverage greater than or equal to this value. Default is 0.5.
    inputBinding:
      prefix: -a
  min_identity:
    type: float?
    label: minimum child identity
    doc: A feature is mapped only if its child features (exons/CDS) align with at least this sequence identity. Default is 0.5.
    inputBinding:
      prefix: -s
  distance_scaling:
    type: float?
    label: distance scaling factor
    doc: Alignment nodes separated by more than this factor in the target genome will not be connected. Defaults to 2.0.
    inputBinding:
      prefix: -d
  flank:
    type: float?
    label: flanking fraction
    doc: Fraction of flanking sequence to include in the alignment, expressed as a proportion of the gene length. Defaults to 0.0.
    inputBinding:
      prefix: -flank
  # Miscellaneous settings:
  parallel_processes:
    type: int?
    label: parallel processes
    doc: Number of parallel processes to use for accelerating the alignment. Default is 1.
    inputBinding:
      prefix: -p
  feature_types:
    type: string?
    label: additional feature type file
    doc: File containing additional parent features to be lifted over. Takes 'gene' features and all of its child features as default.
    inputBinding:
      prefix: -f
  infer_genes:
    type: boolean?
    label: infer genes
    doc: Set to true to infer genes if the annotation file only includes transcripts.
    inputBinding:
      prefix: -infer_genes
    default: false
  infer_transcripts:
    type: boolean?
    label: infer transcripts
    doc: Set to true to infer transcripts if the annotation file only includes exon/CDS features.
    inputBinding:
      prefix: -infer_transcripts
    default: false
  chromosomes:
    type: File?
    label: corresponding chromosomes
    doc: Comma-separated file with corresponding chromosomes in the reference and target sequences
    inputBinding:
      prefix: -chroms
  unplaced:
    type: File?
    label: unplaced sequence names
    doc: Text file listing unplaced sequence name. Defaults to unplaced_seq_names.txt.
    inputBinding:
      prefix: -unplaced
  copies:
    type: boolean?
    label: extra gene copies
    doc: Set to true to look for extra gene copies in the target genome.
    inputBinding:
      prefix: -copies
    default: false
  copy_seq_identity:
    type: float?
    label: minimum sequence identity
    doc: Minimum sequence identity threshold for a gene to be considered a copy. Must be greater than $(inputs.min_identity). Defaults to 1.0.
    inputBinding:
      prefix: -sc
  overlap:
    type: float?
    label: maximum overlap
    doc: Maximum fraction of overlap allowed between features. Defaults to 0.1.
    inputBinding:
      prefix: -overlap
  mismatch:
    type: int?
    label: mismatch penalty
    doc: Mismatch penalty for exons. Defaults to 2.
    inputBinding:
      prefix: -mismatch
  gap_open:
    type: int?
    label: gap open penalty
    doc: Gap open penalty for exons. Defaults to 2.
    inputBinding:
      prefix: -gap_open
  gap_extend:
    type: int?
    label: gap extend penalty
    doc: Gap extend penalty for exons. Defaults to 1.
    inputBinding:
      prefix: -gap_extend

outputs:
  output_gff:
    type: File
    label: output GFF3 file
    outputBinding:
      glob: "$(inputs.output ? inputs.output : 'liftoff.gff3')"
    doc: "GFF3 file with the lifted annotations."
  unmapped_features_out:
    type: File
    label: unmapped features file
    outputBinding:
      glob: "$(inputs.unmapped_features ? inputs.unmapped_features : 'unmapped_features.txt')"
    doc: "File with unmapped features."
  intermediate_dir_out:
    type: Directory?
    label: intermediate files
    doc: directory to save intermediate fasta and SAM files
    outputBinding:
      glob: "$(inputs.include_intermediate_dir ? (inputs.intermediate_dir ? inputs.intermediate_dir : 'intermediate_files') : null)"
stdout: liftoff.gff3

$namespaces:
  s: https://schema.org/   
  edam: http://edamontology.org/ 
s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse
  - class: s:Person
    s:identifier: https://orcid.org/0009-0005-0017-0928
    s:email: mailto:martijn.melissen@wur.nl
    s:name: Martijn Melissen
s:citation: https://m-unlock.nl
s:codeRepository: https://git.wur.nl/ssb/automated-data-analysis
s:dateCreated: "2025-03-06"
s:dateModified: "2025-03-07"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"