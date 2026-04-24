cwlVersion: v1.2
class: CommandLineTool
baseCommand: weave
label: tapestry_weave
doc: "assess quality of one genome assembly\n\nTool homepage: https://github.com/johnomics/tapestry"
inputs:
  - id: assembly
    type: File
    doc: filename of assembly in FASTA format (required)
    inputBinding:
      position: 101
      prefix: --assembly
  - id: cores
    type:
      - 'null'
      - int
    doc: number of parallel cores to use (default 1)
    inputBinding:
      position: 101
      prefix: --cores
  - id: depth
    type:
      - 'null'
      - int
    doc: genome coverage to subsample from FASTQ file
    inputBinding:
      position: 101
      prefix: --depth
  - id: forcereadoutput
    type:
      - 'null'
      - boolean
    doc: output read alignments whatever the assembly size (default, only output
      read alignments for <50 Mb assemblies)
    inputBinding:
      position: 101
      prefix: --forcereadoutput
  - id: length
    type:
      - 'null'
      - int
    doc: minimum read length to retain when subsampling (default 10000 bp)
    inputBinding:
      position: 101
      prefix: --length
  - id: mincontigalignment
    type:
      - 'null'
      - int
    doc: minimum length of contig alignment to keep (default 2000 bp)
    inputBinding:
      position: 101
      prefix: --mincontigalignment
  - id: output
    type:
      - 'null'
      - Directory
    doc: directory to write output, default weave_output
    inputBinding:
      position: 101
      prefix: --output
  - id: reads
    type: File
    doc: filename of long reads in FASTQ format (required; must be gzipped)
    inputBinding:
      position: 101
      prefix: --reads
  - id: telomere
    type:
      - 'null'
      - type: array
        items: string
    doc: telomere sequence to search for
    inputBinding:
      position: 101
      prefix: --telomere
  - id: windowsize
    type:
      - 'null'
      - int
    doc: window size for ploidy calculations (default ~1/30th of contig N50 
      length, minimum 10000 bp)
    inputBinding:
      position: 101
      prefix: --windowsize
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tapestry:1.0.1--pyhdfd78af_0
stdout: tapestry_weave.out
