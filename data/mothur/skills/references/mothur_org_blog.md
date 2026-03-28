[![logo](/assets/img/mothur_RGB.png)mothur](/)

[mothur/mothur.github.io](https://github.com/mothur/mothur.github.io "Go to repository")

* [Wiki](/wiki)

+ - [MiSeq SOP](/wiki/miseq_sop)
  - [Manual](/wiki/mothur_manual)
  - [FAQ](/wiki/frequently_asked_questions)
  - [Analysis examples](/wiki/analysis_examples)
  - [Download](https://github.com/mothur/mothur/releases/latest)

* [Workshops](https://riffomonas.org/workshops)
* [Blog](/blog)
* [Forum](https://forum.mothur.org)
* [facebook](https://facebook.com/mothur)
* [About](/about)

Pat offers mothur and R workshops through Riffomonas Professional Development. [Learn more](https://riffomonas.org/workshops)!

[Edit this page](https://github.com/mothur/mothur.github.io/edit/master/pages/blog.md)
[Ask question about or comment on this page](https://github.com/mothur/mothur.github.io/issues/new?labels=question&title=Question on: mothur's blog)

# mothur's blog

mothur is designed to help scientists to curate and analyze their 16S rRNA gene sequences. Frequently, there will be questions that come up where it would be helpful to demonstrate various concepts and processes. The code presented in this blog represents commands from mothur as well as in R. Here are some of the things we’ll cover at the blog…

* Demo new features that have been incorporate into mothur
* Describe how reference files were generated
* Test ideas being bandied about in the literature
* Respond to common or good questions that you email us

Another goal is to engage the community in a framework that supports reproducible science. These blog posts are not written as much as they are executed to generate their results. You can download all of the source code used to build this site at [our github repository](https://github.com/mothurblog/mothurblog.github.io). There you can fork the repository and play around with our code to test various assumptions and modify the code to suit your needs.

Want to older posts? See the [archive](/archive/). Feel free to reach out to us if you have any questions!

---

* Sep 26, 2024
  [README for the SILVA v138.2 reference files](/blog/2024/SILVA-v138_2-reference-files/)

  The good people at [SILVA](http://arb-silva.de) have released a new version of the SILVA v138 (and v138.1) database. [My understanding](https://www.arb-silva.de/documentation/release-1382/) is that this update removed 13 sequences from v138. The biggest change was a number of modifications to the taxonomy including applying 6 taxonomic levels and using “Incertae Sedis” instead of “unclassified”. A little bit of tweaking is needed to get their files to be compatible with mothur. This README document describes the process that I used to generate the [mothur-compatible reference files](http://www.mothur.org/wiki/Silva_reference_files).
* Jun 25, 2024
  [README for the greengenes2 2020\_10 reference files](/blog/2024/greengenes2_2020_10/)

  The [biocore group](https://github.com/biocore/greengenes2/) released an updated version of the greengenes taxonomy in [October 2022](https://ftp.microbio.me/greengenes_release/2022.10/), which was published in [Nature Biotechnology](https://www.nature.com/articles/s41587-023-01845-1). If you use these files, you should cite McDonald et al.
* Mar 12, 2024
  [README for the RDP v19 reference files](/blog/2024/RDP-v19-reference-files/)

  The good people at the [RDP](http://rdp.cme.msu.edu) have released a new version of the RDP database. A little bit of tweaking is needed to get their files to be compatible with mothur. This README document describes the process that I used to generate the [mothur-compatible reference files](http://mothur.org/wiki/RDP_reference_files). The original files are available from the RDPs [sourceforge server](http://sourceforge.net/projects/rdp-classifier/files/RDP_Classifier_TrainingData/) and were used as the starting point for this README.
* Feb 23, 2021
  [README for the SILVA v138.1 reference files](/blog/2021/SILVA-v138_1-reference-files/)

  The good people at [SILVA](http://arb-silva.de) have released a new version of the SILVA v138 database. My understanding is that this is a minor update to correct some taxonomic information. A little bit of tweaking is needed to get their files to be compatible with mothur. This README document describes the process that I used to generate the [mothur-compatible reference files](http://www.mothur.org/wiki/Silva_reference_files).
* Feb 4, 2021
  [README for the RDP v18 reference files](/blog/2021/RDP-v18-reference-files/)

  The good people at the [RDP](http://rdp.cme.msu.edu) have released a new version of the RDP database. A little bit of tweaking is needed to get their files to be compatible with mothur. This README document describes the process that I used to generate the [mothur-compatible reference files](http://mothur.org/wiki/RDP_reference_files). The original files are available from the RDPs [sourceforge server](http://sourceforge.net/projects/rdp-classifier/files/RDP_Classifier_TrainingData/) and were used as the starting point for this README.

Subscribe with [RSS](/feed.xml) to keep up with the latest news.

© 2019 Patrick D. Schloss, PhD
All content on this site is available under the [CC-BY 4.0 license](https://creativecommons.org/licenses/by/4.0/)

[About mothur](/about/)