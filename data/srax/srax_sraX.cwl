cwlVersion: v1.2
class: CommandLineTool
baseCommand: srax
label: srax_sraX
doc: "sraX is designed to read assembled sequence files in FASTA format and systematically
  detect the presence of antimicrobial resistance genes (ARGs). The complete resistome
  analysis is effectively accomplished by running a single command. Under default
  parameters, only a mandatory folder enclosing the selected genome FASTA files is
  required. In addition, the following default data repositories & software dependences
  are preferred: CARD database (ARG repository), DIAMOND (sequence aligner), MUSCLE
  (multiple-sequence aligner, required for SNP detection) and R environment (visualization
  plots).\n\nTool homepage: https://github.com/lgpdevtools/sraX"
inputs:
  - id: aln_cov
    type:
      - 'null'
      - int
    doc: Minimum length of the query which must align to the reference sequence.
    default: 60
    inputBinding:
      position: 101
      prefix: --aln_cov
  - id: dbsearch
    type:
      - 'null'
      - string
    doc: "The level of the ARG search, on account of the number and type of employed
      AMR DB. The possible choices are: 'basic' or 'ext'. The 'basic' option only
      applies 'CARD', while the 'ext' option utilizes as well the 'ARGminer' (compilation
      of multiple AMR DBs) and 'BACMET' (biocides and metal resistance) repositories.
      Note: In operational terms, the extensive search ('ext' option) takes much longer
      computing times."
    default: basic
    inputBinding:
      position: 101
      prefix: --dbsearch
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Verbose output (for debugging).
    inputBinding:
      position: 101
      prefix: --debug
  - id: eval
    type:
      - 'null'
      - float
    doc: Minimum evalue cut-off to filter false positives.
    default: '1e-05'
    inputBinding:
      position: 101
      prefix: --eval
  - id: input_dir
    type: Directory
    doc: Input directory containing the input file(s), which must be in FASTA 
      format and consisting of individual assembled genome sequences.
    inputBinding:
      position: 101
      prefix: --input
  - id: min_identity
    type:
      - 'null'
      - int
    doc: Minimum identity cut-off to filter false positives.
    default: 85
    inputBinding:
      position: 101
      prefix: --id
  - id: msa
    type:
      - 'null'
      - string
    doc: "The preferred algorithm for producing the alignment of clustered homologous
      sequences (multiple-sequence files). The possible choices are: 'muscle', 'clustalo'
      or 'mafft'. Note: The accuracy and computing times are both dependent on the
      selected algorithm."
    default: muscle
    inputBinding:
      position: 101
      prefix: --msa
  - id: seqal
    type:
      - 'null'
      - string
    doc: "The preferred algorithm for aligning the assembled genome(s) to a locally
      compiled AMR DB. The possible choices are: 'dblastx' (DIAMOND blastx) or 'blastx'
      (NCBI blastx). In any case, the process is parallelized (up to 100 genome files
      are run simultaneously) for reducing computing times."
    default: dblastx
    inputBinding:
      position: 101
      prefix: --seqal
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads when running sraX.
    default: 6
    inputBinding:
      position: 101
      prefix: --threads
  - id: user_sq
    type:
      - 'null'
      - File
    doc: Customary AMR DB provided by the user. The sequences must be in FASTA 
      format.
    inputBinding:
      position: 101
      prefix: --user_sq
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: "Directory to store obtained results. While not provided, the following default
      name will be taken: 'input_directory'_'sraX'_'id'_'aln_cov'_'seqal'"
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/srax:1.5--pl5321h05cac1d_4
