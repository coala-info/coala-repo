cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sierrapy
  - seqreads
label: sierrapy_seqreads
doc: "Run alignment, drug resistance and other analysis for one or more tab-delimited
  text files contained codon reads of HIV-1 pol DNA sequences.\n\nTool homepage: https://github.com/hivdb/sierra-client/tree/master/python"
inputs:
  - id: seqreads
    type: string
    doc: One or more tab-delimited text files contained codon reads of HIV-1 pol
      DNA sequences.
    inputBinding:
      position: 1
  - id: min_codon_reads
    type:
      - 'null'
      - int
    doc: Minimal read depth applied to each codon of this sequence
    default: 1
    inputBinding:
      position: 102
      prefix: --min-codon-reads
  - id: min_position_reads
    type:
      - 'null'
      - int
    doc: Minimal read depth applied to each position of this sequence
    default: 1
    inputBinding:
      position: 102
      prefix: --min-position-reads
  - id: mixture_cutoff
    type:
      - 'null'
      - float
    doc: 'Maximum mixture rate for this sequence reads (range: 0-1.0)'
    default: 0.0005
    inputBinding:
      position: 102
      prefix: --mixture-cutoff
  - id: pcnt_cutoff
    type:
      - 'null'
      - float
    doc: 'Minimal prevalence cutoff for this sequence reads (range: 0-1.0)'
    default: 0.1
    inputBinding:
      position: 102
      prefix: --pcnt-cutoff
  - id: query
    type:
      - 'null'
      - File
    doc: A file contains GraphQL fragment definition on `SequenceAnalysis`
    inputBinding:
      position: 102
      prefix: --query
  - id: ugly
    type:
      - 'null'
      - boolean
    doc: Output compressed JSON result
    inputBinding:
      position: 102
      prefix: --ugly
  - id: url
    type:
      - 'null'
      - string
    doc: URL of Sierra GraphQL Web Service.
    default: production URL varied by virus
    inputBinding:
      position: 102
      prefix: --url
  - id: virus
    type:
      - 'null'
      - string
    doc: Specify virus to be analyzed.
    default: HIV1
    inputBinding:
      position: 102
      prefix: --virus
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sierrapy:0.4.3--pyh7cba7a3_0
stdout: sierrapy_seqreads.out
