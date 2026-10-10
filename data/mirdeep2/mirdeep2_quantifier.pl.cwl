cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - quantifier.pl
label: mirdeep2_quantifier.pl
doc: "Map deep sequencing reads to predefined miRNA precursors and count the reads of the mature, star and loop sequences\n\nTool homepage: https://github.com/rajewsky-lab/mirdeep2"
inputs:
  - id: precursors
    type: File
    doc: miRNA precursor sequences from miRBase
    inputBinding:
      position: 101
      prefix: -p
  - id: mature
    type: File
    doc: miRNA sequences from miRBase
    inputBinding:
      position: 101
      prefix: -m
  - id: reads
    type: File
    doc: Read sequences (collapsed fasta)
    inputBinding:
      position: 101
      prefix: -r
  - id: list_ucsc_species
    type:
      - 'null'
      - boolean
    doc: List all values allowed for the species parameter that have an entry at UCSC
    inputBinding:
      position: 101
      prefix: -u
  - id: mature_5p_3p_ids
    type:
      - 'null'
      - boolean
    doc: Specify this option if the mature miRNA file contains 5p and 3p ids only
    inputBinding:
      position: 101
      prefix: -P
  - id: config_file
    type:
      - 'null'
      - File
    doc: Config file with different sample ids, or just the one sample id (deprecated)
    inputBinding:
      position: 101
      prefix: -c
  - id: star_sequences
    type:
      - 'null'
      - File
    doc: Optional star sequences from miRBase
    inputBinding:
      position: 101
      prefix: -s
  - id: species
    type:
      - 'null'
      - string
    doc: Species, e.g. Mouse or mmu. If not given, all species in the files are analyzed
    inputBinding:
      position: 101
      prefix: -t
  - id: timestamp
    type:
      - 'null'
      - string
    doc: Optional time stamp used in output names; otherwise a new one is generated
    inputBinding:
      position: 101
      prefix: -y
  - id: no_pdfs
    type:
      - 'null'
      - boolean
    doc: Do not generate pdfs
    inputBinding:
      position: 101
      prefix: -d
  - id: no_sort_by_sample
    type:
      - 'null'
      - boolean
    doc: Do not sort reads by sample in the pdf file
    inputBinding:
      position: 101
      prefix: -o
  - id: different_ids
    type:
      - 'null'
      - boolean
    doc: Also consider precursor-mature mappings that have different ids, e.g. let7c may map to pre-let7a
    inputBinding:
      position: 101
      prefix: -k
  - id: no_file_conversion
    type:
      - 'null'
      - boolean
    doc: Do not do file conversion again
    inputBinding:
      position: 101
      prefix: -n
  - id: no_precursor_mapping
    type:
      - 'null'
      - boolean
    doc: Do not do mapping against precursor again
    inputBinding:
      position: 101
      prefix: -x
  - id: mismatches
    type:
      - 'null'
      - int
    doc: Number of allowed mismatches when mapping reads to precursors, default 1
    inputBinding:
      position: 101
      prefix: -g
  - id: upstream_nt
    type:
      - 'null'
      - int
    doc: Number of nucleotides upstream of the mature sequence to consider, default 2
    inputBinding:
      position: 101
      prefix: -e
  - id: downstream_nt
    type:
      - 'null'
      - int
    doc: Number of nucleotides downstream of the mature sequence to consider, default 5
    inputBinding:
      position: 101
      prefix: -f
  - id: no_mrd_and_pdfs
    type:
      - 'null'
      - boolean
    doc: Do not create an output.mrd file and pdfs
    inputBinding:
      position: 101
      prefix: -j
  - id: weigh_by_mappings
    type:
      - 'null'
      - boolean
    doc: Read counts are weighed by their number of mappings
    inputBinding:
      position: 101
      prefix: -W
  - id: unique_mappings_only
    type:
      - 'null'
      - boolean
    doc: Use only unique read mappings; miRNAs with multiple precursors will be underestimated
    inputBinding:
      position: 101
      prefix: -U
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: expression_html
    type:
      - 'null'
      - type: array
        items: File
    doc: Expression results as html
    outputBinding:
      glob: expression_*.html
  - id: expression_csv
    type:
      - 'null'
      - type: array
        items: File
    doc: Read counts of the miRNAs per sample
    outputBinding:
      glob: miRNAs_expressed_all_samples_*.csv
  - id: pdf_directories
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Read signature pdfs per precursor
    outputBinding:
      glob: pdfs_*
  - id: expression_analyses
    type:
      - 'null'
      - Directory
    doc: Intermediate mapping and analysis files
    outputBinding:
      glob: expression_analyses
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
stdout: quantifier.out
