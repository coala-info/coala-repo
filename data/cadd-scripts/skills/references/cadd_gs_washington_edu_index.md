[![CADD logo](/static/icon.png)

# CADD - Combined Annotation Dependent Depletion](/)

* [News](/news "Recent updates")
* [Score](/score "Upload a vcf file for variant scoring")
* [SNV](#popover-snv)

  + [Single](/snv "Lookup for single SNV")
  + [Range](/snv-range "SNV range lookup")
* [Downloads](/download "Data downloads for offline scoring")
* [About](#popover-about)

  + [Information](/info "About CADD")
  + [API](/api "Information about the CADD API")
  + [Genome Browser](/genome-browser "Information about displaying CADD scores in UCSC Genome Browser")
  + [Links](/links "Links to CADD related resources")
  + [Contact](/contact "Contact")
* (Alt. site:
  [![Visit German site](/static/DE-flag.png)](https://cadd.bihealth.org/))

***Note:* Scoring of VCF files with CADD v1.7 is still rather slow if many new
variants need to be calculated from scratch (e.g., if many insertion/deletion or multi-nucleotide substitutions
are included). If possible use the pre-scored whole genome and pre-calculated indel files directly where possible.**

# What is Combined Annotation Dependent Depletion (CADD)?

CADD is a tool for scoring the deleteriousness of single nucleotide variants, multi-nucleotide substitutions as well as
insertion/deletions variants in the human genome.

While many variant annotation and scoring tools are around, most annotations
tend to exploit a single information type (e.g. conservation) and/or
are restricted in scope (e.g. to missense changes). Thus, a broadly applicable metric
that objectively weights and integrates diverse information is needed.
Combined Annotation Dependent Depletion (CADD) is a framework that
integrates multiple annotations into one metric by contrasting variants that
survived natural selection with simulated mutations.

C-scores strongly correlate with allelic
diversity, pathogenicity of both coding and non-coding variants, and
experimentally measured regulatory effects, and also highly rank causal variants
within individual genome sequences. Finally, C-scores of complex
trait-associated variants from genome-wide association studies (GWAS) are
significantly higher than matched controls and correlate with study sample size,
likely reflecting the increased accuracy of larger GWAS.

CADD can quantitatively prioritize functional, deleterious, and disease causal
variants across a wide range of functional categories, effect sizes and genetic
architectures and can be used prioritize causal variation in
both research and clinical settings.

In addition to this website, CADD has been described in four publications.
The most recent manuscript describes CADD v1.7, an extension to the annotations
included in the model. Most prominently, this version improves the scoring of
coding variants with features derived from the ESM-1v protein language model
as well as the scoring of regulatory variants with features derived from a
convolutional neural network trained on regions of open chromatin:
> Schubach M, Maass T, Nazaretyan L, Röner S, Kircher M.
> *CADD v1.7: Using protein language models, regulatory CNNs and other nucleotide-level scores to improve genome-wide
> variant predictions.*
> Nucleic Acids Res. 2024 Jan 5. doi: [10.1093/nar/gkad989](https://doi.org/10.1093/nar/gkad989).
> PubMed PMID: [38183205](https://pubmed.ncbi.nlm.nih.gov/38183205/).

Then there is CADD-Splice (CADD v1.6), which specifically improved the prediction of splicing effects:
> Rentzsch P, Schubach M, Shendure J, Kircher M.
> *CADD-Splice—improving genome-wide variant effect prediction using deep learning-derived splice scores.*
> Genome Med. 2021 Feb 22. doi: [10.1186/s13073-021-00835-9](https://doi.org/10.1186/s13073-021-00835-9).
> PubMed PMID: [33618777](http://www.ncbi.nlm.nih.gov/pubmed/33618777).

Our third manuscript describes the updates between the initial publication and CADD v1.4, introduces CADD for GRCh38
and explains how we envision the use of CADD. It was published by Nucleic Acids Research in 2018:
> Rentzsch P, Witten D, Cooper GM, Shendure J, Kircher M.
> *CADD: predicting the deleteriousness of variants throughout the human genome.*
> Nucleic Acids Res. 2018 Oct 29. doi: [10.1093/nar/gky1016](http://dx.doi.org/10.1093/nar/gky1016).
> PubMed PMID: [30371827](http://www.ncbi.nlm.nih.gov/pubmed/30371827).

Finally, the original manuscript describing the method was published by Nature Genetics in 2014:
> Kircher M, Witten DM, Jain P, O'Roak BJ, Cooper GM, Shendure J.
> *A general framework for estimating the relative pathogenicity of human genetic variants.*
> Nat Genet. 2014 Feb 2. doi: [10.1038/ng.2892](http://dx.doi.org/10.1038/ng.2892).
> PubMed PMID: [24487276](http://www.ncbi.nlm.nih.gov/pubmed/24487276).

# How can I obtain CADD scores?

CADD scores are freely available for all non-commercial applications. If
you are planning on using them in a commercial application, you can obtain a license through the [UW CoMotion Express Licensing System](https://els2.comotion.uw.edu/product/cadd-scores). If in doubt about
whether you need a license for your application, please contact
[Martin Kircher](https://kircherlab.github.io/people.html),
[Jay Shendure](https://krishna.gs.washington.edu/current.html) and
[Gregory M. Cooper](https://www.hudsonalpha.org/faculty/greg-cooper/).
CADD is currently developed by [Martin Kircher](https://kircherlab.github.io/people.html),  [Max
Schubach](https://kircherlab.github.io/people/max.html), [Thorben Maaß](https://kircherlab.github.io/people.html), and [Lusine Nazaretyan](https://kircherlab.bihealth.org/people.html).
Former developers are  [Philipp Rentzsch](https://github.com/aerval), [Daniela M. Witten](https://www.biostat.washington.edu/people/daniela-witten), [Gregory M. Cooper](https://www.hudsonalpha.org/faculty/greg-cooper/), and [Jay Shendure](https://krishna.gs.washington.edu/current.html).

We have pre-computed CADD-based scores (C-scores) for all [approximately 9 billion possible single
nucleotide variants (SNVs) of
the reference genome, a selection of short insertion/deletions as well as some large variant sets
(e.g. gnomAD, ExAC, 1000 Genomes, ESP).](/download) We also provide a [simple lookup for SNVs](/snv)
and [enable scoring of short insertions/deletions](/score). Ranges of scores can be natively visualized
in [UCSC Genome Browser](/genome-browser) or using our custom tracks (for [CADD v1.6 hg19/GRCh37](http://genome.ucsc.edu/cgi-bin/hgTracks?db=hg19&hubUrl=https://raw.githubusercontent.com/kircherlab/CADD-browserTracks/master/hub.txt)
and [CADD v1.6 hg38/GRCh38](http://genome.ucsc.edu/cgi-bin/hgTracks?db=hg38&hubUrl=https://raw.githubusercontent.com/kircherlab/CADD-browserTracks/master/hub.txt)).

[![University of Washington homepage.](/static/logos/uw.png)](https://washington.edu)
[![Brotman Baty Institute homepage.](/static/logos/bbi.png)](https://brotmanbatyinstitute.org)
[![HudsonAlpha Institute for Biotechnology homepage.](/static/logos/ha.jpg)](https://hudsonalpha.org)
[![Berlin Institute of Health homepage.](/static/logos/bih.png)](https://www.bihealth.org/en)

© University of Washington, Hudson-Alpha Institute for Biotechnology and Berlin Institute
of Health at Charité - Universitätsmedizin Berlin 2013-2023. All rights reserved.

[Terms and Conditions](http://www.washington.edu/online/terms/) and the [Online Privacy Statement](http://www.washington.edu/online/privacy/) of the University of
Washington apply.