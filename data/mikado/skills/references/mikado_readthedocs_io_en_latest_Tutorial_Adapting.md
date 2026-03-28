### Navigation

* [index](../../genindex/ "General Index")
* [next](../../Usage/ "7. Usage") |
* [previous](../Scoring_tutorial/ "5. Tutorial: how to create a scoring configuration file") |
* [Mikado](../../) »

# 6. Adapting Mikado to specific user-cases[¶](#adapting-mikado-to-specific-user-cases "Permalink to this headline")

Although Mikado provides generally sane defaults for most projects and species, one of its key advantages is its flexibility, which allows it to be tailored for the needs of various projects. In this section we provide an overview on how to adapt the workflow to specific user-cases.

In general, this tailoring can be performed in these sections of the workflow:

* when launching `mikado configure`, to set up influential parameters such as the flank clustering distance or the expected intron size range.
* by modifying directly the resulting configuration file.
* by modifying the [scoring file](../Scoring_tutorial/#configure-scoring-tutorial).

## 6.1. Case study 1: adapting Mikado to your genome of interest[¶](#case-study-1-adapting-mikado-to-your-genome-of-interest "Permalink to this headline")

When adapting Mikado to a new species, some of the most important factors to be considered are:

* how compact is the species’ genome - ie, what is the expected genomic distance between two neighbouring genes?
* what is the expected intron size range?
* what is the expected UTR/CDS ratio, ie, will transcripts generally have short UTR sections (e.g. *Arabidopsis thaliana*, with its average ~80% coding section) or will they instead have long, multiexonic UTRs (as is the case in e.g. *Homo sapiens*)?
* will the organism mostly possess multi-exonic, long genes with many splicing variants (as is the case for mammals, e.g. our own species) or does it instead harbour mostly short transcripts with a low number of exons - potentially, even, mostly monoexonic (as is the case for many fungi, e.g., *Saccharomyces cerevisiae*)?

A good starting point for understanding how to answer these questions is to head over to [EnsEMBL](https://www.fungi.ensembl.org/index.html), and look for an annotated species sufficiently similar to the one under examination. For example, let us say that we want to annotate a yeast in the same family of *S. pombe*. We can fetch its GTF annotation from the [FTP download page of EnsEMBL](http://fungi.ensembl.org/info/website/ftp/index.html) and start analysing it. We can use to this end mikado util stats:

```
mikado util stats Schizosaccharomyces_pombe.ASM294v2.38.gff3.gz Schizosaccharomyces_pombe.ASM294v2.38.stats
```

which returns the following:

| Stat | Total | Average | Mode | Min | 1% | 5% | 10% | 25% | Median | 75% | 90% | 95% | 99% | Max |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Number of genes | 7268 | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA |
| Number of genes (coding) | 5145 | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA |
| Number of monoexonic genes | 4715 | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA |
| Transcripts per gene | 7269 | 1.00 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 2 |
| Coding transcripts per gene | 5146 | 0.71 | 1 | 0 | 0 | 0 | 0 | 0 | 1 | 1 | 1 | 1 | 1 | 2 |
| CDNA lengths | 12610347 | 1,734.81 | 72 | 47 | 72 | 83 | 306 | 846 | 1,504 | 2,322 | 3,370 | 4,103 | 5,807 | 15,022 |
| CDNA lengths (mRNAs) | 10592917 | 2,058.48 | 1315 | 75 | 283 | 546 | 753 | 1,201 | 1,792 | 2,613 | 3,675 | 4,425 | 6,404 | 15,022 |
| CDS lengths | 7178717 | 987.58 | 0 | 0 | 0 | 0 | 0 | 0 | 750 | 1,461 | 2,308 | 3,008 | 4,944 | 14,775 |
| CDS lengths (mRNAs) | NA | 1,395.01 | 354;750 | 75 | 201 | 307 | 387 | 669 | 1,137 | 1,752 | 2,661 | 3,420 | 5,502 | 14,775 |
| CDS/cDNA ratio | NA | 67.48 | 100.0 | 5 | 15 | 28 | 37 | 53 | 70 | 84 | 93 | 100 | 100 | 100 |
| Monoexonic transcripts | 4715 | 1,656.09 | 72 | 47 | 71 | 74 | 119 | 695 | 1,413 | 2,276 | 3,386 | 4,124 | 5,950 | 14,362 |
| MonoCDS transcripts | 2753 | 1,485.99 | 375;432;4002 | 93 | 218 | 332 | 418 | 732 | 1,191 | 1,806 | 2,849 | 3,784 | 5,875 | 14,154 |
| Exons per transcript | 12633 | 1.74 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 2 | 3 | 4 | 7 | 16 |
| Exons per transcript (mRNAs) | 3081 | 2.03 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 3 | 4 | 5 | 7 | 16 |
| Exon lengths | NA | 998.21 | 72 | 2 | 25 | 62 | 79 | 171 | 538 | 1,474 | 2,522 | 3,298 | 5,002 | 14,362 |
| Exon lengths (mRNAs) | NA | 1,013.39 | 106 | 3 | 24 | 59 | 86 | 175 | 499 | 1,516 | 2,605 | 3,414 | 5,117 | 14,362 |
| Intron lengths | NA | 83.69 | 49 | 1 | 17 | 38 | 41 | 46 | 56 | 85 | 162 | 226 | 411 | 2,526 |
| Intron lengths (mRNAs) | NA | 84.16 | 46 | 1 | 36 | 39 | 41 | 46 | 56 | 86 | 162 | 227 | 412 | 2,526 |
| CDS exons per transcript | 2091 | 1.41 | 1 | 0 | 0 | 0 | 0 | 0 | 1 | 2 | 3 | 4 | 7 | 16 |
| CDS exons per transcript (mRNAs) | 2091 | 1.99 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 3 | 4 | 5 | 7 | 16 |
| CDS exon lengths | 7178717 | 702.76 | 69;99 | 1 | 8 | 29 | 49 | 106 | 307 | 990 | 1,797 | 2,474 | 4,370 | 14,154 |
| CDS Intron lengths | 414501 | 81.77 | 44;45 | 0 | 35 | 38 | 40 | 45 | 55 | 84 | 157 | 220 | 395 | 2,525 |
| 5’UTR exon number | 5146 | 0.95 | 1 | 0 | 0 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | 2 | 3 |
| 3’UTR exon number | 5146 | 0.93 | 1 | 0 | 0 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | 2 | 3 |
| 5’UTR length | 1372304 | 266.67 | 0 | 0 | 0 | 0 | 17 | 71 | 154 | 309 | 586 | 932 | 1,935 | 4,397 |
| 3’UTR length | 2041896 | 396.79 | 0 | 0 | 0 | 0 | 46 | 126 | 243 | 441 | 865 | 1,386 | 2,644 | 5,911 |
| Stop distance from junction | NA | 7.58 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 23 | 3,385 |
| Intergenic distances | NA | -60.33 | -66 | -9,461 | -3,753 | -2,180 | -1,382 | -161 | 64 | 365 | 842 | 1,279 | 2,698 | 31,961 |
| Intergenic distances (coding) | NA | 297.72 | -66 | -7,815 | -3,477 | -1,598 | -440 | -32 | 176 | 600 | 1,302 | 1,913 | 3,924 | 78,421 |

From this table we can already see the following:

> * Most genes (5145 out of 7268, or 70.9%) are monoexonic
> * The average and modal intergenic distance between genes are very small, with almost half of the recorded distances being negative - indicating that most genes are actually *overlapping*.
> * Only a very small handful of genes (less than 1%) is annotated as having any splicing event
> * On average, UTRs occupy 33% of the length of coding transcripts (CDS/cDNA ratio is at 67%, on average) but most often transcripts actually lack an UTR at all (mode of 100%).
> * 98% of the introns have a length between 36 and 412 bps.

On the basis of this information, we can now start to customize the behaviour of Mikado for the species.

### 6.1.1. Creating the scoring file[¶](#creating-the-scoring-file "Permalink to this headline")

The first step in the process is for us to create a scoring file, following the [tutorial on the subject](../Scoring_tutorial/#configure-scoring-tutorial). We will call it “spombe.yaml”; as detailed in the link before, we will write it in the textual [YAML format](http://yaml.org/spec/1.2/spec.html).

Following the indications above and those in the tutorial, we should make the following changes in terms of priority for transcripts:

* we want mostly monoexonic transcripts
* transcripts with a UTR ratio under 33%
* we should look at most to 1 UTR exon, each way, targeting 0 (most transcripts are monoexonic and have their UTR contained in the same exon as the ORF).
* the distance of the stop codon from the nearest junction should be 0 (again this follows from having mostly monoexonic transcripts).

The scoring section would therefore end up looking like this:

```
scoring:
      snowy_blast_score: {rescaling: max}
      cdna_length: {rescaling: max}
      cds_not_maximal: {rescaling: min}
      cds_not_maximal_fraction: {rescaling: min}
      exon_num: {
        rescaling: target,
        value: 1
      }
      five_utr_length:
        filter: {operator: le, value: 2500}
        rescaling: target
        value: 100
      five_utr_num:
        filter: {operator: lt, value: 4}
        rescaling: target
        value: 0
      end_distance_from_junction:
        filter: {operator: lt, value: 23}
        rescaling: min
      highest_cds_exon_number: {rescaling: target, value: 1}
      intron_fraction: {rescaling: min}
      is_complete: {rescaling: target, value: true}
      number_internal_orfs: {rescaling: target, value: 1}
      non_verified_introns_num: {rescaling: min}
      # proportion_verified_introns_inlocus: {rescaling: max}
      retained_fraction: {rescaling: min}
      retained_intron_num: {rescaling: min}
      selected_cds_fraction: {rescaling: target, value: 1, filter: {operator: gt, value: 0.7 }}
      # selected_cds_intron_fraction: {rescaling: max}
      selected_cds_length: {rescaling: max}
      selected_cds_num: {rescaling: target, value: 1}
      three_utr_length:
        filter: {operator: le, value: 2500}
        rescaling: target
        value: 200
      three_utr_num:
        filter: {operator: lt, value: 2}
        rescaling: target
        value: 0
      combined_cds_locus_fraction: {rescaling: max}
```

Now that we have codified the scoring part, the next step is to determine the [requirements](../Scoring_tutorial/#scoring-tutorial-first-reqs) regarding the transcripts that should be accepted into our annotation. Given the simplicity of the organism, we can satisfy ourselves with the following two requirements:

> * No transcript should be shorter than 75 bps (minimum length for coding transcripts)
> * No transcript should have an intron longer than ~2600 bps (in the annotation the maximum is 2,526); we can be slightly more permissive here and set the limit at 3,000 bps.

This will yield the following, very simple requirements section:

```
requirements:
    expression:
        - cdna_length and max_intron_length
    parameters:
        cdna_length: {operator: ge, value: 75}
        max_intron_length: {operator: lt, value: 3000}
```

### 6.1.2. Modifying the general configuration file[¶](#modifying-the-general-configuration-file "Permalink to this headline")

The second step in the customization process is to personalize the general configuration. On the basis of what we know of *S. pombe*, we have to intervene here in the following way:

* set the intron range: per above, a reasonable setting should be 36-412.
* set the clustering flank: given the very compact size of the genome, we should aim for something very small - probably 50bps is plenty.
* given the very compact size of the genome and the general lack of splicing, it is also advised to set Mikado to split any chimeric transcripts - the chances are very, very high that any such occurrence is artifactual.
* make alternative splicing calling a very rare occurrence

First of all, we will download our genome in a single file (genome.fasta). We will use the pretty boilerplate *A. thaliana* scoring configuration as our starting block, and we will ask Daijin to copy it to the current location.

```
daijin configure --scoring spombe.yaml \
    --flank 50 \
    -i 36 412 \
    -m split \
    -o configuration.yaml \
    --genome genome.fasta
```

Once the configuration file has been created, we have to perform another couple of modifications, to make Mikado more stringent in terms of alternative splicing events. Look for the section [mikado/pick](../../Usage/Pick/#pick). Here we can do the following:

1. If you are completely uninterested in alternative splicing events, you can just set the “report” flag to false. This will disable AS calling completely.
2. If you want to still report AS events but at a far lower rate, you can:

   > * reduce the number of maximum isoforms reported: from 5 to 2, for example. **Note**: reducing this number to 1 will have the same effect as disabling AS calling completely.
   > * restrict the types of AS events we call (see the class code section for more details). We can for example restrict the calling to “j” and “G”, and potentially add “g” (i.e. consider as a valid alternative splicing event for a multiexonic transcript a monoexonic one).
   > * increase the minimum score percentage of an AS event for it to be reported, to extremely high values (such as 0.9 to 0.99). This will ensure that only a small amount of isoforms will be called.
   > * increase the minimum cDNA/CDS overlap between the AS events and the primary transcript. This cannot go up to 100% for both, otherwise no AS event will ever be reported. However, you could for example set the CDS overlap to 100%, if you are only interested in alternative UTR splicing.
   > * leave the “keep\_retained\_introns” field as false, and “only\_confirmed\_introns” field as “true”.

Once these modifications have been made, Mikado is ready to be run.

## 6.2. Case study 2: noisy RNA-Seq data[¶](#case-study-2-noisy-rna-seq-data "Permalink to this headline")

With RNA-Seq, a relatively common happenstance is the presence of noise in the data - either experimentally, through the presence of pre-mRNA, genomic contamination, or otherwise erroneous transcripts; or from computational artifacts, e.g. an explicit choice on the part of the experimenter to retrieve from the data even isoforms and loci with little coverage support, in an attempt to boost the sensitivity of the analysis at the cost of decreased precision.

In such instances, it might make sense to make Mikado more stringent than usual. In this tutorial we will focus on the following:

* Making Mikado more aggressive in filtering out putative fragments
* Making Mikado more aggressive in splitting chimeric transcripts
* Making Mikado more aggressive in filtering out incorrect alternative splicing events such as retained introns

For ease of discussion, we will suppose that we are working in a species similar in features to *D. melanogaster*. We will, therefore, be using a copy of the dmelanogaster\_scoring.yaml file included in the distribution of Mikado.

### 6.2.1. Modifying the general configuration file and obtaining a copy of the original template[¶](#modifying-the-general-configuration-file-and-obtaining-a-copy-of-the-original-template "Permalink to this headline")

Before touching the scoring file, this time we will call the Daijin configurator in order to obtain a copy of the original *D. melanogaster* scoring file.
We will suppose to have relevant proteins in “proteins.fasta” (e.g. a dataset assembled from SwissProt), and that - like for *D. melanogaster* - the acceptable intron size range is between 50 and 26000 bps. As the data is quite noisy, we have to expect that there will be fragments derived from mis-alignments or genomic contamination; we will, therefore, enlarge the normal flanking area to 2000 bps. This will allow to catch more of these events, when we check for potential fragments in the neighbourhood of good loci. Regarding probable chimeric events, we will be quite aggressive - we will split any chimeric event which is not supported by a good blast hit against the 