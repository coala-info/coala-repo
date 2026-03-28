[![Logo](_static/qualimap_logo_small.png)](index.html)

[Qualimap 2.3 documentation](index.html)

[previous](command_line.html "Command Line Interface") |
[next](faq.html "Frequently Asked Questions")

# Examples[¶](#examples "Permalink to this headline")

## Sample Data[¶](#sample-data "Permalink to this headline")

### Alignments[¶](#alignments "Permalink to this headline")

* [ERR089819.bam](http://qualimap.bioinfo.cipf.es/samples/alignments/ERR089819.bam) (2.6 GB)
  :   Whole genome sequencing data of C. elegans from the following [study](http://trace.ncbi.nlm.nih.gov/Traces/sra/?study=ERP000975).
* [HG00096.chrom20.bam](http://qualimap.bioinfo.cipf.es/samples/alignments/HG00096.chrom20.bam) (278 MB)
  :   Sequencing of the chromosome 20 from a H. sapiens sample from [1000 Genomes project](http://www.1000genomes.org/). The header of the BAM file was changed in order to contain only chromosome 20. Original file can be found here.
* [kidney.bam](http://qualimap.bioinfo.cipf.es/samples/counts/kidney.bam) (386 MB) and [liver.bam](http://qualimap.bioinfo.cipf.es/samples/counts/liver.bam) (412 MB)
  :   Human RNA-seq sequencing data from from the paper of [Marioni JC et al](http://genome.cshlp.org/content/18/9/1509.abstract)

### Annotations[¶](#annotations "Permalink to this headline")

* [human.64.gtf](http://qualimap.bioinfo.cipf.es/samples/annotations/human.64.gtf)
  :   Human genome annotations from Ensembl database (v. 64).
* [transcripts.human.64.bed](http://qualimap.bioinfo.cipf.es/samples/annotations/transcripts.human.64.bed)
  :   Human transcripts in BED format from Ensembl database (v. 64).

### Multisample BAM QC[¶](#multisample-bam-qc "Permalink to this headline")

* [gh2ax\_chip\_seq.zip](http://kokonech.github.io/qualimap/samples/gh2ax_chip_seq.zip)

  > Example dataset from an unpublished ChiP-seq experiment with 4 condtions, each having 3 replicates (12 sampels in total). The archive contains BAM QC results for each sample and input configurations (normal: *input.txt*, with marked conditions: *input.with\_groups.txt*) for command line version of Multisample BAM QC.

### Counts QC[¶](#counts-qc "Permalink to this headline")

* [mouse\_counts\_ensembl.txt](http://kokonech.github.io/qualimap/samples/mouse_counts_ensembl.txt)
  :   Mouse counts data from a [study](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE54853) investigating effects of D-Glucosamine:
* [GlcN\_countsqc\_input.txt](http://kokonech.github.io/qualimap/samples/GlcN_countsqc_input.txt)
  :   Command line input configuration for the counts data above.
* [kidney.counts](http://qualimap.bioinfo.cipf.es/samples/counts/kidney.counts) and [liver.counts](http://qualimap.bioinfo.cipf.es/samples/counts/liver.counts)
  :   Counts data from the paper by [Marioni JC et al](http://genome.cshlp.org/content/18/9/1509.abstract).
* [marioini\_countsqc\_input.txt](http://kokonech.github.io/qualimap/samples/marioni_countsqc_input.txt)
  :   Command line input configuration for the counts data above.

### Clustering[¶](#clustering "Permalink to this headline")

* [hmeDIP.bam](http://qualimap.bioinfo.cipf.es/samples/clustering/hmeDIP.bam) (988M)
  :   MeDIP-seq of human embryonic stem cells from the study of [Stroud H et al](http://genomebiology.com/content/12/6/R54).
* [input.bam](http://qualimap.bioinfo.cipf.es/samples/clustering/input.bam) (1.8G)
  :   Input data of the same study

## Sample Output[¶](#sample-output "Permalink to this headline")

### BAM QC[¶](#bam-qc "Permalink to this headline")

Analysis of the WG-seq data (HG00096.chrom20.bam): [QualiMap HTML report](http://rawgit.com/kokonech/kokonech.github.io/master/qualimap/HG00096.chr20_bamqc/qualimapReport.html).

Analysis of the WG-seq data (ERR089819.bam): [QualiMap PDF report](http://rawgit.com/kokonech/kokonech.github.io/master/qualimap/ERR089819_report.pdf).

### RNA-seq QC[¶](#rna-seq-qc "Permalink to this headline")

Analysis of RNA-seq data (kidney.bam, human.64.gtf): [QualiMap HTML report](http://rawgit.com/kokonech/kokonech.github.io/master/qualimap/kidney_rnaseqqc/qualimapReport.html).

### Multisample BAM QC[¶](#id4 "Permalink to this headline")

Multisample analysis of 12 gH2AX ChiP-seq alignments: [Qualimap HTML report](http://rawgit.com/kokonech/kokonech.github.io/master/qualimap/gh2ax_multibamqc/multisampleBamQcReport.html).

Multisample analysis of the same data with condition assigned for each sample: [Qualimap HTML report](http://rawgit.com/kokonech/kokonech.github.io/master/qualimap/gh2ax_groups_multibamqc/multisampleBamQcReport.html).

### Counts QC[¶](#id7 "Permalink to this headline")

Counts QC HTML reports computed from RNA-seq experiment analyzing influence of D-Glucosamine on mice. The analysis was performed for 6 samples in 2 conditions - GlcN positive and negative (mouse\_counts\_ensembl.txt):

* [Global report](http://kokonech.github.io/qualimap/glcn_mice_counts/GlobalReport.html)
* [Comparison of conditions](http://kokonech.github.io/qualimap/glcn_mice_counts/ComparisonReport.html)
* [Sample 01 (GlcN negative)](http://kokonech.github.io/qualimap/glcn_mice_counts/nGlcn01Report.html)
* [Sample 02 (GlcN negative)](http://kokonech.github.io/qualimap/glcn_mice_counts/nGlcn02Report.html)
* [Sample 03 (GlcN negative)](http://kokonech.github.io/qualimap/glcn_mice_counts/nGlcn03Report.html)
* [Sample 04 (GlcN positive)](http://kokonech.github.io/qualimap/glcn_mice_counts/pGlcn01Report.html)
* [Sample 05 (GlcN positive)](http://kokonech.github.io/qualimap/glcn_mice_counts/pGlcn02Report.html)
* [Sample 06 (GlcN positive)](http://kokonech.github.io/qualimap/glcn_mice_counts/pGlcn03Report.html)

Counts QC HTML reports from human RNA-seq data from study by [Marioni JC et al](http://genome.cshlp.org/content/18/9/1509.abstract) (kidney.counts, liver.counts):

* [Global report](http://kokonech.github.io/qualimap/marioni_counts/GlobalReport.html)
* [Comparison of conditions](http://kokonech.github.io/qualimap/marioni_counts/ComparisonReport.html)
* [Sample 01 (Kidney)](http://kokonech.github.io/qualimap/marioni_counts/KidneyReport.html)
* [Sample 02 (Liver)](http://kokonech.github.io/qualimap/marioni_counts/LiverReport.html)

### Clustering[¶](#id11 "Permalink to this headline")

Analysis of MeDIP-seq data: [QualiMap HTML report](http://qualimap.bioinfo.cipf.es/samples/clustering_result/qualimapReport.html).

### Table Of Contents

* [Introduction](intro.html)
* [Workflow](workflow.html)
* [Analysis types](analysis.html)
* [Tools](tools.html)
* [Command Line Interface](command_line.html)
* Examples
  + [Sample Data](#sample-data)
    - [Alignments](#alignments)
    - [Annotations](#annotations)
    - [Multisample BAM QC](#multisample-bam-qc)
    - [Counts QC](#counts-qc)
    - [Clustering](#clustering)
  + [Sample Output](#sample-output)
    - [BAM QC](#bam-qc)
    - [RNA-seq QC](#rna-seq-qc)
    - [Multisample BAM QC](#id4)
    - [Counts QC](#id7)
    - [Clustering](#id11)
* [Frequently Asked Questions](faq.html)

### Search

[previous](command_line.html "Command Line Interface") |
[next](faq.html "Frequently Asked Questions")