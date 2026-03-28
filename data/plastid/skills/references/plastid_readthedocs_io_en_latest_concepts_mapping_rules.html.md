[plastid](../index.html)

latest

Getting started

* [Getting started](../quickstart.html)
* [Tour](../tour.html)
* [Installation](../installation.html)
* [Demo dataset](../test_dataset.html)
* [List of command-line scripts](../scriptlist.html)

User manual

* [Tutorials](../examples.html)
  + [Cookbook](../examples.html#cookbook)
  + [In-depth](../examples.html#in-depth)
    - [Coordinate systems used in genomics](coordinates.html)
    - [Categories and formats of genomics data](data.html)
    - [Working with GFF files](gff3.html)
    - Read mapping functions
      * [Mapping functions included in `plastid`](#mapping-functions-included-in-plastid)
      * [Writing new mapping functions](#writing-new-mapping-functions)
      * [See also](#see-also)
    - [Ambiguous read alignments](multimappers.html)
* [Module documentation](../generated/plastid.html)
* [Frequently asked questions](../FAQ.html)
* [Glossary of terms](../glossary.html)
* [References](../zreferences.html)

Developer info

* [Contributing](../devinfo/contributing.html)
* [Entrypoints](../devinfo/entrypoints.html)

Other information

* [Citing `plastid`](../citing.html)
* [License](../license.html)
* [Change log](../CHANGES.html)
* [Related resources](../related.html)
* [Contact](../contact.html)

[plastid](../index.html)

* »
* [Tutorials](../examples.html) »
* Read mapping functions
* [Edit on GitHub](https://github.com/joshuagryphon/plastid/blob/master/docs/source/concepts/mapping_rules.rst)

---

# Read mapping functions[¶](#read-mapping-functions "Permalink to this headline")

Numerous sequencing assays encode interesting biology in various properties of
read alignments withu nucleotide precision. For example:

> * [ribosome profiling](../glossary.html#term-ribosome-profiling) encodes the positions of ribosomal P-sites as a
>   function of both read length and alignment coordinates
>   ([[IGNW09](../zreferences.html#id4 "Nicholas T Ingolia, Sina Ghaemmaghami, John R S Newman, and Jonathan S Weissman. Genome-wide analysis in vivo of translation with nucleotide resolution using ribosome profiling. Science, 324(5924):218-23, Apr 2009. URL: http://view.ncbi.nlm.nih.gov/pubmed/19213877, doi:10.1126/science.1168978."), [ILW11](../zreferences.html#id5 "Nicholas T Ingolia, Liana F Lareau, and Jonathan S Weissman. Ribosome profiling of mouse embryonic stem cells reveals the complexity and dynamics of mammalian proteomes. Cell, 147(4):789-802, Nov 2011. URL: http://view.ncbi.nlm.nih.gov/pubmed/22056041, doi:10.1016/j.cell.2011.10.002.")])
> * Bisulfite sequencing encodes methylation status as C-to-T transitions within
>   read alignments
> * [DMS-Seq](../glossary.html#term-DMS-seq) ([[RZW+14](../zreferences.html#id7 "Silvi Rouskin, Meghan Zubradt, Stefan Washietl, Manolis Kellis, and Jonathan S Weissman. Genome-wide probing of rna structure reveals active unfolding of mrna structures in vivo. Nature, 505(7485):701-5, Jan 2014. URL: http://view.ncbi.nlm.nih.gov/pubmed/24336214, doi:10.1038/nature12894.")]) and Pseudouridine profiling (:cite:)
>   encode unstructured regions of RNA or sites of pseudouridine modification,
>   respectively, in the 5’ termini fo their read aligments.

[`plastid`](../generated/plastid.html#module-plastid "plastid") uses configurable [mapping functions](../glossary.html#term-mapping-rule) to
decode the biology of interest from read alignments, and convert the decoded
data into [`arrays`](https://numpy.org/doc/stable/reference/generated/numpy.ndarray.html#numpy.ndarray "(in NumPy v1.22)") over regions of interest (such as an
array of the number of ribosomes at each nucleotide in a coding region).

This design enables [`plastid`](../generated/plastid.html#module-plastid "plastid")’s tools to operate on sequencing data from
virtually any NGS assay, provided the appropriate mapping function and
parameters.

Mapping functions are described in the following sections:

* [Mapping functions included in `plastid`](#mapping-functions-included-in-plastid)

  + [Choosing mapping functions in command-line scripts](#choosing-mapping-functions-in-command-line-scripts)
  + [Choosing mapping functions in interactive Python sessions](#choosing-mapping-functions-in-interactive-python-sessions)
* [Writing new mapping functions](#writing-new-mapping-functions)

  + [Parameters](#parameters)
  + [Return values](#return-values)
  + [Example 1: Fiveprime alignment mapping](#example-1-fiveprime-alignment-mapping)
  + [Example 2: mapping alignments to their mismatches](#example-2-mapping-alignments-to-their-mismatches)
* [See also](#see-also)

## [Mapping functions included in `plastid`](#id8)[¶](#mapping-functions-included-in-plastid "Permalink to this headline")

At present, the following mapping functions are provided, although users are
encouraged to [write their own mapping functions](#mapping-rules-roll-your-own) as needed. These include:

*Fiveprime end mapping*
:   Each read alignment is mapped to its 5’ end, or at a fixed offset (in
    nucleotides) from its 5’ end

*Variable fiveprime end mapping*
:   Each read alignment is mapped at a fixed distance from its 5’ end, where the
    distance is determined by the length of the read alignment.

    This is used for [ribosome profiling](../glossary.html#term-ribosome-profiling) of yeast ([[IGNW09](../zreferences.html#id4 "Nicholas T Ingolia, Sina Ghaemmaghami, John R S Newman, and Jonathan S Weissman. Genome-wide analysis in vivo of translation with nucleotide resolution using ribosome profiling. Science, 324(5924):218-23, Apr 2009. URL: http://view.ncbi.nlm.nih.gov/pubmed/19213877, doi:10.1126/science.1168978.")])
    and mammalian cells ([[ILW11](../zreferences.html#id5 "Nicholas T Ingolia, Liana F Lareau, and Jonathan S Weissman. Ribosome profiling of mouse embryonic stem cells reveals the complexity and dynamics of mammalian proteomes. Cell, 147(4):789-802, Nov 2011. URL: http://view.ncbi.nlm.nih.gov/pubmed/22056041, doi:10.1016/j.cell.2011.10.002.")]).

*Stratified variable fiveprime end mapping*
:   This multidimensional mapping function behaves as variable fiveprime end
    mapping, and additionally returns arrays that are stratified by read length.

    For each region of interest, a 2D array is returned, in which each row
    represents a given read length, and each column a nucleotide position in the
    region of interest. In other words, summing over the columns produces the
    same array that would be given by variable fiveprime end mapping.

*Threeprime end mapping*
:   Each read alignment is mapped to its 3’ end, or at a fixed offset (in
    nucleotides) from its 3’ end.

*Entire* or *Center-weighted mapping*
:   Zero or more positions are trimmed from each end of the read alignment, and
    the remaining N positions in the alignment are incremented by 1/N read
    counts (so that each read is still counted once, when integrated over its
    mapped length).

    This is also used for [ribosome profiling](../glossary.html#term-ribosome-profiling) of *E. coli*
    ([[OBS+11](../zreferences.html#id13 "Eugene Oh, Annemarie H Becker, Arzu Sandikci, Damon Huber, Rachna Chaba, Felix Gloge, Robert J Nichols, Athanasios Typas, Carol A Gross, Günter Kramer, Jonathan S Weissman, and Bernd Bukau. Selective ribosome profiling reveals the cotranslational chaperone action of trigger factor in vivo. Cell, 147(6):1295-308, Dec 2011. URL: http://view.ncbi.nlm.nih.gov/pubmed/22153074, doi:10.1016/j.cell.2011.10.044.")]) and *D. melanogaster* ([[DFB+13](../zreferences.html#id2 "Joshua G Dunn, Catherine K Foo, Nicolette G Belletier, Elizabeth R Gavis, and Jonathan S Weissman. Ribosome profiling reveals pervasive and regulated stop codon readthrough in drosophila melanogaster. Elife, 2(0):e01179, 2013. URL: http://view.ncbi.nlm.nih.gov/pubmed/24302569, doi:10.7554/elife.01179.")]), and RNA-seq.

In the image below, the same set of [read alignments](../glossary.html#term-read-alignments) from a
[ribosome profiling](../glossary.html#term-ribosome-profiling) experiment is mapped under various functions. Note
the [start codon peak](../glossary.html#term-start-codon-peak) and [stop codon peak](../glossary.html#term-stop-codon-peak) that appear when reads
are mapped to specific locations:

[![Ribosome profiling data under different mapping functions](../_images/mapping_rule_demo.png)](../_images/mapping_rule_demo.png)

**Top**: gene model. **Middle**: alignments of [ribosome-protected footprints](../glossary.html#term-ribosome-protected-footprint),
displayed as in the [IGV](https://www.broadinstitute.org/igv/) genome browser without a mapping function.
**Bottom rows**: [Ribosome footprints](../glossary.html#term-ribosome-protected-footprint)
mapped under various mapping functions.[¶](#id7 "Permalink to this image")

### [Choosing mapping functions in command-line scripts](#id9)[¶](#choosing-mapping-functions-in-command-line-scripts "Permalink to this headline")

Mapping functions may be specified to [`command-line scripts`](../generated/plastid.bin.html#module-plastid.bin "plastid.bin")
using the following command-line arguments (note, command-line scripts don’t at
present support mapping functions that return multidimensional arrays):

> |  |  |
> | --- | --- |
> | **Mapping function** | **Argument** |
> | Fiveprime | `--fiveprime` |
> | Fiveprime variable | `--fiveprime_variable` |
> | Threeprime | `--threeprime` |
> | Center/entire | `--center` |

The following arguments additionally influence how mapping functions behave:

> |  |  |
> | --- | --- |
> | **Argument** | **Behavior** |
> | `--offset X` | For `--fiveprime` or `--threeprime`, `X` is taken to be an integer specifying the offset into the read, at which read alignments should be mapped.  For `--fiveprime_variable`, `X` is taken to be the filename of a two-column tab-delimited text file, in which first column represents read length or the special keyword ‘default’, and the second column represents the offset from the five prime end at which reads of that length should be mapped. |
> | `--nibble X` | `X` is taken to be the number of bases to trim from each end of the read before mapping. |

See the documentation for individual [`command-line scripts`](../generated/plastid.bin.html#module-plastid.bin "plastid.bin")
for a detailed discussion of their arguments.

### [Choosing mapping functions in interactive Python sessions](#id10)[¶](#choosing-mapping-functions-in-interactive-python-sessions "Permalink to this headline")

Mapping functions in [`plastid`](../generated/plastid.html#module-plastid "plastid") are applied when [read alignments](../glossary.html#term-read-alignments)
are imported. Read alignments are held in data structures called *GenomeArrays*
(see [`plastid.genomics.genome_array`](../generated/plastid.genomics.genome_array.html#module-plastid.genomics.genome_array "plastid.genomics.genome_array")).

Alignments in [BAM](http://samtools.github.io/hts-specs/) format can be imported into a [`BAMGenomeArray`](../generated/plastid.genomics.genome_array.html#plastid.genomics.genome_array.BAMGenomeArray "plastid.genomics.genome_array.BAMGenomeArray"). Mapping
functions are set via
[`set_mapping()`](../generated/plastid.genomics.genome_array.html#plastid.genomics.genome_array.BAMGenomeArray.set_mapping "plastid.genomics.genome_array.BAMGenomeArray.set_mapping"):

```
>>> from plastid.genomics.genome_array import BAMGenomeArray, FivePrimeMapFactory, CenterMapFactory

>>> alignments = BAMGenomeArray("SRR609197_riboprofile_5hr_rep1.bam")

>>> # map reads 5 nucleotides downstream from their 5' ends
>>> alignments.set_mapping(FivePrimeMapFactory(offset=5))
```

and, the mapping function for a [`BAMGenomeArray`](../generated/plastid.genomics.genome_array.html#plastid.genomics.genome_array.BAMGenomeArray "plastid.genomics.genome_array.BAMGenomeArray") can be changed at any time:

```
>>> # map reads along entire lengths
>>> alignments.set_mapping(CenterMapFactory())
```

Alignments in [bowtie](http://bowtie-bio.sourceforge.net/manual.shtml) format can be imported into a [`GenomeArray`](../generated/plastid.genomics.genome_array.html#plastid.genomics.genome_array.GenomeArray "plastid.genomics.genome_array.GenomeArray"). Because
[bowtie](http://bowtie-bio.sourceforge.net/manual.shtml) files are not sorted or indexed, mapping functions must be applied
upon import, and cannot be changed afterwards:

```
>>> from plastid.genomics.genome_array import GenomeArray, five_prime_map

>>> # map reads 5 nucleotides downstream from their 5' ends
>>> fiveprime_alignments = GenomeArray()
>>> fiveprime_alignments.add_from_bowtie(open("some_file.bowtie"),five_prime_map,offset=5)

>>> # map reads along entire lengths
>>> entire_alignments = GenomeArray()
>>> entire_alignments.add_from_bowtie(open("some_file.bowtie"),center_map)
```

Method names for the various [mapping functions](../glossary.html#term-mapping-rule) appear below:

|  |  |  |
| --- | --- | --- |
| **Mapping function** | [`GenomeArray`](../generated/plastid.genomics.genome_array.html#plastid.genomics.genome_array.GenomeArray "plastid.genomics.genome_array.GenomeArray"), [`SparseGenomeArray`](../generated/plastid.genomics.genome_array.html#plastid.genomics.genome_array.SparseGenomeArray "plastid.genomics.genome_array.SparseGenomeArray") | [`BAMGenomeArray`](../generated/plastid.genomics.genome_array.html#plastid.genomics.genome_array.BAMGenomeArray "plastid.genomics.genome_array.BAMGenomeArray") |
| Fiveprime | [`five_prime_map()`](../generated/plastid.genomics.genome_array.html#plastid.genomics.genome_array.five_prime_map "plastid.genomics.genome_array.five_prime_map") | [`FivePrimeMapFactory`](../generated/plastid.genomics.map_factories.html#plastid.genomics.map_factories.FivePrimeMapFactory "plastid.genomics.map_factories.FivePrimeMapFactory") |
| Fiveprime variable | [`variable_five_prime_map()`](../generated/plastid.genomics.genome_array.html#plastid.genomics.genome_array.variable_five_prime_map "plastid.genomics.genome_array.variable_five_prime_map") | [`VariableFivePrimeMapFactory`](../generated/plastid.genomics.map_factories.html#plastid.genomics.map_factories.VariableFivePrimeMapFactory "plastid.genomics.map_factories.VariableFivePrimeMapFactory") |
| Stratified fiveprime variable | not implemented | [`StratifiedVariableFivePrimeMapFactory`](../generated/plastid.genomics.map_factories.html#plastid.genomics.map_factories.StratifiedVariableFivePrimeMapFactory "plastid.genomics.map_factories.StratifiedVariableFivePrimeMapFactory") |
| Threeprime | [`three_prime_map()`](../generated/plastid.genomics.genome_array.html#plastid.genomics.genome_array.three_prime_map "plastid.genomics.genome_array.three_prime_map") | [`ThreePrimeMapFactory`](../generated/plastid.genomics.map_factories.html#plastid.genomics.map_factories.ThreePrimeMapFactory "plastid.genomics.map_factories.ThreePrimeMapFactory") |
| Center/entire | [`center_map()`](../generated/plastid.genomics.genome_array.html#plastid.genomics.genome_array.