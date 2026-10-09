cwlVersion: v1.2
class: CommandLineTool
baseCommand: impute2
label: impute2
doc: "IMPUTE version 2.3.2: genotype imputation and haplotype phasing.\n\nTool homepage: https://mathgen.stats.ox.ac.uk/impute/impute_v2.html"
inputs:
  - id: genetic_map
    type: File
    doc: "Fine-scale recombination map for the region to be analyzed. This file should have three columns: physical position (in base pairs), recombination rate between current position and next position in map (in cM/Mb), and genetic map position (in cM). The file should also have a header line with an unbroken character string for each column (e.g., \"position COMBINED_rate(cM/Mb) Genetic_Map(cM)\"). All of our reference panel download packages come with appropriate recombination map files."
    inputBinding:
      position: 1
      prefix: '-m'
  - id: interval
    type:
      type: array
      items: string
    doc: "Genomic interval to use for inference, as specified by <lower> and <upper> boundaries in base pair position. The boundaries can be expressed either in long form (e.g., -int 5420000 10420000) or in exponential notation (e.g., -int 5.42e6 10.42e6). This option is particularly useful for restricting test jobs to small regions or splitting whole-chromosome analyses into manageable chunks, as discussed in the section on analyzing whole chromosomes. IMPUTE2 requires that you specify an analysis interval in order to prevent accidental whole-chromosome analyses. If you want to impute a region larger than 7 Mb (which is not generally recommended), you must activate the -allow_large_regions flag."
    inputBinding:
      position: 2
      prefix: '-int'
  - id: study_genotypes
    type:
      - 'null'
      - File
    doc: "File containing genotypes for a study cohort that you want to impute or phase. The format of this file is described on our file format webpage and is the same as the output format from our genotype calling program CHIAMO. If you do not supply a file of unphased genotypes via this argument, you must supply a file of phased study haplotypes via the -known_haps_g option."
    inputBinding:
      position: 3
      prefix: '-g'
  - id: ref_haplotypes
    type:
      - 'null'
      - type: array
        items: File
    doc: "File of known haplotypes, with one row per SNP and one column per haplotype. All alleles must be coded as 0 or 1, and each -h file must be provided with a corresponding legend file. We provide formatted haplotypes from the HapMap Project and the 1,000 Genomes Project in our reference panel download packages. In IMPUTE2, it is possible to specify two -h files. In this case, the file with more SNPs should be provided first (in the <file 1> position) and the file with fewer SNPs should be provided second (in the <file 2> position), with a single space separating the file names."
    inputBinding:
      position: 4
      prefix: '-h'
  - id: ref_legend
    type:
      - 'null'
      - type: array
        items: File
    doc: "Legend file(s) with information about the SNPs in the -h file(s). Each file should have four columns: rsID, physical position (in base pairs), allele 0, and allele 1. The last two columns specify the alleles underlying the 0/1 coding in the corresponding -h file; these alleles can take values in {A,C,G,T}. Each legend file should also have a header line with an unbroken character string for each column (e.g., \"rsID position a0 a1\"). We provide legend files for data from the HapMap Project and the 1,000 Genomes Project in our reference panel download packages. When using two -h files with IMPUTE2, you must supply the corresponding legend files in the same order�i.e., the file with more SNPs comes first."
    inputBinding:
      position: 5
      prefix: '-l'
  - id: ref_genotypes
    type:
      - 'null'
      - File
    doc: "File containing unphased genotypes to use as a reference panel for imputation. This file should follow the same format as the -g file. A -g_ref file can be used as the lone reference panel for imputation, or it can be combined with a single -h file to create a two-tiered reference panel (in the latter case, the -g_ref file should contain roughly a subset of the SNPs in the -h file)."
    inputBinding:
      position: 6
      prefix: '-g_ref'
  - id: known_haps_g
    type:
      - 'null'
      - File
    doc: "File containing known haplotypes for the study cohort. The format is the same as the output format from IMPUTE2's -phase option: five header columns (as in the -g file) followed by two columns (haplotypes) per individual. Allowed values in the haplotype columns are 0, 1, and ?. If your study dataset is fully phased, you can replace the -g file with a -known_haps_g file. This will cause IMPUTE2 to perform haploid imputation, although it will still report diploid imputation probabilities in the main output file. If any genotypes are missing, they can be marked as '? ?' (two question marks separated by one space) in the input file. (The program does not allow just one allele from a diploid genotype to be missing.) If the reference panels are also phased, IMPUTE2 will perform a single, fast imputation step rather than its standard MCMC module�this is how the program imputes into pre-phased ..."
    inputBinding:
      position: 7
      prefix: '-known_haps_g'
  - id: output_file
    type: string
    doc: "Name of main output file. Follows the same format as the -g file. (default: ./test.impute2)"
    inputBinding:
      position: 8
      prefix: '-o'
  - id: info_file
    type:
      - 'null'
      - string
    doc: "Name of SNP-wise information file with one line per SNP and a single header line at the beginning. This file always contains the following columns (header tags shown in parentheses): 1. SNP identifier from -g file (snp_id) 2. rsID (rs_id) 3. base pair position (position) 4. expected frequency of allele coded '1' in the -o file (exp_freq_a1) 5. measure of the observed statistical information associated with the allele frequency estimate (info) [details] 6. average certainty of best-guess genotypes (certainty) 7. internal \"type\" assigned to SNP (type) Depending on the command-line options invoked, there may also be columns labeled info_typeX, concord_typeX, and r2_typeX. IMPUTE2 assigns every SNP an internal \"type\" which reflects the combination of input datasets that include data for that SNP; here, X gives the type, which takes values in {0,1,2}. You can learn how the program determines ... (default: [-o]_info)"
    inputBinding:
      position: 9
      prefix: '-i'
  - id: summary_file
    type:
      - 'null'
      - string
    doc: "Name of log file that records a summary of the screen output. (default: [-o]_summary)"
    inputBinding:
      position: 10
      prefix: '-r'
  - id: warnings_file
    type:
      - 'null'
      - string
    doc: "Name of file that records warnings generated by IMPUTE2. (default: [-o]_warnings)"
    inputBinding:
      position: 11
      prefix: '-w'
  - id: output_snp_types
    type:
      - 'null'
      - type: array
        items: int
    doc: "\"Output SNPs\": specifies the SNP types that will be printed to the output file (SNP labeling is discussed in the Overview). By default, all imputed and genotyped SNPs are included in the output, i.e., \"-os 0 1 2 3\". (default: 0 1 2 3)"
    inputBinding:
      position: 12
      prefix: '-os'
  - id: o_gz
    type:
      - 'null'
      - boolean
    doc: "Specifies that the main output file should be compressed by the gzip utility; this also applies to some non-standard output files that can become large."
    inputBinding:
      position: 13
      prefix: '-o_gz'
  - id: outdp
    type:
      - 'null'
      - int
    doc: "Specifies the number of decimal places to use for reporting genotype probabilities in the main output file. (default: 3)"
    inputBinding:
      position: 14
      prefix: '-outdp'
  - id: no_snp_qc_info
    type:
      - 'null'
      - boolean
    doc: "Suppresses printing of info_typeX, concord_typeX, and r2_typeX columns in the -i file."
    inputBinding:
      position: 15
      prefix: '-no_snp_qc_info'
  - id: no_sample_qc_info
    type:
      - 'null'
      - boolean
    doc: "Suppresses printing of per-sample quality control metrics file. The default is to print a file named \"[-i]_by_sample\"."
    inputBinding:
      position: 16
      prefix: '-no_sample_qc_info'
  - id: phase
    type:
      - 'null'
      - boolean
    doc: "IMPUTE2 always implicitly phases the study genotypes (-g file), and this flag tells the program to print the best-guess haplotypes that result from the phasing process. In addition to the standard imputation output file, the program also prints a separate haplotype file named \"[-o]_haps\". This file contains the same five header columns as the standard output, along with two columns (haplotypes) per individual, in the same order they appear in the main output. In addition to this \"best-guess\" haplotype file, the program also prints the certainty that each successive pair of heterozygous SNPs is correctly phased. These certainties occur in a file named \"[-o]_haps_confidence\". In this file, homozygotes are represented by * characters and heterozygotes are represented by numbers between 0.5 and 1.0; this is the estimated probability that the phasing between the current heterozygote and the ..."
    inputBinding:
      position: 17
      prefix: '-phase'
  - id: pgs
    type:
      - 'null'
      - boolean
    doc: "\"Predict Genotyped SNPs\": Tells the program to replace the input genotypes from the -g file with imputed genotypes in the -o file (applies to Type 2 SNPs only)."
    inputBinding:
      position: 18
      prefix: '-pgs'
  - id: pgs_miss
    type:
      - 'null'
      - boolean
    doc: "Unlike -pgs, which replaces all input genotypes with imputed genotypes, this option tells the program to replace only the missing genotypes at typed SNPs. That is, any input genotype whose maximum probability exceeds the -call_thresh will simply be reprinted in the -o file, whereas input genotypes that fall below the calling threshold will be imputed in the output. WARNING: This is an appealing option that will \"fill in\" sporadically missing genotypes in your input data. However, it is possible that this could cause subtle problems in downstream association testing. We therefore suggest that you use caution when applying this option."
    inputBinding:
      position: 19
      prefix: '-pgs_miss'
  - id: buffer
    type:
      - 'null'
      - int
    doc: "Length of buffer region (in kb) to include on each side of the analysis interval specified by the -int option. SNPs in the buffer regions inform the inference but do not appear in output files (unless you activate the -include_buffer_in_output flag). Using a buffer region helps prevent imputation quality from deteriorating near the edges of the analysis interval. Larger buffers may improve accuracy for low-frequency variants (since such variants tend to reside on long haplotype backgrounds) at the cost of longer running times. (default: 250 kb)"
    inputBinding:
      position: 20
      prefix: '-buffer'
  - id: allow_large_regions
    type:
      - 'null'
      - boolean
    doc: "Allows the analysis of regions larger than 7 Mb. If this flag is not activated and the analysis interval plus buffer region exceeds 7 Mb, the program will quit with an error. The rationale for this flag is described here."
    inputBinding:
      position: 21
      prefix: '-allow_large_regions'
  - id: include_buffer_in_output
    type:
      - 'null'
      - boolean
    doc: "Tells the program to include SNPs from the -buffer region in all output files. The main reason for using this option is to preserve the buffer information for downstream imputation, e.g. when pre-phasing a GWAS dataset."
    inputBinding:
      position: 22
      prefix: '-include_buffer_in_output'
  - id: effective_size
    type:
      - 'null'
      - int
    doc: "\"Effective size\" of the population (commonly denoted as Ne in the population genetics literature) from which your dataset was sampled. This parameter scales the recombination rates that IMPUTE2 uses to guide its model of linkage disequilibrium patterns. When most imputation runs were conducted with reference panels from HapMap Phase 2, we suggested values of 11418 for imputation from HapMap CEU, 17469 for YRI, and 14269 for CHB+JPT. Modern imputation analyses typically involve reference panels with greater ancestral diversity, which can make it hard to determine the \"ideal\" -Ne value for a particular study. Fortunately, we have found that imputation accuracy is highly robust to different -Ne values; within each of several human populations, we have obtained nearly identical accuracy levels for values between 10000 and 25000. We suggest setting -Ne to 20000 in the majority of modern ... (default: 20000)"
    inputBinding:
      position: 23
      prefix: '-Ne'
  - id: call_thresh
    type:
      - 'null'
      - float
    doc: "Threshold for calling genotypes in the -g file. For each individual at each SNP, the program will use the genotype with the maximum probability if that probability exceeds the threshold; otherwise, the genotype will be treated as missing. NOTE: This threshold applies only to input genotypes. If you want to apply a calling threshold to IMPUTE2's output probabilities, you will have to do it yourself. However, it is usually not a good idea to treat imputation output this way; see the webpage of our association-testing software SNPTEST for better suggestions. (default: 0.9)"
    inputBinding:
      position: 24
      prefix: '-call_thresh'
  - id: nind
    type:
      - 'null'
      - int
    doc: "Number of individuals from the -g file to include in the analysis. For example, to impute only the first five individuals, set -nind 5. This option is useful for debugging and test runs. (default: # of indiv in -g file)"
    inputBinding:
      position: 25
      prefix: '-nind'
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Print detailed output about the progress of imputation. By default, IMPUTE2 prints only the number of the current MCMC iteration when performing imputation, but this flag tells it to print more detailed updates."
    inputBinding:
      position: 26
      prefix: '-verbose'
  - id: strand_g
    type:
      - 'null'
      - File
    doc: "File showing the strand orientation of the SNP allele codings in the -g file, relative to a fixed reference point. Each SNP occupies one line, and the file should have two columns: (i) the base pair position of the SNP and (ii) the strand orientation ('+' or '-') of the alleles in the genotype file; the columns should be separated by a single space. The ordering of the SNPs in this file does not matter (by contrast to the -g file, which must be sorted by SNP position), and it is okay if some SNPs in the strand file are not present in the genotype file (e.g., due to filtering). We provide model strand files in the Example/ directory that comes with the software download."
    inputBinding:
      position: 27
      prefix: '-strand_g'
  - id: strand_g_ref
    type:
      - 'null'
      - File
    doc: "Same as -strand_g, but applies to the -g_ref file."
    inputBinding:
      position: 28
      prefix: '-strand_g_ref'
  - id: align_by_maf_g
    type:
      - 'null'
      - boolean
    doc: "Activates the program's internal strand alignment procedure for the -g file (AKA Panel 2; for details about the panel nomenclature used here, see the overview). The strand is aligned to the alleles in reference Panel 0, if present, otherwise to reference Panel 1. This option pertains only to A/T and C/G SNPs, which it aligns such that Panel 2 and the alignment reference (Panel 0 or 1) have the same minor allele. NOTE: This flag can be used in conjunction with the -strand_g option. In that case, the information from the strand file takes precedence, i.e., the program will not try to align the strand of SNPs that have explicit strand info already. This is useful if you have strand information for some SNPs but not others. NOTE: You should take care when using this option. In particular, it can get the alignment wrong at A/T and C/G SNPs with minor allele frequencies near 50%, which can ..."
    inputBinding:
      position: 29
      prefix: '-align_by_maf_g'
  - id: align_by_maf_g_ref
    type:
      - 'null'
      - boolean
    doc: "Similar to -align_by_maf_g, but applies to the -g_ref file (Panel 1). In this case the strand is aligned to the alleles in Panel 0, so the flag does not work if Panel 0 was not provided (i.e., if you did not supply -l and -h files). NOTE: Just as -align_by_maf_g can be used in conjunction with -strand_g, this flag can be used in conjunction with the -strand_g_ref option. As before, the strand file takes precedence over aligning the strand by MAF. NOTE: As with -align_by_maf_g, you should be careful about using this option to align A/T and C/G SNPs with minor allele frequencies near 50%. This flag replaces -fix_strand_g_ref as of IMPUTE v2.2."
    inputBinding:
      position: 30
      prefix: '-align_by_maf_g_ref'
  - id: filt_rules_l
    type:
      - 'null'
      - type: array
        items: string
    doc: "This option provides flexible variant filtering in the reference panel via \"filter rules\", which are based on annotation columns in a -l file. Each column should be labeled by a contiguous string (no whitespace) describing its contents. For example, the Example/ directory in the software download packages includes a file named example.chr22.1kG.annot.legend that contains columns named eur.maf and afr.maf and TYPE. To filter variants based on the numeric annotation values in the -l file, you should combine a column string with a cutoff value and one of these six comparison operators: < <= > >= == != . For example, writing -filt_rules_l 'eur.maf<0.05' on the command line would tell the program to remove any variants with eur.maf values less than 0.05 from the reference panel. You can include an arbitrary number of filtering strings after the -filt_rules_l option, in which case the ..."
    inputBinding:
      position: 31
      prefix: '-filt_rules_l'
  - id: exclude_snps_g
    type:
      - 'null'
      - File
    doc: "List of SNPs to exclude from the -g file. The list should take the form of a single column of identifiers in a text file. The SNPs can be identified by their SNP IDs (first column of -g file), their rsIDs (second column of -g file), or their base pair positions (third column of -g file). Excluded SNPs will be treated as if they had not been present in the genotypes file, and they will not be shown in the output unless you use the -impute_excluded option."
    inputBinding:
      position: 32
      prefix: '-exclude_snps_g'
  - id: exclude_snps_g_ref
    type:
      - 'null'
      - File
    doc: "Same as -exclude_snps_g, but applies to the -g_ref file."
    inputBinding:
      position: 33
      prefix: '-exclude_snps_g_ref'
  - id: impute_excluded
    type:
      - 'null'
      - boolean
    doc: "Specifies that SNPs excluded from the study dataset via the -exclude_snps_g option should be imputed and included in the output file. When this flag is not activated, excluded SNPs are simply ignored."
    inputBinding:
      position: 34
      prefix: '-impute_excluded'
  - id: include_snps
    type:
      - 'null'
      - File
    doc: "List of reference-panel-only SNPs to impute. If you do not want the program to impute all of the reference SNPs in the region you are analyzing, you can use this list to specify a subset of SNPs to impute; all other SNPs will be ignored unless they have data in the -g file. The list should take the form of a single column of identifiers in a text file. The SNPs can be identified by their SNP IDs (first column of -g_ref file), their rsIDs (second column of -g_ref file or first column of -l file), or their base pair positions (third column of -g_ref file or second column of -l file). This option does not have any effect on SNPs in the -g file."
    inputBinding:
      position: 35
      prefix: '-include_snps'
  - id: sample_g
    type:
      - 'null'
      - File
    doc: "File of sample IDs for the individuals in the -g file; should follow the format described here. Only the first two columns are necessary, but they must be present and labeled \"ID_1\" and \"ID_2\". NOTE: Currently, the only reason to provide a sample file is if you want to exclude some individuals via the -exclude_samples_g option, or if you are analyzing chromosome X data via the -chrX option."
    inputBinding:
      position: 36
      prefix: '-sample_g'
  - id: sample_g_ref
    type:
      - 'null'
      - File
    doc: "Same as -sample_g, but applies to the -g_ref file."
    inputBinding:
      position: 37
      prefix: '-sample_g_ref'
  - id: exclude_samples_g
    type:
      - 'null'
      - File
    doc: "List of samples to exclude from the -g file. The list should take the form of a single column of identifiers in a text file. The samples can be identified by the IDs in either of the first two columns of the -sample_g file, which is REQUIRED if you want to use this option. Excluded samples will be treated as if they had not been present in the genotypes file, and the program will re-print the original sample list, minus the excluded samples, to a file named \"[-o]_samples\", where -o is the name of the main output file. NOTE: Part of the IMPUTE2 algorithm involves pooling information across the individuals in your study dataset. Samples with systematically aberrant genotypes (due, e.g., to degraded assay DNA) can confuse this part of the model; you should take care to identify such samples ahead of time and exclude them either manually or with this option."
    inputBinding:
      position: 38
      prefix: '-exclude_samples_g'
  - id: exclude_samples_g_ref
    type:
      - 'null'
      - File
    doc: "Same as -exclude_samples_g, but applies to the -g_ref file. One difference is that the program will not print a filtered list of -g_ref samples like the one that gets printed with -exclude_samples_g."
    inputBinding:
      position: 39
      prefix: '-exclude_samples_g_ref'
  - id: iter
    type:
      - 'null'
      - int
    doc: "Total number of MCMC iterations to perform, including burn-in. Increasing the number of iterations may improve accuracy slightly, although increasing -k generally leads to greater improvements for a fixed computational cost. (default: 30)"
    inputBinding:
      position: 40
      prefix: '-iter'
  - id: burnin
    type:
      - 'null'
      - int
    doc: "Number of MCMC iterations to discard as burn-in. The algorithm samples new haplotypes for unphased individuals during each of the first [-burnin] iterations, but these iterations do not contribute to the final imputation probabilities. We have found that 10 burn-in iterations is enough to ensure good results in a variety of different datasets. (default: 10)"
    inputBinding:
      position: 41
      prefix: '-burnin'
  - id: k_templates
    type:
      - 'null'
      - int
    doc: "Number of haplotypes (in the reference or study data) to use as templates when phasing observed genotypes. Increasing this value will lead to higher accuracy at the cost of longer running times, which scale quadratically with -k. The default value should be sufficient for most analyses. (default: 80)"
    inputBinding:
      position: 42
      prefix: '-k'
  - id: k_hap
    type:
      - 'null'
      - int
    doc: "Number of reference haplotypes to use as templates when imputing missing genotypes. As a rule of thumb, you should set -k_hap to the number of reference haplotypes that you expect to be useful for your study population. If this value is less than the total number of haplotypes in your reference panel, IMPUTE2 will choose a \"custom\" set of -k_hap haplotypes each time it imputes missing alleles in a study haplotype. If all of your reference haplotypes have similar ancestry to the subjects in your study, each haplotype is potentially useful for imputation, so the best accuracy can be achieved by setting -k_hap to the total number of reference haplotypes. Using smaller values will decrease the running time linearly while incurring a slight loss of accuracy. Conversely, we now recommend running IMPUTE2 with large reference panels containing haplotypes of diverse ancestry. (For more details, ... (default: 500)"
    inputBinding:
      position: 43
      prefix: '-k_hap'
  - id: prephase_g
    type:
      - 'null'
      - boolean
    doc: "Tells IMPUTE2 to phase the genotypes in the -g file. The estimated haplotypes are printed to a dedicated output file named \"[-o]_haps\", where [-o] is the name supplied for the main output file. To avoid edge effects in downstream imputation, IMPUTE2 will extend the estimated haplotypes into the buffer regions that flank the main region specified via -int."
    inputBinding:
      position: 44
      prefix: '-prephase_g'
  - id: use_prephased_g
    type:
      - 'null'
      - boolean
    doc: "Tells IMPUTE2 to perform imputation with pre-phased GWAS haplotypes, which must be supplied via a -known_haps_g file. This file will often be produced by a pre-phasing run that used -prephase_g on the same imputation interval (-int), although it may also come from a different phasing algorithm like SHAPEIT, which can print haplotypes in -known_haps_g format. We now recommend using SHAPEIT for pre-phasing and IMPUTE2 for downstream imputation."
    inputBinding:
      position: 45
      prefix: '-use_prephased_g'
  - id: merge_ref_panels
    type:
      - 'null'
      - boolean
    doc: "Tells the program to combine information across two reference panels using the approach described here."
    inputBinding:
      position: 46
      prefix: '-merge_ref_panels'
  - id: merge_ref_panels_output_ref
    type:
      - 'null'
      - string
    doc: "Activates -merge_ref_panels and tells the program to store the merged panel in two output files: a legend file named <file>.legend and a haplotype file named <file>.hap."
    inputBinding:
      position: 47
      prefix: '-merge_ref_panels_output_ref'
  - id: merge_ref_panels_output_gen
    type:
      - 'null'
      - string
    doc: "Activates -merge_ref_panels and tells the program to store the merged panel in .gen format in an output file named <file>.gen."
    inputBinding:
      position: 48
      prefix: '-merge_ref_panels_output_gen'
  - id: chrX
    type:
      - 'null'
      - boolean
    doc: "Specifies that this is an analysis of chromosome X data. This flag changes the model parameters by automatically reducing the -Ne value by 25%, and it allows the -g file to include a mixture of dizygous females and hemizygous males. When using the -chrX option, it is essential to provide a -sample_g file with a column named 'sex', since this tells the program which individuals are males and which are females. More details on the file formats for chromosome X analysis are available here, and you can see an example run here."
    inputBinding:
      position: 49
      prefix: '-chrX'
  - id: Xpar
    type:
      - 'null'
      - boolean
    doc: "Specifies that the current dataset comes from a pseudoautosomal region (PAR) of chromosome X, where both males and females are diploid. When used together with -chrX, this flag will reduce -Ne by 25% but otherwise run the analysis in the same way as on the autosomes."
    inputBinding:
      position: 50
      prefix: '-Xpar'
  - id: seed
    type:
      - 'null'
      - int
    doc: "Initial seed for random number generator. The seed is set using the system clock unless it is manually overridden with this option. (default: random)"
    inputBinding:
      position: 51
      prefix: '-seed'
  - id: no_warn
    type:
      - 'null'
      - boolean
    doc: "Turns warnings off, so that the -w file does not get printed."
    inputBinding:
      position: 52
      prefix: '-no_warn'
  - id: fill_holes
    type:
      - 'null'
      - boolean
    doc: "Turns on the \"hole-filling\" function, which allows SNPs that are typed in the -g file but not in the lowest reference panel to contribute to the inference."
    inputBinding:
      position: 53
      prefix: '-fill_holes'
  - id: no_remove
    type:
      - 'null'
      - boolean
    doc: "Prevents the program from discarding SNPs whose alleles cannot be aligned across panels. Such SNPs will be retained in the output, but they will not be used for inference."
    inputBinding:
      position: 54
      prefix: '-no_remove'
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: result_files
    type:
      type: array
      items: File
    doc: Main output file and the files written with the same basename (_info, _summary, _warnings, _info_by_sample).
    outputBinding:
      glob: $(inputs.output_file)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/impute2:2.3.2--1
stdout: impute2.out
