[ms2pip](../../)

About

* [Home](../../)
* [Installation](../../installation/)
* [Usage](../../usage/)
* [Prediction models](../../prediction-models/)

Command line interface

* [Command line interface](../../cli/cli/)

Python API reference

* [ms2pip](../ms2pip/)
* [ms2pip.constants](../ms2pip.constants/)
* [ms2pip.correlation](../ms2pip.correlation/)
* [ms2pip.exceptions](../ms2pip.exceptions/)
* [ms2pip.result](../ms2pip.result/)
* [ms2pip.search\_space](../ms2pip.search-space/)
* [ms2pip.spectrum](../ms2pip.spectrum/)
* [ms2pip.spectrum\_input](../ms2pip.spectrum-input/)
* ms2pip.spectrum\_output
  + [`write_spectra()`](#ms2pip.spectrum_output.write_spectra)
  + [`TSV`](#ms2pip.spectrum_output.TSV)
    - [`TSV.write()`](#ms2pip.spectrum_output.TSV.write)
  + [`MSP`](#ms2pip.spectrum_output.MSP)
    - [`MSP.write()`](#ms2pip.spectrum_output.MSP.write)
  + [`MGF`](#ms2pip.spectrum_output.MGF)
    - [`MGF.write()`](#ms2pip.spectrum_output.MGF.write)
  + [`Spectronaut`](#ms2pip.spectrum_output.Spectronaut)
    - [`Spectronaut.write()`](#ms2pip.spectrum_output.Spectronaut.write)
  + [`Bibliospec`](#ms2pip.spectrum_output.Bibliospec)
    - [`Bibliospec.open()`](#ms2pip.spectrum_output.Bibliospec.open)
    - [`Bibliospec.close()`](#ms2pip.spectrum_output.Bibliospec.close)
    - [`Bibliospec.write()`](#ms2pip.spectrum_output.Bibliospec.write)
  + [`DLIB`](#ms2pip.spectrum_output.DLIB)
    - [`DLIB.open()`](#ms2pip.spectrum_output.DLIB.open)
    - [`DLIB.write()`](#ms2pip.spectrum_output.DLIB.write)
  + [`ms2pip.spectrum_output.SUPPORTED_FORMATS`](#ms2pip.spectrum_output.ms2pip.spectrum_output.SUPPORTED_FORMATS)

[ms2pip](../../)

* ms2pip.spectrum\_output
* [View page source](../../_sources/api/ms2pip.spectrum-output.rst.txt)

---

# ms2pip.spectrum\_output[](#module-ms2pip.spectrum_output "Link to this heading")

Write spectrum files from MS²PIP prediction results.

Examples

The simplest way to write MS²PIP predictions to a file is to use the [`write_spectra()`](#ms2pip.spectrum_output.write_spectra "ms2pip.spectrum_output.write_spectra")
function:

```
>>> from ms2pip import predict_single, write_spectra
>>> results = [predict_single("ACDE/2")]
>>> write_spectra("/path/to/output/filename", results, "mgf")
```

Specific writer classes can also be used directly. Writer classes should be used in a context
manager to ensure the file is properly closed after writing. The following example writes MS²PIP
predictions to a TSV file:

```
>>> from ms2pip import predict_single
>>> results = [predict_single("ACDE/2")]
>>> with TSV("output.tsv") as writer:
...     writer.write(results)
```

Results can be written to the same file sequentially:

```
>>> results_2 = [predict_single("PEPTIDEK/2")]
>>> with TSV("output.tsv", write_mode="a") as writer:
...     writer.write(results)
...     writer.write(results_2)
```

Results can be written to an existing file using the append mode:

```
>>> with TSV("output.tsv", write_mode="a") as writer:
...     writer.write(results_2)
```

ms2pip.spectrum\_output.write\_spectra(*filename*, *processing\_results*, *file\_format='tsv'*, *write\_mode='w'*)[[source]](../../_modules/ms2pip/spectrum_output/#write_spectra)[](#ms2pip.spectrum_output.write_spectra "Link to this definition")
:   Write MS2PIP processing results to a supported spectrum file format.

    Parameters:
    :   * **filename** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* [*PathLike*](https://docs.python.org/3/library/os.html#os.PathLike "(in Python v3.14)")) – Output filename without file extension.
        * **processing\_results** ([*List*](https://docs.python.org/3/library/typing.html#typing.List "(in Python v3.14)")*[*[*ProcessingResult*](../ms2pip.result/#ms2pip.result.ProcessingResult "ms2pip.result.ProcessingResult")*]*) – List of [`ms2pip.result.ProcessingResult`](../ms2pip.result/#ms2pip.result.ProcessingResult "ms2pip.result.ProcessingResult") objects.
        * **file\_format** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")) – File format to write. See `FILE_FORMATS` for available formats.
        * **write\_mode** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")) – Write mode for file. Default is `w` (write). Use `a` (append) to add to existing file.

class ms2pip.spectrum\_output.TSV(*filename*, *write\_mode='w'*)[[source]](../../_modules/ms2pip/spectrum_output/#TSV)[](#ms2pip.spectrum_output.TSV "Link to this definition")
:   Bases: `_Writer`

    Write TSV files from MS2PIP processing results.

    Parameters:
    :   * **filename** (*Union**[*[*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*,* *PathLike**]*)
        * **write\_mode** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)"))

    write(*processing\_results*)[[source]](../../_modules/ms2pip/spectrum_output/#TSV.write)[](#ms2pip.spectrum_output.TSV.write "Link to this definition")
    :   Write multiple processing results to file.

        Parameters:
        :   **processing\_results** ([*List*](https://docs.python.org/3/library/typing.html#typing.List "(in Python v3.14)")*[*[*ProcessingResult*](../ms2pip.result/#ms2pip.result.ProcessingResult "ms2pip.result.ProcessingResult")*]*)

class ms2pip.spectrum\_output.MSP(*filename*, *write\_mode='w'*)[[source]](../../_modules/ms2pip/spectrum_output/#MSP)[](#ms2pip.spectrum_output.MSP "Link to this definition")
:   Bases: `_Writer`

    Write MSP files from MS2PIP processing results.

    Parameters:
    :   * **filename** (*Union**[*[*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*,* *PathLike**]*)
        * **write\_mode** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)"))

    write(*results*)[[source]](../../_modules/ms2pip/spectrum_output/#MSP.write)[](#ms2pip.spectrum_output.MSP.write "Link to this definition")
    :   Write multiple processing results to file.

        Parameters:
        :   **results** ([*List*](https://docs.python.org/3/library/typing.html#typing.List "(in Python v3.14)")*[*[*ProcessingResult*](../ms2pip.result/#ms2pip.result.ProcessingResult "ms2pip.result.ProcessingResult")*]*)

class ms2pip.spectrum\_output.MGF(*filename*, *write\_mode='w'*)[[source]](../../_modules/ms2pip/spectrum_output/#MGF)[](#ms2pip.spectrum_output.MGF "Link to this definition")
:   Bases: `_Writer`

    Write MGF files from MS2PIP processing results.

    See <http://www.matrixscience.com/help/data_file_help.html> for documentation on the MGF format.

    Parameters:
    :   * **filename** (*Union**[*[*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*,* *PathLike**]*)
        * **write\_mode** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)"))

    write(*results*)[[source]](../../_modules/ms2pip/spectrum_output/#MGF.write)[](#ms2pip.spectrum_output.MGF.write "Link to this definition")
    :   Write multiple processing results to file.

        Parameters:
        :   **results** ([*List*](https://docs.python.org/3/library/typing.html#typing.List "(in Python v3.14)")*[*[*ProcessingResult*](../ms2pip.result/#ms2pip.result.ProcessingResult "ms2pip.result.ProcessingResult")*]*)

class ms2pip.spectrum\_output.Spectronaut(*filename*, *write\_mode='w'*)[[source]](../../_modules/ms2pip/spectrum_output/#Spectronaut)[](#ms2pip.spectrum_output.Spectronaut "Link to this definition")
:   Bases: `_Writer`

    Write Spectronaut files from MS2PIP processing results.

    Parameters:
    :   * **filename** (*Union**[*[*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*,* *PathLike**]*)
        * **write\_mode** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)"))

    write(*processing\_results*)[[source]](../../_modules/ms2pip/spectrum_output/#Spectronaut.write)[](#ms2pip.spectrum_output.Spectronaut.write "Link to this definition")
    :   Write multiple processing results to file.

        Parameters:
        :   **processing\_results** ([*List*](https://docs.python.org/3/library/typing.html#typing.List "(in Python v3.14)")*[*[*ProcessingResult*](../ms2pip.result/#ms2pip.result.ProcessingResult "ms2pip.result.ProcessingResult")*]*)

class ms2pip.spectrum\_output.Bibliospec(*filename*, *write\_mode='w'*)[[source]](../../_modules/ms2pip/spectrum_output/#Bibliospec)[](#ms2pip.spectrum_output.Bibliospec "Link to this definition")
:   Bases: `_Writer`

    Write Bibliospec SSL and MS2 files from MS2PIP processing results.

    Bibliospec SSL and MS2 files are also compatible with Skyline. See
    <https://skyline.ms/wiki/home/software/BiblioSpec/page.view?name=BiblioSpec%20input%20and%20output%20file%20formats>
    for documentation on the Bibliospec file formats.

    Parameters:
    :   * **filename** (*Union**[*[*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*,* *PathLike**]*)
        * **write\_mode** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)"))

    open()[[source]](../../_modules/ms2pip/spectrum_output/#Bibliospec.open)[](#ms2pip.spectrum_output.Bibliospec.open "Link to this definition")
    :   Open files.

    close()[[source]](../../_modules/ms2pip/spectrum_output/#Bibliospec.close)[](#ms2pip.spectrum_output.Bibliospec.close "Link to this definition")
    :   Close files.

    write(*processing\_results*)[[source]](../../_modules/ms2pip/spectrum_output/#Bibliospec.write)[](#ms2pip.spectrum_output.Bibliospec.write "Link to this definition")
    :   Write multiple processing results to file.

        Parameters:
        :   **processing\_results** ([*List*](https://docs.python.org/3/library/typing.html#typing.List "(in Python v3.14)")*[*[*ProcessingResult*](../ms2pip.result/#ms2pip.result.ProcessingResult "ms2pip.result.ProcessingResult")*]*)

class ms2pip.spectrum\_output.DLIB(*filename*, *write\_mode='w'*)[[source]](../../_modules/ms2pip/spectrum_output/#DLIB)[](#ms2pip.spectrum_output.DLIB "Link to this definition")
:   Bases: `_Writer`

    Write DLIB files from MS2PIP processing results.

    See [EncyclopeDIA File Formats](https://bitbucket.org/searleb/encyclopedia/wiki/EncyclopeDIA%20File%20Formats)
    for documentation on the DLIB format.

    Parameters:
    :   * **filename** (*Union**[*[*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*,* *PathLike**]*)
        * **write\_mode** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)"))

    open()[[source]](../../_modules/ms2pip/spectrum_output/#DLIB.open)[](#ms2pip.spectrum_output.DLIB.open "Link to this definition")
    :   Open file.

    write(*processing\_results*)[[source]](../../_modules/ms2pip/spectrum_output/#DLIB.write)[](#ms2pip.spectrum_output.DLIB.write "Link to this definition")
    :   Write MS2PIP predictions to a DLIB SQLite file.

        Parameters:
        :   **processing\_results** ([*List*](https://docs.python.org/3/library/typing.html#typing.List "(in Python v3.14)")*[*[*ProcessingResult*](../ms2pip.result/#ms2pip.result.ProcessingResult "ms2pip.result.ProcessingResult")*]*)

ms2pip.spectrum\_output.SUPPORTED\_FORMATS: [dict](https://docs.python.org/3/library/stdtypes.html#dict "(in Python v3.14)")[](#ms2pip.spectrum_output.ms2pip.spectrum_output.SUPPORTED_FORMATS "Link to this definition")
:   Supported file formats and respective `_Writer` class for spectrum output.

[Previous](../ms2pip.spectrum-input/ "ms2pip.spectrum_input")

---

© Copyright .

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).