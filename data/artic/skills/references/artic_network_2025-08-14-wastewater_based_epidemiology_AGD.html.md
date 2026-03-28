Toggle navigation

[![](/images/artic-logo-small.svg)](/index.html)

* Toggle Sidebar

* ARTIC 2
* [About](/about "About")
* [People](/people/artic-network "People")
* [News](/news "News")
* Resources
  + [Overview](/resources "Overview")
  + [Viruses](/viruses "Viruses")
  + [Protocols](/protocols "Protocols")
  + [Pipelines](/pipelines "Pipelines")
  + [Software](/software "Software")
* Training
  + [Overview](/training "Overview")
  + [Workshops](/training/workshops "Workshops")
  + [Tutorials](/training/tutorials "Tutorials")
  + [Guides](/training/guides "Guides")
* Projects
  + [Overview](/projects "Overview")
  + [ARTIC-1](/projects/artic1 "ARTIC-1")
  + [ARTIC-2](/projects/artic2 "ARTIC-2")
* [FAQ](/faq "FAQ")

# Are sewers a gold mine of epidemiological data? Applying the ARTIC approach to wastewater

Aug 14, 2025 / Alvaro Garcia Delgado

![Image](images/posts/2025-08-15_sampling_collage1.png)

### What is wastewater-based epidemiology?

Interest in wastewater-based epidemiology (WBE) peaked during the SARS-CoV-2 pandemic; a number of governments turned to it in the hope of informing their strategy to manage the virus at a time when balancing economic needs with protecting public health was a top priority. But what is WBE and what does it have to do with the ARTIC project?

WBE, as its name suggests, consists in the use of wastewater to track the health of populations, including the prevalence of viral diseases. For this it relies on the fact that many viruses, even respiratory ones, are often shed in the faeces of infected people. Because sewers collect faeces from entire populations, the amount of a virus that is detected in a sewer can serve as a measure of the prevalence of that virus in the population it serves.

WBE has several advantages over clinical testing, and perhaps the most notable is how efficient it is. To provide a representative picture of infection burden of a population through clinical testing, a representative number of samples must be taken and processed, involving substantial efforts and cost; on the other hand, a single sample of wastewater can provide an estimate for the entire population within a sewershed (the area drained by one discrete sewer system). Because everyone contributes to the production of wastewater, this approach does not miss asymptomatic cases. Furthermore, in the case of SARS-CoV-2 it has been found on several occasions (Karthikeyan et al. 2022; Nemudryi et al., 2020) that wastewater monitoring can identify epidemiological trends earlier than clinical testing. These advantages were what caused interest in WBE to peak during the SARS-CoV-2 pandemic in the early 2020s, with several countries setting up their own testing networks (including the four nations of the UK).

### Next-generation sequencing in WBE

Quantification of viral burdens is not the only capability of WBE. DNA sequencing can be used to obtain information about what viral strains are found in wastewater, which can serve to detect cryptic (hidden) variants, follow trends in circulating variants, track their spread, etc. This ties in well with the ARTIC goals of using viral genome sequencing to enhance response to disease outbreaks and epidemics! There are caveats, however, to sequencing in wastewater; viral genetic material of interest is often found at very low concentrations relative to irrelevant genetic material. This makes it difficult to obtain information from pure, untargeted metagenomic sequencing, as most of sequencing data is background noise.

Tiled amplicon sequencing can be used to address this problem. Tiled amplicon sequencing in this context consists in selectively amplifying the genome of a target virus before sequencing; by having a large amount of the target relative to the background noise, it becomes more effective. This is one of the main efforts of the Quick Lab at the University of Birmingham: to develop the primer schemes necessary to perform this technique on a range of viruses. PrimalScheme, the software used to design primer schemes, was built at the Quick lab with the aim of facilitating real-time molecular epidemiology in the context of the Zika epidemic (Quick et al., 2017). Originally primer schemes were used to amplify low-concentration viruses from clinical samples, but the same advantages apply in the context of wastewater.

However, there are concerns with this approach too. The PCR reaction used to amplify the target virus relies on primers that match sections of its genome, but there is always a possibility of these primers matching unintended bits of DNA. For example, primers can match up with other primers, which can result in large amounts of bogus DNA being generated. PrimalScheme, has in-built checks that take this into account, and avoids including primers that match themselves or each other in any given scheme. Unfortunately, primers may still match up with other background DNA in a sample, which is relatively abundant and varied in wastewater samples. If this results in non-target amplification, this can negate the advantages of tiled amplicon sequencing.

### Current research at the University of Birmingham

To investigate the effectiveness of tiled amplicon sequencing in complex samples such as wastewater, we have set up an experimental sampling and testing program here at the University of Birmingham. The samples are collected from the sewers of our own campus and processed in our labs at the School of Biosciences. These are weekly “grab” samples, collected simply by dipping a bucket in the wastewater stream. Though the means of sampling are rudimentary they are straightforward, and our initial tests demonstrate the presence of the faecal indicator virus crAssphage (ie., there is human waste in our water, and the extraction methods work). Additionally, we have been able to detect traces of SARS-CoV-2 and norovirus, which are a reminder of why WBE can be useful in the first place.

These samples will serve to investigate the relationship between the concentration of a virus in wastewater, and the performance of tiled amplicon sequencing in several parameters. For example, how does virus concentration relate to genome coverage and completeness? What are the most common unintended by-products of our assays in real wastewater samples? What changes in the amplicon schemes or reactions can reduce these unintended by-products? And so on. By answering these questions we can understand when it is appropriate to use tiled amplicon sequencing, how reliable results will be depending on virus concentration, and produce assays that are more specific and efficient.
Ultimately, we expect the research underpinned by our wastewater collection program to improve how reliable and informative viral genome sequencing is in the context of WBE. Better WBE, in turn, can inform authorities in their response to outbreaks or in their management common diseases, helping shape policy and healthcare resource allocation, with more early warning and more efficiency than relying solely on clinical testing.

### References

Karthikeyan, S., Levy, J. I., De Hoff, P., Humphrey, G., Birmingham, A., Jepsen, K., … & Knight, R. (2022). Wastewater sequencing reveals early cryptic SARS-CoV-2 variant transmission. *Nature*, *609*(7925), 101-108.

Nemudryi, A., Nemudraia, A., Wiegand, T., Surya, K., Buyukyoruk, M., Cicha, C., … & Wiedenheft, B. (2020). Temporal detection and phylogenetic assessment of SARS-CoV-2 in municipal wastewater. *Cell Reports Medicine*, *1*(6).

Quick, J., Grubaugh, N. D., Pullan, S. T., Claro, I. M., Smith, A. D., Gangavarapu, K., … & Loman, N. J. (2017). Multiplex PCR method for MinION and Illumina sequencing of Zika and other virus genomes directly from clinical samples. *Nature protocols*, *12*(6), 1261-1276.

---

©2026 ARTIC network. All rights reserved.
Site last generated: Mar 27, 2026

![ARTIC logo](/images/artic.png)![Wellcome logo](/images/wellcome-logo.png)