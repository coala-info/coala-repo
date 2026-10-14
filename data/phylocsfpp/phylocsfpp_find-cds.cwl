cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phylocsf++
  - find-cds
label: phylocsfpp_find-cds
doc: "Takes a GFF file with transcripts and scores every possible ORF to find novel protein-coding genes and outputs a GFF file with annotated CDS features. Either all CDS meeting the criteria can be outputted, or the longest or best-scoring one. find-cds and especially --evaluate is experimental.\n\nTool homepage: https://github.com/cpockrandt/PhyloCSFpp"
inputs:
  - id: output
    type: string
    doc: "Directory where the output GFF/GTF will be written to. If it does not exist, it will be created."
    inputBinding:
      position: 1
      prefix: "--output"
  - id: mode
    type:
      - 'null'
      - string
    doc: "Which CDS to report: ALL, LONGEST, BEST_SCORE. Default: LONGEST"
    inputBinding:
      position: 1
      prefix: "--mode"
  - id: min_score
    type:
      - 'null'
      - float
    doc: "Only consider ORFs with a minimum weighted PhyloCSF mean score (range from -15 to +15, >0 more likely to be protein-coding). Default: 0"
    inputBinding:
      position: 1
      prefix: "--min-score"
  - id: min_codons
    type:
      - 'null'
      - int
    doc: "Only consider ORFs with a minimum codon length. Default: 25"
    inputBinding:
      position: 1
      prefix: "--min-codons"
  - id: evaluate
    type:
      - 'null'
      - int
    doc: "Additionally reads CDS features in input GFF/GTF and outputs statistics how well PhyloCSF++ has predicted CDS (0 or 1). Default: 0"
    inputBinding:
      position: 1
      prefix: "--evaluate"
  - id: fasta
    type: File
    doc: "Path to the genome fasta file."
    inputBinding:
      position: 2
  - id: tracks
    type: File
    doc: "The bigWig file PhyloCSF+1.bw (the other 5 frames, and optionally the power track, are expected in the same directory: list them in track_files)."
    inputBinding:
      position: 3
  - id: track_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "The other bigWig tracks (PhyloCSF+2.bw, PhyloCSF+3.bw, PhyloCSF-1.bw, PhyloCSF-2.bw, PhyloCSF-3.bw and optionally PhyloCSFpower.bw), staged next to the first track"
  - id: gff_files
    type:
      type: array
      items: File
    doc: "One or more GFF/GTF files with transcripts."
    inputBinding:
      position: 4
outputs:
  - id: cds_gff
    type:
      - 'null'
      - Directory
    doc: "GFF/GTF files with annotated CDS features"
    outputBinding:
      glob: "$(inputs.output)"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.tracks)
      - $(inputs.track_files || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylocsfpp:1.2.0_9643238d--hea07040_3
stdout: phylocsfpp_find-cds.out
