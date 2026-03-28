### Navigation

* [index](genindex.html "General Index")
* [next](cli.html "Command Line Interface") |
* [previous](devel.html "Development Manual") |
* [mhpl8r](index.html) »
* Python API Reference

# Python API Reference[¶](#python-api-reference "Permalink to this heading")

**NOTE**: The MicroHapulator Python API is under [Semantic Versioning](https://semver.org/).
In brief, this means that every stable version of the MicroHapulator software is assigned a version number, and that any changes to the software's behavior or interface require the software version number to be updated in prescribed and predictable ways.

## Haplotype calling[¶](#haplotype-calling "Permalink to this heading")

microhapulator.api.type(*bamfile*, *markertsv*, *minbasequal=10*, *max\_depth=1000000.0*)[¶](#microhapulator.api.type "Permalink to this definition")
:   Perform haplotype calling

    Parameters:
    :   * **bamfile** (*str*) -- path of a BAM file containing NGS reads aligned to marker reference sequences and sorted
        * **markertsv** (*str*) -- path of a TSV file containing marker metadata, specifically the offset of each SNP for every marker in the panel
        * **minbasequal** (*int*) -- minimum base quality (PHRED score) to be considered reliable for haplotype calling; default is 10, corresponding to Q10, i.e., 90% probability that the base call is correct
        * **max\_depth** (*float*) -- maximum permitted read depth

    Returns:
    :   an unfiltered catalog of haplotype counts for each marker (a *typing result*)

    Return type:
    :   microhapulator.profile.TypingResult

microhapulator.profile.TypingResult.filter(*self*, *thresholds*)[¶](#microhapulator.profile.TypingResult.filter "Permalink to this definition")
:   Apply static and/or dynamic thresholds to distinguish true and false haplotypes

    Thresholds are applied to the haplotype read counts of a raw typing result. Static integer
    thresholds are commonly used as detection thresholds, below which any haplotype count is
    considered noise. Dynamic thresholds are commonly used as analytical thresholds and
    represent a percentage of the total read count at the marker, after any haplotypes failing
    a static threshold are discarded.

    Parameters:
    :   **thresholds** (*ThresholdIndex*) -- data structure containing static and dynamic thresholds

## Analysis, QA/QC, and interpretation[¶](#analysis-qa-qc-and-interpretation "Permalink to this heading")

microhapulator.api.read\_length\_dist(*lengthfiles*, *plotfile*, *samples*, *hspace=-0.7*, *xlabel='Read Length (bp)'*, *color=None*, *edgecolor=None*)[¶](#microhapulator.api.read_length_dist "Permalink to this definition")
:   Plot distribution of read lengths

    Parameters:
    :   * **lengthsfiles** (*list*) -- list of JSON files containing read lengths for each sample
        * **plotfile** (*str*) -- path of a graphic file to create
        * **xlabel** (*str*) -- label for the X axis
        * **title** (*str*) -- title for the plot
        * **color** (*str*) -- override histogram plot color; red by default
        * **edgecolor** (*str*) -- override histogram edge color; black by default

microhapulator.api.interlocus\_balance(*result*, *include\_discarded=True*, *terminal=True*, *tofile=None*, *title=None*, *figsize=(6, 4)*, *dpi=200*, *color=None*)[¶](#microhapulator.api.interlocus_balance "Permalink to this definition")
:   Compute interlocus balance

    Plot interlocus balance in the terminal and/or a high-resolution graphic. Also normalize read
    counts and perform a chi-square goodness-of-fit test assuming uniform read coverage across
    markers. The reported chi-square statistic measures the extent of imbalance, and can be compared
    among samples sequenced using the same panel: the minimum value of 0 represents perfectly
    uniform coverage, while the maximum value of *D* occurs when all reads map to a single marker
    (*D* represents the degrees of freedom, or the number of markers minus 1).

    Parameters:
    :   * **result** (*microhapulator.profile.TypingResult*) -- a typing result including haplotype counts
        * **included\_discarded** (*bool*) -- flag indicating whether to include in each marker's total read count reads that are successfully aligned but discarded because they do not span all SNPs at the marker
        * **terminal** (*bool*) -- flag indicating whether to print the interlocus balance histogram to standard output; enabled by default
        * **tofile** (*str*) -- name of image file to which the interlocus balance histogram will be written using Matplotlib; image format is inferred from file extension; by default, no image file is generated
        * **title** (*str*) -- add a title (such as a sample name) to the histogram plot
        * **figsize** (*tuple*) -- a 2-tuple of integers indicating the dimensions of the image file to be generated
        * **dpi** (*int*) -- resolution (in dots per inch) of the image file to be generated
        * **color** (*str*) -- override histogram plot color; green by default

    Returns:
    :   a tuple (S, C) where S is the chi-square statistic, and C is a table of total read counts for each marker

    Return type:
    :   tuple(float, pandas.DataFrame)

microhapulator.api.plot\_haplotype\_calls(*result*, *outdir*, *sample=None*, *plot\_marker\_name=True*, *ignore\_low=True*)[¶](#microhapulator.api.plot_haplotype_calls "Permalink to this definition")
:   Plot haplotype calls for each marker in a typing result

    Parameters:
    :   * **result** (*microhapulator.profile.TypingResult*) -- a typing result
        * **outdir** (*Path*) -- Path object or string indicating the directory to which the graphics files will be saved
        * **sample** (*str*) -- name of the sample to be included as the plot title; by default no sample name is shown
        * **plot\_marker\_name** (*boolean*) -- flag indicating whether to plot the marker name as subtitle
        * **ignore\_low** (*boolean*) -- flag indicating whether to exclude haplotypes that fall below the detection threshold (when provided)

microhapulator.api.heterozygote\_balance(*result*, *tofile=None*, *title=None*, *figsize=None*, *dpi=200*, *dolabels=False*, *absolute=False*)[¶](#microhapulator.api.heterozygote_balance "Permalink to this definition")
:   Compute heterozygote balance

    Compute absolute and relative abundance of major and minor alleles at heterozygote loci and plot
    abundances in a high-resolution graphic. Also perform a one-sided paired t-test and report the
    t-statistic as a measure of heterozygote imbalance.

    Graphics implementation adapted from
    <https://www.pythoncharts.com/matplotlib/grouped-bar-charts-matplotlib/>.

    Parameters:
    :   * **result** (*microhapulator.profile.TypingResult*) -- a filtered typing result including haplotype counts and genotype calls
        * **tofile** (*str*) -- name of image file to which the interlocus balance histogram will be written using Matplotlib; image format is inferred from file extension; by default, no image file is generated
        * **title** (*str*) -- add a title (such as a sample name) to the histogram plot
        * **figsize** (*tuple*) -- a 2-tuple of integers indicating the dimensions of the image file to be generated
        * **dpi** (*int*) -- resolution (in dots per inch) of the image file to be generated
        * **dolabels** (*bool*) -- flag indicating whether marker labels and read counts should be added to the figure
        * **absolute** (*bool*) -- plot absolute read counts rather than relative abundances

    Returns:
    :   a tuple (T, C) where T is the t-statistic, and C is the table of read counts and percentages for each heterozygous marker

    Return type:
    :   pandas.DataFrame

microhapulator.api.contrib(*profile*)[¶](#microhapulator.api.contrib "Permalink to this definition")
:   Estimate the minimum number of DNA contributors to a suspected mixture

    Let \(N\_{\text{al}}\) represent the largest number of haplotypes observed at any marker. We
    then estimate the minimum number of DNA contributors as follows.

    \(C\_{\text{min}} = \left\lceil\frac{N\_{\text{al}}}{2}\right\rceil\)

    Parameters:
    :   **profile** (*microhapulator.profile.Profile*) -- a typing result or a simulated genotype

    Returns:
    :   a tuple (E, N, P), where E is the estimate for the minimum number of DNA contributors, N is the number of markers supporting the estimate, and P is the percentage of markers supporting the estimate

    Return type:
    :   tuple(int, int, float)

microhapulator.api.prob(*frequencies*, *prof1*, *prof2=None*, *erate=0.01*)[¶](#microhapulator.api.prob "Permalink to this definition")
:   Compute a profile random match probability (RMP) or an RMP-based likelihood ratio (LR) test

    The LR test, when performed, assesses the relative weight of two competing propositions.

    * \(H\_1\): the genetic profiles *prof1* and *prof2* originated from the same individuals
    * \(H\_2\): *prof1* and *prof2* originated from two unrelated individuals in the population

    The test statistic is computed as follows.

    \[LR = \frac{P(H\_1)}{P(H\_2)}\]

    The probability \(P(H\_1) = \epsilon^R\), where \(\epsilon\) is the per-marker rate of
    genotyping error (*erate*) and \(R\) is the number of markers with discordant genotypes
    between profiles. The probability \(P(H\_2)\) is the RMP of *prof1*. Note that when there is
    a perfect match between *prof1* and *prof2*, \(P(H\_1) = 1\) and the LR statistic is simply
    the reciprocal of the RMP.

    Note that the LR test as formulated assumes that *prof1* and *prof2* are close matches. The
    error rate accommodates a small amount of allelic drop-out or drop-in but is not designed to
    accommodate profiles with substantial differences.

    Parameters:
    :   * **frequencies** (*pandas.DataFrame*) -- table of population haplotype frequencies
        * **prof1** (*microhapulator.profile.Profile*) -- a typing result or simulated genotype
        * **prof2** (*microhapulator.profile.Profile*) -- a typing result or simulated genotype; *optional*
        * **erate** (*float*) -- rate of genotyping error

    Returns:
    :   the RMP of prof1 if prof2 is undefined, or the LR test statistic if prof2 is defined

    Return type:
    :   float

microhapulator.api.diff(*prof1*, *prof2*)[¶](#microhapulator.api.diff "Permalink to this definition")
:   Compare two profiles and determine the markers at which their genotypes differ

    Note: this is a generator function.

    Parameters:
    :   * **prof1** (*microhapulator.profile.Profile*) -- typing result or simulated profile
        * **prof2** (*microhapulator.profile.Profile*) -- typing result or simulated profile

    Yields:
    :   for each discordant marker, a tuple (M, X, Y), where M is the marker name, X is the set of haplotypes unique to *prof1*, and Y is the set of haplotypes unique to *prof2*

microhapulator.api.dist(*prof1*, *prof2*)[¶](#microhapulator.api.dist "Permalink to this definition")
:   Compute a simple Hamming distance between two profiles

    Parameters:
    :   * **prof1** (*microhapulator.profile.Profile*) -- typing result or simulated profile
        * **prof2** (*microhapulator.profile.Profile*) -- typing result or simulated profile

    Returns:
    :   the number of markers with a discordant genotype between the two profiles

    Return type:
    :   int

microhapulator.api.contain(*prof1*, *prof2*)[¶](#microhapulator.api.contain "Permalink to this definition")
:   Perform a simple containment test

    Calculate a simple containment statistic C, representing the number of markers whose haplotypes
    in *prof1* are a subset of the haplotypes in *prof2*. Dividing by the total number of markers
    provides a rudimentary measure of containment, the proportion of *prof1* "contained" in
    *prof2*. Note that this statistic does not accommodate allelic drop-in or drop-out.

    Parameters:
    :   * **prof1** (*microhapulator.profile.Profile*) -- a typing result or simulated genotype
        * **prof2** (*microhapulator.profile.Profile*) -- a typing result or simulated genotype

    Returns:
    :   a tuple (C, T), where C is the containment statistic and T is the total number of markers

    Return type:
    :   tuple(float, int)

## Simulation[¶](#simulation "Permalink to this heading")

microhapulator.api.sim(*frequencies*, *seed=None*)[¶](#microhapulator.api.sim "Permalink to this definition")
:   Simulate a diploid genotype from the specified microhaplotype frequencies

    Parameters:
    :   * **frequencies** (*pandas.DataFrame*) -- population haplotype frequencies
        * **seed** (*int*) -- seed for random number generator

    Returns:
    :   a simulated genotype profile for all markers specified in the haplotype frequencies

    Return type:
    :   microhapulator.profile.SimulatedProfile

microhapulator.profile.SimulatedProfile.merge(*profiles*)[¶](#microhapulator.profile.SimulatedProfile.merge "Permalink to this definition")
:   Combine simulated profiles into a mock DNA mixture

    Parameters:
    :   **profiles** (*list*) -- list of simulated profiles

    Returns:
    :   a combined profile

    Return type:
    :   microhapulator.profile.SimulatedProfile

microhapulator.profile.Profile.unite(*mom*, *dad*)[¶](#microhapulator.profile.Profile.unite "Permalink to this definition")
:   Simulate the creation of a new profile from a mother and father

    Parameters:
    :   * **mom** (*microhapulator.profile.Profile*) -- typing result or simulated profile
        * **dad** (*microhapulator.profile.Profile*) -- typing result or simulated profile

    Returns:
    :   a simulated offspring

    Return type:
    :   microhapulator.profile.SimulatedProfile

microhapulator.api.seq(*profiles*, *mhindex*, *seeds=None*, *threads=1*, *totalreads=500000*, *proportions=None*, *sig=None*)[¶](#microhapulator.api.seq "Permalink to this definition")
:   Simulate paired-end Illumina MiSeq sequencing of the given profile(s)

    This generator function accepts any combination of simple (single-source) or complex
    (multi-source mixture) profiles as input. Each profile is "sequenced" separately, and then all
    reads are aggregated.

    Parameters:
    :   * **profiles** (*list*) -- list of mock profiles
        * **mhindex** (*MicrohapIndex*) -- an index containing microhap marker definitions and reference sequences
        * **seeds** (*list*) -- optional list of random seeds, one per profile
        * **threads** (*int*) -- number of threads to use for each sequencing task; note that optimal performance is typically achieved with a single thread
        * **totalreads** (*int*) -- total number of reads to generate across all profiles
        * **proportions** (*list*) -- optional list of relative proportions, equal to the number of profiles; by default, each profile contributes an equal nu