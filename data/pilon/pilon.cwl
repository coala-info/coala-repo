cwlVersion: v1.2
class: CommandLineTool
baseCommand: pilon
label: pilon
doc: "Pilon is a tool for genome assembly improvement and variant calling using read
  alignments.\n\nTool homepage: https://github.com/broadinstitute/pilon/"
inputs:
  - id: bam
    type:
      - 'null'
      - File
    doc: A bam file of unknown type; Pilon will scan it and attempt to classify it.
    inputBinding:
      position: 101
      prefix: --bam
  - id: chunksize
    type:
      - 'null'
      - int
    doc: Input FASTA elements larger than this will be processed in smaller pieces.
    default: 10000000
    inputBinding:
      position: 101
      prefix: --chunksize
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debugging output (implies verbose).
    inputBinding:
      position: 101
      prefix: --debug
  - id: defaultqual
    type:
      - 'null'
      - int
    doc: Assumes bases are of this quality if quals are no present in input BAMs.
    default: 10
    inputBinding:
      position: 101
      prefix: --defaultqual
  - id: diploid
    type:
      - 'null'
      - boolean
    doc: Sample is from diploid organism.
    inputBinding:
      position: 101
      prefix: --diploid
  - id: dumpreads
    type:
      - 'null'
      - boolean
    doc: Dump reads for local re-assemblies.
    inputBinding:
      position: 101
      prefix: --dumpreads
  - id: duplicates
    type:
      - 'null'
      - boolean
    doc: Use reads marked as duplicates in the input BAMs (ignored by default).
    inputBinding:
      position: 101
      prefix: --duplicates
  - id: fix
    type:
      - 'null'
      - string
    doc: A comma-separated list of categories of issues to try to fix (snps, indels,
      gaps, local, all, bases, none, amb, breaks, circles, novel).
    default: all
    inputBinding:
      position: 101
      prefix: --fix
  - id: flank
    type:
      - 'null'
      - int
    doc: Controls how much of the well-aligned reads will be used; bases at each end
      of the good reads will be ignored.
    default: 10
    inputBinding:
      position: 101
      prefix: --flank
  - id: frags
    type:
      - 'null'
      - type: array
        items: File
    doc: A bam file consisting of fragment paired-end alignments. This argument may
      be specified more than once.
    inputBinding:
      position: 101
      prefix: --frags
  - id: gapmargin
    type:
      - 'null'
      - int
    doc: Closed gaps must be within this number of bases of true size to be closed.
    default: 100000
    inputBinding:
      position: 101
      prefix: --gapmargin
  - id: genome
    type: File
    doc: The input genome we are trying to improve, which must be the reference used
      for the bam alignments.
    inputBinding:
      position: 101
      prefix: --genome
  - id: iupac
    type:
      - 'null'
      - boolean
    doc: Output IUPAC ambiguous base codes in the output FASTA file when appropriate.
    inputBinding:
      position: 101
      prefix: --iupac
  - id: jumps
    type:
      - 'null'
      - type: array
        items: File
    doc: A bam file consisting of jump (mate pair) paired-end alignments. This argument
      may be specified more than once.
    inputBinding:
      position: 101
      prefix: --jumps
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: Kmer size used by internal assembler.
    default: 47
    inputBinding:
      position: 101
      prefix: --K
  - id: mindepth
    type:
      - 'null'
      - float
    doc: Minimum coverage depth required to call variants.
    default: 0.1
    inputBinding:
      position: 101
      prefix: --mindepth
  - id: mingap
    type:
      - 'null'
      - int
    doc: Minimum size for unclosed gaps.
    default: 10
    inputBinding:
      position: 101
      prefix: --mingap
  - id: minmq
    type:
      - 'null'
      - int
    doc: Minimum alignment mapping quality for a read to count in pileups.
    default: 0
    inputBinding:
      position: 101
      prefix: --minmq
  - id: minqual
    type:
      - 'null'
      - int
    doc: Minimum base quality to consider for pileups.
    default: 0
    inputBinding:
      position: 101
      prefix: --minqual
  - id: nanopore
    type:
      - 'null'
      - File
    doc: A bam file containing Oxford Nanopore read alignments. Experimental.
    inputBinding:
      position: 101
      prefix: --nanopore
  - id: nonpf
    type:
      - 'null'
      - boolean
    doc: Use reads which failed sequencer quality filtering (ignored by default).
    inputBinding:
      position: 101
      prefix: --nonpf
  - id: nostrays
    type:
      - 'null'
      - boolean
    doc: Skip making a pass through the input BAM files to identify stray pairs.
    inputBinding:
      position: 101
      prefix: --nostrays
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files
    inputBinding:
      position: 101
      prefix: --output
  - id: pacbio
    type:
      - 'null'
      - File
    doc: A bam file containing Pacific Biosciences read alignments. Experimental.
    inputBinding:
      position: 101
      prefix: --pacbio
  - id: targets
    type:
      - 'null'
      - string
    doc: Only process the specified target(s). Can be a comma-separated list or a
      file name.
    inputBinding:
      position: 101
      prefix: --targets
  - id: unpaired
    type:
      - 'null'
      - type: array
        items: File
    doc: A bam file consisting of unpaired alignments. This argument may be specified
      more than once.
    inputBinding:
      position: 101
      prefix: --unpaired
  - id: variant
    type:
      - 'null'
      - boolean
    doc: Sets up heuristics for variant calling; equivalent to "--vcf --fix all,breaks".
    inputBinding:
      position: 101
      prefix: --variant
  - id: vcfqe
    type:
      - 'null'
      - boolean
    doc: If specified, the VCF will contain a QE (quality-weighted evidence) field
      rather than the default QP field.
    inputBinding:
      position: 101
      prefix: --vcfqe
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: More verbose output.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Use this directory for all output files.
    outputBinding:
      glob: $(inputs.outdir)
  - id: changes
    type:
      - 'null'
      - File
    doc: If specified, a file listing changes in the <output>.fasta will be generated.
    outputBinding:
      glob: $(inputs.changes)
  - id: vcf
    type:
      - 'null'
      - File
    doc: If specified, a vcf file will be generated
    outputBinding:
      glob: $(inputs.vcf)
  - id: tracks
    type:
      - 'null'
      - File
    doc: This options will cause many track files (*.bed, *.wig) suitable for viewing
      in a genome browser to be written.
    outputBinding:
      glob: $(inputs.tracks)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pilon:1.24--hdfd78af_0
