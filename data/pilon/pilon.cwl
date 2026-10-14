cwlVersion: v1.2
class: CommandLineTool
baseCommand: pilon
label: pilon
doc: "Pilon is a tool for genome assembly improvement and variant calling using read\n  alignments.\n\nTool homepage: https://github.com/broadinstitute/pilon/"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: genome
    type: File
    doc: The input genome we are trying to improve, which must be the reference used for the bam alignments. At least one of frags or jumps must also be given.
    inputBinding:
      position: 100
      prefix: --genome
  - id: frags
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --frags
    doc: 'Fragment paired-end alignments (bam, indexed) aligned to the genome; may be given more than once'
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
    inputBinding:
      position: 101
  - id: jumps
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --jumps
    doc: 'Jump (mate pair) paired-end alignments (bam, indexed); may be given more than once'
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
    inputBinding:
      position: 101
  - id: unpaired
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --unpaired
    doc: 'Unpaired alignments (bam, indexed); may be given more than once'
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
    inputBinding:
      position: 101
  - id: bam
    type:
      - 'null'
      - File
    doc: 'A bam file of unknown type; Pilon will scan it and attempt to classify it'
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
    inputBinding:
      position: 101
      prefix: --bam
  - id: nanopore
    type:
      - 'null'
      - File
    doc: 'A bam file containing Oxford Nanopore read alignments. Experimental.'
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
    inputBinding:
      position: 101
      prefix: --nanopore
  - id: pacbio
    type:
      - 'null'
      - File
    doc: 'A bam file containing Pacific Biosciences read alignments. Experimental.'
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
    inputBinding:
      position: 101
      prefix: --pacbio
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: 'Prefix for output files (default pilon)'
    inputBinding:
      position: 101
      prefix: --output
  - id: outdir
    type:
      - 'null'
      - string
    doc: 'Use this directory for all output files'
    inputBinding:
      position: 101
      prefix: --outdir
  - id: changes
    type:
      - 'null'
      - boolean
    doc: 'Write a file listing changes in the output fasta'
    inputBinding:
      position: 101
      prefix: --changes
  - id: vcf
    type:
      - 'null'
      - boolean
    doc: 'Write a vcf file'
    inputBinding:
      position: 101
      prefix: --vcf
  - id: vcfqe
    type:
      - 'null'
      - boolean
    doc: 'The VCF will contain a QE field rather than the default QP field'
    inputBinding:
      position: 101
      prefix: --vcfqe
  - id: tracks
    type:
      - 'null'
      - boolean
    doc: 'Write many track files (*.bed, *.wig) suitable for viewing in a genome browser'
    inputBinding:
      position: 101
      prefix: --tracks
  - id: variant
    type:
      - 'null'
      - boolean
    doc: 'Heuristics for variant calling, equivalent to --vcf --fix all,breaks'
    inputBinding:
      position: 101
      prefix: --variant
  - id: chunksize
    type:
      - 'null'
      - int
    doc: 'Input FASTA elements larger than this will be processed in smaller pieces (default 10000000)'
    inputBinding:
      position: 101
      prefix: --chunksize
  - id: diploid
    type:
      - 'null'
      - boolean
    doc: 'Sample is from a diploid organism'
    inputBinding:
      position: 101
      prefix: --diploid
  - id: fix
    type:
      - 'null'
      - string
    doc: 'Comma-separated list of issue categories to fix: snps, indels, gaps, local, all, bases, none, amb, breaks, circles, novel'
    inputBinding:
      position: 101
      prefix: --fix
  - id: dumpreads
    type:
      - 'null'
      - boolean
    doc: 'Dump reads for local re-assemblies'
    inputBinding:
      position: 101
      prefix: --dumpreads
  - id: duplicates
    type:
      - 'null'
      - boolean
    doc: 'Use reads marked as duplicates in the input BAMs'
    inputBinding:
      position: 101
      prefix: --duplicates
  - id: iupac
    type:
      - 'null'
      - boolean
    doc: 'Output IUPAC ambiguous base codes in the output FASTA file when appropriate'
    inputBinding:
      position: 101
      prefix: --iupac
  - id: nonpf
    type:
      - 'null'
      - boolean
    doc: 'Use reads which failed sequencer quality filtering'
    inputBinding:
      position: 101
      prefix: --nonpf
  - id: targets
    type:
      - 'null'
      - string
    doc: 'Only process the specified target(s), comma-separated, each a fasta element name optionally followed by a base range'
    inputBinding:
      position: 101
      prefix: --targets
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'More verbose output'
    inputBinding:
      position: 101
      prefix: --verbose
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'Debugging output (implies verbose)'
    inputBinding:
      position: 101
      prefix: --debug
  - id: defaultqual
    type:
      - 'null'
      - int
    doc: 'Assumed base quality if quals are not present in input BAMs (default 10)'
    inputBinding:
      position: 101
      prefix: --defaultqual
  - id: flank
    type:
      - 'null'
      - int
    doc: 'Number of bases at each end of the good reads that will be ignored (default 10)'
    inputBinding:
      position: 101
      prefix: --flank
  - id: gapmargin
    type:
      - 'null'
      - int
    doc: 'Closed gaps must be within this number of bases of true size (default 100000)'
    inputBinding:
      position: 101
      prefix: --gapmargin
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: 'Kmer size used by internal assembler (default 47)'
    inputBinding:
      position: 101
      prefix: --K
  - id: mindepth
    type:
      - 'null'
      - float
    doc: 'Minimum depth to call variants; absolute if >= 1, otherwise a fraction of mean coverage (default 0.1)'
    inputBinding:
      position: 101
      prefix: --mindepth
  - id: mingap
    type:
      - 'null'
      - int
    doc: 'Minimum size for unclosed gaps (default 10)'
    inputBinding:
      position: 101
      prefix: --mingap
  - id: minmq
    type:
      - 'null'
      - int
    doc: 'Minimum alignment mapping quality for a read to count in pileups (default 0)'
    inputBinding:
      position: 101
      prefix: --minmq
  - id: minqual
    type:
      - 'null'
      - int
    doc: 'Minimum base quality to consider for pileups (default 0)'
    inputBinding:
      position: 101
      prefix: --minqual
  - id: nostrays
    type:
      - 'null'
      - boolean
    doc: 'Skip the pass through the input BAM files that identifies stray pairs'
    inputBinding:
      position: 101
      prefix: --nostrays
