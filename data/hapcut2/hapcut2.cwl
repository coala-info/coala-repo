cwlVersion: v1.2
class: CommandLineTool
baseCommand: HAPCUT2
label: hapcut2
doc: "HapCUT2: robust and accurate haplotype assembly for diverse sequencing technologies. Phases the heterozygous variants of one diploid individual from the fragments made by extractHAIRS.\n\nTool homepage: https://github.com/vibansal/HapCUT2/"
inputs:
  - id: fragments
    type: File
    doc: file with haplotype-informative reads generated using the
      extracthairs program
    inputBinding:
      position: 1
      prefix: --fragments
  - id: variantcalls
    type: File
    doc: variant file in VCF format (use EXACT SAME file that was used for
      the extracthairs program)
    inputBinding:
      position: 2
      prefix: --VCF
  - id: output_path
    type: string
    doc: file to which phased haplotype segments/blocks will be output
    inputBinding:
      position: 3
      prefix: --output
  - id: outvcf
    type:
      - 'null'
      - int
    doc: "output phased variants to VCF file (<OUTFILE>.phased.vcf), 0 or 1, default: 0"
    inputBinding:
      position: 10
      prefix: --outvcf
  - id: converge
    type:
      - 'null'
      - int
    doc: "cut off iterations (global or maxcut) after this many iterations with no improvement. default: 5"
    inputBinding:
      position: 11
      prefix: --converge
  - id: verbose
    type:
      - 'null'
      - int
    doc: "verbose mode: print extra information to stdout and stderr, 0 or 1, default: 0"
    inputBinding:
      position: 12
      prefix: --verbose
  - id: hic
    type:
      - 'null'
      - int
    doc: "increases accuracy on Hi-C data; models h-trans errors directly from the data, 0 or 1, default: 0"
    inputBinding:
      position: 13
      prefix: --hic
  - id: hic_htrans_file
    type:
      - 'null'
      - File
    doc: optional tab-delimited input file where second column specifies
      h-trans error probabilities for insert size bins 0-50Kb, 50Kb-100Kb,
      etc.
    inputBinding:
      position: 14
      prefix: --hic_htrans_file
  - id: qv_offset
    type:
      - 'null'
      - int
    doc: "quality value offset for base quality scores (33, 48 or 64), default: 33 (use same value as for extracthairs)"
    inputBinding:
      position: 15
      prefix: --qv_offset
  - id: long_reads
    type:
      - 'null'
      - int
    doc: "reduces memory when phasing long read data with many SNPs per read, 0 or 1. default: automatic"
    inputBinding:
      position: 16
      prefix: --long_reads
  - id: threshold
    type:
      - 'null'
      - float
    doc: "PHRED SCALED threshold for pruning low-confidence SNPs (range 0-100, larger values prune more). default: 6.98"
    inputBinding:
      position: 17
      prefix: --threshold
  - id: skip_prune
    type:
      - 'null'
      - int
    doc: "skip default likelihood pruning step (prune SNPs after the fact using column 11 of the output), 0 or 1. default: 0"
    inputBinding:
      position: 18
      prefix: --skip_prune
  - id: call_homozygous
    type:
      - 'null'
      - int
    doc: "call positions as homozygous if they appear to be false heterozygotes, 0 or 1. default: 0"
    inputBinding:
      position: 19
      prefix: --call_homozygous
  - id: discrete_pruning
    type:
      - 'null'
      - int
    doc: "use discrete heuristic to prune SNPs, 0 or 1. default: 0"
    inputBinding:
      position: 20
      prefix: --discrete_pruning
  - id: new_format
    type:
      - 'null'
      - int
    doc: "use new Hi-C fragment matrix file format (but do not do h-trans error modeling), 0 or 1. default: 0"
    inputBinding:
      position: 21
      prefix: --new_format
  - id: max_iter
    type:
      - 'null'
      - int
    doc: "maximum number of global iterations. Preferable to tweak --converge option instead. default: 10000"
    inputBinding:
      position: 22
      prefix: --max_iter
  - id: maxcut_iter
    type:
      - 'null'
      - int
    doc: "maximum number of max-likelihood-cut iterations. Preferable to tweak --converge option instead. default: 10000"
    inputBinding:
      position: 23
      prefix: --maxcut_iter
  - id: htrans_read_lowbound
    type:
      - 'null'
      - int
    doc: "with --hic on, h-trans probability estimation will require this many matepairs per window. default: 500"
    inputBinding:
      position: 24
      prefix: --htrans_read_lowbound
  - id: htrans_max_window
    type:
      - 'null'
      - int
    doc: "with --hic on, the insert-size window for h-trans probability estimation will not expand larger than this many basepairs. default: 4000000"
    inputBinding:
      position: 25
      prefix: --htrans_max_window
outputs:
  - id: output
    type: File
    doc: haplotype_output_file
    outputBinding:
      glob: $(inputs.output_path)
  - id: phased_vcf
    type:
      - 'null'
      - File
    doc: Phased variants in VCF format (<output>.phased.VCF), written when outvcf is 1
    outputBinding:
      glob: $(inputs.output_path).phased.[Vv][Cc][Ff]
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hapcut2:1.3.4--h7e4f606_2
