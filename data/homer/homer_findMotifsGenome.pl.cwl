cwlVersion: v1.2
class: CommandLineTool
baseCommand: findMotifsGenome.pl
label: homer_findMotifsGenome.pl
doc: "Find de novo and known motifs in regions of a genome (peak or position file, genome name or custom FASTA)\n\nTool homepage: http://homer.ucsd.edu/homer/index.html"
inputs:
  - id: pos_file
    type: File
    doc: 'Peak or position file (HOMER peak format or BED) with the regions to analyze'
    inputBinding:
      position: 1
  - id: genome
    type:
      - string
      - File
      - Directory
    doc: 'Genome name, or a custom genome FASTA file or directory of FASTA files (a preparsed/ directory is created next to it)'
    inputBinding:
      position: 2
  - id: output_directory
    type: string
    doc: 'Name of the output directory for the results'
    inputBinding:
      position: 3
  - id: mask
    type:
      - 'null'
      - boolean
    doc: 'mask repeats/lower case sequence'
    inputBinding:
      position: 103
      prefix: '-mask'
  - id: len
    type:
      - 'null'
      - string
    doc: 'motif length, comma separated list (default: 8,10,12). Values greater than 12 may run out of memory'
    inputBinding:
      position: 103
      prefix: '-len'
  - id: size
    type:
      - 'null'
      - string
    doc: 'fragment size to use for motif finding (default: 200); use a range such as -100,50 for positions relative to the center, or the word given to use the exact regions'
    inputBinding:
      position: 103
      prefix: '-size'
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
    doc: 'global optimization: searches for strings with this many mismatches (default: 2)'
    inputBinding:
      position: 103
      prefix: '-mis'
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
  - id: noknown
    type:
      - 'null'
      - boolean
    doc: 'do not search for known motif enrichment'
    inputBinding:
      position: 103
      prefix: '-noknown'
  - id: rna
    type:
      - 'null'
      - boolean
    doc: 'output RNA motif logos and compare to the RNA motif database (sets -norevopp)'
    inputBinding:
      position: 103
      prefix: '-rna'
  - id: useNewBg
    type:
      - 'null'
      - boolean
    doc: 'new background selection that does not use preparsed genome files'
    inputBinding:
      position: 103
      prefix: '-useNewBg'
  - id: genomeBg
    type:
      - 'null'
      - boolean
    doc: 'use genome sequences for background (default)'
    inputBinding:
      position: 103
      prefix: '-genomeBg'
  - id: modelBg
    type:
      - 'null'
      - boolean
    doc: 'generate background sequences by modeling the sequence properties of the target sequences'
    inputBinding:
      position: 103
      prefix: '-modelBg'
  - id: bg
    type:
      - 'null'
      - File
    doc: 'background BED or peak file (genomic positions to be used as background)'
    inputBinding:
      position: 103
      prefix: '-bg'
  - id: N
    type:
      - 'null'
      - int
    doc: 'number of background sequences to use for motif finding (default: 100000, or 2x input)'
    inputBinding:
      position: 103
      prefix: '-N'
  - id: numBins
    type:
      - 'null'
      - int
    doc: 'number of GC bins to stratify GC content of sequences by (default: 10)'
    inputBinding:
      position: 103
      prefix: '-numBins'
  - id: ikmer
    type:
      - 'null'
      - int
    doc: 'when constructing the background, match the kmer content of this length with the targets (default: 2)'
    inputBinding:
      position: 103
      prefix: '-ikmer'
  - id: pkmer
    type:
      - 'null'
      - int
    doc: 'when constructing the background, positionally match the kmer content'
    inputBinding:
      position: 103
      prefix: '-pkmer'
  - id: allowTargetOverlaps
    type:
      - 'null'
      - boolean
    doc: 'allow selected genomic background regions to overlap target regions'
    inputBinding:
      position: 103
      prefix: '-allowTargetOverlaps'
  - id: allowBgOverlaps
    type:
      - 'null'
      - boolean
    doc: 'allow selected genomic background regions to overlap one another'
    inputBinding:
      position: 103
      prefix: '-allowBgOverlaps'
  - id: NN
    type:
      - 'null'
      - int
    doc: 'when selecting genomic background sequences, consider this many initially (default: 100000000)'
    inputBinding:
      position: 103
      prefix: '-NN'
  - id: useOldBg
    type:
      - 'null'
      - boolean
    doc: 'use old style (4.11 and earlier) background selection'
    inputBinding:
      position: 103
      prefix: '-useOldBg'
  - id: chopify
    type:
      - 'null'
      - boolean
    doc: 'chop up large background regions to the average size of the target regions (old background)'
    inputBinding:
      position: 103
      prefix: '-chopify'
  - id: gc
    type:
      - 'null'
      - boolean
    doc: 'use GC% for sequence content normalization (default)'
    inputBinding:
      position: 103
      prefix: '-gc'
  - id: cpg
    type:
      - 'null'
      - boolean
    doc: 'use CpG% instead of GC% for sequence content normalization'
    inputBinding:
      position: 103
      prefix: '-cpg'
  - id: noweight
    type:
      - 'null'
      - boolean
    doc: 'no CG correction'
    inputBinding:
      position: 103
      prefix: '-noweight'
  - id: find
    type:
      - 'null'
      - File
    doc: 'motif file: only scan the sequences for these motifs'
    inputBinding:
      position: 103
      prefix: '-find'
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
    doc: 'only visualize de novo motifs, do not check similarity with known motifs'
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
    doc: 'do not search for de novo vs. known motif similarity'
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
  - id: float
    type:
      - 'null'
      - boolean
    doc: 'allow adjustment of the degeneracy threshold for known motifs to improve the p-value (dangerous)'
    inputBinding:
      position: 103
      prefix: '-float'
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
    doc: 'use weblogo/seqlogo/ghostscript to generate logos (default uses SVG)'
    inputBinding:
      position: 103
      prefix: '-seqlogo'
  - id: flip
    type:
      - 'null'
      - boolean
    doc: 'look for motifs enriched in the background instead of the target sequences'
    inputBinding:
      position: 103
      prefix: '-flip'
  - id: hypergeometric
    type:
      - 'null'
      - boolean
    doc: 'use the hypergeometric distribution for p-values (binomial is default)'
    inputBinding:
      position: 103
      prefix: '-h'
  - id: local
    type:
      - 'null'
      - int
    doc: 'use local background: number of equal size regions around the peaks to use, i.e. 2'
    inputBinding:
      position: 103
      prefix: '-local'
  - id: redundant
    type:
      - 'null'
      - float
    doc: 'remove redundant sequences matching greater than this fraction, i.e. 0.5'
    inputBinding:
      position: 103
      prefix: '-redundant'
  - id: maxN
    type:
      - 'null'
      - float
    doc: 'maximum fraction of N in a sequence to consider for motif finding (default: 0.7)'
    inputBinding:
      position: 103
      prefix: '-maxN'
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
  - id: rand
    type:
      - 'null'
      - boolean
    doc: 'randomize target and background sequence labels'
    inputBinding:
      position: 103
      prefix: '-rand'
  - id: ref
    type:
      - 'null'
      - File
    doc: 'use this peak file for target and background (the first argument is a list of peak ids for targets)'
    inputBinding:
      position: 103
      prefix: '-ref'
  - id: oligo
    type:
      - 'null'
      - boolean
    doc: 'perform analysis of individual oligo enrichment'
    inputBinding:
      position: 103
      prefix: '-oligo'
  - id: dumpFasta
    type:
      - 'null'
      - boolean
    doc: 'dump fasta files for target and background sequences for use with other programs'
    inputBinding:
      position: 103
      prefix: '-dumpFasta'
  - id: preparse
    type:
      - 'null'
      - boolean
    doc: 'force new background files to be created'
    inputBinding:
      position: 103
      prefix: '-preparse'
  - id: preparsedDir
    type:
      - 'null'
      - string
    doc: 'location to search for preparsed files and/or place new files (the wrapper sets preparsed in the working directory, because a FASTA genome input is read-only)'
    inputBinding:
      position: 103
      prefix: '-preparsedDir'
  - id: keepFiles
    type:
      - 'null'
      - boolean
    doc: 'keep temporary files'
    inputBinding:
      position: 103
      prefix: '-keepFiles'
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
    doc: 'length of lower-order oligos to normalize in the background (default: 3)'
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
  - id: preparsed_directory
    type:
      - 'null'
      - Directory
    doc: 'Preparsed genome and background files (-preparsedDir, default preparsed)'
    outputBinding:
      glob: '$(inputs.preparsedDir ? inputs.preparsedDir : "preparsed")'
  - id: log
    type: stdout
    doc: 'Program messages written to standard output'
arguments:
  - position: 102
    prefix: '-preparsedDir'
    valueFrom: preparsed
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/homer:5.1--pl5262h9948957_0
stdout: homer_findMotifsGenome.out
