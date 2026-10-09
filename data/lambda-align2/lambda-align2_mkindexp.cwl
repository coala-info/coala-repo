cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lambda2
  - mkindexp
label: lambda-align2_mkindexp
doc: "Create an index for protein searches (builds the Lambda index of a protein or translated DNA database).\n\nTool homepage: http://seqan.github.io/lambda/"
inputs:
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Display more/less diagnostic output during operation: 0 [only errors]; 1 [default]; 2 [+run-time, options and statistics]. In range [0..2]. Default: 1.'
    inputBinding:
      position: 101
      prefix: --verbosity
  - id: database
    type: File
    doc: 'Database sequences. Valid filetypes are: .sam[.*], .raw[.*], .gbk[.*], .frn[.*], .fq[.*], .fna[.*], .ffn[.*], .fastq[.*], .fasta[.*], .faa[.*], .fa[.*], .embl[.*], and .bam, where * is any of the following extensions: gz, bz2, and bgzf for transparent (de)compression.'
    inputBinding:
      position: 101
      prefix: --database
  - id: acc_tax_map
    type:
      - 'null'
      - File
    doc: 'An NCBI or UniProt accession-to-taxid mapping file. Download from ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/accession2taxid/ or ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/idmapping/ . Valid filetypes are: .dat[.*] and .accession2taxid[.*], where * is any of the following extensions: gz, bz2, and bgzf for transparent (de)compression.'
    inputBinding:
      position: 101
      prefix: --acc-tax-map
  - id: tax_dump_dir
    type:
      - 'null'
      - Directory
    doc: 'A directory that contains nodes.dmp and names.dmp; unzipped from ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/taxdump.tar.gz'
    inputBinding:
      position: 101
      prefix: --tax-dump-dir
  - id: index
    type: string
    doc: 'The output directory for the index files (defaults to "DATABASE.lambda"). Valid filetype is: .lambda.'
    inputBinding:
      position: 101
      prefix: --index
  - id: db_index_type
    type:
      - 'null'
      - string
    doc: 'Suffix array or full-text minute space. One of fm and bifm. Default: fm.'
    inputBinding:
      position: 101
      prefix: --db-index-type
  - id: truncate_ids
    type:
      - 'null'
      - string
    doc: 'Truncate IDs at first whitespace. This saves a lot of space and is irrelevant for all LAMBDA output formats other than BLAST Pairwise (.m0). One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO. Default: on.'
    inputBinding:
      position: 101
      prefix: --truncate-ids
  - id: input_alphabet
    type:
      - 'null'
      - string
    doc: 'Alphabet of the database sequences (specify to override auto-detection); if input is Dna, it will be translated. One of auto, dna5, and aminoacid. Default: auto.'
    inputBinding:
      position: 101
      prefix: --input-alphabet
  - id: genetic_code
    type:
      - 'null'
      - int
    doc: 'The translation table to use if input is Dna. See https://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi?mode=c for ids (default is generic). Default: 1.'
    inputBinding:
      position: 101
      prefix: --genetic-code
  - id: alphabet_reduction
    type:
      - 'null'
      - string
    doc: 'Alphabet Reduction for seeding phase. One of none and murphy10. Default: murphy10.'
    inputBinding:
      position: 101
      prefix: --alphabet-reduction
  - id: algorithm
    type:
      - 'null'
      - string
    doc: 'Algorithm for SA construction (also used for FM; see Memory Requirements below!). One of mergesort, quicksortbuckets, quicksort, radixsort, and skew7ext. Default: radixsort.'
    inputBinding:
      position: 101
      prefix: --algorithm
  - id: threads
    type:
      - 'null'
      - int
    doc: 'number of threads to run concurrently (ignored if a == skew7ext). In range [1..200]. Default: 20.'
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: 'temporary directory used by skew, defaults to working directory. Default: /data.'
    inputBinding:
      position: 101
      prefix: --tmp-dir
outputs:
  - id: index_dir
    type: Directory
    doc: Lambda index directory
    outputBinding:
      glob: $(inputs.index)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/lambda-align2:v2.0.0-6-deb_cv1
stdout: lambda-align2_mkindexp.out
