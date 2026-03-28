### Navigation

* [index](../../genindex/ "General Index")
* [next](../Adapting/ "6. Adapting Mikado to specific user-cases") |
* [previous](../Daijin_tutorial/ "4. Tutorial for Daijin") |
* [Mikado](../../) »

# 5. Tutorial: how to create a scoring configuration file[¶](#tutorial-how-to-create-a-scoring-configuration-file "Permalink to this headline")

The current version of Mikado relies upon the experimenter to determine what desirable transcripts should look like, and
how to prioritise across different possible isoforms. These instructions are provided through **scoring configuration files**,
whose detailed description can be found in the [general documentation](../../Scoring_files/#scoring-files). In this section, we will
expose a general way to create your own configuration file.

## 5.1. The purpose of scoring files: introductory note[¶](#the-purpose-of-scoring-files-introductory-note "Permalink to this headline")

Mikado is an annotation pipeline, and as such, it does not have, at its core, the mission to represent every possible expressed transcript. Some sequenced transcripts may originate from transcriptional errors, exist only transiently or may have no functional role. When performing a sequencing experiment, we create a “snapshot” of the transient transcriptional state of the cell: inclusive of erroneous events, along with immature transcripts and artifacts arising from misassemblies, fragmentation during library construction, genomic DNA contamination, etc.

In Mikado, we make a choice regarding what transcripts we want to retain in our annotation (as is the case with any genome annotation). For example, as you will see in this tutorial, the standard configuration penalises transcripts with retained CDS introns, and transcripts that are NMD targets. This choice does not mean that we think that these transcripts are artifacts; rather, it signifies that we prioritise those transcripts that are more likely to represent functionally active genes. Annotators will differ on this point: for example, the human reference annotation retains and marks these events, rather than discarding them.

Mikado allows the experimenter to make these choices simply and transparently. Our pre-defined configuration files strive to replicate the choices made by annotators over the years, and thus allow to replicate - as much as possible - the reference annotations of various species starting from partial sequencing data. However, if as an experimenter you are interested in a more stringent approach - say, only coding transcripts with a complete ORF and a UTR - or you would like instead to perform only a minimal cleaning up - say, just discarding obvious NMD targets - Mikado will allow you to do so. This tutorial will show you how.

## 5.2. Obtaining pre-defined scoring files[¶](#obtaining-pre-defined-scoring-files "Permalink to this headline")

Mikado comes with two pre-packaged scoring files, one for plant species as well as another generic for mammalian species. These can be found in the installation directory, under “configuration/scoring\_files”; or, when launching mikado configure, you can request to copy a template file to the working directory (”–copy-scoring” command flag). In the rest of the tutorial, however, we will presume that no suitable scoring file exists and that a new one has to be created from scratch.

## 5.3. First step: defining transcript requirements[¶](#first-step-defining-transcript-requirements "Permalink to this headline")

The first step in the process is to define the minimum attributes of a transcript that should be retained in your annotation. For example, if the experimenter is interested only in coding transcripts and would like to ignore any non-coding RNA, this strict requirement would have to be encoded in this section. Transcripts that do not pass this preliminary filter are completely excluded from any subsequent analysis.

In general, this filter should be very gentle - being too stringent at this stage risks completely throwing out all the transcripts present in a given locus. It is rather preferable to strongly penalise dubious transcripts later at the scoring stage, so that they will be kept in the final annotation if no alternative is present, but discarded in most cases as there will be better alternatives.

The requirements block is composed of two sub-sections:

> * a *parameters* section, which details which [metrics](../../Scoring_files/#metrics) will have to be evaluated, and according to which [operators](../../Scoring_files/#operators).
> * an *expression* section, detailing how the various parameters have to be considered together.

As an example, let us imagine a quite stringent experiment in which we are interested only in transcripts that respect the following conditions:

> * minimum transcript length of 300 bps:
>   - *cdna\_length: {operator: ge, value: 300}*
> * if they are multiexonic, at least one of their junctions must be validated by a junction checker such as Portcullis
>   - *exon\_num: {operator: ge, value: 2}*
>   - *verified\_introns\_num: {operator: gt, value: 0}*
> * if they are multiexonic, their introns must be within 5 and 2000 bps:
>   - *exon\_num: {operator: ge, value: 2}*
>   - *min\_intron\_length: {operator: ge, value: 5}*
>   - *max\_intron\_length: {operator: le, value: 2000}*
> * if they are monoexonic, they must be coding:
>   - *exon\_num: {operator: eq, value: 1}*
>   - *combined\_cds\_length: {operator: gt, value: 0}*

Having defined the parameters, we can now put them together in an *expression*:

```
expression:
    cdna_length and ((exon_num and verified_introns_num and min_intron_length and max_intron_length) or (exon_num and combined_cds_length))
```

Notice that we have used a property twice (*exon\_num*). This would confuse Mikado and cause an error. In order to tell the program that these are actually two different values, we can prepend a suffix, starting with a mandatory dot sign:

> * exon\_num.**multi**: {operator: ge, value: 2}
> * exon\_num.**mono**: {operator: eq, value: 1}

Note

The suffix must be ASCII alphanumeric in character. Therefore, the following suffices are valid:

> * .mono
> * .mono1
> * .mono\_first

```
The expression now becomes:
    cdna_length and ((exon_num.multi and verified_introns_num and min_intron_length and max_intron_length) or (exon_num.mono and combined_cds_length))
```

Warning

if no expression is provided, Mikado will create a default one by connecting all the parameters with an and. This will make life simpler for simple cases (e.g. we only have a couple of parameters we want to check). In complex, conditional scenarios like this one, however, this might well lead to discarding all transcripts!

Putting it all together, this is how the section in the configuration file would look like:

|  |  |
| --- | --- |
| ```  1  2  3  4  5  6  7  8  9 10 11 12 ``` | ``` requirements:     expression:     - cdna_length and ((exon_num and verified_introns_num and min_intron_length     - and max_intron_length) or (exon_num and combined_cds_length))     parameters:     - cdna_length: {operator: ge, value: 300}     - exon_num.multi:  {operator: ge, value: 2}     - verified_introns_num: {operator: gt, value: 0}     - min_intron_length: {operator: ge, value: 5}     - max_intron_length: {operator: le, value: 2000}     - exon_num.mono: {operator: eq, value: 1}     - combined_cds_length: {operator: gt, value: 0} ``` |

Warning

The example in this section is more stringent than the standard selection provided by the included scoring files.

## 5.4. Second step: prioritising transcripts[¶](#second-step-prioritising-transcripts "Permalink to this headline")

After removing transcripts which are not good enough for our annotation, Mikado will analyse any remaining models and assign each a score. How to score models in Mikado is, explicitly, a procedure left to the experimenter, to allow specific tailoring for each different species. In our own experiments, we have abided by the following principles:

1. Good transcripts should preferentially be protein coding, with homology to known proteins in other species, and sport both start and stop codon.
2. Good coding transcripts should contain only one ORF, not multiple; if they have multiple, most of the CDS should be within the primary.
3. The total length of the CDS should be within 60 and 80% of the transcript length, ideally (with the value changing by species, on the basis of available data).
4. All else equal, good coding transcripts should have a long ORF, contain most of the coding bases in the locus, and have that most of their introns are between coding exons.
5. All else equal, good transcripts should be longer and have more exons; however, there should be no preference between mono- and di-exonic transcripts.
6. Good coding transcripts should have a defined UTR, on both sides; however, if the UTR goes beyond a certain limit, the transcript should be penalised instead. For 5’UTR, we preferentially look at transcripts with at most four UTR exons, and preferentially **two**, for a total length of ideally 100 bps and maximally of 2500. For 3’UTR, based on literature and the phenomenon of nonsense mediated decay (NMD), we look for transcripts with at most **two** UTR exons and ideally **one**; the total length of this UTR should be ideally of 200 bps, and at most of 2500.
7. Multiexonic transcripts should have at least some of their junctions confirmed by Portcullis, ideally all of them. Ideally and all else equal, they should contain all of the verified junctions in the locus.
8. The distance between the stop codon and the last junction in the transcript should be the least possible, and in any case, not exceed 55 bps (as discovered by studies on NMD).

The first step is to associate each of these requirements with the proper [metric](../../Scoring_files/#metrics). In order:

1. Good transcripts should preferentially be protein coding, with a good BLAST coverage of homologous proteins, and sport start and stop codon:

   > * snowy\_blast\_score: look for the maximum value
   > * is\_complete: look for `true`
   > * has\_start\_codon: look for `true`
   > * has\_stop\_codon: look for `true`

Looking at the documentation on [scoring files](../../Scoring_files/#scoring-files), we can write it down thus:

```
- snowy_blast_score: {rescaling: max}
- is_complete: {rescaling: target, value: true}
- has_start_codon: {rescaling: target, value: true}
- has_stop_codon: {rescaling: target, value: true}
```

Applying the same procedure to the rest of the conditions:

2. Good coding transcripts should contain only one ORF, not multiple; if they have multiple, most of the CDS should be within the primary.

   > * number\_internal\_orfs: look for a target of 1
   > * cds\_not\_maximal: look for the **minimum** value
   > * cds\_not\_maximal\_fraction: look for the **minimum** value

```
- number_internal_orfs: {rescaling: target, value: 1}
- cds_not_maximal: {rescaling: min}
- cds_not_maximal_fraction: {rescaling: min}
```

3. The total length of the CDS should be within 60 and 80% of the transcript length, ideally (with the value changing by species, on the basis of available data).

   > * selected\_cds\_fraction: look for a target of x *(where x depends on the species and is between 0 and 1)*, for example, let us set it to 0.7

```
- selected_cds_fraction: {rescaling: target, value: 0.7}
```

4. All else equal, good coding transcripts should have a long ORF, contain most of the coding bases in the locus, and have that most of their introns are between coding exons.

   > * cdna\_length: look for the maximum value
   > * selected\_cds\_length: look for the maximum value
   > * selected\_cds\_intron\_fraction: look for the maximum value

```
- selected_cds_length: {rescaling: max}
- selected_cds_intron_fraction: {rescaling: max}
- selected_cds_intron_fraction: {rescaling: max}
```

5. All else equal, good transcripts should be longer and have more exons; however, there should be no preference between mono- and di-exonic transcripts.

   > * cdna\_length: look for the maximum value
   > * exon\_num: look for the maximum value, ignore for any transcript with one or two exons.

```
- cdna_length: {rescaling: max}
- exon_num: {rescaling: max, filter: {operator: ge, value: 3}
```

6. Good coding transcripts should have a defined UTR, on both sides; however, if the UTR goes beyond a certain limit, the transcript should be penalised instead.

   > * For 5’UTR, we preferentially look at transcripts with at most three UTR exons, and preferentially **two**, for a total length of ideally 100 bps and maximally of 2500.
   >
   >   > + five\_utr\_num: look for a target of 2, ignore anything with four or more 5’ UTR exons
   >   > + five\_utr\_length: look for a target of 100, ignore anything with 2500 or more bps
   > * For 3’UTR, based on literature and the phenomenon of nonsense mediated decay (NMD), we look for transcripts with at most **two** UTR exons and ideally **one**; the total length of this UTR should be ideally of 200 bps, and at most of 2500.
   >
   >   > + three\_utr\_num: look for a target of 1, ignore anything with three or more 3’UTR exons
   >   > + three\_utr\_length: look for a target of 200, ignore anything with 2500 bps or more

```
- five_utr_num: {rescaling: target, value: 2, filter: {operator: lt, value: 4}}
- five_utr_length: {rescaling: target, value: 100, filter: {operator: le, value: 2500}}
- three_utr_num: {rescaling: target, value: 1, filter: {operator: lt, value: 3}}
- three_utr_length: {rescaling: target, value: 200, filter: {operator: lt, value: 2500}}
```

7. Multiexonic transcripts should have at least some of their junctions confirmed by Portcullis, ideally all of them. Ideally and all else equal, they should contain most of the verified junctions in the locus.

   > * proportion\_verified\_introns\_inlocus: look for the maximum value
   > * non\_verified\_introns\_num: look for the minimum value

```
- proportion_verified_introns_inlocus: {rescaling: max}
- non_verified_introns_num: {rescaling: min}
```

8. The distance between the stop codon and the last junction in the transcript should be the least possible, and in any case, not exceed 55 bps (as discovered by studies on NMD).

   > * end\_distance\_from\_junction: look for the minimum value, discard anything over 55

```
- end_distance_from_junction: {rescaling: min, filter: {operator: lt, value: 55}}
```

Putting everything together:

```
scoring:
    - snowy_blast_score: {rescaling: max}
    - is_complete: {rescaling: target, value: true}
    - has_start_codon: {rescaling: target, value: true}
    - has_stop_codon: {rescaling: target, value: true}
    - number_internal_orfs: {rescaling: target, value: 1}
    - cds_not_maximal: {rescaling: min}
    - cds_not_maximal_fraction: {rescaling: min}
    - selected_cds_fraction: {rescaling: target, value: 0.7}
    - selected_cds_length: {rescaling: max}