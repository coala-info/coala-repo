cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ananse
  - binding
label: ananse_binding
doc: "Predict transcription factor binding in each region from ATAC-seq and/or H3K27ac ChIP-seq signal (or CAGE TPMs) and motif scores; writes binding.h5\n\nTool homepage: https://github.com/vanheeringen-lab/ANANSE"
inputs:
  - id: atac_bams
    type: ['null', {type: array, items: File}]
    doc: "ATAC-seq input BAM file(s) (or one counts table with reads per peak), can be used alone or in combination with the -H option"
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      position: 1
      prefix: --atac-bams
  - id: histone_bams
    type: ['null', {type: array, items: File}]
    doc: "H3K27ac ChIP-seq input BAM file(s) (or one counts table with reads per peak), can be used alone or in combination with the -A option"
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      position: 1
      prefix: --histone-bams
  - id: cage_tpms
    type: ['null', File]
    doc: "CAGE-seq bidirectional regions (TPM) generated with CAGEfightR, cannot be used in combination with the -A and/or -H options"
    inputBinding:
      position: 1
      prefix: --cage-tpms
  - id: genome
    type: ['null', File]
    doc: "Genome FASTA file used to align the BAMs and regions to (genomepy writes its index files next to it; a genomepy gene annotation <name>.annotation.gtf/.bed beside it is used to map transcripts to gene names)"
    secondaryFiles:
      - pattern: .fai
        required: false
      - pattern: .sizes
        required: false
      - pattern: ^.annotation.bed
        required: false
      - pattern: ^.annotation.gtf
        required: false
    inputBinding:
      position: 1
      prefix: --genome
  - id: regions
    type: ['null', {type: array, items: File}]
    doc: "Regions to analyse: one or more BED format files (e.g. BED, narrowPeak, broadPeak) or one file with one region per line (e.g. 'chr1:100-200'). Optional if a pfmscorefile is provided"
    inputBinding:
      position: 1
      prefix: --regions
  - id: pfmfile
    type: ['null', File]
    doc: "PFM file of the transcription factors to search for (default: gimme.vertebrate.v5.0); its <name>.motif2factors.txt is staged with it"
    secondaryFiles:
      - pattern: ^.motif2factors.txt
        required: false
    inputBinding:
      position: 1
      prefix: --pfmfile
  - id: outdir
    type: ['null', string]
    doc: "Directory where you wish to store the output (default: ./ANANSE_binding)"
    default: ANANSE_binding
    inputBinding:
      position: 1
      prefix: --outdir
  - id: columns
    type: ['null', {type: array, items: string}]
    doc: "One or more (case insensitive) column names to extract from the counts table(s) (default: all)"
    inputBinding:
      position: 1
      prefix: --columns
  - id: reference
    type: ['null', Directory]
    doc: "Path to reference data directory"
    inputBinding:
      position: 1
      prefix: --reference
  - id: pfmscorefile
    type: ['null', File]
    doc: "Use precomputed gimmemotifs scores (gimme scan -Tz --gc -g GENOME REGIONS > SCAN.tsv)"
    inputBinding:
      position: 1
      prefix: --pfmscorefile
  - id: tfs
    type: ['null', {type: array, items: string}]
    doc: "Filter Transcription Factors to use (default: all in motif2factors.txt). Either a space-separated list or one or more files with one TF per line"
    inputBinding:
      position: 1
      prefix: --tfs
  - id: jaccard_cutoff
    type: ['null', float]
    doc: "TFs with a jaccard motif similarity >= the cutoff can be used as backup model. 0: any similarity, 1: perfect similarity (default is 0.1)"
    inputBinding:
      position: 1
      prefix: --jaccard-cutoff
  - id: ncore
    type: ['null', int]
    doc: "Number of cores to use."
    inputBinding:
      position: 1
      prefix: --ncore
outputs:
  - id: binding_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.outdir)
  - id: binding_h5
    type: File
    doc: TF binding predictions (binding.h5)
    outputBinding:
      glob: $(inputs.outdir)/binding.h5
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.genome)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ananse:0.5.1--pyhdfd78af_0
