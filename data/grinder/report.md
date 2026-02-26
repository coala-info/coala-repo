# grinder CWL Generation Report

## grinder

### Tool Description
Generates simulated shotgun or amplicon sequencing reads from reference sequences.

### Metadata
- **Docker Image**: biocontainers/grinder:v0.5.4-5-deb_cv1
- **Homepage**: https://github.com/rcoh/angle-grinder
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/grinder/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/rcoh/angle-grinder
- **Stars**: N/A
### Original Help Text
```text
Usage:
           grinder -rf <reference_file> | -reference_file <reference_file> | -gf <reference_file> | -genome_file <reference_file> [cli optional arguments]
           grinder --help
           grinder --man
           grinder --usage
           grinder --version

Cli required arguments:
    -rf <reference_file> | -reference_file <reference_file> | -gf
    <reference_file> | -genome_file <reference_file>
        FASTA file that contains the input reference sequences (full
        genomes, 16S rRNA genes, transcripts, proteins...) or '-' to read
        them from the standard input. See the README file for examples of
        databases you can use and where to get them from. Default: -

Cli optional arguments:
    -tr <total_reads> | -total_reads <total_reads>
        Number of shotgun or amplicon reads to generate for each library. Do
        not specify this if you specify the fold coverage. Default: 100

    -cf <coverage_fold> | -coverage_fold <coverage_fold>
        Desired fold coverage of the input reference sequences (the output
        FASTA length divided by the input FASTA length). Do not specify this
        if you specify the number of reads directly.

    -rd <read_dist>... | -read_dist <read_dist>...
        Desired shotgun or amplicon read length distribution specified as:
        average length, distribution ('uniform' or 'normal') and standard
        deviation.

        Only the first element is required. Examples:

          All reads exactly 101 bp long (Illumina GA 2x): 101
          Uniform read distribution around 100+-10 bp: 100 uniform 10
          Reads normally distributed with an average of 800 and a standard deviation of 100
            bp (Sanger reads): 800 normal 100
          Reads normally distributed with an average of 450 and a standard deviation of 50
            bp (454 GS-FLX Ti): 450 normal 50

        Reference sequences smaller than the specified read length are not
        used. Default: 100

    -id <insert_dist>... | -insert_dist <insert_dist>...
        Create paired-end or mate-pair reads spanning the given insert
        length. Important: the insert is defined in the biological sense,
        i.e. its length includes the length of both reads and of the stretch
        of DNA between them: 0 : off, or: insert size distribution in bp, in
        the same format as the read length distribution (a typical value is
        2,500 bp for mate pairs) Two distinct reads are generated whether or
        not the mate pair overlaps. Default: 0

    -mo <mate_orientation> | -mate_orientation <mate_orientation>
        When generating paired-end or mate-pair reads (see <insert_dist>),
        specify the orientation of the reads (F: forward, R: reverse):

           FR:  ---> <---  e.g. Sanger, Illumina paired-end, IonTorrent mate-pair
           FF:  ---> --->  e.g. 454
           RF:  <--- --->  e.g. Illumina mate-pair
           RR:  <--- <---

        Default: FR

    -ec <exclude_chars> | -exclude_chars <exclude_chars>
        Do not create reads containing any of the specified characters (case
        insensitive). For example, use 'NX' to prevent reads with
        ambiguities (N or X). Grinder will error if it fails to find a
        suitable read (or pair of reads) after 10 attempts. Consider using
        <delete_chars>, which may be more appropriate for your case.
        Default: ''

    -dc <delete_chars> | -delete_chars <delete_chars>
        Remove the specified characters from the reference sequences
        (case-insensitive), e.g. '-~*' to remove gaps (- or ~) or terminator
        (*). Removing these characters is done once, when reading the
        reference sequences, prior to taking reads. Hence it is more
        efficient than <exclude_chars>. Default:

    -fr <forward_reverse> | -forward_reverse <forward_reverse>
        Use DNA amplicon sequencing using a forward and reverse PCR primer
        sequence provided in a FASTA file. The reference sequences and their
        reverse complement will be searched for PCR primer matches. The
        primer sequences should use the IUPAC convention for degenerate
        residues and the reference sequences that that do not match the
        specified primers are excluded. If your reference sequences are full
        genomes, it is recommended to use <copy_bias> = 1 and <length_bias>
        = 0 to generate amplicon reads. To sequence from the forward strand,
        set <unidirectional> to 1 and put the forward primer first and
        reverse primer second in the FASTA file. To sequence from the
        reverse strand, invert the primers in the FASTA file and use
        <unidirectional> = -1. The second primer sequence in the FASTA file
        is always optional. Example: AAACTYAAAKGAATTGRCGG and
        ACGGGCGGTGTGTRC for the 926F and 1392R primers that target the V6 to
        V9 region of the 16S rRNA gene.

    -un <unidirectional> | -unidirectional <unidirectional>
        Instead of producing reads bidirectionally, from the reference
        strand and its reverse complement, proceed unidirectionally, from
        one strand only (forward or reverse). Values: 0 (off, i.e.
        bidirectional), 1 (forward), -1 (reverse). Use <unidirectional> = 1
        for amplicon and strand-specific transcriptomic or proteomic
        datasets. Default: 0

    -lb <length_bias> | -length_bias <length_bias>
        In shotgun libraries, sample reference sequences proportionally to
        their length. For example, in simulated microbial datasets, this
        means that at the same relative abundance, larger genomes contribute
        more reads than smaller genomes (and all genomes have the same fold
        coverage). 0 = no, 1 = yes. Default: 1

    -cb <copy_bias> | -copy_bias <copy_bias>
        In amplicon libraries where full genomes are used as input, sample
        species proportionally to the number of copies of the target gene:
        at equal relative abundance, genomes that have multiple copies of
        the target gene contribute more amplicon reads than genomes that
        have a single copy. 0 = no, 1 = yes. Default: 1

    -md <mutation_dist>... | -mutation_dist <mutation_dist>...
        Introduce sequencing errors in the reads, under the form of
        mutations (substitutions, insertions and deletions) at positions
        that follow a specified distribution (with replacement): model
        (uniform, linear, poly4), model parameters. For example, for a
        uniform 0.1% error rate, use: uniform 0.1. To simulate Sanger
        errors, use a linear model where the errror rate is 1% at the 5' end
        of reads and 2% at the 3' end: linear 1 2. To model Illumina errors
        using the 4th degree polynome 3e-3 + 3.3e-8 * i^4 (Korbel et al
        2009), use: poly4 3e-3 3.3e-8. Use the <mutation_ratio> option to
        alter how many of these mutations are substitutions or indels.
        Default: uniform 0 0

    -mr <mutation_ratio>... | -mutation_ratio <mutation_ratio>...
        Indicate the percentage of substitutions and the number of indels
        (insertions and deletions). For example, use '80 20' (4
        substitutions for each indel) for Sanger reads. Note that this
        parameter has no effect unless you specify the <mutation_dist>
        option. Default: 80 20

    -hd <homopolymer_dist> | -homopolymer_dist <homopolymer_dist>
        Introduce sequencing errors in the reads under the form of
        homopolymeric stretches (e.g. AAA, CCCCC) using a specified model
        where the homopolymer length follows a normal distribution N(mean,
        standard deviation) that is function of the homopolymer length n:

          Margulies: N(n, 0.15 * n)              ,  Margulies et al. 2005.
          Richter  : N(n, 0.15 * sqrt(n))        ,  Richter et al. 2008.
          Balzer   : N(n, 0.03494 + n * 0.06856) ,  Balzer et al. 2010.

        Default: 0

    -cp <chimera_perc> | -chimera_perc <chimera_perc>
        Specify the percent of reads in amplicon libraries that should be
        chimeric sequences. The 'reference' field in the description of
        chimeric reads will contain the ID of all the reference sequences
        forming the chimeric template. A typical value is 10% for amplicons.
        This option can be used to generate chimeric shotgun reads as well.
        Default: 0 %

    -cd <chimera_dist>... | -chimera_dist <chimera_dist>...
        Specify the distribution of chimeras: bimeras, trimeras, quadrameras
        and multimeras of higher order. The default is the average values
        from Quince et al. 2011: '314 38 1', which corresponds to 89% of
        bimeras, 11% of trimeras and 0.3% of quadrameras. Note that this
        option only takes effect when you request the generation of chimeras
        with the <chimera_perc> option. Default: 314 38 1

    -ck <chimera_kmer> | -chimera_kmer <chimera_kmer>
        Activate a method to form chimeras by picking breakpoints at places
        where k-mers are shared between sequences. <chimera_kmer> represents
        k, the length of the k-mers (in bp). The longer the kmer, the more
        similar the sequences have to be to be eligible to form chimeras.
        The more frequent a k-mer is in the pool of reference sequences
        (taking into account their relative abundance), the more often this
        k-mer will be chosen. For example, CHSIM (Edgar et al. 2011) uses
        this method with a k-mer length of 10 bp. If you do not want to use
        k-mer information to form chimeras, use 0, which will result in the
        reference sequences and breakpoints to be taken randomly on the
        "aligned" reference sequences. Note that this option only takes
        effect when you request the generation of chimeras with the
        <chimera_perc> option. Also, this options is quite memory intensive,
        so you should probably limit yourself to a relatively small number
        of reference sequences if you want to use it. Default: 10 bp

    -af <abundance_file> | -abundance_file <abundance_file>
        Specify the relative abundance of the reference sequences manually
        in an input file. Each line of the file should contain a sequence
        name and its relative abundance (%), e.g. 'seqABC 82.1' or 'seqABC
        82.1 10.2' if you are specifying two different libraries.

    -am <abundance_model>... | -abundance_model <abundance_model>...
        Relative abundance model for the input reference sequences: uniform,
        linear, powerlaw, logarithmic or exponential. The uniform and linear
        models do not require a parameter, but the other models take a
        parameter in the range [0, infinity). If this parameter is not
        specified, then it is randomly chosen. Examples:

          uniform distribution: uniform
          powerlaw distribution with parameter 0.1: powerlaw 0.1
          exponential distribution with automatically chosen parameter: exponential

        Default: uniform 1

    -nl <num_libraries> | -num_libraries <num_libraries>
        Number of independent libraries to create. Specify how diverse and
        similar they should be with <diversity>, <shared_perc> and
        <permuted_perc>. Assign them different MID tags with
        <multiplex_mids>. Default: 1

    -mi <multiplex_ids> | -multiplex_ids <multiplex_ids>
        Specify an optional FASTA file that contains multiplex sequence
        identifiers (a.k.a MIDs or barcodes) to add to the sequences (one
        sequence per library, in the order given). The MIDs are included in
        the length specified with the -read_dist option and can be altered
        by sequencing errors. See the MIDesigner or BarCrawl programs to
        generate MID sequences.

    -di <diversity>... | -diversity <diversity>...
        This option specifies alpha diversity, specifically the richness,
        i.e. number of reference sequences to take randomly and include in
        each library. Use 0 for the maximum richness possible (based on the
        number of reference sequences available). Provide one value to make
        all libraries have the same diversity, or one richness value per
        library otherwise. Default: 0

    -sp <shared_perc> | -shared_perc <shared_perc>
        This option controls an aspect of beta-diversity. When creating
        multiple libraries, specify the percent of reference sequences they
        should have in common (relative to the diversity of the least
        diverse library). Default: 0 %

    -pp <permuted_perc> | -permuted_perc <permuted_perc>
        This option controls another aspect of beta-diversity. For multiple
        libraries, choose the percent of the most-abundant reference
        sequences to permute (randomly shuffle) the rank-abundance of.
        Default: 100 %

    -rs <random_seed> | -random_seed <random_seed>
        Seed number to use for the pseudo-random number generator.

    -dt <desc_track> | -desc_track <desc_track>
        Track read information (reference sequence, position, errors, ...)
        by writing it in the read description. Default: 1

    -ql <qual_levels>... | -qual_levels <qual_levels>...
        Generate basic quality scores for the simulated reads. Good residues
        are given a specified good score (e.g. 30) and residues that are the
        result of an insertion or substitution are given a specified bad
        score (e.g. 10). Specify first the good score and then the bad score
        on the command-line, e.g.: 30 10. Default:

    -fq <fastq_output> | -fastq_output <fastq_output>
        Whether to write the generated reads in FASTQ format (with
        Sanger-encoded quality scores) instead of FASTA and QUAL or not (1:
        yes, 0: no). <qual_levels> need to be specified for this option to
        be effective. Default: 0

    -bn <base_name> | -base_name <base_name>
        Prefix of the output files. Default: grinder

    -od <output_dir> | -output_dir <output_dir>
        Directory where the results should be written. This folder will be
        created if needed. Default: .

    -pf <profile_file> | -profile_file <profile_file>
        A file that contains Grinder arguments. This is useful if you use
        many options or often use the same options. Lines with comments (#)
        are ignored. Consider the profile file, 'simple_profile.txt':

          # A simple Grinder profile
          -read_dist 105 normal 12
          -total_reads 1000

        Running: grinder -reference_file viral_genomes.fa -profile_file
        simple_profile.txt

        Translates into: grinder -reference_file viral_genomes.fa -read_dist
        105 normal 12 -total_reads 1000

        Note that the arguments specified in the profile should not be
        specified again on the command line.
```

