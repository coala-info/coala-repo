cwlVersion: v1.2
class: CommandLineTool
baseCommand: quaqc
label: quaqc
doc: "Copyright (C) 2025  Benjamin Jean-Marie Tremblay\n\nTool homepage: https://github.com/bjmt/quaqc"
inputs:
  - id: input_bam_files
    type:
      type: array
      items: File
    doc: Input BAM files
    inputBinding:
      position: 1
  - id: bed
    type:
      - 'null'
      - boolean
    doc: Output a gzipped BED6 file of passing reads.
    inputBinding:
      position: 102
      prefix: --bed
  - id: bedGraph
    type:
      - 'null'
      - boolean
    doc: Output a gzipped read density bedGraph.
    inputBinding:
      position: 102
      prefix: --bedGraph
  - id: bedGraph_dir
    type:
      - 'null'
      - Directory
    doc: Directory to output bedGraphs if not that of input.
    inputBinding:
      position: 102
      prefix: --bedGraph-dir
  - id: bedGraph_ext
    type:
      - 'null'
      - string
    doc: Filename extension for bedGraphs.
    default: .bedGraph.gz
    inputBinding:
      position: 102
      prefix: --bedGraph-ext
  - id: bedGraph_qlen
    type:
      - 'null'
      - int
    doc: Resize reads (centered on the 5-prime end).
    default: 100
    inputBinding:
      position: 102
      prefix: --bedGraph-qlen
  - id: bedGraph_tn5
    type:
      - 'null'
      - boolean
    doc: Shift 5-prime end coordinates +4/-5 bases.
    inputBinding:
      position: 102
      prefix: --bedGraph-tn5
  - id: bed_dir
    type:
      - 'null'
      - Directory
    doc: Directory to output BED files if not that of input.
    inputBinding:
      position: 102
      prefix: --bed-dir
  - id: bed_ext
    type:
      - 'null'
      - string
    doc: Filename extension for BED files.
    default: .bed.gz
    inputBinding:
      position: 102
      prefix: --bed-ext
  - id: bed_ins
    type:
      - 'null'
      - boolean
    doc: Print 5-prime insertions in BED3 format instead.
    inputBinding:
      position: 102
      prefix: --bed-ins
  - id: bed_tn5
    type:
      - 'null'
      - boolean
    doc: Adjust coordinates to account for Tn5 shift (+4/-5).
    inputBinding:
      position: 102
      prefix: --bed-tn5
  - id: blacklist
    type:
      - 'null'
      - File
    doc: Only consider reads outside ranges in a BED file.
    inputBinding:
      position: 102
      prefix: --blacklist
  - id: chip
    type:
      - 'null'
      - boolean
    doc: --tss-qlen=0 --tss-size=5001 (uses --peaks for pileup)
    inputBinding:
      position: 102
      prefix: --chip
  - id: continue
    type:
      - 'null'
      - boolean
    doc: Do not stop when a sample triggers a program error.
    inputBinding:
      position: 102
      prefix: --continue
  - id: fast
    type:
      - 'null'
      - boolean
    doc: --omit-gc --omit-depth (~15% shorter runtime)
    inputBinding:
      position: 102
      prefix: --fast
  - id: footprint
    type:
      - 'null'
      - boolean
    doc: --tss-qlen=1 --tss-size=501 --tss-tn5
    inputBinding:
      position: 102
      prefix: --footprint
  - id: keep
    type:
      - 'null'
      - boolean
    doc: Save passing nuclear reads in a new BAM file.
    inputBinding:
      position: 102
      prefix: --keep
  - id: keep_dir
    type:
      - 'null'
      - Directory
    doc: Directory to create new BAM in if not that of input.
    inputBinding:
      position: 102
      prefix: --keep-dir
  - id: keep_ext
    type:
      - 'null'
      - string
    doc: Extension of new BAM.
    default: .filt.bam
    inputBinding:
      position: 102
      prefix: --keep-ext
  - id: lenient
    type:
      - 'null'
      - boolean
    doc: --use-nomate --use-dups --use-dovetails --mapq=10
    inputBinding:
      position: 102
      prefix: --lenient
  - id: mapq
    type:
      - 'null'
      - int
    doc: Min read MAPQ score.
    default: 30
    inputBinding:
      position: 102
      prefix: --mapq
  - id: max_depth
    type:
      - 'null'
      - int
    doc: Max base depth for read depth histogram.
    default: 100000
    inputBinding:
      position: 102
      prefix: --max-depth
  - id: max_fhist
    type:
      - 'null'
      - int
    doc: Max fragment length for histogram.
    default: --max-flen
    inputBinding:
      position: 102
      prefix: --max-fhist
  - id: max_flen
    type:
      - 'null'
      - int
    doc: Max fragment length.
    default: 2000
    inputBinding:
      position: 102
      prefix: --max-flen
  - id: max_qhist
    type:
      - 'null'
      - int
    doc: Max alignment length for histogram.
    default: --max-qlen
    inputBinding:
      position: 102
      prefix: --max-qhist
  - id: max_qlen
    type:
      - 'null'
      - int
    doc: Max alignment length.
    default: 250
    inputBinding:
      position: 102
      prefix: --max-qlen
  - id: min_flen
    type:
      - 'null'
      - int
    doc: Min fragment length.
    default: 15
    inputBinding:
      position: 102
      prefix: --min-flen
  - id: min_qlen
    type:
      - 'null'
      - int
    doc: Min alignment length.
    default: 15
    inputBinding:
      position: 102
      prefix: --min-qlen
  - id: mitochondria
    type:
      - 'null'
      - string
    doc: Mitochondria references names.
    default: chrM,ChrM,Mt,MT,MtDNA,mit,Mito,mitochondria,mitochondrion
    inputBinding:
      position: 102
      prefix: --mitochondria
  - id: nbr
    type:
      - 'null'
      - boolean
    doc: --no-se --min-flen=150 --max-flen=1000 --tss-qlen=0
    inputBinding:
      position: 102
      prefix: --nbr
  - id: nfr
    type:
      - 'null'
      - boolean
    doc: --no-se --max-flen=120 --tss-tn5
    inputBinding:
      position: 102
      prefix: --nfr
  - id: no_output
    type:
      - 'null'
      - boolean
    doc: Suppress creation of output QC reports.
    inputBinding:
      position: 102
      prefix: --no-output
  - id: no_se
    type:
      - 'null'
      - boolean
    doc: Discard SE reads.
    inputBinding:
      position: 102
      prefix: --no-se
  - id: omit_depth
    type:
      - 'null'
      - boolean
    doc: Omit calculation of read depths.
    inputBinding:
      position: 102
      prefix: --omit-depth
  - id: omit_gc
    type:
      - 'null'
      - boolean
    doc: Omit calculation of read GC content.
    inputBinding:
      position: 102
      prefix: --omit-gc
  - id: output_ext
    type:
      - 'null'
      - string
    doc: Filename extension for output files.
    default: .quaqc.txt
    inputBinding:
      position: 102
      prefix: --output-ext
  - id: peaks
    type:
      - 'null'
      - File
    doc: Peak coordinates in a BED file for FRIP calculation.
    inputBinding:
      position: 102
      prefix: --peaks
  - id: plastids
    type:
      - 'null'
      - string
    doc: Plastid reference names.
    default: chrC,ChrC,Pt,PT,Pltd,Chloro,chloroplast
    inputBinding:
      position: 102
      prefix: --plastids
  - id: quant
    type:
      - 'null'
      - File
    doc: Output quantification of reads in non-overlapping peaks.
    inputBinding:
      position: 102
      prefix: --quant
  - id: quant_ins
    type:
      - 'null'
      - boolean
    doc: Quantify based on 5-prime insertion coordinates.
    inputBinding:
      position: 102
      prefix: --quant-ins
  - id: quant_pn
    type:
      - 'null'
      - boolean
    doc: Use pretty names instead of full file paths.
    inputBinding:
      position: 102
      prefix: --quant-pn
  - id: quant_tn5
    type:
      - 'null'
      - boolean
    doc: Adjust coordinates to account for Tn5 shift (+4/-5).
    inputBinding:
      position: 102
      prefix: --quant-tn5
  - id: rg_list
    type:
      - 'null'
      - File
    doc: Only consider reads with read groups (RG) in a file.
    inputBinding:
      position: 102
      prefix: --rg-list
  - id: rg_names
    type:
      - 'null'
      - string
    doc: Only consider reads with these read groups (RG).
    inputBinding:
      position: 102
      prefix: --rg-names
  - id: rg_tag
    type:
      - 'null'
      - string
    doc: Match reads with -r/-R using another tag, such as CB.
    inputBinding:
      position: 102
      prefix: --rg-tag
  - id: strict
    type:
      - 'null'
      - boolean
    doc: --min-flen=50 --max-flen=150 --mapq=40
    inputBinding:
      position: 102
      prefix: --strict
  - id: target_list
    type:
      - 'null'
      - File
    doc: Only consider reads overlapping ranges in a BED file.
    inputBinding:
      position: 102
      prefix: --target-list
  - id: target_names
    type:
      - 'null'
      - string
    doc: Only consider reads on target sequences.
    inputBinding:
      position: 102
      prefix: --target-names
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of worker threads. Max one per sample.
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: title
    type:
      - 'null'
      - string
    doc: Assign a title to run.
    inputBinding:
      position: 102
      prefix: --title
  - id: tn5_fwd
    type:
      - 'null'
      - int
    doc: Change the global Tn5 shift for forward reads.
    default: 4
    inputBinding:
      position: 102
      prefix: --tn5-fwd
  - id: tn5_rev
    type:
      - 'null'
      - int
    doc: Change the global Tn5 shift for reverse reads.
    default: 5
    inputBinding:
      position: 102
      prefix: --tn5-rev
  - id: tss
    type:
      - 'null'
      - File
    doc: TSS coordinates in a BED file for TSS pileup.
    inputBinding:
      position: 102
      prefix: --tss
  - id: tss_qlen
    type:
      - 'null'
      - int
    doc: Resize reads (centered on the 5p end) for pileup.
    default: 100
    inputBinding:
      position: 102
      prefix: --tss-qlen
  - id: tss_size
    type:
      - 'null'
      - int
    doc: Size of the TSS region for pileup.
    default: 2001
    inputBinding:
      position: 102
      prefix: --tss-size
  - id: tss_tn5
    type:
      - 'null'
      - boolean
    doc: Shift 5-prime end coordinates +4/-5 bases for pileup.
    inputBinding:
      position: 102
      prefix: --tss-tn5
  - id: use_all
    type:
      - 'null'
      - boolean
    doc: Do not apply any filters to mapped reads.
    inputBinding:
      position: 102
      prefix: --use-all
  - id: use_chimeric
    type:
      - 'null'
      - boolean
    doc: Allow supplemental/chimeric alignments.
    inputBinding:
      position: 102
      prefix: --use-chimeric
  - id: use_dovetails
    type:
      - 'null'
      - boolean
    doc: Allow dovetailing PE reads.
    inputBinding:
      position: 102
      prefix: --use-dovetails
  - id: use_dups
    type:
      - 'null'
      - boolean
    doc: Allow duplicate reads.
    inputBinding:
      position: 102
      prefix: --use-dups
  - id: use_nomate
    type:
      - 'null'
      - boolean
    doc: Allow PE reads when the mate does not align properly.
    inputBinding:
      position: 102
      prefix: --use-nomate
  - id: use_secondary
    type:
      - 'null'
      - boolean
    doc: Allow secondary alignments.
    inputBinding:
      position: 102
      prefix: --use-secondary
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print progress messages during runtime.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory to save QC report if not that of input.
    outputBinding:
      glob: $(inputs.output_dir)
  - id: json
    type:
      - 'null'
      - File
    doc: Save combined QC as a JSON file. Use '-' for stdout.
    outputBinding:
      glob: $(inputs.json)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quaqc:1.5--h577a1d6_0
