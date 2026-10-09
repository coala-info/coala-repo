cwlVersion: v1.2
class: CommandLineTool
baseCommand: annotatePeaks.pl
label: homer_annotatePeaks.pl
doc: "Annotate peaks with the nearest gene and genomic feature, count tags, find motifs, make histograms around peaks\n\nTool homepage: http://homer.ucsd.edu/homer/index.html"
inputs:
  - id: peak_file
    type:
      - File
      - string
    doc: Peak file (BED or HOMER peak format), or the word tss, tts or rna for gene-centric mode
    inputBinding:
      position: 1
  - id: genome
    type:
      - string
      - File
    doc: Genome version (name), a custom genome FASTA file, or none
    inputBinding:
      position: 2
  - id: gtf
    type:
      - 'null'
      - File
    doc: 'GTF (gene transfer format) file to annotate positions relative to custom annotations'
    inputBinding:
      position: 103
      prefix: '-gtf'
  - id: gff
    type:
      - 'null'
      - File
    doc: 'GFF file with custom annotations'
    inputBinding:
      position: 103
      prefix: '-gff'
  - id: gff3
    type:
      - 'null'
      - File
    doc: 'GFF3 file with custom annotations'
    inputBinding:
      position: 103
      prefix: '-gff3'
  - id: gid
    type:
      - 'null'
      - boolean
    doc: 'by default the GTF file is processed by transcript_id, use this option for gene_id'
    inputBinding:
      position: 103
      prefix: '-gid'
  - id: ann
    type:
      - 'null'
      - File
    doc: 'custom homer annotation file (created by assignGenomeAnnotation)'
    inputBinding:
      position: 103
      prefix: '-ann'
  - id: organism
    type:
      - 'null'
      - string
    doc: 'organism, useful with a FASTA genome or none'
    inputBinding:
      position: 103
      prefix: '-organism'
  - id: list
    type:
      - 'null'
      - File
    doc: 'gene id list (subset of genes to perform analysis, TSS mode)'
    inputBinding:
      position: 103
      prefix: '-list'
  - id: cTSS
    type:
      - 'null'
      - File
    doc: 'promoter position file (should be centered on TSS)'
    inputBinding:
      position: 103
      prefix: '-cTSS'
  - id: mask
    type:
      - 'null'
      - boolean
    doc: 'masked repeats'
    inputBinding:
      position: 103
      prefix: '-mask'
  - id: motif_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'list of motif files to find in peaks'
    inputBinding:
      position: 103
      prefix: '-m'
  - id: mscore
    type:
      - 'null'
      - boolean
    doc: 'reports the highest log-odds score within the peak'
    inputBinding:
      position: 103
      prefix: '-mscore'
  - id: nmotifs
    type:
      - 'null'
      - boolean
    doc: 'reports the number of motifs per peak'
    inputBinding:
      position: 103
      prefix: '-nmotifs'
  - id: mdist
    type:
      - 'null'
      - boolean
    doc: 'reports distance to closest motif'
    inputBinding:
      position: 103
      prefix: '-mdist'
  - id: mfasta
    type:
      - 'null'
      - string
    doc: 'file name for a fasta file of motif sites'
    inputBinding:
      position: 103
      prefix: '-mfasta'
  - id: filter_motif_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'list of motif files to filter from -m'
    inputBinding:
      position: 103
      prefix: '-fm'
  - id: rmrevopp
    type:
      - 'null'
      - int
    doc: 'only count sites found within <#> on both strands once (palindromic)'
    inputBinding:
      position: 103
      prefix: '-rmrevopp'
  - id: matrix
    type:
      - 'null'
      - string
    doc: 'prefix for motif co-occurrence output files'
    inputBinding:
      position: 103
      prefix: '-matrix'
  - id: matrixMinDist
    type:
      - 'null'
      - int
    doc: 'minimum distance between motif pairs (default 4)'
    inputBinding:
      position: 103
      prefix: '-matrixMinDist'
  - id: matrixMaxDist
    type:
      - 'null'
      - int
    doc: 'maximum distance between motif pairs'
    inputBinding:
      position: 103
      prefix: '-matrixMaxDist'
  - id: mbed
    type:
      - 'null'
      - string
    doc: 'file name for motif positions in BED format'
    inputBinding:
      position: 103
      prefix: '-mbed'
  - id: mlogic
    type:
      - 'null'
      - string
    doc: 'file name for stats on common motif orientations'
    inputBinding:
      position: 103
      prefix: '-mlogic'
  - id: tag_directories
    type:
      - 'null'
      - type: array
        items: Directory
    doc: 'list of tag directories to show tag counts for'
    inputBinding:
      position: 103
      prefix: '-d'
  - id: dfile
    type:
      - 'null'
      - File
    doc: 'file with a list of tag directories in the first column'
    inputBinding:
      position: 103
      prefix: '-dfile'
  - id: bedGraph
    type:
      - 'null'
      - type: array
        items: File
    doc: 'bedGraph files to read coverage counts from'
    inputBinding:
      position: 103
      prefix: '-bedGraph'
  - id: wig
    type:
      - 'null'
      - type: array
        items: File
    doc: 'wiggle files to read coverage counts from'
    inputBinding:
      position: 103
      prefix: '-wig'
  - id: peak_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'peak files to find nearest peaks'
    inputBinding:
      position: 103
      prefix: '-p'
  - id: pdist
    type:
      - 'null'
      - boolean
    doc: 'only report distance to nearest peak'
    inputBinding:
      position: 103
      prefix: '-pdist'
  - id: pdist2
    type:
      - 'null'
      - boolean
    doc: 'directional distance to nearest peak'
    inputBinding:
      position: 103
      prefix: '-pdist2'
  - id: pcount
    type:
      - 'null'
      - boolean
    doc: 'report number of peaks within region'
    inputBinding:
      position: 103
      prefix: '-pcount'
  - id: vcf
    type:
      - 'null'
      - File
    doc: 'VCF file to annotate peaks with genetic variation'
    inputBinding:
      position: 103
      prefix: '-vcf'
  - id: editDistance
    type:
      - 'null'
      - boolean
    doc: 'computes the number of bp changes relative to reference'
    inputBinding:
      position: 103
      prefix: '-editDistance'
  - id: individuals
    type:
      - 'null'
      - type: array
        items: string
    doc: 'restrict analysis to these individuals'
    inputBinding:
      position: 103
      prefix: '-individuals'
  - id: gene_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'data files added to the result based on the closest gene'
    inputBinding:
      position: 103
      prefix: '-gene'
  - id: go
    type:
      - 'null'
      - string
    doc: 'output directory for a GO analysis using genes near peaks'
    inputBinding:
      position: 103
      prefix: '-go'
  - id: genomeOntology
    type:
      - 'null'
      - string
    doc: 'output directory for a genomeOntology analysis on peaks'
    inputBinding:
      position: 103
      prefix: '-genomeOntology'
  - id: gsize
    type:
      - 'null'
      - string
    doc: 'genome size for genomeOntology analysis (default 2e9)'
    inputBinding:
      position: 103
      prefix: '-gsize'
  - id: hist
    type:
      - 'null'
      - int
    doc: 'histogram mode: bin size in bp'
    inputBinding:
      position: 103
      prefix: '-hist'
  - id: nuc
    type:
      - 'null'
      - boolean
    doc: 'calculate mononucleotide frequencies at each position'
    inputBinding:
      position: 103
      prefix: '-nuc'
  - id: di
    type:
      - 'null'
      - boolean
    doc: 'calculate dinucleotide frequencies at each position'
    inputBinding:
      position: 103
      prefix: '-di'
  - id: histNorm
    type:
      - 'null'
      - int
    doc: 'normalize the total tag count for each region to 1 (minimum tag total per region)'
    inputBinding:
      position: 103
      prefix: '-histNorm'
  - id: ghist
    type:
      - 'null'
      - boolean
    doc: 'output profiles for each gene'
    inputBinding:
      position: 103
      prefix: '-ghist'
  - id: rm
    type:
      - 'null'
      - int
    doc: 'remove occurrences of same motif that occur within # bp'
    inputBinding:
      position: 103
      prefix: '-rm'
  - id: center
    type:
      - 'null'
      - File
    doc: 're-center peaks on the motif of this file'
    inputBinding:
      position: 103
      prefix: '-center'
  - id: multi
    type:
      - 'null'
      - boolean
    doc: 'return genomic positions of all sites instead of just the closest to center'
    inputBinding:
      position: 103
      prefix: '-multi'
  - id: mirror
    type:
      - 'null'
      - boolean
    doc: 'flip the position when re-centering'
    inputBinding:
      position: 103
      prefix: '-mirror'
  - id: cmpGenome
    type:
      - 'null'
      - type: array
        items: string
    doc: 'genomes to compare for sequence/motifs'
    inputBinding:
      position: 103
      prefix: '-cmpGenome'
  - id: cmpLiftover
    type:
      - 'null'
      - type: array
        items: File
    doc: 'liftover files to compare for sequence/motifs'
    inputBinding:
      position: 103
      prefix: '-cmpLiftover'
  - id: revLiftover
    type:
      - 'null'
      - type: array
        items: File
    doc: 'reverse liftover files to compare for sequence/motifs'
    inputBinding:
      position: 103
      prefix: '-revLiftover'
  - id: fpkm
    type:
      - 'null'
      - boolean
    doc: 'normalize read counts to million reads or fragments per kilobase mapped'
    inputBinding:
      position: 103
      prefix: '-fpkm'
  - id: raw
    type:
      - 'null'
      - boolean
    doc: 'do not adjust the tag counts based on total tags sequenced'
    inputBinding:
      position: 103
      prefix: '-raw'
  - id: norm
    type:
      - 'null'
      - int
    doc: 'normalize tags to this tag count (default 1e7, 0 = average)'
    inputBinding:
      position: 103
      prefix: '-norm'
  - id: normLength
    type:
      - 'null'
      - int
    doc: 'fragment length to normalize to (default 100)'
    inputBinding:
      position: 103
      prefix: '-normLength'
  - id: log
    type:
      - 'null'
      - boolean
    doc: 'output tag counts as log2(x+1+rand) values'
    inputBinding:
      position: 103
      prefix: '-log'
  - id: sqrt
    type:
      - 'null'
      - boolean
    doc: 'output tag counts as sqrt(x+rand) values'
    inputBinding:
      position: 103
      prefix: '-sqrt'
  - id: ratio
    type:
      - 'null'
      - boolean
    doc: 'process tag values as ratios'
    inputBinding:
      position: 103
      prefix: '-ratio'
  - id: rlog
    type:
      - 'null'
      - boolean
    doc: 'rlog normalization with DESeq2 (needs R)'
    inputBinding:
      position: 103
      prefix: '-rlog'
  - id: vst
    type:
      - 'null'
      - boolean
    doc: 'vst normalization with DESeq2 (needs R)'
    inputBinding:
      position: 103
      prefix: '-vst'
  - id: len
    type:
      - 'null'
      - int
    doc: 'fragment length (default auto)'
    inputBinding:
      position: 103
      prefix: '-len'
  - id: size
    type:
      - 'null'
      - string
    doc: 'peak size from center of peak, "#,#" for a range or "given"'
    inputBinding:
      position: 103
      prefix: '-size'
  - id: strand
    type:
      - 'null'
      - string
    doc: 'count tags on a specific strand relative to peak: +, - or both'
    inputBinding:
      position: 103
      prefix: '-strand'
  - id: pc
    type:
      - 'null'
      - int
    doc: 'maximum number of tags to count per bp (default 0, no maximum)'
    inputBinding:
      position: 103
      prefix: '-pc'
  - id: CpG
    type:
      - 'null'
      - boolean
    doc: 'calculate CpG/GC content'
    inputBinding:
      position: 103
      prefix: '-CpG'
  - id: nfr
    type:
      - 'null'
      - boolean
    doc: 'report nucleosome free region scores instead of tag counts'
    inputBinding:
      position: 103
      prefix: '-nfr'
  - id: nfrSize
    type:
      - 'null'
      - int
    doc: 'size of the nucleosome free region'
    inputBinding:
      position: 103
      prefix: '-nfrSize'
  - id: norevopp
    type:
      - 'null'
      - boolean
    doc: 'do not search for motifs on the opposite strand'
    inputBinding:
      position: 103
      prefix: '-norevopp'
  - id: gwasCatalog
    type:
      - 'null'
      - File
    doc: 'gwasCatalog file from UCSC (list overlapping GWAS risk SNPs)'
    inputBinding:
      position: 103
      prefix: '-gwasCatalog'
  - id: map
    type:
      - 'null'
      - File
    doc: 'mapping file between peak IDs and promoter IDs'
    inputBinding:
      position: 103
      prefix: '-map'
  - id: noann
    type:
      - 'null'
      - boolean
    doc: 'skip genome annotation step'
    inputBinding:
      position: 103
      prefix: '-noann'
  - id: nogene
    type:
      - 'null'
      - boolean
    doc: 'skip TSS annotation'
    inputBinding:
      position: 103
      prefix: '-nogene'
  - id: homer1
    type:
      - 'null'
      - boolean
    doc: 'use the old version of homer for finding motifs'
    inputBinding:
      position: 103
      prefix: '-homer1'
  - id: homer2
    type:
      - 'null'
      - boolean
    doc: 'use the new version of homer for finding motifs (default)'
    inputBinding:
      position: 103
      prefix: '-homer2'
  - id: cpu
    type:
      - 'null'
      - int
    doc: 'number of processors to use'
    inputBinding:
      position: 103
      prefix: '-cpu'
  - id: noblanks
    type:
      - 'null'
      - boolean
    doc: 'remove peaks/rows with missing data'
    inputBinding:
      position: 103
      prefix: '-noblanks'
outputs:
  - id: annotation
    type: stdout
    doc: Annotated peaks (tab separated table written to standard output)
  - id: motif_sites_fasta
    type:
      - 'null'
      - File
    doc: Motif sites in fasta format (-mfasta)
    outputBinding:
      glob: $(inputs.mfasta)
  - id: motif_sites_bed
    type:
      - 'null'
      - File
    doc: Motif positions in BED format (-mbed)
    outputBinding:
      glob: $(inputs.mbed)
  - id: motif_logic
    type:
      - 'null'
      - File
    doc: Motif orientation stats (-mlogic)
    outputBinding:
      glob: $(inputs.mlogic)
  - id: matrix_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Motif co-occurrence files (-matrix prefix)
    outputBinding:
      glob: $(inputs.matrix + ".*")
  - id: go_directory
    type:
      - 'null'
      - Directory
    doc: GO analysis results (-go)
    outputBinding:
      glob: $(inputs.go)
  - id: genome_ontology_directory
    type:
      - 'null'
      - Directory
    doc: genomeOntology analysis results (-genomeOntology)
    outputBinding:
      glob: $(inputs.genomeOntology)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/homer:5.1--pl5262h9948957_0
stdout: homer_annotatePeaks.out
