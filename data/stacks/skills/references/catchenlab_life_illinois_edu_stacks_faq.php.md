[![Stacks](/stacks/images/stacks_logo.png "Stacks")](/stacks)

## Frequently Asked Questions

1. [How should I cite the use of Stacks?](#cite)
2. [What are the requirements to run Stacks?](#reqs)
3. [What is the basic idea behind Stacks?](#basic)
4. [How do I optimize the various parameters in Stacks?](#param)
5. [Is there a protocol that I can follow for running Stacks?](#prot)
6. [Can Stacks handle double-digested data? How about combinatorial barcodes?](#dd)
7. [Can Stacks perform gapped alignments within and among samples?](#gap)
8. [Are previous versions of Stacks available?](#prev)
9. [Can Stacks quality-filter raw data? Or, how do I prepare data for the Stacks pipeline?](#filter)
10. [The restriction enzyme I used is not listed in the process\_radtags program. Will you add it?](#enz)
11. [What are the input and output data formats for Stacks?](#format)
12. [What do the fields mean in Stacks output files?](#fields)
13. [Can Stacks be run in Galaxy?](#galaxy)
14. [Does Stacks take advantage of sequencing quality scores?](#qual)

### How should I cite the use of Stacks?

Please cite one or both of these papers:
> J. Catchen, P. Hohenlohe, S. Bassham, A. Amores, and W. Cresko. *Stacks: an analysis tool set for
> population genomics*. **Molecular Ecology**. 2013.
> [[reprint](http://dx.doi.org/10.1111/mec.12354)]

> J. Catchen, A. Amores, P. Hohenlohe, W. Cresko, and J. Postlethwait. *Stacks: building and genotyping
> loci de novo from short-read sequences*. **G3: Genes, Genomes, Genetics**, 1:171-182, 2011.
> [[reprint](http://dx.doi.org/10.1534/g3.111.000240)]

### What are the requirements to run Stacks?

Stacks is written in C++ and can be built in any UNIX-like environment. To compile on Linux,
Stacks requires GCC version 4.9 or higher. The software will also build on Apple’s OS X,
which instead uses the [CLANG](http://clang.llvm.org/) compiler. Stacks relies on the
[OpenMP](http://openmp.org/wp/) libraries to run in multi-threaded mode.

### What is the basic idea behind Stacks?

Stacks is meant to track a set of loci, and the alleles present at those loci, in a population
of organisms. In the sense of small genetic distance, *population* could be interpreted as a
set of parents and the resulting progeny of a genetic cross for a linkage mapping analysis. In the
medium sense, *population* could be a set of related populations from a single species employing
a population genetic analysis, and in the large sense, *population* could be a set of closely
related species in a phylogenetic analysis.

#### Assembling loci in individuals

The genome of each individual in the population is sampled (e.g. using a restriction
enzyme, such as done in [RADseq](http://dx.doi.org/10.1371/journal.pone.0003376))
and then sequenced (typically using the Illumina platform, although the Ion Torrent platform is also used).
The sampled loci from each individual are then reassembled from the sequenced reads (creating Stacks!)
either *de novo* (using ustacks), or by first aligning them to a reference
genome and then assembling them using gstacks.

#### Creating a catalog of loci, spanning the whole population

Next, we need to synthesize the loci assembled independently in each individual into a single view of
all the loci and alleles present in the population. There is a trade off when constructing this
*catalog* of loci, each individual we add to the catalog will bring a small amount of error with
it, so we want to minimize the amount of error while capturing all the true loci segregating in the
population. Having a reference genome can simplfy this problem as it acts like a filter, excluding most
(but not all) of the error (and some of the true loci as well).

In a genetic cross, constructing the catalog is easily done by matching together the loci from the two
parents of the cross, since all the progeny will contain the same loci as the parents. In a set of
related populations from the same species, if we have a moderate number of individuals, we will add all
of them to the catalog. However, if we have hundreds or thousands of individuals, we may choose to only
add a fraction of indiviudals from each sub-population -- just enough to include (almost) all of the
loci segregating in the populations. In a phylogenetic analysis, where we have a small number of individuals
from a number of different species, we will likely have to add all individuals to the catalog to
maximize the number of shared loci found across the species. This process is implemented by
the cstacks program.

Finally, all individuals in the experiment are matched against the catalog (using
sstacks), resulting in a map of all the alleles present in the set of loci
sampled from across the population. Once the above process is completed, we can interpret the loci in a
number of different ways, without recalculating the above steps. So, the process is to run the components
of the main pipeline, and then once complete, we can repeatedly interpret them.
Using photography as a metaphor, first we develop the negative, then we can
print the photo from the negative using a number of different tools and filters.

#### Interpreting the loci in a biological context

For a genetic map, we interpret the loci as a set of markers, and export those markers that are mappable,
given a particualr cross design (different types of markers are mappable in an F0 cross versus an F2, for
example). This is done with the genotypes program.

Given a set of related populations, or closely related species, we use the populations
program to interpret the sampled loci. We can choose to filter the loci using a number of criteria, such as
how frequently they occur in the population, or based on properties such as heterozygosity. We can choose to
group the individuals in different ways, say by sampling location or phenotype, or exclude particular individuals.
Each grouping is defined by a *population map* and we can feed these different population maps to the
populations program to change how the set of individuals is being interpreted, and then
calculate summary statistics (such as FST or π) based on each of the different groupings. This is
very powerful because we don't have to change the set of loci the main pipeline defined, we just repeatedly run
populations using these tools to identify and hone the biological signal in our data. For each different frame we
define we can export sets of loci for further analysis, in programs like STRUCTURE, GenePop, Adegenet, or RaXML.

In the simplest case, we can use the wrapper programs, denovo\_map.pl and
ref\_map.pl to run the entire above process. Or, we can run all the components by hand
to customize exactly how the data are processed.

### How do I optimize the various parameters in Stacks?

There are several methods you can use, but we recommend optimizing parameters using the ***r80***
method. In this method you vary several *de novo* parameters and select those values which maximize the
number of polymorphic loci found in 80% of the individuals in your study. This process is outlined in the paper:

J. Paris, J. Stevens, & J. Catchen. *Lost in parameter space: a road map for Stacks*. **Methods in Ecology and Evolution** 2017.
[[reprint](http://doi.org/10.1111/2041-210X.12775)]

### Is there a protocol that I can follow for running Stacks?

Yes, we have published a protocol for running both the de novo and reference-based pipelines, including optimizing
assembly parameters, correcting data, and selecting the proper samples for the catalog. It can be found in Nature Protocols:

N. Rochette & J. Catchen. *Deriving genotypes from RAD-seq short-read data using Stacks*. **Nature Protocols**. 2017.
[[reprint](http://doi.org/10.1038/nprot.2017.123)]

### Can Stacks handle double-digested data? How about combinatorial barcodes?

Yes, Stacks can handle both types of input data. The process\_radtags program
will demultiplex these types of data and check and correct both single and double-digested restriction
enzyme cutsites. See the the process\_radtags
[documentation](/stacks/comp/process_radtags.php) for examples and
[the manual](/stacks/manual/#data) for additional information.

### Can Stacks perform gapped alignments within and among samples?

Yes! Support for gapped alignments was added in Stacks version 1.38.

### Are previous versions of Stacks available?

Although we recommend using the latest version of Stacks, sometimes bugs in the newer versions make
it necessary to revert to an older version. All the versions are still available on the website, here are a few:

* [stacks-1.19.tar.gz](http://catchenlab.life.illinois.edu/stacks/source/stacks-1.19.tar.gz)
* [stacks-1.23.tar.gz](http://catchenlab.life.illinois.edu/stacks/source/stacks-1.23.tar.gz)
* [stacks-1.27.tar.gz](http://catchenlab.life.illinois.edu/stacks/source/stacks-1.27.tar.gz)
* [stacks-1.29.tar.gz](http://catchenlab.life.illinois.edu/stacks/source/stacks-1.29.tar.gz)
* [stacks-1.37.tar.gz](http://catchenlab.life.illinois.edu/stacks/source/stacks-1.37.tar.gz)
* **This is the final version 1 release:** [stacks-1.48.tar.gz](http://catchenlab.life.illinois.edu/stacks/source/stacks-1.48.tar.gz)

### Can Stacks quality-filter raw data? Or, how do I prepare data for the Stacks pipeline?

Yes, Stacks uses a sliding-window quality filtering algorithm that allows for isolated low-quality base calls
while discarding reads that show a degenerating quality level across the read length. The program will
also demultiplex data according to a set of barcodes and check for the presence of a restriction enzyme cutsite
-- for both single and double-digested data. The process\_radtags program can process
a number of different file formats including single and paired-end data in FASTQ format (gzipped or not), as
well as in FASTA or BAM format. It can also handle inline barcodes or Illumina barcode indexes as well as
combinatorial barcodes. The process\_radtags program can also filter adapter seqeunce
from raw reads while allowing for sequencing error in the adapter sequence. Lots of examples for processing
different file formats can be found with the process\_radtags
[documentation](/stacks/comp/process_radtags.php).

### The restriction enzyme I used is not listed in the process\_radtags program. Will you add it?

Yes! We are happy to add restriction enzymes to the process\_radtags program.
However, we ask that in exchange for adding it you will be willing to try it out on your data and let
us know that it is working correctly. We could simply add all the restriction enzymes available, but
we want to make sure the code works right and we don’t have access to all those types of data.

In addition, you can specify the --disable\_rad\_check flag to the
process\_radtags program to stop it from checking the integrity of the RAD
site. Of course, this will affect the quality of the data input to Stacks.

### What are the input and output data formats for Stacks?

In the *de novo* case, data is read by the ustacks program
and it currently can read either FASTA, FASTQ, or BAM formats. When a reference genome is available, aligned
data is read by the gstacks program and either
[SAM](http://www.htslib.org/doc/samtools.html) or BAM
formats can be input.

The populations program can output SNP locations in the
[VCF](http://www.1000genomes.org/node/101) format. It will also generate summary statistics
and compute population genetic measures such as π, heterozygosity, FIS within populations and FST between
populations, and these data will be exported in tab-separated format. It can also output data
formatted for the [GenePop](http://genepop.curtin.edu.au/) program, for
[Structure](http://pritchardlab.stanford.edu/structure.html), as well as for standard phylogenetic programs
that can read [Phylip](http://evolution.genetics.washington.edu/phylip/doc/sequence.html) files. The
populations program can also output the alleles from each locus in each individual as a set
of FASTA sequences and it can output data for a number of phasing programs such as
[PHASE](http://stephenslab.uchicago.edu/software.html#phase),
[fastPHASE](http://stephenslab.uchicago.edu/software.html#fastphase),
[Beagle](http://faculty.washington.edu/browning/beagle/beagle.html), and
[Plink](http://pngu.mgh.harvard.edu/~purcell/plink/).

### What do the fields mean in Stacks output files?

See the *Stacks* [manual](/stacks/manual/index.php#files).

### Can Stacks be run in Galaxy?

Yes! Support for Stacks in [Galaxy](http://galaxyproject.org/) has been kindly added by Yvan Le Bras. You can
find more information on how to set it up [here](https://www.e-biogenouest.org/groups/guggo/wiki/StacksToolsuite).

### Does Stacks take advantage of sequencing quality scores?

No, however, Stacks expects data to be strenuously filtered prior to running the pipeline.