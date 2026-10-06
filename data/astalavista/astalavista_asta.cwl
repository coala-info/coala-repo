cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - astalavista
  - -t
  - asta
label: astalavista_asta
doc: "AStalavista event retriever. Decomposes an input GTF annotation systematically into
  alternative splicing (AS) events and writes them as GTF.\n\nTool homepage: https://github.com/divyavewall/astalavista-frontend"
inputs:
  - id: in_file
    type: File
    doc: Path to the GTF reference annotation
    inputBinding:
      position: 102
      prefix: --in
  - id: events_file
    type: string
    doc: Path to the GTF output file for events (a .gz name gives gzipped output)
    inputBinding:
      position: 102
      prefix: --eo
  - id: events
    type:
      - 'null'
      - string
    doc: Type of events that are considered (default ASI)
    inputBinding:
      position: 102
      prefix: --ev
  - id: events_dimension
    type:
      - 'null'
      - int
    doc: Dimension of the AS events to be extracted, retrieves 'complete' events for
      parameter values < 2 (default 2)
    inputBinding:
      position: 102
      prefix: --ed
  - id: events_attributes
    type:
      - 'null'
      - string
    doc: Toggle optional attributes to be output
    inputBinding:
      position: 102
      prefix: --ea
  - id: chr_seq
    type:
      - 'null'
      - Directory
    doc: Directory with the genomic sequences, one fasta file per chromosome/scaffold/contig
      named by the identifiers of the first column in the GTF annotation
    inputBinding:
      position: 102
      prefix: --chr
  - id: par_file
    type:
      - 'null'
      - File
    doc: Path to the parameter file
    inputBinding:
      position: 102
      prefix: --par
  - id: intron_confidence
    type:
      - 'null'
      - int
    doc: Confidence level for introns in the annotation
    inputBinding:
      position: 102
      prefix: --ic
  - id: edge_confidence
    type:
      - 'null'
      - int
    doc: Transcript edge confidence level
    inputBinding:
      position: 102
      prefix: --ec
  - id: force
    type:
      - 'null'
      - boolean
    doc: Disable interactivity. No questions will be asked
    inputBinding:
      position: 101
      prefix: --force
  - id: log_level
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
  - id: events_gtf
    type: File
    doc: AS events in GTF format
    outputBinding:
      glob: $(inputs.events_file)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.in_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/astalavista:4.0--0
stdout: astalavista_asta.out
