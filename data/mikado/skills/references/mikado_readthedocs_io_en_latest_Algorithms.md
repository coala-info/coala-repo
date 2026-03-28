### Navigation

* [index](../genindex/ "General Index")
* [next](../Scoring_files/ "9. Scoring files") |
* [previous](../Usage/Utilities/ "7.4.1. Mikado miscellaneous scripts") |
* [Mikado](../) »

# 8. Mikado core algorithms[¶](#mikado-core-algorithms "Permalink to this headline")

## 8.1. Picking transcripts: how to define loci and their members[¶](#picking-transcripts-how-to-define-loci-and-their-members "Permalink to this headline")

The Mikado pick algorithm

[![../_images/Mikado_algorithm.jpeg](../_images/Mikado_algorithm.jpeg)](../_images/Mikado_algorithm.jpeg)

Schematic representation of how Mikado unbundles a complex locus into two separate genes.

Transcripts are scored and selected according to user-defined rules, based on many different features of the transcripts themselves (cDNA length, CDS length, UTR fraction, number of reliable junctions, etc.; please see the [dedicated section on scoring](../Scoring_files/#scoring-files) for details on the scoring algorithm).

The detection and analysis of a locus proceeds as follows:

1. When the first transcript is detected, Mikado will create a *superlocus* - a container of transcripts sharing the same genomic location - and assign the transcript to it.
2. While traversing the genome, as long as any new transcript is within the maximum allowed flanking distance, it will be added to the superlocus.
3. When the last transcript is added, Mikado performs the following preliminary operations:

   > 1. Integrate all the data from the database (including ORFs, reliable junctions in the region, and BLAST homology).
   > 2. If a transcript is monoexonic, assign or reverse its strand if the ORF data supports the decision
   > 3. If requested and the ORF data supports the operation, split chimeric transcripts - ie those that contain two or more non-overlapping ORFs on the same strand.
   > 4. Split the superlocus into groups of transcripts that:
   >
   >    > * share the same strand
   >    > * have at least 1bp overlap
   > 5. Analyse each of these novel “stranded” superloci separately.
4. Create *subloci*, ie group transcripts so to minimize the probability of mistakenly merging multiple gene loci due to chimeras. These groups are defined as follows:

   > * if the transcripts are multiexonic, they must share at least one intron, inclusive of the borders
   > * if the transcripts are monoexonic, they must overlap by at least 1bp.
   > * Monoexonic and multiexonic transcripts *cannot* be part of the same sublocus.
5. Select the best transcript inside each sublocus:

   > 1. Score the transcripts (see the [section on scoring](../Scoring_files/#scoring-files))
   > 2. Select as winner the transcript with the highest score and assign it to a *monosublocus*
   > 3. Discard any transcript which is overlapping with it, according to the definitions in the point above
   > 4. Repeat the procedure from point 2 until no transcript remains in the sublocus
6. *Monosubloci* are gathered together into *monosubloci holders*, ie the seeds for the gene loci. Monosubloci holders have more lenient parameters to group transcripts, as the first phase should have already discarded most chimeras. Once a holder is created by a single *monosublocus*, any subsequent candidate *monosublocus* will be integrated only if the following conditions are satisfied:

   > * if the candidate is monoexonic, its exon must overlap at least one exon of a transcript already present in the holder
   > * if the candidate is multiexonic and the holder contains only monoexonic transcripts, apply the same criterion, ie check whether its exons overlap the exons of at least one of the transcripts already present
   > * if the candidate is multiexonic and the holder contains multiexonic transcripts, check whether one of the following conditions is satisfied:
   >
   >   > + at least one intron of the candidate overlaps with an intron of a transcript in the holder
   >   > + at least one intron of the candidate is completely contained within an exon of a transcript in the holder
   >   > + at least one intron of a transcript in the holder is completely contained within an exon of a transcript in the holder.
   >   > + the cDNA overlap and CDS overlap between the candidate and the transcript in the holder are over a [specified threshold](../Usage/Configure/#clustering-specifics).

   Optionally, it is possible to tell Mikado to use a simpler algorithm, and integrate together all transcripts that share exon space. Such a simpler algorithm risks, however, chaining together multiple loci - especially in small, compact genomes.
7. Once the holders are created, apply the same scoring and selection procedure of the sublocus selection step. The winning transcripts are assigned to the final *loci*. These are called the *primary transcripts of the loci*.
8. Once the loci are created, track back to the original transcripts of the superlocus:

   > 1. discard any transcript overlapping more than one locus, as these are probably chimeras.
   > 2. For those transcripts that are overlapping to a single locus, verify that they are valid alternative splicing events using the [class code](../Usage/Compare/#ccodes) of the comparison against the primary transcript. Transcripts are re-scored dynamically when they are re-added in this fashion, to ensure their quality when compared with the primary transcript.
   >
   >    > * For coding loci, transcripts will be added as alternative splicing events **only if they are in the same frame as the primary transcript**. New in version 1.5.
   > 3. If there are transcripts that do not overlap any of the final loci, create a new superlocus with the missed transcripts and perform the scoring and selection again on them, until no transcript is unaccounted for.
9. After the alternative splicing events have been defined, Mikado can optionally “pad” them. See the [padding section](#padding) for details.
10. Finally detect and either tag or discard fragments inside the initial *superlocus* (irrespective of strand):

    > 1. Check whether the primary transcript of any locus meets the criteria to be defined as a fragment (by default, maximum ORF of 30AA and maximum 2 exons - any transcript exceeding either criterion will be considered as non-fragment by default)
    > 2. If so, verify whether they are near enough any valid locus to be considered as a fragment (in general, class codes which constitute the “Intronic”, “Fragmentary” and “No overlap” categories).
    > 3. If these conditions are met, tag the locus as a fragment. If requested, Mikado will just discard these transcripts (advised).

These steps help Mikado identify and solve fusions, detect correctly the gene loci, and define valid alternative splicing events.

## 8.2. Definition of retained introns[¶](#definition-of-retained-introns "Permalink to this headline")

When gathering transcripts into loci, Mikado will try to identify and tag transcripts that contain retained intron events. For our purposes, a retained intron event is an exon which:

* is part of a **coding** transcript but is *not* completely coding itself.
* if it is an *internal* exon, it **completely spans** the putative retained intron.
* if it is a *terminal* exon, it must start within the exon of the putative retained intron, and terminate within the intron.
* if it constitutes a monoexonic transcript, at least one of the two ends must reside within the bordering exons.

In addition to this, a transcript might be tagged as having its CDS disrupted by the retained intron event if:

* the non-coding part of the exon is in the 3’UTR and it begins within the intron
* the exon is 3’ terminal, coding and it ends within the intron.

Warning

The definition of a retained intron is **stricty context dependent**, i.e. the same exon will be regarded as a “retained intron” if the transcript is gathered together with other transcripts, but as non-retained if it were in isolation. It is therefore **normal and expected** that the associated metrics and scores will change, for a given transcript, across the various clustering stages.

## 8.3. Identification and breaking of chimeric transcripts[¶](#identification-and-breaking-of-chimeric-transcripts "Permalink to this headline")

When a transcript contains more than one ORF, Mikado will try to determine whether this is due to a retained intron event or a frameshift (in which case the two ORFs are presumed to be mangled forms of an original, correct ORF for a single protein) or whether instead this is due to the fragment being polycystronic (in a prokaryote) or chimeric (in a eukaryote). The latter case is relatively common due to technical artefacts during sequencing and assembling of RNASeq reads.

A chimeric transcript is defined by Mikado as a model with multiple ORFs, where:

> * all the ORFs share the same strand
> * all the ORFs are non-overlapping.

In these situations, Mikado can try to deal with the chimeras in five different ways, in decreasingly conservative fashion:

* *nosplit*: leave the transcript unchanged. The presence of multiple ORFs will affect the scoring.
* *stringent*: leave the transcript unchanged, unless the two ORFs both have hits in the protein database and none of the hits is in common.
* *lenient*: leave the transcript unchanged, unless *either* the two ORFs both have hits in the protein database, none of which is in common, *or* both have no hits in the protein database.
* *permissive*: presume the transcript is a chimera, and split it, *unless* two ORFs share a hit in the protein database.
* *split*: presume that every transcript with more than one ORF is incorrect, and split them.

If any BLAST hit *spans* the two ORFs, then the model will be considered as a non-chimera because there is evidence that the transcript constitutes a single unit. The only case when this information will be disregarded is during the execution of the *split* mode.

These modes can be controlled directly from the [pick command line](../Usage/Pick/#pick), or during the [initial configuration stage](../Usage/Configure/#configure).

## 8.4. Transcript measurements and scoring[¶](#transcript-measurements-and-scoring "Permalink to this headline")

In order to determine the best transcript for each locus, Mikado measures each available candidate according to various different [metrics](../Scoring_files/#metrics) and assigning a specific score for each of those. Similarly to [RAMPART](https://github.com/TGAC/RAMPART) [[Rampart]](../References/#rampart), Mikado will assign a score to each transcript for each metric by assessing it relatively to the other transcripts in the locus. The particular feature rescaling equation used for a given metric depends on the type of feature it represents:

* metrics where higher values represent better transcript assemblies (“maximum”).
* metrics where lower values represent better transcript assemblies (“minimum”)
* metrics where values closer to a defined value represent better assemblies (“target”)

To allow for this tripartite scoring system with disparate input values, we have to employ rescaling equations so that each metric for each transcript will be assigned a score between 0 and 1. Optionally, each metric might be assigned a greater weight so that its maximum possible value will be greater or smaller than 1. Formally, let metric \(m\) be one of the available metrics \(M\), \(t\) a transcript in locus \(L\), \(w\_{m}\) the weight assigned to metric \(m\), and \(r\_{mt}\) the raw value of metric \(m\) for \(t\). Then, the score to metric \(m\) for transcript \(t\), \(s\_{mt}\), will be derived using one of the following three different rescaling equations:

* If higher values are best:
  :   \(s\_{mt} = w\_{m} \* (\frac{r\_{mt} - min(r\_m)}{max(r\_m)-min(r\_m)})\)
* If lower values are best:
  :   \(s\_{mt} = w\_{m} \* (1 - \frac{r\_{mt} - min(r\_m)}{max(r\_m)-min(r\_m)})\)
* If values closer to a target \(v\_{m}\) are best:
  :   \(s\_{mt} = w\_{m} \* (1 - \frac{|r\_{mt} - v\_{m}|}{max(|r\_{m} - v\_{m}|)})\)

Finally, the scores for each metric will be summed up to produce a final score for the transcript:
:   \(s\_{t} = \sum\_{m \forall m \in M} s\_{mt}\).

Not all the available metrics will be necessarily used for scoring; the choice of which to employ and how to score and weight each of them is left to the experimenter, although Mikado provides some pre-configured scoring files.
Values that are guaranteed to be between 0 and 1 (e.g. a percentage value) can be used directly as scores, by setting the *use\_raw* parameter as true for them.

Details on the structure of scoring files can be found [in a dedicated section](../Scoring_files/#scoring-files); we also provide a tutorial on [how to create your own scoring file](../Tutorial/Scoring_tutorial/#configure-scoring-tutorial).

Important

The scoring algorithm is dependent on the other transcripts in the locus, so each score should not be taken as an *absolute* measure of the reliability of a transcript, but rather as a measure of its **relative goodness compared with the alternatives**. Shifting a transcript from one locus to another can have dramatic effects on the scoring of a transcript, even while most or all of the underlying metric values remain unchanged. This is why the score assigned to each transcript changes throughout the Mikado run, as transcripts are moved to subloci, monoloci and finally loci.

## 8.5. Padding transcripts[¶](#padding-transcripts "Permalink to this headline")

Mikado has the ability of padding transcripts in a locus, so to uniform their starts and stops, and to infer the presence
of missing exons from neighbouring data. The procedure is similar to the one employed by PASA and functions as follows:

1. A transcript can function as **template** for a candidate if:

> * the candidate’s terminal exon falls within an **exon** of the template
> * the extension would enlarge the candidate by at most *“ts\_distance”* basepairs (not including introns), default
>   **2000** bps
> * the extension would add at most *“ts\_max\_splices”* splice sites to the candidate, default **2**.

2. A graph of possible extensions is built for both the 5’ end and the 3’ end of the locus.
   Transcripts are then divided in extension groups, starting with the outmost (ie the potential **template** for the group). Links that would cause chains
   (e.g. A can act as template for B and B can act as template for C, but A *cannot* act as template for C) are broken.

2. Create a copy of the transcripts in the locus, for backtracking.
3. Start expanding each transcript:

> 1. Create a copy of the transcript for backtracking
> 2. Calculate whether the 5’ terminal exon should be enlarged:
>
> > * if the transcript exon terminally overlaps a template exon, enlarge it until the end of the template
> > * If the template transcript has multiple exons upstream of the expanded exon, add those to the transcript.
> > * Calculate the number of bases that have been