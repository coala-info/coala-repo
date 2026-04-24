cwlVersion: v1.2
class: CommandLineTool
baseCommand: python /usr/local/bin/quast
label: quast
doc: "Quality Assessment Tool for Genome Assemblies\n\nTool homepage: http://quast.sourceforge.net/"
inputs:
  - id: files_with_contigs
    type: File
    doc: Files containing contigs for assembly
    inputBinding:
      position: 1
  - id: ambiguity_score
    type:
      - 'null'
      - float
    doc: Score S for defining equally good alignments of a single contig. All 
      alignments are sorted by decreasing LEN * IDY% value. All alignments with 
      LEN * IDY% < S * best(LEN * IDY%) are discarded. S should be between 0.8 
      and 1.0
    inputBinding:
      position: 102
      prefix: --ambiguity-score
  - id: ambiguity_usage
    type:
      - 'null'
      - string
    doc: Use none, one, or all alignments of a contig when all of them are 
      almost equally good (see --ambiguity-score)
    inputBinding:
      position: 102
      prefix: --ambiguity-usage
  - id: bam_alignments
    type:
      - 'null'
      - type: array
        items: File
    doc: Comma-separated list of BAM alignment files obtained by aligning reads 
      to assemblies (use the same order as for files with contigs). Reads (or 
      SAM/BAM file) are used for structural variation detection and coverage 
      histogram building in Icarus
    inputBinding:
      position: 102
      prefix: --bam
  - id: circos
    type:
      - 'null'
      - boolean
    doc: Draw Circos plot
    inputBinding:
      position: 102
      prefix: --circos
  - id: conserved_genes_finding
    type:
      - 'null'
      - boolean
    doc: Count conserved orthologs using BUSCO (only on Linux)
    inputBinding:
      position: 102
      prefix: --conserved-genes-finding
  - id: contig_thresholds
    type:
      - 'null'
      - string
    doc: Comma-separated list of contig length thresholds
    inputBinding:
      position: 102
      prefix: --contig-thresholds
  - id: est_insert_size
    type:
      - 'null'
      - int
    doc: Use provided insert size in upper bound assembly simulation
    inputBinding:
      position: 102
      prefix: --est-insert-size
  - id: est_ref_size
    type:
      - 'null'
      - int
    doc: Estimated reference size (for computing NGx metrics without a 
      reference)
    inputBinding:
      position: 102
      prefix: --est-insert-size
  - id: eukaryote
    type:
      - 'null'
      - boolean
    doc: Genome is eukaryotic (primarily affects gene prediction)
    inputBinding:
      position: 102
      prefix: --eukaryote
  - id: extensive_mis_size
    type:
      - 'null'
      - int
    doc: Lower threshold for extensive misassembly size. All relocations with 
      inconsistency less than extensive-mis-size are counted as local 
      misassemblies
    inputBinding:
      position: 102
      prefix: --extensive-mis-size
  - id: fast
    type:
      - 'null'
      - boolean
    doc: A combination of all speedup options except --no-check
    inputBinding:
      position: 102
      prefix: --fast
  - id: features
    type:
      - 'null'
      - File
    doc: File with genomic feature coordinates in the reference (GFF, BED, NCBI 
      or TXT). Optional 'type' can be specified for extracting only a specific 
      feature type from GFF
    inputBinding:
      position: 102
      prefix: --features
  - id: fragmented
    type:
      - 'null'
      - boolean
    doc: Reference genome may be fragmented into small pieces (e.g. scaffolded 
      reference)
    inputBinding:
      position: 102
      prefix: --fragmented
  - id: fragmented_max_indent
    type:
      - 'null'
      - int
    doc: Mark translocation as fake if both alignments are located no further 
      than N bases from the ends of the reference fragments. Requires 
      --fragmented option
    inputBinding:
      position: 102
      prefix: --fragmented-max-indent
  - id: fungus
    type:
      - 'null'
      - boolean
    doc: Genome is fungal (primarily affects gene prediction)
    inputBinding:
      position: 102
      prefix: --fungus
  - id: gene_finding
    type:
      - 'null'
      - boolean
    doc: Predict genes using GeneMarkS (prokaryotes, default) or GeneMark-ES 
      (eukaryotes, use --eukaryote)
    inputBinding:
      position: 102
      prefix: --gene-finding
  - id: gene_thresholds
    type:
      - 'null'
      - string
    doc: Comma-separated list of threshold lengths of genes to search with Gene 
      Finding module
    inputBinding:
      position: 102
      prefix: --gene-thresholds
  - id: glimmer
    type:
      - 'null'
      - boolean
    doc: Use GlimmerHMM for gene prediction (instead of the default finder, see 
      above)
    inputBinding:
      position: 102
      prefix: --glimmer
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: Size of k used in --k-mer-stats
    inputBinding:
      position: 102
      prefix: --k-mer-size
  - id: kmer_stats
    type:
      - 'null'
      - boolean
    doc: Compute k-mer-based quality metrics (recommended for large genomes). 
      This may significantly increase memory and time consumption on large 
      genomes
    inputBinding:
      position: 102
      prefix: --k-mer-stats
  - id: labels
    type:
      - 'null'
      - string
    doc: Names of assemblies to use in reports, comma-separated. If contain 
      spaces, use quotes
    inputBinding:
      position: 102
      prefix: --labels
  - id: large_genome_params
    type:
      - 'null'
      - boolean
    doc: Use optimal parameters for evaluation of large genomes. In particular, 
      imposes '-e -m 3000 -i 500 -x 7000' (can be overridden manually)
    inputBinding:
      position: 102
      prefix: --large
  - id: local_mis_size
    type:
      - 'null'
      - int
    doc: Lower threshold on local misassembly size. Local misassemblies with 
      inconsistency less than local-mis-size are counted as (long) indels
    inputBinding:
      position: 102
      prefix: --local-mis-size
  - id: memory_efficient
    type:
      - 'null'
      - boolean
    doc: Run everything using one thread, separately per each assembly. This may
      significantly reduce memory consumption on large genomes
    inputBinding:
      position: 102
      prefix: --memory-efficient
  - id: mgm
    type:
      - 'null'
      - boolean
    doc: Use MetaGeneMark for gene prediction (instead of the default finder, 
      see above)
    inputBinding:
      position: 102
      prefix: --mgm
  - id: min_alignment
    type:
      - 'null'
      - int
    doc: The minimum alignment length
    inputBinding:
      position: 102
      prefix: --min-alignment
  - id: min_contig
    type:
      - 'null'
      - int
    doc: Lower threshold for contig length
    inputBinding:
      position: 102
      prefix: --min-contig
  - id: min_identity
    type:
      - 'null'
      - float
    doc: The minimum alignment identity (80.0, 100.0)
    inputBinding:
      position: 102
      prefix: --min-identity
  - id: mp1
    type:
      - 'null'
      - File
    doc: File with forward mate-pair reads (in FASTQ format, may be gzipped)
    inputBinding:
      position: 102
      prefix: --mp1
  - id: mp12
    type:
      - 'null'
      - File
    doc: File with interlaced forward and reverse mate-pair reads (in FASTQ 
      format, may be gzipped)
    inputBinding:
      position: 102
      prefix: --mp12
  - id: mp2
    type:
      - 'null'
      - File
    doc: File with reverse mate-pair reads (in FASTQ format, may be gzipped)
    inputBinding:
      position: 102
      prefix: --mp2
  - id: nanopore
    type:
      - 'null'
      - File
    doc: File with Oxford Nanopore reads (in FASTQ format, may be gzipped)
    inputBinding:
      position: 102
      prefix: --nanopore
  - id: no_check
    type:
      - 'null'
      - boolean
    doc: Do not check and correct input fasta files. Use at your own risk (see 
      manual)
    inputBinding:
      position: 102
      prefix: --no-check
  - id: no_gc
    type:
      - 'null'
      - boolean
    doc: Do not compute GC% and GC-distribution
    inputBinding:
      position: 102
      prefix: --no-gc
  - id: no_html
    type:
      - 'null'
      - boolean
    doc: Do not build html reports and Icarus viewers
    inputBinding:
      position: 102
      prefix: --no-html
  - id: no_icarus
    type:
      - 'null'
      - boolean
    doc: Do not build Icarus viewers
    inputBinding:
      position: 102
      prefix: --no-icarus
  - id: no_plots
    type:
      - 'null'
      - boolean
    doc: Do not draw static plots
    inputBinding:
      position: 102
      prefix: --no-plots
  - id: no_read_stats
    type:
      - 'null'
      - boolean
    doc: Do not align reads to assemblies. Reads will be aligned to reference 
      and used for coverage analysis, upper bound assembly simulation, and 
      structural variation detection. Use this option if you do not need read 
      statistics for assemblies.
    inputBinding:
      position: 102
      prefix: --no-read-stats
  - id: no_snps
    type:
      - 'null'
      - boolean
    doc: Do not report SNPs (may significantly reduce memory consumption on 
      large genomes)
    inputBinding:
      position: 102
      prefix: --no-snps
  - id: no_sv
    type:
      - 'null'
      - boolean
    doc: Do not run structural variation detection (make sense only if reads are
      specified)
    inputBinding:
      position: 102
      prefix: --no-sv
  - id: operons
    type:
      - 'null'
      - File
    doc: File with operon coordinates in the reference (GFF, BED, NCBI or TXT)
    inputBinding:
      position: 102
      prefix: --operons
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory to store all result files
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: pacbio
    type:
      - 'null'
      - File
    doc: File with PacBio reads (in FASTQ format, may be gzipped)
    inputBinding:
      position: 102
      prefix: --pacbio
  - id: pe1
    type:
      - 'null'
      - File
    doc: File with forward paired-end reads (in FASTQ format, may be gzipped)
    inputBinding:
      position: 102
      prefix: --pe1
  - id: pe12
    type:
      - 'null'
      - File
    doc: File with interlaced forward and reverse paired-end reads. (in FASTQ 
      format, may be gzipped)
    inputBinding:
      position: 102
      prefix: --pe12
  - id: pe2
    type:
      - 'null'
      - File
    doc: File with reverse paired-end reads (in FASTQ format, may be gzipped)
    inputBinding:
      position: 102
      prefix: --pe2
  - id: plots_format
    type:
      - 'null'
      - string
    doc: 'Save plots in specified format. Supported formats: emf, eps, pdf, png, ps,
      raw, rgba, svg, svgz'
    inputBinding:
      position: 102
      prefix: --plots-format
  - id: ref_bam
    type:
      - 'null'
      - File
    doc: BAM alignment file obtained by aligning reads to reference genome file
    inputBinding:
      position: 102
      prefix: --ref-bam
  - id: ref_sam
    type:
      - 'null'
      - File
    doc: SAM alignment file obtained by aligning reads to reference genome file
    inputBinding:
      position: 102
      prefix: --ref-sam
  - id: reference_genome
    type:
      - 'null'
      - File
    doc: Reference genome file
    inputBinding:
      position: 102
      prefix: -r
  - id: report_all_metrics
    type:
      - 'null'
      - boolean
    doc: Keep all quality metrics in the main report even if their values are 
      '-' for all assemblies or if they are not applicable (e.g., 
      reference-based metrics in the no-reference mode)
    inputBinding:
      position: 102
      prefix: --report-all-metrics
  - id: rna_finding
    type:
      - 'null'
      - boolean
    doc: Predict ribosomal RNA genes using Barrnap
    inputBinding:
      position: 102
      prefix: --rna-finding
  - id: sam_alignments
    type:
      - 'null'
      - type: array
        items: File
    doc: Comma-separated list of SAM alignment files obtained by aligning reads 
      to assemblies (use the same order as for files with contigs)
    inputBinding:
      position: 102
      prefix: --sam
  - id: scaffold_gap_max_size
    type:
      - 'null'
      - int
    doc: Max allowed scaffold gap length difference. All relocations with 
      inconsistency less than scaffold-gap-size are counted as scaffold gap 
      misassemblies
    inputBinding:
      position: 102
      prefix: --scaffold-gap-max-size
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Do not print detailed information about each step to stdout (log file 
      is not affected)
    inputBinding:
      position: 102
      prefix: --silent
  - id: single
    type:
      - 'null'
      - File
    doc: File with unpaired short reads (in FASTQ format, may be gzipped)
    inputBinding:
      position: 102
      prefix: --single
  - id: skip_unaligned_mis_contigs
    type:
      - 'null'
      - boolean
    doc: Do not distinguish contigs with >= 50% unaligned bases as a separate 
      group. By default, QUAST does not count misassemblies in them
    inputBinding:
      position: 102
      prefix: --skip-unaligned-mis-contigs
  - id: space_efficient
    type:
      - 'null'
      - boolean
    doc: Create only reports and plots files. Aux files including .stdout, 
      .stderr, .coords will not be created. This may significantly reduce space 
      consumption on large genomes. Icarus viewers also will not be built
    inputBinding:
      position: 102
      prefix: --space-efficient
  - id: split_scaffolds
    type:
      - 'null'
      - boolean
    doc: Split assemblies by continuous fragments of N's and add such "contigs" 
      to the comparison
    inputBinding:
      position: 102
      prefix: --split-scaffolds
  - id: strict_na
    type:
      - 'null'
      - boolean
    doc: Break contigs in any misassembly event when compute NAx and NGAx. By 
      default, QUAST breaks contigs only by extensive misassemblies (not local 
      ones)
    inputBinding:
      position: 102
      prefix: --strict-NA
  - id: sv_bedpe
    type:
      - 'null'
      - File
    doc: File with structural variations (in BEDPE format)
    inputBinding:
      position: 102
      prefix: --sv-bedpe
  - id: take_assembly_names_from_parent_dir
    type:
      - 'null'
      - boolean
    doc: Take assembly names from their parent directory names
    inputBinding:
      position: 102
      prefix: -L
  - id: test
    type:
      - 'null'
      - boolean
    doc: Run QUAST on the data from the test_data folder, output to 
      quast_test_output
    inputBinding:
      position: 102
      prefix: --test
  - id: test_sv
    type:
      - 'null'
      - boolean
    doc: Run QUAST with structural variants detection on the data from the 
      test_data folder, output to quast_test_output
    inputBinding:
      position: 102
      prefix: --test-sv
  - id: threads
    type:
      - 'null'
      - int
    doc: Maximum number of threads
    inputBinding:
      position: 102
      prefix: --threads
  - id: unaligned_part_size
    type:
      - 'null'
      - int
    doc: Lower threshold for detecting partially unaligned contigs. Such contig 
      should have at least one unaligned fragment >= the threshold
    inputBinding:
      position: 102
      prefix: --unaligned-part-size
  - id: upper_bound_assembly
    type:
      - 'null'
      - boolean
    doc: Simulate upper bound assembly based on the reference genome and reads
    inputBinding:
      position: 102
      prefix: --upper-bound-assembly
  - id: upper_bound_min_con
    type:
      - 'null'
      - int
    doc: Minimal number of 'connecting reads' needed for joining upper bound 
      contigs into a scaffold
    inputBinding:
      position: 102
      prefix: --upper-bound-min-con
  - id: use_all_alignments
    type:
      - 'null'
      - boolean
    doc: "Compute genome fraction, # genes, # operons in QUAST v1.* style. By default,
      QUAST filters Minimap's alignments to keep only best ones"
    inputBinding:
      position: 102
      prefix: --use-all-alignments
  - id: x_for_nx
    type:
      - 'null'
      - int
    doc: Value of 'x' for Nx, Lx, etc metrics reported in addition to N50, L50, 
      etc (0, 100)
    inputBinding:
      position: 102
      prefix: --x-for-Nx
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quast:5.3.0--py313pl5321h5ca1c30_2
stdout: quast.out