outputs:
  - id: fasta
    type:
      - 'null'
      - File
    doc: Improved genome (not written with --fix none)
    outputBinding:
      glob: "$(inputs.outdir ? inputs.outdir + '/' : '')$(inputs.output_prefix ? inputs.output_prefix : 'pilon').fasta"
  - id: changes_file
    type:
      - 'null'
      - File
    doc: List of changes (with --changes)
    outputBinding:
      glob: "$(inputs.outdir ? inputs.outdir + '/' : '')$(inputs.output_prefix ? inputs.output_prefix : 'pilon').changes"
  - id: vcf_file
    type:
      - 'null'
      - File
    doc: VCF file (with --vcf or --variant)
    outputBinding:
      glob: "$(inputs.outdir ? inputs.outdir + '/' : '')$(inputs.output_prefix ? inputs.output_prefix : 'pilon').vcf"
  - id: track_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Track files (with --tracks)
    outputBinding:
      glob:
        - "$(inputs.outdir ? inputs.outdir + '/' : '')$(inputs.output_prefix ? inputs.output_prefix : 'pilon')*.bed"
        - "$(inputs.outdir ? inputs.outdir + '/' : '')$(inputs.output_prefix ? inputs.output_prefix : 'pilon')*.wig"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pilon:1.24--hdfd78af_0
