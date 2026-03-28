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

## Tools and applications using/annotating CADD

* [gnomAD and ExAC](http://gnomad.broadinstitute.org/): variants aggregated from disease controls, late onset disease studies and population studies
* [Bravo/TOPMed](http://bravo.sph.umich.edu/): variants from WGS variant calls aggregated across various cohort studies
* [Ensembl VEP](https://www.ensembl.org/info/docs/tools/vep/index.html): genome variant
  annotation tool and platform
* [dbNSFP](https://sites.google.com/site/jpopgen/dbNSFP): database for many different
  annotations and scores for non-synonymous sequence alterations
* [PopViz](http://shiva.rockefeller.edu/PopViz/): webserver for visualizing minor allele
  frequencies and damage prediction scores of human genetic variations

## Annotations

Selection of links to (some) annotations that have been added since CADD v1.4. For more information about
annotations included in CADD please also see our manuscripts and release notes.

* [TargetScan](http://www.targetscan.org/cgi-bin/targetscan/data_download.vert71.cgi)
* [dbscSNV](https://sites.google.com/site/jpopgen/dbNSFP)
* [SpliceAI](https://github.com/Illumina/SpliceAI)
* [MMSplice](https://github.com/gagneurlab/MMSplice)
* [Meta Evolutionary Scale Modeling (ESM) language models for proteins](https://github.com/facebookresearch/esm)
* [GRCh38/hg38 GERP, PhastCons and PhyloP](http://compgen.cshl.edu/phast/): using [muliz\*way alignment](http://hgdownload.soe.ucsc.edu/goldenPath/hg38/multiz100way) from
  UCSC, processing according to [UCSC/Kentlab](https://github.com/ucscGenomeBrowser/kent/blob/master/src/hg/makeDb/doc/hg38/hg38.txt) without human
* [GRCh37/hg19 GERP](http://mendel.stanford.edu/SidowLab/downloads/gerp/)
* [Encode Annotations](https://www.encodeproject.org/), using data from reference
  epigenomes like [this](https://www.encodeproject.org/reference-epigenomes/ENCSR184WKQ/)
* [ChromHMM](http://compbio.mit.edu/ChromHMM/): in GRCh38 using [25 state Roadmap/Encode model](http://ftp.ensembl.org/pub/release-87/data_files/homo_sapiens/GRCh38/segmentation_file/085/)
* [Ensembl Regulatroy Build v90](https://www.ensembl.org/info/genome/funcgen/index.html)
  from [Ensembl server](https://ftp.ensembl.org/pub/release-90/regulation/homo_sapiens/)
* [ReMap2 (ReMap2018)](https://remap.univ-amu.fr/download_page)

© University of Washington, Hudson-Alpha Institute for Biotechnology and Berlin Institute
of Health at Charité - Universitätsmedizin Berlin 2013-2023. All rights reserved.

[Terms and Conditions](http://www.washington.edu/online/terms/) and the [Online Privacy Statement](http://www.washington.edu/online/privacy/) of the University of
Washington apply.