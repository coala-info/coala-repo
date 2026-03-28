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

CADD scores are freely available for all non-commercial applications. If you are
planning on using them in a commercial application, please [contact us](/contact).

# Please upload a VCF file containing up to 100,000 variants

Please provide a (preferentially gzip-compressed) VCF file of your variants. For information on the VCF format see <https://samtools.github.io/hts-specs/>. It is sufficient
to provide the first 5 columns of a VCF file without header, as all other information than CHROM, POS, REF, ALT will
be ignored anyway. The maximum accepted file size is set at 2MB (>100,000 variants for 5 column compressed VCF). If
you try to upload files larger than 2MB, you will receive an error ("Connection reset"). You will be able to retrieve
your variants faster, if you upload them in smaller sets. The file that will be provided for download is a
gzip-compressed tab-separated text file. Make sure that your browser does not alter the file extension (.tsv.gz)
during download; otherwise your operating system will not be able to automatically pick the right programs for opening
the output. If you need more variants, we suggest [downloading](/download) the full set of variants.

GRCh38-v1.7
GRCh37-v1.7
GRCh38-v1.6
GRCh37-v1.6
GRCh38-v1.5
GRCh37-v1.4
GRCh38-v1.4
v1.3
v1.2
v1.1
v1.0

Optional: Provide your email and you will be contacted when your job is completed

[ ]
Include Annotations
> Please note that by clicking 'Upload variants', you confirm and warrant that you have the full right and authority
> to provide genomic variant data to CADD, to analyze such data, and to obtain results on such data. You further
> confirm and warrant that the data does not contain any identifiable information. You also understand that the CADD
> web server does not require user registration, so that your data is potentially accessible by third parties by
> decrypting URLs. Finally, you understand that any user data will be removed from the web server periodically, and it
> is your own responsibility to backup any data and results. You hereby irrevocably agree to hold the developers
> harmless from any form of liability, even if the data which you provide to CADD becomes compromised.

© University of Washington, Hudson-Alpha Institute for Biotechnology and Berlin Institute
of Health at Charité - Universitätsmedizin Berlin 2013-2023. All rights reserved.

[Terms and Conditions](http://www.washington.edu/online/terms/) and the [Online Privacy Statement](http://www.washington.edu/online/privacy/) of the University of
Washington apply.