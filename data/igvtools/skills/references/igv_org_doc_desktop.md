IGV Desktop Application

* About IGV
* [Quick Start](QuickStart/)
* User Guide
* + [Reference genome](UserGuide/reference_genome/)
  + [Loading and removing tracks](UserGuide/loading_data/)
  + [Navigating the view](UserGuide/navigation/)
  + Tracks and Data Types
  + - [Track attributes](UserGuide/tracks/track_attributes/)
    - [Genome annotations](UserGuide/tracks/annotations/)
    - [Reference sequence](UserGuide/tracks/sequence/)
    - [Quantitative data](UserGuide/tracks/quantitative_data/)
    - Alignments
    - * [Alignments basics](UserGuide/tracks/alignments/viewing_alignments_basics/)
      * [Paired-end alignments](UserGuide/tracks/alignments/paired_end_alignments/)
      * [RNA-seq data](UserGuide/tracks/alignments/rna_seq/)
      * [Bisulfite sequencing](UserGuide/tracks/alignments/bisulfite_sequencing/)
      * [Base modifications](UserGuide/tracks/alignments/base_modifications/)
      * [Chimeric reads](UserGuide/tracks/alignments/chimeric_reads/)
      * [SMRT kinetics](UserGuide/tracks/alignments/smrt/)
      * [SBX alignments](UserGuide/tracks/alignments/sbx/)
      * [Ultima indel coloring](UserGuide/tracks/alignments/ultima/ultima/)
    - [Variants (VCF)](UserGuide/tracks/vcf/)
    - [GWAS](UserGuide/tracks/gwas/)
  + [Sample attributes](UserGuide/sample_attributes/)
  + [Regions](UserGuide/regions/)
  + [Sessions](UserGuide/sessions/)
  + [Saving images](UserGuide/saving_images/)
  + [User preferences](UserGuide/preferences/)
  + Tools Menu
  + - [Batch scripts](UserGuide/tools/batch/)
    - [igvtools](UserGuide/tools/igvtools_ui/)
    - [Motif finder](UserGuide/tools/motif_finder/)
    - [BLAT](UserGuide/tools/blat/)
    - [Combining tracks](UserGuide/tools/combine_tracks/)
  + Advanced
  + - [IGV from the command line](UserGuide/advanced/command_line/)
    - [External control of IGV](UserGuide/advanced/external_control/)
    - [Authentication](UserGuide/advanced/oauth/)
    - [AWS support](UserGuide/advanced/aws/)
* File Formats
* + [Data Tracks](FileFormats/DataTracks/)
  + [Sample Info (Attributes)](FileFormats/SampleInfo/)
  + [Genomes](FileFormats/Genomes/)
* [Tutorial Videos](TutorialVideos/)
* [Download IGV](DownloadPage/)
* Release Notes
* + [2.19.x](ReleaseNotes/2.19.x/)
  + [2.18.x](ReleaseNotes/2.18.x/)
  + [2.17.x](ReleaseNotes/2.17.x/)
  + [2.16.x](ReleaseNotes/2.16.x/)
  + [2.15.x](ReleaseNotes/2.15.x/)
  + [2.14.x](ReleaseNotes/2.14.x/)
  + [2.13.x](ReleaseNotes/2.13.x/)
  + [2.12.x](ReleaseNotes/2.12.x/)
  + [2.11.x](ReleaseNotes/2.11.x/)
  + [2.10.x](ReleaseNotes/2.10.x/)
  + [2.9.x](ReleaseNotes/2.9.x/)
  + [2.8.x](ReleaseNotes/2.8.x/)
* [Getting Help](GettingHelp/)

About IGV

![IGV banner](img/banner.png)

# Overview[#](#overview "Direct link to this section")

The **Integrative Genomics Viewer (IGV)** is a high-performance, easy-to-use, interactive tool for the visual
exploration of genomic data. It supports flexible integration of all the common types of genomic data and metadata,
investigator-generated or publicly available, loaded from local or cloud sources.

IGV is available in multiple forms, including:

* the original **IGV** - a Java desktop application,
* **IGV-Web** - a web application,
* **igv.js** - a JavaScript component that can be embedded in web pages *(for* *developers)*

This site is focused on the IGV desktop application. See **<https://igv.org>** for links to all forms
of IGV.

# IGV website[#](#igv-website "Direct link to this section")

<https://igv.org>

# Usage license and source code[#](#usage-license-and-source-code "Direct link to this section")

IGV is completely open for anyone to use under an [MIT open-source license](https://github.com/igvteam/igv/blob/master/license.txt).

The source code repository for the IGV desktop application is hosted on GitHub at <https://github.com/igvteam/igv>.

# Citing IGV[#](#citing-igv "Direct link to this section")

To cite your use of IGV in your publication, please reference one or more of:

James T. Robinson, Helga Thorvaldsdóttir, Wendy Winckler, Mitchell Guttman, Eric S. Lander, Gad Getz, Jill P.Mesirov.
[**Integrative Genomics
Viewer**. Nature Biotechnology 29, 24–26 (2011)](http://www.nature.com/nbt/journal/v29/n1/abs/nbt.1754.html). (Free PMC
article [here](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3346182/)).

Helga Thorvaldsdóttir, James T. Robinson, Jill P. Mesirov.
[**Integrative Genomics Viewer (IGV): high-performance genomics data visualization and
exploration**. Briefings in Bioinformatics 14, 178-192 (2013)](https://academic.oup.com/bib/article/14/2/178/208453/Integrative-Genomics-Viewer-IGV-high-performance?searchresult=1)
.

James T. Robinson, Helga Thorvaldsdóttir, Aaron M. Wenger, Ahmet Zehir, Jill P. Mesirov.
[**Variant Review with the
Integrative Genomics Viewer (IGV)
.** Cancer Research 77(21) 31-34 (2017)](http://cancerres.aacrjournals.org/content/77/21/e31.long).

James T. Robinson, Helga Thorvaldsdóttir, Douglass Turner, Jill P. Mesirov.
[**igv.js: an embeddable JavaScript implementation of the Integrative Genomics Viewer (IGV)**, Bioinformatics, 39(1) (2023), btac830](https://doi.org/10.1093/bioinformatics/btac830).

# Funding[#](#funding "Direct link to this section")

Development of IGV has been supported by funding from the [National Cancer Institute (NCI)](http://cancer.gov) of
the [National Institutes of Health](https://www.nih.gov),
the [Informatics Technology for Cancer Reserarch (ITCR)](https://itcr.nci.nih.gov) of the NCI, and
the [Starr Cancer Consortium](http://www.starrcancer.org/starr/html/83159.cfm).

​

---

Documentation built with [MkDocs](http://www.mkdocs.org/) using a modified version of the [Windmill](https://github.com/gristlabs/mkdocs-windmill) theme by Grist Labs.