[bioconvert
![Logo](_static/logo.png)](index.html)

* [1. Installation](installation.html)
* [2. User Guide](user_guide.html)
* [3. Tutorial](tutorial.html)
* [4. Developer guide](developer_guide.html)
* [5. Benchmarking](benchmarking.html)
* [6. Gallery](auto_examples/index.html)
* [7. References](references.html)
  + [7.1. Core functions](ref_core.html)
  + [7.2. Reference converters](ref_converters.html)
  + 7.3. IO functions
    - [`read_from_buffer()`](#bioconvert.io.scf.read_from_buffer)
    - [`MAF`](#bioconvert.io.maf.MAF)
      * [`MAF.count_insertions()`](#bioconvert.io.maf.MAF.count_insertions)
    - [`MAFLine`](#bioconvert.io.maf.MAFLine)
* [8. Formats](formats.html)
* [9. Glossary](glossary.html)
* [10. Faqs](faqs.html)
* [11. Bibliography](bibliography.html)

[bioconvert](index.html)

* [7. References](references.html)
* 7.3. IO functions
* [View page source](_sources/ref_io.rst.txt)

---

# 7.3. IO functions[](#io-functions "Link to this heading")

|  |  |
| --- | --- |
| [`bioconvert.io.maf`](#module-bioconvert.io.maf "bioconvert.io.maf") |  |
| [`bioconvert.io.scf`](#module-bioconvert.io.scf "bioconvert.io.scf") |  |

bioconvert.io.scf.read\_from\_buffer(*f\_file*, *length*, *offset*)[[source]](_modules/bioconvert/io/scf.html#read_from_buffer)[](#bioconvert.io.scf.read_from_buffer "Link to this definition")
:   Return ‘length’ bits of file ‘f\_file’ starting at offset ‘offset’

*class* bioconvert.io.maf.MAF(*filename*, *outfile=None*)[[source]](_modules/bioconvert/io/maf.html#MAF)[](#bioconvert.io.maf.MAF "Link to this definition")
:   A reader for [MAF](glossary.html#term-MAF) format.

    Methods

    |  |  |
    | --- | --- |
    | [`count_insertions`](#bioconvert.io.maf.MAF.count_insertions "bioconvert.io.maf.MAF.count_insertions")(alnString) | return length without insertion, forward and reverse shift |

    |  |  |
    | --- | --- |
    | **get\_flag** |  |
    | **to\_sam** |  |

    count\_insertions(*alnString*)[[source]](_modules/bioconvert/io/maf.html#MAF.count_insertions)[](#bioconvert.io.maf.MAF.count_insertions "Link to this definition")
    :   return length without insertion, forward and reverse shift

*class* bioconvert.io.maf.MAFLine(*line*)[[source]](_modules/bioconvert/io/maf.html#MAFLine)[](#bioconvert.io.maf.MAFLine "Link to this definition")
:   A reader for [MAF](glossary.html#term-MAF) format.

    mode refname start algsize strand refsize alignment

    ```
    a
    s ref    100 10 + 100000 ---AGC-CAT-CATT
    s contig 0   10 + 10     ---AGC-CAT-CATT

    a
    s ref    100 12 + 100000 ---AGC-CAT-CATTTT
    s contig 0   12 + 12     ---AGC-CAT-CATTTT
    ```

    The alignments are stored by pair, one item for the reference, one for the
    query. The query (second line) starts at zero.

    Attributes:
    :   **alignment**

        **alignment\_size**

        **alignment\_start**

        **mode**

        **name**

        **sequence\_size**

        **strand**

    Methods

    |  |  |
    | --- | --- |
    | **get\_alignment\_length** |  |

[Previous](ref_converters.html "7.2. Reference converters")
[Next](formats.html "8. Formats")

---

© Copyright .
Last updated on Mar 09, 2026.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).