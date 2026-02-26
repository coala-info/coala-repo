# cnvpytor CWL Generation Report

## cnvpytor

### Tool Description
Lite version of the CNVnator written in Python. A tool for CNV discovery from depth of read mapping.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvpytor:1.3.2--pyhdfd78af_0
- **Homepage**: https://github.com/abyzovlab/CNVpytor
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvpytor/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvpytor/overview
- **Total Downloads**: 17.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/abyzovlab/CNVpytor
- **Stars**: N/A
### Original Help Text
```text
usage: cnvpytor [-h] [-version] [-root ROOT [ROOT ...]] [-download]
                [-chrom CHROM [CHROM ...]]
                [-v {none,debug,info,warning,error,d,e,i,w}] [-log LOG_FILE]
                [-j MAX_CORES] [-rd RD [RD ...]] [-T REFERENCE_FILENAME]
                [-gc GC] [-cgc COPY_GC] [-his HIS [HIS ...]]
                [-snp2his HIS_FROM_SNP [HIS_FROM_SNP ...]]
                [-stat STAT [STAT ...]] [-partition PARTITION [PARTITION ...]]
                [-call CALL [CALL ...]] [-filter_nan] [-vcf VCF [VCF ...]]
                [-stdin2snp] [-somatic_snv SOMATIC_SNV [SOMATIC_SNV ...]]
                [-minc MIN_COUNT] [-vcf2rd RD_FROM_VCF] [-noAD] [-nofilter]
                [-ad AD_TAG] [-gt GT_TAG] [-dp DP_TAG] [-callset CALLSET]
                [-maxcn MAX_COPY_NUMBER] [-mindbaf BAF_THRESHOLD]
                [-gnp GENOME_NORM_PCT] [-bafres BAF_RESOLUTION] [-nolh]
                [-oth OVERLAP_THRESHOLD] [-mincf MIN_CELL_FRACTION]
                [-pileup PILEUP_BAM [PILEUP_BAM ...]] [-snp2rd]
                [-sbin S_BIN_SIZE] [-mask MASK] [-mask_snps] [-trio_phase]
                [-parents] [-mask_snvs MASK_SNVS] [-idvar IDVAR]
                [-random_phase] [-baf BAF [BAF ...]] [-nomask] [-useid]
                [-usehom] [-usephase] [-reducenoise]
                [-blw BAF_LIKELIHOOD_WIDTH] [-altc] [-plot PLOT [PLOT ...]]
                [-view VIEW] [-agg]
                [-panels {rd,baf,likelihood} [{rd,baf,likelihood} ...]]
                [-style {Solarize_Light2,_classic_test_patch,_mpl-gallery,_mpl-gallery-nogrid,bmh,classic,dark_background,fast,fivethirtyeight,ggplot,grayscale,petroff10,seaborn-v0_8,seaborn-v0_8-bright,seaborn-v0_8-colorblind,seaborn-v0_8-dark,seaborn-v0_8-dark-palette,seaborn-v0_8-darkgrid,seaborn-v0_8-deep,seaborn-v0_8-muted,seaborn-v0_8-notebook,seaborn-v0_8-paper,seaborn-v0_8-pastel,seaborn-v0_8-poster,seaborn-v0_8-talk,seaborn-v0_8-ticks,seaborn-v0_8-white,seaborn-v0_8-whitegrid,tableau-colorblind10}]
                [-o PLOT_OUTPUT_FILE] [-anim ANIMATION] [-make_gc_file]
                [-make_mask_file] [-rd_use_mask] [-nogc] [-gc_auto]
                [-gc_corr_rm_ol] [-rg REFERENCE_GENOME] [-sample VCF_SAMPLE]
                [-conf REFERENCE_GENOMES_CONF] [-ls] [-gc_info] [-rg_info]
                [-info [INFO ...]] [-qc [QC ...]] [-rdqc [RD_QC ...]]
                [-comp [COMPARE ...]] [-genotype [GENOTYPE ...]]
                [-genotype_genes [GENOTYPE_GENES ...]] [-a] [-meta]
                [-fasta2rg REFERENCE_GENOME_TEMPLATE] [-export [EXPORT ...]]

Lite version of the CNVnator written in Python. A tool for CNV discovery from
depth of read mapping.

options:
  -h, --help            show this help message and exit
  -version, --version   show version number and exit
  -root ROOT [ROOT ...], --root ROOT [ROOT ...]
                        CNVnator hd5 file: data storage for all calculations
  -download, --download_resources
                        download resource files
  -chrom CHROM [CHROM ...], --chrom CHROM [CHROM ...]
                        list of chromosomes to apply calculation
  -v {none,debug,info,warning,error,d,e,i,w}, --verbose {none,debug,info,warning,error,d,e,i,w}
                        verbose level: debug, info (default), warning, error
  -log LOG_FILE, --log_file LOG_FILE
                        log file
  -j MAX_CORES, --max_cores MAX_CORES
                        maximal number of cores to use in calculation
  -rd RD [RD ...], --rd RD [RD ...]
                        read bam/sam/cram and store read depth information
  -T REFERENCE_FILENAME, --reference_filename REFERENCE_FILENAME
                        reference fasta for CRAM
  -gc GC, --gc GC       read fasta file and store GC/AT content
  -cgc COPY_GC, --copy_gc COPY_GC
                        copy GC/AT content from another cnvnator file
  -his HIS [HIS ...], --his HIS [HIS ...]
                        create histograms for specified bin size (multiple bin
                        sizes separate by space)
  -snp2his HIS_FROM_SNP [HIS_FROM_SNP ...], --his_from_snp HIS_FROM_SNP [HIS_FROM_SNP ...]
                        create histograms for specified bin size (multiple bin
                        sizes separate by space)
  -stat STAT [STAT ...], --stat STAT [STAT ...]
                        calculate statistics for specified bin size (multiple
                        bin sizes separate by space)
  -partition PARTITION [PARTITION ...], --partition PARTITION [PARTITION ...]
                        calculate segmentation for specified bin size
                        (multiple bin sizes separate by space)
  -call CALL [CALL ...], --call CALL [CALL ...]
                        CNV caller: [baf] bin_size [bin_size2 ...] (multiple
                        bin sizes separate by space)
  -filter_nan, --filter_nan
                        filter nan values in rd/partition
  -vcf VCF [VCF ...], -snp VCF [VCF ...], --vcf VCF [VCF ...]
                        read SNP data from vcf files
  -stdin2snp, --stdin2snp
                        read SNP data from stdin
  -somatic_snv SOMATIC_SNV [SOMATIC_SNV ...], --somatic_snv SOMATIC_SNV [SOMATIC_SNV ...]
                        read SNP data from vcf files
  -minc MIN_COUNT, --min_count MIN_COUNT
                        minimal count of haterozygous SNPs
  -vcf2rd RD_FROM_VCF, --rd_from_vcf RD_FROM_VCF
                        read SNP data from vcf files
  -noAD, --no_snp_counts
                        read positions of variants, not counts (AD tag)
  -nofilter, --no_filter
                        read all variants (not only PASS)
  -ad AD_TAG, --ad_tag AD_TAG
                        counts tag (default: AD)
  -gt GT_TAG, --gt_tag GT_TAG
                        genotype tag (default: GT)
  -dp DP_TAG, --dp_tag DP_TAG
                        read depth tag (default: DP)
  -callset CALLSET, --callset CALLSET
                        name for somatic VCF signal
  -maxcn MAX_COPY_NUMBER, --max_copy_number MAX_COPY_NUMBER
                        maximal copy number
  -mindbaf BAF_THRESHOLD, --baf_threshold BAF_THRESHOLD
                        threshold for change in BAF level
  -gnp GENOME_NORM_PCT, --genome_norm_pct GENOME_NORM_PCT
                        minimal percentage of genome used for normalisation
  -bafres BAF_RESOLUTION, --baf_resolution BAF_RESOLUTION
                        Resolution for unphased BAF likelihood
  -nolh, --no_save_likelihood
                        do not save likelihood histograms (reduce size of
                        pytor file)
  -oth OVERLAP_THRESHOLD, --overlap_threshold OVERLAP_THRESHOLD
                        likelihood overlap threshold
  -mincf MIN_CELL_FRACTION, --min_cell_fraction MIN_CELL_FRACTION
                        minimal cell fraction
  -pileup PILEUP_BAM [PILEUP_BAM ...], --pileup_bam PILEUP_BAM [PILEUP_BAM ...]
                        calculate SNP counts from bam files
  -snp2rd, --rd_from_snp
                        calculate RD from SNP counts
  -sbin S_BIN_SIZE, --s_bin_size S_BIN_SIZE
                        Super bin size (use with -snp2rd)
  -mask MASK, --mask MASK
                        read fasta mask file and flag SNPs in P region
  -mask_snps, --mask_snps
                        flag SNPs in P region
  -trio_phase, --trio_phase
                        Phase trio
  -parents, --phase_parents
                        Phase parents
  -mask_snvs MASK_SNVS, --mask_snvs MASK_SNVS
                        flag SNVs in P region
  -idvar IDVAR, --idvar IDVAR
                        read vcf file and flag SNPs that exist in database
                        file
  -random_phase, --random_phase
                        randomly phase SNPs
  -baf BAF [BAF ...], --baf BAF [BAF ...]
                        create BAF histograms for specified bin size (multiple
                        bin sizes separate by space)
  -nomask, --no_mask    do not use P mask in BAF histograms
  -useid, --use_id      use id flag filtering in SNP histograms
  -usehom, --use_hom    use hom
  -usephase, --use_phase
                        use information about phase while processing SNP data
  -reducenoise, --reduce_noise
                        reduce noise in processing SNP data
  -blw BAF_LIKELIHOOD_WIDTH, --baf_likelihood_width BAF_LIKELIHOOD_WIDTH
                        likelihood width used in processing SNP data
                        (default=0.8)
  -altc, --alt_corr     Remove alt/ref bias
  -plot PLOT [PLOT ...], --plot PLOT [PLOT ...]
                        plotting
  -view VIEW, --view VIEW
                        Enters interactive ploting mode
  -agg, --force_agg     Force Agg matplotlib backend
  -panels {rd,baf,likelihood} [{rd,baf,likelihood} ...], --panels {rd,baf,likelihood} [{rd,baf,likelihood} ...]
                        plot panels (with -plot regions)
  -style {Solarize_Light2,_classic_test_patch,_mpl-gallery,_mpl-gallery-nogrid,bmh,classic,dark_background,fast,fivethirtyeight,ggplot,grayscale,petroff10,seaborn-v0_8,seaborn-v0_8-bright,seaborn-v0_8-colorblind,seaborn-v0_8-dark,seaborn-v0_8-dark-palette,seaborn-v0_8-darkgrid,seaborn-v0_8-deep,seaborn-v0_8-muted,seaborn-v0_8-notebook,seaborn-v0_8-paper,seaborn-v0_8-pastel,seaborn-v0_8-poster,seaborn-v0_8-talk,seaborn-v0_8-ticks,seaborn-v0_8-white,seaborn-v0_8-whitegrid,tableau-colorblind10}, --plot_style {Solarize_Light2,_classic_test_patch,_mpl-gallery,_mpl-gallery-nogrid,bmh,classic,dark_background,fast,fivethirtyeight,ggplot,grayscale,petroff10,seaborn-v0_8,seaborn-v0_8-bright,seaborn-v0_8-colorblind,seaborn-v0_8-dark,seaborn-v0_8-dark-palette,seaborn-v0_8-darkgrid,seaborn-v0_8-deep,seaborn-v0_8-muted,seaborn-v0_8-notebook,seaborn-v0_8-paper,seaborn-v0_8-pastel,seaborn-v0_8-poster,seaborn-v0_8-talk,seaborn-v0_8-ticks,seaborn-v0_8-white,seaborn-v0_8-whitegrid,tableau-colorblind10}
                        available plot styles: Solarize_Light2,
                        _classic_test_patch, _mpl-gallery, _mpl-gallery-
                        nogrid, bmh, classic, dark_background, fast,
                        fivethirtyeight, ggplot, grayscale, petroff10,
                        seaborn-v0_8, seaborn-v0_8-bright,
                        seaborn-v0_8-colorblind, seaborn-v0_8-dark,
                        seaborn-v0_8-dark-palette, seaborn-v0_8-darkgrid,
                        seaborn-v0_8-deep, seaborn-v0_8-muted,
                        seaborn-v0_8-notebook, seaborn-v0_8-paper,
                        seaborn-v0_8-pastel, seaborn-v0_8-poster,
                        seaborn-v0_8-talk, seaborn-v0_8-ticks,
                        seaborn-v0_8-white, seaborn-v0_8-whitegrid, tableau-
                        colorblind10
  -o PLOT_OUTPUT_FILE, --plot_output_file PLOT_OUTPUT_FILE
                        output filename prefix and extension
  -anim ANIMATION, --animation ANIMATION
                        animation folder/prefix
  -make_gc_file, --make_gc_genome_file
                        used with -gc will create genome gc file
  -make_mask_file, --make_mask_genome_file
                        used with -mask will create genome mask file
  -rd_use_mask, --use_mask_with_rd
                        used P mask in RD histograms
  -nogc, --no_gc_corr   do not use GC correction in RD histograms
  -gc_auto, --gc_auto   use autosomal GC correction for X, Y and MT
  -gc_corr_rm_ol, --gc_corr_rm_ol
                        use only rd bins between 75% and 125% of mean value
                        for gc correction curve
  -rg REFERENCE_GENOME, --reference_genome REFERENCE_GENOME
                        Manually set reference genome
  -sample VCF_SAMPLE, --vcf_sample VCF_SAMPLE
                        Sample name in vcf file
  -conf REFERENCE_GENOMES_CONF, --reference_genomes_conf REFERENCE_GENOMES_CONF
                        Configuration with reference genomes
  -ls, --ls             list pytor file(s) content
  -gc_info, --gc_info   list pytor file(s) gc content stat
  -rg_info, --rg_info   list loaded reference gnomes
  -info [INFO ...], --info [INFO ...]
                        print statistics for pythor file(s)
  -qc [QC ...], --qc [QC ...]
                        print quality control statistics
  -rdqc [RD_QC ...], --rd_qc [RD_QC ...]
                        print quality control statistics without SNP data
  -comp [COMPARE ...], --compare [COMPARE ...]
                        compere two regions: -comp reg1 reg2 [n_bins]
  -genotype [GENOTYPE ...], --genotype [GENOTYPE ...]
  -genotype_genes [GENOTYPE_GENES ...], --genotype_genes [GENOTYPE_GENES ...]
  -a, --all             Genotype with all columns
  -meta, --metadata     list Metadata
  -fasta2rg REFERENCE_GENOME_TEMPLATE, --reference_genome_template REFERENCE_GENOME_TEMPLATE
                        create template for reference genome using chromosome
                        lengths from fasta file
  -export [EXPORT ...], --export [EXPORT ...]
                        Export to jbrowse and cnvnator
```

