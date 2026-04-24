cwlVersion: v1.2
class: CommandLineTool
baseCommand: irescue
label: irescue
doc: "IRescue (Interspersed Repeats single-cell quantifier): a toolfor quantifying
  transposable elements expression in scRNA-seq.\n\nTool homepage: https://github.com/bodegalab/irescue"
inputs:
  - id: bam_file
    type: File
    doc: sc-RNA-seq reads aligned to a reference genome (required).
    inputBinding:
      position: 101
      prefix: --bam
  - id: bedtools_path
    type:
      - 'null'
      - string
    doc: "Path to bedtools binary, in case it's not in PATH (Default: bedtools)."
    inputBinding:
      position: 101
      prefix: --bedtools
  - id: cb_tag
    type:
      - 'null'
      - string
    doc: 'BAM tag containing the cell barcode sequence (default: CB).'
    inputBinding:
      position: 101
      prefix: --cb-tag
  - id: dump_ec
    type:
      - 'null'
      - boolean
    doc: Write a description log file of Equivalence Classes.
    inputBinding:
      position: 101
      prefix: --dump-ec
  - id: genome
    type:
      - 'null'
      - string
    doc: 'Genome assembly symbol. One of: GRCh38, hg38, GRCh37, hg19, GRCm39, mm39,
      GRCm38, mm10, dm6, test (default: None).'
    inputBinding:
      position: 101
      prefix: --genome
  - id: integers
    type:
      - 'null'
      - boolean
    doc: Use if integers count are needed for downstream analysis.
    inputBinding:
      position: 101
      prefix: --integers
  - id: keeptmp
    type:
      - 'null'
      - boolean
    doc: Keep temporary files under <output_dir>/tmp.
    inputBinding:
      position: 101
      prefix: --keeptmp
  - id: locus
    type:
      - 'null'
      - boolean
    doc: 'Perform locus-level quantification, instead of subfamily-level (default:
      False).'
    inputBinding:
      position: 101
      prefix: --locus
  - id: max_iters
    type:
      - 'null'
      - int
    doc: 'Maximum number of EM iterations (Default: 100).'
    inputBinding:
      position: 101
      prefix: --max-iters
  - id: min_bp_overlap
    type:
      - 'null'
      - int
    doc: 'Minimum overlap between read and TE as number of nucleotides (Default: disabled).'
    inputBinding:
      position: 101
      prefix: --min-bp-overlap
  - id: min_fraction_overlap
    type:
      - 'null'
      - float
    doc: "Minimum overlap between read and TE as a fraction of read's alignment (i.e.
      0.00 <= NUM <= 1.00) (Default: disabled)."
    inputBinding:
      position: 101
      prefix: --min-fraction-overlap
  - id: no_tags_check
    type:
      - 'null'
      - boolean
    doc: Suppress checking for CBtag and UMItag presence in BAM file.
    inputBinding:
      position: 101
      prefix: --no-tags-check
  - id: no_umi
    type:
      - 'null'
      - boolean
    doc: 'Ignore UMI sequence. Intended for UMI-less datasets, such as Smart-seq (default:
      False).'
    inputBinding:
      position: 101
      prefix: --no-umi
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: 'Output directory name (default: irescue_out).'
    inputBinding:
      position: 101
      prefix: --outdir
  - id: regions_file
    type:
      - 'null'
      - File
    doc: 'Genomic TE coordinates in bed format (at least 4 columns with TE feature
      name (e.g. subfamily) as the 4th column). Takes priority over --genome (default:
      None).'
    inputBinding:
      position: 101
      prefix: --regions
  - id: samtools_path
    type:
      - 'null'
      - string
    doc: "Path to samtools binary, in case it's not in PATH (Default: samtools)."
    inputBinding:
      position: 101
      prefix: --samtools
  - id: strandedness
    type:
      - 'null'
      - string
    doc: 'Library strandedness. Use only if the orientation of TEs is relevant. One
      of: unstranded, forward, reverse (default: unstranded).'
    inputBinding:
      position: 101
      prefix: --strandedness
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of cpus to use (default: 1).'
    inputBinding:
      position: 101
      prefix: --threads
  - id: tolerance
    type:
      - 'null'
      - float
    doc: 'Log-likelihood change below which convergence is assumed (Default: 0.0001).'
    inputBinding:
      position: 101
      prefix: --tolerance
  - id: umi_tag
    type:
      - 'null'
      - string
    doc: 'BAM tag containing the UMI sequence (default: UR).'
    inputBinding:
      position: 101
      prefix: --umi-tag
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Writes additional logging to stderr. Use once for normal verbosity 
      (-v), twice for debugging (-vv).
    inputBinding:
      position: 101
      prefix: --verbose
  - id: whitelist_file
    type:
      - 'null'
      - File
    doc: 'Text file of filtered cell barcodes by e.g. Cell Ranger, STARSolo or your
      gene expression quantifier of choice (Recommended. default: None). Note: If
      not provided, all barcodes found in BAM will be used.'
    inputBinding:
      position: 101
      prefix: --whitelist
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/irescue:1.2.0--pyhdfd78af_0
stdout: irescue.out
