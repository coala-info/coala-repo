[bedparse](index.html)

stable

* [Installation](Installation.html)
* [Motivation](Motivation.html)
* [Usage](Usage.html)
* [Implementations notes](Usage.html#implementations-notes)
* APIs reference
* [Bedparse tutorial](Tutorial.html)

[bedparse](index.html)

* [Docs](index.html) »
* bedparse.bedline module
* [Edit on GitHub](https://github.com/tleonardi/bedparse/blob/b2833706a006504b267b9a0692334a7d18e44e5c/docs/bedparse.bedline.rst)

---

# bedparse.bedline module[¶](#module-bedparse.bedline "Permalink to this headline")

*class* `bedparse.bedline.``bedline`(*line=None*)[¶](#bedparse.bedline.bedline "Permalink to this definition")
:   Bases: `object`

    The bedline class defines an object that represents a single BED[3,4,6,12] line

    |  |  |
    | --- | --- |
    | Parameters: | **line** (*list*) – List where each element corresponds to one field of a BED file |

    `bed12tobed6`(*appendExN=False*, *whichExon='all'*)[¶](#bedparse.bedline.bedline.bed12tobed6 "Permalink to this definition")
    :   Returns a list of bedlines (bed6) corresponding to the exons.

        |  |  |
        | --- | --- |
        | Parameters: | * **appendExN** (*bool*) – Appends the exon number to the transcript name * **whichExon** (*str*) – Which exon to return. One of [“all”, “first”, “last”]. First and last respectively report the first or last exon relative to the TSS (i.e. taking strand into account). |
        | Returns: | list of bedline objects, one per exon |
        | Return type: | list |

        Examples

        ```
        >>> bl = bedline(["chr1", 100, 420, "Name", 0, "+", 210, 310, ".", 4, "20,20,20,20,", "0,100,200,300,"])
        >>> for i in bl.bed12tobed6(appendExN=True): print(i)
        ...
        ['chr1', 100, 120, 'Name_Exon001', 0, '+']
        ['chr1', 200, 220, 'Name_Exon002', 0, '+']
        ['chr1', 300, 320, 'Name_Exon003', 0, '+']
        ['chr1', 400, 420, 'Name_Exon004', 0, '+']
        ```

    `cds`(*ignoreCDSonly=False*)[¶](#bedparse.bedline.bedline.cds "Permalink to this definition")
    :   Return the CDS of a coding transcript. Transcripts without CDS are not reported

        |  |  |
        | --- | --- |
        | Parameters: | **ignoreCDSonly** (*bool*) – If True return None when the entire transcript is CDS |
        | Returns: | The CDS as a bedline object |
        | Return type: | [bedline](#bedparse.bedline.bedline "bedparse.bedline.bedline") |

        Examples

        ```
        >>> bl = bedline(["chr1", 100, 500, "Tx1", 0, "+", 200, 300, ".", 1, "400,", "0,"])
        >>> print(bl.cds())
        ['chr1', 200, 300, 'Tx1', 0, '+', 200, 300, '.', 1, '100,', '0,']
        ```

    `introns`()[¶](#bedparse.bedline.bedline.introns "Permalink to this definition")
    :   Returns a bedline object of the introns of a transcript

        |  |  |
        | --- | --- |
        | Returns: | The introns of the transcripts as a bedline object |
        | Return type: | [bedline](#bedparse.bedline.bedline "bedparse.bedline.bedline") |

        Examples

        ```
        >>> bl = bedline(["chr1", 100, 420, "Name", 0, "+", 210, 310, ".", 4, "20,20,20,20,", "0,100,200,300,"])
        >>> print(bl.introns())
        ['chr1', 120, 400, 'Name', 0, '+', 120, 120, '.', 3, '80,80,80,', '0,100,200,']
        >>> bl = bedline(["chr1", 100, 420, "Name", 0, "-", 210, 310, ".", 1, "320,", "0,"])
        >>> print(bl.introns())
        None
        ```

    `pprint`()[¶](#bedparse.bedline.bedline.pprint "Permalink to this definition")
    :   Prints a bedline object formatted as a python list

    `print`(*end='\n'*)[¶](#bedparse.bedline.bedline.print "Permalink to this definition")
    :   Prints a bedline object

        |  |  |
        | --- | --- |
        | Parameters: | **end** – Line terminator character |

    `promoter`(*up=500*, *down=500*, *strand=True*)[¶](#bedparse.bedline.bedline.promoter "Permalink to this definition")
    :   Returns the promoter of a bedline object

        |  |  |
        | --- | --- |
        | Parameters: | * **up** (*int*) – Number of upstream bases * **down** (*int*) – Number of donwstream bases * **strand** (*bool*) – If false strandedness is ignored |
        | Returns: | The promoter as a bedline object |
        | Return type: | [bedline](#bedparse.bedline.bedline "bedparse.bedline.bedline") |

        Examples

        ```
        >>> bl = bedline(['chr1', 1000, 2000, 'Tx1', '0', '+'])
        >>> print(bl.promoter())
        ['chr1', 500, 1500, 'Tx1']
        ```

    `translateChr`(*assembly*, *target*, *suppress=False*, *ignore=False*, *patches=False*)[¶](#bedparse.bedline.bedline.translateChr "Permalink to this definition")
    :   Convert the chromosome name to Ensembl or UCSC

        |  |  |
        | --- | --- |
        | Parameters: | * **assembly** (*str*) – Assembly of the BED file (either hg38 or mm10). * **target** (*str*) – Desidered chromosome name convention (ucsc or ens). * **suppress** (*bool*) – When a chromosome name can’t be matched between USCS and Ensembl set it to ‘NA’ (by default throws as error) * **ignore** (*bool*) – When a chromosome name can’t be matched between USCS and Ensembl do not report it in the output (by default throws an error) * **patches** (*bool*) – Allows conversion of all patches up to p11 for hg38 and p4 for mm10. Without this option, if the BED file contains contigs added by a patch the conversion terminates with an error (unless the -a or -s flags are present |
        | Returns: | A bedline object with the converted chromosome |
        | Return type: | [bedline](#bedparse.bedline.bedline "bedparse.bedline.bedline") |

        Examples

        ```
        >>> bl = bedline(['chr1', 1000, 2000, 'Tx1', '0', '-'])
        >>> print(bl.translateChr(assembly="hg38", target="ens"))
        ['1', 1000, 2000, 'Tx1', '0', '-']
        >>> bl = bedline(['chr19_GL000209v2_alt', 1000, 2000, 'Tx1', '0', '-'])
        >>> print(bl.translateChr(assembly="hg38", target="ens"))
        ['CHR_HSCHR19KIR_RP5_B_HAP_CTG3_1', 1000, 2000, 'Tx1', '0', '-']
        ```

    `tx2genome`(*coord*, *stranded=False*)[¶](#bedparse.bedline.bedline.tx2genome "Permalink to this definition")
    :   Given a position in transcript coordinates returns the equivalent in genome coordinates.
        The transcript coordinates are considered without regard to strand, i.e. 0 is the leftmost
        position for both + and - strand transcripts, unless the stranded options is set to True.

        |  |  |
        | --- | --- |
        | Parameters: | * **coord** (*int*) – Coordinate to convert from transcript-space to genome space * **stranded** (*bool*) – If True use the rightmost base of negative strand trascripts as 0 |
        | Returns: | Coordinate in genome-space |
        | Return type: | int |

        Examples

        ```
        >>> bl = bedline(['chr1', 1000, 2000, 'Tx1', '0', '-'])
        >>> bl.tx2genome(10)
        1010
        >>> bl.tx2genome(10, stranded=True)
        1989
        ```

    `utr`(*which=None*)[¶](#bedparse.bedline.bedline.utr "Permalink to this definition")
    :   Returns the UTR of coding transcripts (i.e. those with a CDS)

        |  |  |
        | --- | --- |
        | Parameters: | **which** (*int*) – Which UTR to return: 3 for 3’UTR or 5 for 5’ UTR |
        | Returns: | The UTR as a bedline object |
        | Return type: | [bedline](#bedparse.bedline.bedline "bedparse.bedline.bedline") |

        Examples

        ```
        >>> bl = bedline(["chr1", 100, 500, "Tx1", 0, "+", 200, 300, ".", 1, "400,", "0,"])
        >>> print(bl.utr(which=5))
        ['chr1', 100, 200, 'Tx1', 0, '+', 100, 100, '.', 1, '100,', '0,']
        ```

[Next](Tutorial.html "Bedparse tutorial")
 [Previous](Usage.html "Usage")

---

© Copyright 2019, Tommaso Leonardi
Revision `b2833706`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).