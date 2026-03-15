The chromosome locations (loci) of potential regulatory elements in
[BED format](../doc/bed-format.html%22).
Typically, these would be transcription factor (TF) peaks from a TF ChIP-seq
experiment, output by a peak-caller such as MACS.

[ close ]

Select genome release corresponding to your genomic locations (loci)
along with a tissue panel of histone modification and gene expression
data, if one is available for your genome release.
T-Gene will score each potential regulatory link between a locus and a TSS,
that are within 500,000bp of each other. (It will always score the closest-TSS
and closest-locus links, regardless of distance.)
If you choose a genome with a tissue panel, T-Gene will score each link by
by combining the correlation between the histone modification
at the locus and the gene expression of the TSS, across the panel of tissues,
with the distance between the locus and TSS.
If no tissue panel is available (or chosen), T-Gene will score each link based
solely on the distance between the locus and the TSS.
See the T-Gene
[Genomes and Tissue Panels documentation](../db/tgene)
for more information on the available genomes and histone/expression panels.

[ close ]

Set this to a value less than 1 to limit the size of the HTML and TSV output files.
Set it to 1 if you want the HTML and TSV files to contain all possible links,
regardless of their statistical significance.

[ close ]

Enable this option if you want T-Gene to include a link to
the closest locus for each transcript even if the link does not satisfy
the maximum link distance requirement.

Enabling this option will make the T-Gene output substantially larger.

[ close ]

Enable this option if you want T-Gene to include a link to
the closest TSS for each locus even if the link does not satisfy
the maximum link distance requirement.

Enabling this option will make the T-Gene output substantially larger.

[ close ]

**Click on the menu at the left to see which of the following loci input methods are available.**

**Upload loci**
:   When this option is available you may upload a file containing
    loci in [BED Format](bed-format.html).

[ close ]

Enter the email address where you want the job notification email to
be sent. Please check that this is a valid email address!

The notification email will include a link to your job results.

**Note:** You can also access your jobs via the **Recent Jobs**
menu on the left of all MEME Suite input pages. That menu only
keeps track of jobs submitted during the current session of your internet browser.

**Note:** Most MEME Suite servers only store results for a couple of days.
So be sure to download any results you wish to keep.

[ close ]

Enter text naming or describing this analysis. The job description will be included in the notification email you
receive and in the job output.

[ close ]

# Javascript is disabled! ☹

The MEME Suite web application requires the use of JavaScript but
Javascript doesn't seem to be available on your browser.

Please re-enable Javascript to use the MEME Suite.

![T-Gene Logo](../doc/images/tgene_icon.png)

# T-Gene

## Prediction of Target Genes

Version 5.5.9

Data Submission Form

Predict regulatory links between genomic loci and genes.

## Input genomic locations

#### Upload a BED file of genomic locations (loci) to analyze.

## Select the genome and tissue panel

#### Choose the genome and histone/expression panel (if available).

Human hg19 (ENCODE Tissue Panel)
Human hg19 (Epigenomic Roadmap Tissue Panel)
Mouse mm9 (ENCODE Tissue Panel)

Arabidopsis thaliana TAIR10 (Ensembl)
Caenorhabditis elegans WBcel235 (Ensembl)
Caenorhabditis elegans ce11 (UCSC)
Danio rerio GRCz11 (Ensembl)
Danio rerio danRer11 (UCSC)
Drosophila melanogaster BDGP6 (Ensembl)
Drosophila melanogaster dm6 (UCSC)
Homo sapiens GRCh38 (Ensembl)
Homo sapiens hg38 (UCSC)
Mus musculus GRCm38 (Ensembl)
Mus musculus mm10 (UCSC)
Rattus norvegicus Rnor\_6 (Ensembl)
Rattus norvegicus rn6 (UCSC)
Saccharomyces cerevisiae R64-1-1 (Ensembl)
Saccharomyces cerevisiae sacCer3 (UCSC)

## Input job details

#### (Optional) Enter your email address.

#### (Optional) Enter a job description.

▶
▼
Advanced options
hidden modifications!
[Reset]

### Set the maximum *p*-value for links in T-Gene's output files

 Link *p*-value ≤

### Include closest locus links

[ ]
Include closest locus links.

### Include closest TSS links

[x]
Include closest TSS links.

**Warning:**
Your maximum job quota has been reached! You will need to wait until
one of your jobs completes or 1 second has
elapsed before submitting another job.

This server has the job quota set to 10 unfinished jobs
every 1 hour.

Note: if the combined form inputs exceed 80MB the job will be rejected.

Version 5.5.9

Powered by [Opal](http://sourceforge.net/projects/opaltoolkit/)

Please send comments and questions to:
meme-suite@uw.edu

---

* [Home](../index.html)
* [Documentation](../doc/overview.html)
* [Downloads](../doc/download.html)
* [Authors](../doc/authors.html)
* [Citing](../doc/cite.html)