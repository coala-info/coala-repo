cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - astalavista
  - -t
  - astafunk
label: astalavista_astafunk
doc: "Alternative Splicing Transcriptional Analyses with Functional Knowledge: Search
  Pfam HMMs against alternatively spliced regions.\n\nTool homepage: https://github.com/divyavewall/astalavista-frontend"
inputs:
  - id: hmm
    type: File
    doc: Path to the profile HMM file (Pfam HMMER3 format)
    inputBinding:
      position: 102
      prefix: --hmm
  - id: gtf
    type: File
    doc: Path to the GTF reference annotation
    inputBinding:
      position: 102
      prefix: --gtf
  - id: genome
    type: Directory
    doc: Directory with the genomic sequences, one fasta file per chromosome/scaffold/contig
      named by the identifiers of the first column in the GTF annotation
    inputBinding:
      position: 102
      prefix: --genome
  - id: cpu
    type:
      - 'null'
      - int
    doc: Number of threads to run (default 1)
    inputBinding:
      position: 102
      prefix: --cpu
  - id: reference
    type:
      - 'null'
      - File
    doc: Path to the reference domain file
    inputBinding:
      position: 102
      prefix: --reference
  - id: overlapping
    type:
      - 'null'
      - int
    doc: Hit overlapping allowed (default 0)
    inputBinding:
      position: 102
      prefix: --overlapping
  - id: naive
    type:
      - 'null'
      - boolean
    doc: Run naive search of domains against all genes with alternative splicing (uses
      a reference domain file)
    inputBinding:
      position: 102
      prefix: --naive
  - id: exhaustive
    type:
      - 'null'
      - boolean
    doc: Perform exhaustive search against HMM database (default heuristic search)
    inputBinding:
      position: 102
      prefix: --exh
  - id: output_hits_per_gene
    type:
      - 'null'
      - boolean
    doc: Output best non-overlapped domain hits of the alternatively spliced gene
    inputBinding:
      position: 102
      prefix: --output-hits-per-gene
  - id: all_hits
    type:
      - 'null'
      - boolean
    doc: Output all domain hits of each alternative variant
    inputBinding:
      position: 102
      prefix: --all
  - id: local
    type:
      - 'null'
      - boolean
    doc: Run local search (default glocal)
    inputBinding:
      position: 102
      prefix: --local
  - id: tref
    type:
      - 'null'
      - boolean
    doc: Output FASTA file with reference transcript of each gene (only with --gtf and
      --genome)
    inputBinding:
      position: 102
      prefix: --tref
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose
    inputBinding:
      position: 102
      prefix: --verbose
  - id: const
    type:
      - 'null'
      - boolean
    doc: Perform a domain search only on constitutive regions of all genes
    inputBinding:
      position: 102
      prefix: --const
  - id: force
    type:
      - 'null'
      - boolean
    doc: Disable interactivity. No questions will be asked
    inputBinding:
      position: 101
      prefix: --force
  - id: log
    type:
      - 'null'
      - string
    doc: Log level (NONE|INFO|ERROR|DEBUG)
    inputBinding:
      position: 101
      prefix: --log
  - id: threads
    type:
      - 'null'
      - int
    doc: Maximum number of threads to use.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.gtf)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/astalavista:4.0--0
stdout: astalavista_astafunk.out
