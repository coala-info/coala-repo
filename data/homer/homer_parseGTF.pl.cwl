cwlVersion: v1.2
class: CommandLineTool
baseCommand: parseGTF.pl
label: homer_parseGTF.pl
doc: "Convert a GTF/GFF annotation file to a HOMER-style position/peak file or annotation file (written to standard output)\n\nTool homepage: http://homer.ucsd.edu/homer/index.html"
inputs:
  - id: gtf_file
    type: File
    doc: 'GTF format file (or GFF/GFF3 with -gff/-gff3)'
    inputBinding:
      position: 1
  - id: mode
    type: string
    doc: 'Output mode: tss (TSS positions +/- 2000 bp), tts (termination positions +/- 2000 bp), exons, ann (file for assignGenomeAnnotation), anntype (as ann, with transcript type), rna (file for analyzeRNA.pl), gtf (gtf file with no redundant transcript/gene ids) or anntable (table with attribute information for each gene id)'
    inputBinding:
      position: 2
  - id: gff
    type:
      - 'null'
      - boolean
    doc: 'input file is in GFF format (treats the 9th column as the id)'
    inputBinding:
      position: 103
      prefix: '-gff'
  - id: gff3
    type:
      - 'null'
      - boolean
    doc: 'input file is in GFF3 format (looks for the parent attribute to assign the gene name)'
    inputBinding:
      position: 103
      prefix: '-gff3'
  - id: att
    type:
      - 'null'
      - string
    doc: 'attribute to report (default: ID); for -gff3 input'
    inputBinding:
      position: 103
      prefix: '-att'
  - id: gid
    type:
      - 'null'
      - boolean
    doc: 'use gene ids as the primary identifier'
    inputBinding:
      position: 103
      prefix: '-gid'
  - id: tid
    type:
      - 'null'
      - boolean
    doc: 'use transcript ids as the primary identifier (default)'
    inputBinding:
      position: 103
      prefix: '-tid'
  - id: removeAccVer
    type:
      - 'null'
      - boolean
    doc: 'remove the .1, .2, etc. at the end of accession numbers, i.e. AT1G01040.2'
    inputBinding:
      position: 103
      prefix: '-removeAccVer'
  - id: removeEnsemblVer
    type:
      - 'null'
      - boolean
    doc: 'remove ''transcript:'' and ''_T01'' style ids'
    inputBinding:
      position: 103
      prefix: '-removeEnsemblVer'
  - id: features
    type:
      - 'null'
      - type: array
        items: string
    doc: 'features to report (default: exon)'
    inputBinding:
      position: 103
      prefix: '-features'
  - id: keepAll
    type:
      - 'null'
      - boolean
    doc: 'keep all transcripts (normally only transcripts with exon annotations are used)'
    inputBinding:
      position: 103
      prefix: '-keepAll'
  - id: annTSSstartOffset
    type:
      - 'null'
      - int
    doc: 'distance upstream of the TSS to start promoter annotation (default: -1000)'
    inputBinding:
      position: 103
      prefix: '-annTSSstartOffset'
  - id: annTSSendOffset
    type:
      - 'null'
      - int
    doc: 'distance downstream of the TSS to end promoter annotation (default: 100)'
    inputBinding:
      position: 103
      prefix: '-annTSSendOffset'
  - id: annTTSstartOffset
    type:
      - 'null'
      - int
    doc: 'distance upstream of the TTS (transcription termination site) to start annotation (default: -100)'
    inputBinding:
      position: 103
      prefix: '-annTTSstartOffset'
  - id: annTTSendOffset
    type:
      - 'null'
      - int
    doc: 'distance downstream of the TTS to end annotation (default: 1000)'
    inputBinding:
      position: 103
      prefix: '-annTTSendOffset'
outputs:
  - id: positions
    type: stdout
    doc: 'Position/annotation output (standard output)'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/homer:5.1--pl5262h9948957_0
stdout: homer_parseGTF.out
