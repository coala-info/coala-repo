[phyluce](../index.html)

Contents:

* [Purpose](../purpose.html)
* [Installation](../installation.html)
* [Phyluce Tutorials](../tutorials/index.html)
* [Phyluce in Daily Use](index.html)
  + [Quality Control](daily-use-1-quality-control.html)
  + [Assembly](daily-use-2-assembly.html)
  + [UCE Processing for Phylogenomics](daily-use-3-uce-processing.html)
  + [Workflows](daily-use-4-workflows.html)
  + List of Phyluce Programs
    - [Assembly](#assembly)
      * [phyluce\_assembly\_assemblo\_abyss](#phyluce-assembly-assemblo-abyss)
      * [phyluce\_assembly\_assemblo\_spades](#phyluce-assembly-assemblo-spades)
      * [phyluce\_assembly\_assemblo\_velvet](#phyluce-assembly-assemblo-velvet)
      * [phyluce\_assembly\_explode\_get\_fastas\_file](#phyluce-assembly-explode-get-fastas-file)
      * [phyluce\_assembly\_extract\_contigs\_to\_barcodes](#phyluce-assembly-extract-contigs-to-barcodes)
      * [phyluce\_assembly\_get\_bed\_from\_lastz](#phyluce-assembly-get-bed-from-lastz)
      * [phyluce\_assembly\_get\_fasta\_lengths](#phyluce-assembly-get-fasta-lengths)
      * [phyluce\_assembly\_get\_fastas\_from\_match\_counts](#phyluce-assembly-get-fastas-from-match-counts)
      * [phyluce\_assembly\_get\_fastq\_lengths](#phyluce-assembly-get-fastq-lengths)
      * [phyluce\_assembly\_get\_match\_counts](#phyluce-assembly-get-match-counts)
      * [phyluce\_assembly\_match\_contigs\_to\_barcodes](#phyluce-assembly-match-contigs-to-barcodes)
      * [phyluce\_assembly\_match\_contigs\_to\_probes](#phyluce-assembly-match-contigs-to-probes)
      * [phyluce\_assembly\_screen\_probes\_for\_dupes](#phyluce-assembly-screen-probes-for-dupes)
    - [Alignment](#alignment)
      * [phyluce\_align\_add\_missing\_data\_designators](#phyluce-align-add-missing-data-designators)
      * [phyluce\_align\_concatenate\_alignments](#phyluce-align-concatenate-alignments)
      * [phyluce\_align\_convert\_degen\_bases](#phyluce-align-convert-degen-bases)
      * [phyluce\_align\_convert\_one\_align\_to\_another](#phyluce-align-convert-one-align-to-another)
      * [phyluce\_align\_explode\_alignments](#phyluce-align-explode-alignments)
      * [phyluce\_align\_extract\_taxa\_from\_alignments](#phyluce-align-extract-taxa-from-alignments)
      * [phyluce\_align\_extract\_taxon\_fasta\_from\_alignments](#phyluce-align-extract-taxon-fasta-from-alignments)
      * [phyluce\_align\_filter\_alignments](#phyluce-align-filter-alignments)
      * [phyluce\_align\_format\_concatenated\_phylip\_for\_paml](#phyluce-align-format-concatenated-phylip-for-paml)
      * [phyluce\_align\_get\_align\_summary\_data](#phyluce-align-get-align-summary-data)
      * [phyluce\_align\_get\_gblocks\_trimmed\_alignments\_from\_untrimmed](#phyluce-align-get-gblocks-trimmed-alignments-from-untrimmed)
      * [phyluce\_align\_get\_incomplete\_matrix\_estimates](#phyluce-align-get-incomplete-matrix-estimates)
      * [phyluce\_align\_get\_informative\_sites](#phyluce-align-get-informative-sites)
      * [phyluce\_align\_get\_only\_loci\_with\_min\_taxa](#phyluce-align-get-only-loci-with-min-taxa)
      * [phyluce\_align\_get\_ry\_recoded\_alignments](#phyluce-align-get-ry-recoded-alignments)
      * [phyluce\_align\_get\_smilogram\_from\_alignments](#phyluce-align-get-smilogram-from-alignments)
      * [phyluce\_align\_get\_taxon\_locus\_counts\_in\_alignments](#phyluce-align-get-taxon-locus-counts-in-alignments)
      * [phyluce\_align\_get\_trimal\_trimmed\_alignments\_from\_untrimmed](#phyluce-align-get-trimal-trimmed-alignments-from-untrimmed)
      * [phyluce\_align\_get\_trimmed\_alignments\_from\_untrimmed](#phyluce-align-get-trimmed-alignments-from-untrimmed)
      * [phyluce\_align\_move\_align\_by\_conf\_file](#phyluce-align-move-align-by-conf-file)
      * [phyluce\_align\_randomly\_sample\_and\_concatenate](#phyluce-align-randomly-sample-and-concatenate)
      * [phyluce\_align\_reduce\_alignments\_with\_raxml](#phyluce-align-reduce-alignments-with-raxml)
      * [phyluce\_align\_remove\_empty\_taxa](#phyluce-align-remove-empty-taxa)
      * [phyluce\_align\_remove\_locus\_name\_from\_files](#phyluce-align-remove-locus-name-from-files)
      * [phyluce\_align\_screen\_alignments\_for\_problems](#phyluce-align-screen-alignments-for-problems)
      * [phyluce\_align\_seqcap\_align](#phyluce-align-seqcap-align)
      * [phyluce\_align\_split\_concat\_nexus\_to\_loci](#phyluce-align-split-concat-nexus-to-loci)
    - [Genetrees](#genetrees)
      * [phyluce\_genetrees\_generate\_multilocus\_bootstrap\_count](#phyluce-genetrees-generate-multilocus-bootstrap-count)
      * [phyluce\_genetrees\_get\_mean\_bootrep\_support](#phyluce-genetrees-get-mean-bootrep-support)
      * [phyluce\_genetrees\_get\_tree\_counts](#phyluce-genetrees-get-tree-counts)
      * [phyluce\_genetrees\_rename\_tree\_leaves](#phyluce-genetrees-rename-tree-leaves)
      * [phyluce\_genetrees\_sort\_multilocus\_bootstraps](#phyluce-genetrees-sort-multilocus-bootstraps)
    - [NCBI](#id1)
      * [phyluce\_ncbi\_chunk\_fasta\_for\_ncbi](#phyluce-ncbi-chunk-fasta-for-ncbi)
      * [phyluce\_ncbi\_prep\_uce\_align\_files\_for\_ncbi](#phyluce-ncbi-prep-uce-align-files-for-ncbi)
    - [Probes](#probes)
      * [phyluce\_probe\_easy\_lastz](#phyluce-probe-easy-lastz)
      * [phyluce\_probe\_get\_genome\_sequences\_from\_bed](#phyluce-probe-get-genome-sequences-from-bed)
      * [phyluce\_probe\_get\_locus\_bed\_from\_lastz\_files](#phyluce-probe-get-locus-bed-from-lastz-files)
      * [phyluce\_probe\_get\_multi\_fasta\_table](#phyluce-probe-get-multi-fasta-table)
      * [phyluce\_probe\_get\_multi\_merge\_table](#phyluce-probe-get-multi-merge-table)
      * [phyluce\_probe\_get\_probe\_bed\_from\_lastz\_files](#phyluce-probe-get-probe-bed-from-lastz-files)
      * [phyluce\_probe\_get\_screened\_loci\_by\_proximity](#phyluce-probe-get-screened-loci-by-proximity)
      * [phyluce\_probe\_get\_subsets\_of\_tiled\_probes](#phyluce-probe-get-subsets-of-tiled-probes)
      * [phyluce\_probe\_get\_tiled\_probe\_from\_multiple\_inputs](#phyluce-probe-get-tiled-probe-from-multiple-inputs)
      * [phyluce\_probe\_get\_tiled\_probes](#phyluce-probe-get-tiled-probes)
      * [phyluce\_probe\_query\_multi\_fasta\_table](#phyluce-probe-query-multi-fasta-table)
      * [phyluce\_probe\_query\_multi\_merge\_table](#phyluce-probe-query-multi-merge-table)
      * [phyluce\_probe\_reconstruct\_uce\_from\_probe](#phyluce-probe-reconstruct-uce-from-probe)
      * [phyluce\_probe\_remove\_duplicate\_hits\_from\_probes\_using\_lastz](#phyluce-probe-remove-duplicate-hits-from-probes-using-lastz)
      * [phyluce\_probe\_remove\_overlapping\_probes\_given\_config](#phyluce-probe-remove-overlapping-probes-given-config)
      * [phyluce\_probe\_run\_multiple\_lastzs\_sqlite](#phyluce-probe-run-multiple-lastzs-sqlite)
      * [phyluce\_probe\_slice\_sequence\_from\_genomes](#phyluce-probe-slice-sequence-from-genomes)
      * [phyluce\_probe\_strip\_masked\_loci\_from\_set](#phyluce-probe-strip-masked-loci-from-set)
    - [Utilities](#utilities)
      * [phyluce\_utilities\_combine\_reads](#phyluce-utilities-combine-reads)
      * [phyluce\_utilities\_filter\_bed\_by\_fasta](#phyluce-utilities-filter-bed-by-fasta)
      * [phyluce\_utilities\_get\_bed\_from\_fasta](#phyluce-utilities-get-bed-from-fasta)
      * [phyluce\_utilities\_merge\_multiple\_gzip\_files](#phyluce-utilities-merge-multiple-gzip-files)
      * [phyluce\_utilities\_merge\_next\_seq\_gzip\_files](#phyluce-utilities-merge-next-seq-gzip-files)
      * [phyluce\_utilities\_replace\_many\_links](#phyluce-utilities-replace-many-links)
      * [phyluce\_utilities\_sample\_reads\_from\_files](#phyluce-utilities-sample-reads-from-files)
      * [phyluce\_utilities\_unmix\_fasta\_reads](#phyluce-utilities-unmix-fasta-reads)
    - [Workflow](#workflow)
      * [phyluce\_workflow](#phyluce-workflow)

* [Citing](../citing.html)
* [License](../license.html)
* [Attributions](../attributions.html)
* [Funding](../funding.html)
* [Acknowledgements](../ack.html)

[phyluce](../index.html)

* [Phyluce in Daily Use](index.html)
* List of Phyluce Programs
* [View page source](../_sources/daily-use/list-of-programs.rst.txt)

---

# List of Phyluce Programs[](#list-of-phyluce-programs "Link to this heading")

## Assembly[](#assembly "Link to this heading")

### phyluce\_assembly\_assemblo\_abyss[](#phyluce-assembly-assemblo-abyss "Link to this heading")

Assemble fastq data for [phyluce](https://github.com/faircloth-lab/phyluce) using [abyss](http://www.bcgsc.ca/platform/bioinfo/software/abyss).

### phyluce\_assembly\_assemblo\_spades[](#phyluce-assembly-assemblo-spades "Link to this heading")

Assemble fastq data for [phyluce](https://github.com/faircloth-lab/phyluce) using [spades](https://cab.spbu.ru/software/spades/).

### phyluce\_assembly\_assemblo\_velvet[](#phyluce-assembly-assemblo-velvet "Link to this heading")

Assemble fastq data for [phyluce](https://github.com/faircloth-lab/phyluce) using [velvet](http://www.ebi.ac.uk/~zerbino/velvet/).

### phyluce\_assembly\_explode\_get\_fastas\_file[](#phyluce-assembly-explode-get-fastas-file "Link to this heading")

Given an input “monolithic” fasta file of UCE contigs (from [phyluce](https://github.com/faircloth-lab/phyluce)), break that file up into locus- or taxon-specific individual files.

### phyluce\_assembly\_extract\_contigs\_to\_barcodes[](#phyluce-assembly-extract-contigs-to-barcodes "Link to this heading")

Takes as input the LOG file created during `phyluce_assembly_match_contigs_to_barcodes` (below) and outputs a more nicely-formatted table of results.

### phyluce\_assembly\_get\_bed\_from\_lastz[](#phyluce-assembly-get-bed-from-lastz "Link to this heading")

Given a [lastz](http://www.bx.psu.edu/~rsharris/lastz/) file produced by [phyluce](https://github.com/faircloth-lab/phyluce), convert those results to BED format.

### phyluce\_assembly\_get\_fasta\_lengths[](#phyluce-assembly-get-fasta-lengths "Link to this heading")

Given an input FASTA-formatted file, summarize the info on contigs within that file and output summary statistics.

### phyluce\_assembly\_get\_fastas\_from\_match\_counts[](#phyluce-assembly-get-fastas-from-match-counts "Link to this heading")

Given a match-count file (produced from `phyluce_assembly_get_match_counts`), output a monolithic FASTA-formatted file of UCE loci.

### phyluce\_assembly\_get\_fastq\_lengths[](#phyluce-assembly-get-fastq-lengths "Link to this heading")

Given some input FASTQ data, output summary stastistics about those reads.

### phyluce\_assembly\_get\_match\_counts[](#phyluce-assembly-get-match-counts "Link to this heading")

Given results from `phyluce_assembly_match_contigs_to_probes` (below) and a configuration file, output those taxa and loci for which matches exist in the UCE database. The config file looks like:

```
[all]
alligator_mississippiensis
anolis_carolinensis
gallus_gallus
mus_musculus
```

### phyluce\_assembly\_match\_contigs\_to\_barcodes[](#phyluce-assembly-match-contigs-to-barcodes "Link to this heading")

Given a directory of assembled contigs and a file containing an organismal barcode in FASTA format, check the contigs of all taxa in the directory for presence of the barcode sequence, extract that region of each contig for each taxon, and run the result against the BOLD database (for each taxon). Useful for checking species ID and also searching for potential contamination.

### phyluce\_assembly\_match\_contigs\_to\_probes[](#phyluce-assembly-match-contigs-to-probes "Link to this heading")

Given a directory of assembled contigs and a file of UCE baits/probes, search the contigs for those that match part/all of a given bait/probe at some level of stringency.

### phyluce\_assembly\_screen\_probes\_for\_dupes[](#phyluce-assembly-screen-probes-for-dupes "Link to this heading")

Check a probe/bait file for potential duplicate baits/probes.

## Alignment[](#alignment "Link to this heading")

### phyluce\_align\_add\_missing\_data\_designators[](#phyluce-align-add-missing-data-designators "Link to this heading")

Sometimes alignments do not contain the same taxa as other alignments, and those “missing taxa” need to be added in. This program allows you to add those missing entries for the missing taxa, although this is often not needed when using the [phyluce](https://github.com/faircloth-lab/phyluce) concatenation tools (see below), which automatically deal with this problem.

### phyluce\_align\_concatenate\_alignments[](#phyluce-align-concatenate-alignments "Link to this heading")

Given an input file of alignments, concatenate those alignments together and output either a `--nexus` or a `--phylip` formatted file, along with charset information (either as an extra file, for phylip, or within the `--nexus` formatted file).

### phyluce\_align\_convert\_degen\_bases[](#phyluce-align-convert-degen-bases "Link to this heading")

If there are IUPAC degenerate base codes within an alignment, convert those to “N”.

### phyluce\_align\_convert\_one\_align\_to\_another[](#phyluce-align-convert-one-align-to-another "Link to this heading")

Convert alignments between formats. Can convert freely between FASTA, Nexus, Phylip, Phylip-relaxed, Clustal, Emboss, and Stockholm.

### phyluce\_align\_explode\_alignments[](#phyluce-align-explode-alignments "Link to this heading")

Given an input directry of alignments, “explode” those files into taxon- or locus-specific sequence files.

### phyluce\_align\_extract\_taxa\_from\_alignments[](#phyluce-align-extract-taxa-from-alignments "Link to this heading")

Given a set of alignments and a list of taxa to keep or remove from the alignments, make a new directory of alignments with those taxa kept or removed.

### phyluce\_align\_extract\_taxon\_fasta\_from\_alignments[](#phyluce-align-extract-taxon-fasta-from-alignments "Link to this heading")

Given a set of alignments and a taxon to extract from them, extract the data for the taxon and format those data as a FASTA file.

### phyluce\_align\_filter\_alignments[](#phyluce-align-filter-alignments "Link to this heading")

Filter alignments having certain taxa or certain lengths and make a new directory without those alignments.

### phyluce\_align\_format\_concatenated\_phylip\_for\_paml[](#phyluce-align-format-concatenated-phylip-for-paml "Link to this heading")

This will convert a Phylip-formatted concatenated alignment for PAML’s weird, internal format. Not sure if PAML needs this format any longer.

### phyluce\_align\_get\_align\_summary\_data[](#phyluce-align-get-align-summary-data "Link to this heading")

Given a directory of alignments, output summary statistics for those alignments quickly.

### phyluce\_align\_get\_gblocks\_trimmed\_alignments\_from\_untrimmed[](#phyluce-align-get-gblocks-trimmed-alignments-from-untrimmed "Link to this heading")

Given a directory of alignments, use [gblocks](http://molevol.cmima.csic