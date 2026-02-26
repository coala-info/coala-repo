cwlVersion: v1.2
class: CommandLineTool
baseCommand: guidemaker
label: guidemaker
doc: "GuideMaker: Software to design gRNAs pools in non-model genomes and CRISPR-Cas
  systems\n\nTool homepage: https://github.com/USDA-ARS-GBRU/GuideMaker"
inputs:
  - id: attribute_key
    type:
      - 'null'
      - string
    doc: 'the attribute key in column 9 of the GFF/GTF file to use for filtering.
      Default: ID'
    default: ID
    inputBinding:
      position: 101
      prefix: --attribute_key
  - id: before
    type:
      - 'null'
      - int
    doc: 'keep guides this far in front of a feature. Default: 100.'
    default: 100
    inputBinding:
      position: 101
      prefix: --before
  - id: cfd_score
    type:
      - 'null'
      - boolean
    doc: 'CFD score for assessing off-target activity of gRNAs with NGG pam: Default:
      None.'
    inputBinding:
      position: 101
      prefix: --cfd_score
  - id: config
    type:
      - 'null'
      - File
    doc: Path to YAML formatted configuration file, default is 
      /usr/local/lib/python3.9/site-packages/guidemaker/data/config_default.yaml
    inputBinding:
      position: 101
      prefix: --config
  - id: controls
    type:
      - 'null'
      - int
    doc: 'Number of random control RNAs to generate. Default: 1000.'
    default: 1000
    inputBinding:
      position: 101
      prefix: --controls
  - id: dist
    type:
      - 'null'
      - int
    doc: 'Minimum edit distance from any other potential guide. Default: 2.'
    default: 2
    inputBinding:
      position: 101
      prefix: --dist
  - id: doench_efficiency_score
    type:
      - 'null'
      - boolean
    doc: 'On-target scoring from Doench et al. 2016 - only for NGG PAM and guidelength=25:
      Default: None.'
    inputBinding:
      position: 101
      prefix: --doench_efficiency_score
  - id: dtype
    type:
      - 'null'
      - string
    doc: 'Select the distance type. Default: hamming.'
    default: hamming
    inputBinding:
      position: 101
      prefix: --dtype
  - id: fasta_files
    type:
      - 'null'
      - type: array
        items: File
    doc: One or more fasta or gzipped fasta files for a single genome. If using 
      a fasta, a GFF/GTF file must also be provided but not a genbank file.
    inputBinding:
      position: 101
      prefix: --fasta
  - id: filter_by_attribute
    type:
      - 'null'
      - type: array
        items: string
    doc: 'List of locus ids. Default: None.'
    default: None
    inputBinding:
      position: 101
      prefix: --filter_by_attribute
  - id: genbank_files
    type:
      - 'null'
      - type: array
        items: File
    doc: One or more genbank .gbk or gzipped .gbk files for a single genome. 
      Provide this or GFF/GTF and fasta files
    inputBinding:
      position: 101
      prefix: --genbank
  - id: gff_files
    type:
      - 'null'
      - type: array
        items: File
    doc: One or more GFF or GTF files (optionally gzipped) for a single genome. 
      If using a GFF/GTF a fasta file must also be provided but not a genbank 
      file.
    inputBinding:
      position: 101
      prefix: --gff
  - id: guidelength
    type:
      - 'null'
      - int
    doc: 'Length of the guide sequence. Default: 20.'
    default: 20
    inputBinding:
      position: 101
      prefix: --guidelength
  - id: into
    type:
      - 'null'
      - int
    doc: 'keep guides this far inside (past the start site)of a feature. Default:
      200.'
    default: 200
    inputBinding:
      position: 101
      prefix: --into
  - id: keeptemp
    type:
      - 'null'
      - boolean
    doc: Option to keep intermediate files be kept
    inputBinding:
      position: 101
      prefix: --keeptemp
  - id: knum
    type:
      - 'null'
      - int
    doc: 'how many sequences similar to the guide to report. Default: 5.'
    default: 5
    inputBinding:
      position: 101
      prefix: --knum
  - id: log
    type:
      - 'null'
      - File
    doc: Log file
    inputBinding:
      position: 101
      prefix: --log
  - id: lsr
    type:
      - 'null'
      - int
    doc: 'Length of a seed region near the PAM site required to be unique. Default:
      10.'
    default: 10
    inputBinding:
      position: 101
      prefix: --lsr
  - id: outdir
    type: Directory
    doc: The directory for data output
    inputBinding:
      position: 101
      prefix: --outdir
  - id: pam_orientation
    type:
      - 'null'
      - string
    doc: "The PAM position relative to the target: 5prime: [PAM][target], 3prime:
      [target][PAM]. For example, SpCas9 is 3prime. Default: '3prime'."
    default: 3prime
    inputBinding:
      position: 101
      prefix: --pam_orientation
  - id: pamseq
    type: string
    doc: A short PAM motif to search for, it may use IUPAC ambiguous alphabet
    inputBinding:
      position: 101
      prefix: --pamseq
  - id: plot
    type:
      - 'null'
      - boolean
    doc: Option to create GuideMaker plots
    inputBinding:
      position: 101
      prefix: --plot
  - id: raw_output_only
    type:
      - 'null'
      - boolean
    doc: if selected only the raw guide RNAs their positions will be returned 
      the meet lsr and dist criteria
    inputBinding:
      position: 101
      prefix: --raw_output_only
  - id: restriction_enzyme_list
    type:
      - 'null'
      - type: array
        items: string
    doc: 'List of sequence representing restriction enzymes. Default: None.'
    default: None
    inputBinding:
      position: 101
      prefix: --restriction_enzyme_list
  - id: tempdir
    type:
      - 'null'
      - Directory
    doc: The temp file directory
    inputBinding:
      position: 101
      prefix: --tempdir
  - id: threads
    type:
      - 'null'
      - int
    doc: 'The number of cpu threads to use. Default: 2'
    default: 2
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/guidemaker:0.4.2--pyhdfd78af_0
stdout: guidemaker.out
