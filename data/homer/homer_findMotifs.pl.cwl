cwlVersion: v1.2
class: CommandLineTool
baseCommand: findMotifs.pl
label: homer_findMotifs.pl
doc: "Find de novo and known motifs in a gene list (promoter based) or in FASTA files\n\nTool homepage: http://homer.ucsd.edu/homer/index.html"
inputs:
  - id: input_list
    type: File
    doc: 'Gene id list, or the target FASTA file when the promoter set is fasta'
    inputBinding:
      position: 1
  - id: promoter_set
    type: string
    doc: 'Promoter set (organism) name, or the word fasta for FASTA input'
    inputBinding:
      position: 2
  - id: output_directory
    type: string
    doc: 'Name of the output directory for the results'
    inputBinding:
      position: 3
  - id: len
    type:
      - 'null'
      - string
    doc: 'motif length, comma separated list (default: 8,10,12). Values greater than 12 may run out of memory'
    inputBinding:
      position: 103
      prefix: '-len'
  - id: bg
    type:
      - 'null'
      - File
    doc: 'background file with ids to use as background (default: all genes)'
    inputBinding:
      position: 103
      prefix: '-bg'
  - id: start
    type:
      - 'null'
      - int
    doc: 'offset from TSS (transcription start site) (default: -300)'
    inputBinding:
      position: 103
      prefix: '-start'
  - id: end
    type:
      - 'null'
      - int
    doc: 'offset from TSS (default: 50)'
    inputBinding:
      position: 103
      prefix: '-end'
  - id: rna
    type:
      - 'null'
      - boolean
    doc: 'output RNA motif logos and compare to the RNA motif database (sets -norevopp)'
    inputBinding:
      position: 103
      prefix: '-rna'
  - id: mask
    type:
      - 'null'
      - boolean
    doc: 'use repeat masked files (default)'
    inputBinding:
      position: 103
      prefix: '-mask'
  - id: nomask
    type:
      - 'null'
      - boolean
    doc: 'do not use repeat masked files'
    inputBinding:
      position: 103
      prefix: '-nomask'
  - id: S
    type:
      - 'null'
      - int
    doc: 'number of motifs to optimize (default: 25)'
    inputBinding:
      position: 103
      prefix: '-S'
  - id: mis
    type:
      - 'null'
      - int
    doc: 'global optimization: searches for strings with this many mismatches (default: 1)'
    inputBinding:
      position: 103
      prefix: '-mis'
  - id: noconvert
    type:
      - 'null'
      - boolean
    doc: 'do not convert input files into unigene ids'
    inputBinding:
      position: 103
      prefix: '-noconvert'
  - id: norevopp
    type:
      - 'null'
      - boolean
    doc: 'do not search the reverse strand for motifs'
    inputBinding:
      position: 103
      prefix: '-norevopp'
  - id: nomotif
    type:
      - 'null'
      - boolean
    doc: 'do not search for de novo motif enrichment'
    inputBinding:
      position: 103
      prefix: '-nomotif'
  - id: find
    type:
      - 'null'
      - File
    doc: 'motif file: only scan the sequences for these motifs'
    inputBinding:
      position: 103
      prefix: '-find'
  - id: enhancers
    type:
      - 'null'
      - File
    doc: 'peak file of enhancer locations to include in the search space (peak ids should be gene ids); needs enhancers_genome'
    inputBinding:
      position: 103
      prefix: '-enhancers'
  - id: enhancers_genome
    type:
      - 'null'
      - string
    doc: 'genome version for the -enhancers file (the second argument of -enhancers)'
    inputBinding:
      position: 103
  - id: enhancers_only
    type:
      - 'null'
      - boolean
    doc: 'do not include promoter sequence in the motif search'
    inputBinding:
      position: 103
      prefix: '-enhancersOnly'
  - id: fastaBg
    type:
      - 'null'
      - File
    doc: 'background FASTA file (recommended for FASTA based analysis)'
    inputBinding:
      position: 103
      prefix: '-fastaBg'
  - id: chopify
    type:
      - 'null'
      - boolean
    doc: 'chop up background regions to match the size of the target regions'
    inputBinding:
      position: 103
      prefix: '-chopify'
  - id: mset
    type:
      - 'null'
      - string
    doc: 'motif collection to check against: vertebrates, insects, worms, plants, yeast or all (default: auto)'
    inputBinding:
      position: 103
      prefix: '-mset'
  - id: basic
    type:
      - 'null'
      - boolean
    doc: 'do not check de novo motifs for similarity to known motifs'
    inputBinding:
      position: 103
      prefix: '-basic'
  - id: bits
    type:
      - 'null'
      - boolean
    doc: 'scale sequence logos by information content'
    inputBinding:
      position: 103
      prefix: '-bits'
  - id: nocheck
    type:
      - 'null'
      - boolean
    doc: 'do not check for similarity between de novo motifs and known motifs'
    inputBinding:
      position: 103
      prefix: '-nocheck'
  - id: mcheck
    type:
      - 'null'
      - File
    doc: 'known motifs to check against de novo motifs'
    inputBinding:
      position: 103
      prefix: '-mcheck'
  - id: noknown
    type:
      - 'null'
      - boolean
    doc: 'do not search for known motif enrichment'
    inputBinding:
      position: 103
      prefix: '-noknown'
  - id: mknown
    type:
      - 'null'
      - File
    doc: 'known motifs to check for enrichment'
    inputBinding:
      position: 103
      prefix: '-mknown'
  - id: nofacts
    type:
      - 'null'
      - boolean
    doc: 'omit humor'
    inputBinding:
      position: 103
      prefix: '-nofacts'
  - id: seqlogo
    type:
      - 'null'
      - boolean
    doc: 'use weblogo/seqlogo/ghostscript to visualize motifs (default uses SVG)'
    inputBinding:
      position: 103
      prefix: '-seqlogo'
  - id: binomial
    type:
      - 'null'
      - boolean
    doc: 'use the binomial distribution to calculate p-values (hypergeometric is default)'
    inputBinding:
      position: 103
      prefix: '-b'
  - id: nogo
    type:
      - 'null'
      - boolean
    doc: 'do not search for gene ontology enrichment'
    inputBinding:
      position: 103
      prefix: '-nogo'
  - id: humanGO
    type:
      - 'null'
      - boolean
    doc: 'convert ids to human for GO (gene ontology) analysis'
    inputBinding:
      position: 103
      prefix: '-humanGO'
  - id: ontology
    type:
      - 'null'
      - type: array
        items: File
    doc: 'custom ontologies (ont.genes files) for GO analysis'
    inputBinding:
      position: 103
      prefix: '-ontology'
  - id: noweight
    type:
      - 'null'
      - boolean
    doc: 'no CG correction'
    inputBinding:
      position: 103
      prefix: '-noweight'
  - id: noredun
    type:
      - 'null'
      - boolean
    doc: 'do not remove predetermined redundant promoters/sequences'
    inputBinding:
      position: 103
      prefix: '-noredun'
  - id: g
    type:
      - 'null'
      - boolean
    doc: 'input file is a group file (1st column = id, 2nd = 0 or 1 [1 = target, 0 = background])'
    inputBinding:
      position: 103
      prefix: '-g'
  - id: cpg
    type:
      - 'null'
      - boolean
    doc: 'use CpG% instead of GC% for sequence normalization'
    inputBinding:
      position: 103
      prefix: '-cpg'
  - id: rand
    type:
      - 'null'
      - boolean
    doc: 'randomize labels for target and background sequences'
    inputBinding:
      position: 103
      prefix: '-rand'
  - id: maskMotif
    type:
      - 'null'
      - type: array
        items: File
    doc: 'motif files to mask before motif finding'
    inputBinding:
      position: 103
      prefix: '-maskMotif'
  - id: opt
    type:
      - 'null'
      - type: array
        items: File
    doc: 'motif files to optimize or change the length of'
    inputBinding:
      position: 103
      prefix: '-opt'
  - id: peaks
    type:
      - 'null'
      - boolean
    doc: 'produce a peak file of promoters to use with findMotifsGenome.pl'
    inputBinding:
      position: 103
      prefix: '-peaks'
  - id: nowarn
    type:
      - 'null'
      - boolean
    doc: 'no warnings'
    inputBinding:
      position: 103
      prefix: '-nowarn'
  - id: keepFiles
    type:
      - 'null'
      - boolean
    doc: 'do not delete temporary files'
    inputBinding:
      position: 103
      prefix: '-keepFiles'
  - id: dumpFasta
    type:
      - 'null'
      - boolean
    doc: 'create target.fa and background.fa files'
    inputBinding:
      position: 103
      prefix: '-dumpFasta'
  - id: min
    type:
      - 'null'
      - int
    doc: 'remove sequences shorter than this (default: 0)'
    inputBinding:
      position: 103
      prefix: '-min'
  - id: max
    type:
      - 'null'
      - float
    doc: 'remove sequences longer than this (default: 1e10)'
    inputBinding:
      position: 103
      prefix: '-max'
  - id: reuse
    type:
      - 'null'
      - boolean
    doc: 'rerun homer using old sequence files etc. with new options (ignores the input list and organism)'
    inputBinding:
      position: 103
      prefix: '-reuse'
  - id: fdr
    type:
      - 'null'
      - int
    doc: 'calculate empirical FDR (false discovery rate) for de novo discovery: number of randomizations'
    inputBinding:
      position: 103
      prefix: '-fdr'
  - id: nlen
    type:
      - 'null'
      - int
    doc: 'length of lower-order oligos to normalize general sequences (default: 3)'
    inputBinding:
      position: 103
      prefix: '-nlen'
  - id: nmax
    type:
      - 'null'
      - int
    doc: 'maximum normalization iterations (default: 160)'
    inputBinding:
      position: 103
      prefix: '-nmax'
  - id: neutral
    type:
      - 'null'
      - boolean
    doc: 'weight sequences to neutral frequencies, i.e. 25%, 6.25%, etc.'
    inputBinding:
      position: 103
      prefix: '-neutral'
  - id: olen
    type:
      - 'null'
      - int
    doc: 'lower-order oligo normalization for the oligo table, use if -nlen is not working well'
    inputBinding:
      position: 103
      prefix: '-olen'
  - id: p
    type:
      - 'null'
      - int
    doc: 'number of processors to use (default: 1)'
    inputBinding:
      position: 103
      prefix: '-p'
  - id: e
    type:
      - 'null'
      - float
    doc: 'maximum expected motif instances per bp in random sequence (default: 0.01)'
    inputBinding:
      position: 103
      prefix: '-e'
  - id: cache
    type:
      - 'null'
      - int
    doc: 'size in MB for the statistics cache (default: 500)'
    inputBinding:
      position: 103
      prefix: '-cache'
  - id: quickMask
    type:
      - 'null'
      - boolean
    doc: 'skip full masking after finding motifs, similar to the original homer'
    inputBinding:
      position: 103
      prefix: '-quickMask'
  - id: homer1
    type:
      - 'null'
      - boolean
    doc: 'force the use of the original homer'
    inputBinding:
      position: 103
      prefix: '-homer1'
  - id: minlp
    type:
      - 'null'
      - float
    doc: 'stop looking for motifs when the seed logp score gets above this value (default: -10)'
    inputBinding:
      position: 103
      prefix: '-minlp'
outputs:
  - id: output_dir
    type: Directory
    doc: 'Motif results (knownResults.html, homerResults.html, homerResults/, knownResults/)'
    outputBinding:
      glob: $(inputs.output_directory)
  - id: log
    type: stdout
    doc: 'Program messages written to standard output'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/homer:5.1--pl5262h9948957_0
stdout: homer_findMotifs.out
