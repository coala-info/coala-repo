[DIMSPy](index.html)

latest

* [Installation](installation.html)
* [API reference](api-reference.html)
  + tools
  + [metadata](dimspy.metadata.html)
  + [models](dimspy.models.html)
  + [portals](dimspy.portals.html)
  + [process](dimspy.process.html)
* [Command Line Interface](cli.html)
* [Credits](credits.html)
* [Bugs and Issues](bugs-and-issues.html)
* [Changelog](changelog.html)
* [Citation](citation.html)
* [License](license.html)

[DIMSPy](index.html)

* [Docs](index.html) »
* [API reference](api-reference.html) »
* tools
* [Edit on GitHub](https://github.com/computational-metabolomics/dimspy/blob/master/docs/source/dimspy.tools.rst)

---

# tools[¶](#module-dimspy.tools "Permalink to this headline")

`dimspy.tools.``process_scans`(*source: str*, *function\_noise: str*, *snr\_thres: float*, *ppm: float*, *min\_fraction: Optional[float] = None*, *rsd\_thres: Optional[float] = None*, *min\_scans: int = 1*, *filelist: Optional[str] = None*, *skip\_stitching: bool = False*, *remove\_mz\_range: list = None*, *ringing\_thres: Optional[float] = None*, *filter\_scan\_events: Dict = None*, *report: Optional[str] = None*, *block\_size: int = 5000*, *ncpus: int = None*)[[source]](_modules/dimspy/tools.html#process_scans)[¶](#dimspy.tools.process_scans "Permalink to this definition")
:   Extract, filter and average spectral data from input .RAW or .mzML files and generate a single mass
    spectral peaklist (object) for each of the data files within a directory or defined in
    the ‘filelist’ (if provided).

    Warning

    When using .mzML files generated using the Proteowizard tool, SIM-type scans will only be treated
    as spectra if the ‘simAsSpectra’ filter was set to true during the conversion process:
    *msconvert.exe example.raw* **–simAsSpectra** *–64 –zlib –filter “peakPicking true 1-”*

    Parameters
    :   * **source** – Path to a set/directory of .raw or .mzML files
        * **function\_noise** –

          Function to calculate the noise from each scan. The following options are available:

          + **median** - the median of all peak intensities within a given scan is used as the noise value.
          + **mean** - the unweighted mean average of all peak intensities within a given scan is used as the noise value.
          + **mad (Mean Absolute Deviation)** - the noise value is set as the mean of the absolute differences between peak
            intensities and the mean peak intensity (calculated across all peak intensities within a given scan).
          + **noise\_packets** - the noise value is calculated using the proprietary algorithms contained in Thermo Fisher
            Scientific’s msFileReader library. This option should only be applied when you are processing .RAW files.
        * **snr\_thres** – Peaks with a signal-to-noise ratio (SNR) less-than or equal-to this value will be removed
          from the output peaklist.
        * **ppm** – Maximum tolerated m/z deviation in parts per million.
        * **min\_fraction** – A numerical value from 0 to 1 that specifies the minimum proportion of scans a given mass
          spectral peak must be detected in, in order for it to be kept in the output peaklist. Here, scans refers to
          replicates of the same scan event type, i.e. if set to 0.33, then a peak would need to be detected in at least
          1 of the 3 replicates of a given scan event type.
        * **rsd\_thres** – Relative standard deviation threshold - A numerical value equal-to or greater-than 0.
          If greater than 0, then peaks whose intensity values have a percent relative standard deviation (otherwise termed
          the percent coefficient of variation) greater-than this value are excluded from the output peaklist.
        * **min\_scans** – Minimum number of scans required for each *m/z* window or event within a raw/mzML data file.
        * **filelist** –

          A tab-delimited text file containing **filename** and **classLabel** information for each
          experimental sample. These column headers MUST be included in the first row of the table. For a standard DIMS
          experiment, users are advised to also include the following additional columns:

          + **injectionOrder** - integer values ranging from 1 to i, where i is the total number of independent injections
            performed as part of a DIMS experiment. e.g. if a study included 20 samples, each of which was injected as four
            independent replicates, there would be at least 20 \* 4 injections, so i = 80 and the range for injection
            order would be from 1 to 80 in steps of 1.
          + **replicate** - integer value from 1 to r, indicating the order in which technical replicates of each study
            sample were injected in to the mass spectrometer, e.g. if study samples were analysed in quadruplicate,
            r = 4 and integer values are accordingly 1, 2, 3, 4.
          + **batch** - integer value from 1 to b, where b corresponds to the total number of batches analysed under
            define analysis conditions, for any given experiment. e.g. : if 4 independent plates of polar extracts were
            analysed in the positive ionisation mode, then valid values for batch are 1, 2, 3 and 4.

          This filelist may include additional columns, e.g. additional metadata relating to study samples. Ensure that columns
          names do not conflict with existing column names.
        * **skip\_stitching** – Selected Ion Monitoring (SIM) scans with overlapping scan ranges can be “stitched” together
          in to a pseudo-spectrum. This is achieved by setting this parameter to False (default).
        * **remove\_mz\_range** – This option allows for specific m/z regions of the output peaklist to be deleted, this
          option may be useful for removing sections of a spectrum known to correspond to system noise peaks.
        * **ringing\_thres** – Fourier transform-based mass spectra often contain peaks (ringing artefacts) around
          spectral features that require removal. This threshold is a positive float indicating the required relative
          intensity a peak must exceed (with reference to the largest peak in a cluster of peaks) in order to be retained.
        * **filter\_scan\_events** –

          Include or exclude specific scan events, by default all ALL scan events will be
          included. To include or exclude specific scan events use the following format of a dictionary.

          ```
          >>> {"include":[[100, 300, "sim"]]} or {"include":[[100, 1000, "full"]]}
          ```
        * **report** – A tab-delimited text file to write measures of quality (e.g. RSD, number of peaks, etc) for each scan event processed in each .RAW or .mzML files.
        * **block\_size** – Number peaks in each centre clustering block.
        * **ncpus** – Number of CPUs for parallel clustering. Default = None, indicating using all CPUs that are available

    Returns
    :   List of peaklist objects

`dimspy.tools.``replicate_filter`(*source: Union[Sequence[[dimspy.models.peaklist.PeakList](dimspy.models.html#dimspy.models.peaklist.PeakList "dimspy.models.peaklist.PeakList")], str]*, *ppm: float*, *replicates: int*, *min\_peaks: int*, *rsd\_thres: Optional[float] = None*, *filelist: Optional[str] = None*, *report: Optional[str] = None*, *block\_size: int = 5000*, *ncpus: int = None*)[[source]](_modules/dimspy/tools.html#replicate_filter)[¶](#dimspy.tools.replicate_filter "Permalink to this definition")
:   Peaks from each technical replicate (for a given study sample) are aligned using a one-dimensional hierarchical
    clustering procedure (applied on the mass-to-charge level).
    Peaks are aligned only if the difference in their mass-to-charge ratios, when divided by the average of their
    mass-to-charge ratios and multiplied by 1 × 106 (i.e. when measured in units of parts-per-million, ppm),
    is less-than or equal-to the user-defined ‘ppm error tolerance’. After alignment, a set of user-defined filters are
    applied to retain only those peaks that:

    > * occur in equal-to or more-than the user-defined ‘Number of technical replicates a peak has to be present
    >   in’, i.e. if set to 2, then a peak must be detected in at least two of the replicate analyses, **and/or**
    > * have relative standard deviation (measured in %; may otherwise be referred to as the percent coefficient
    >   of variation) of intensity values, across technical replicates, that is equal-to or less-than the user-defined
    >   ‘relative standard deviation threshold’ (if defined, otherwise ignored).

    Warning

    When the parameter “number of technical replicates for each sample” is set to a value less-than the total
    number of technical replicates actually acquired for each study sample, this tool will automatically determine
    which combination of technical replicates to combine. See the parameter description (below) for further details.

    Parameters
    :   * **source** – A list of processed peaklist objects generated by ‘process\_scans’ or path to .hdf5 file
        * **ppm** – Maximum tolerated m/z deviation in parts per million.
        * **replicates** – Number of technical replicates for each sample - the total number of technical replicates
          acquired for each study sample. This value must be set to the lowest number of technical replicates acquired
          for ANY of the study samples, or alternatively, may be set to the minimum number of replicates the user would
          like to select from the total number of technical replicates for a biological sample.
        * **min\_peaks** –

          Minimum number of technical replicates a peak has to be present in.
          For a given biological sample, the number of replicates that will be used to generate the replicate-filtered
          peaklist. If this parameter is set to a value less-than the total number of technical replicates acquired for
          each biological sample, it will automatically determines which combination of technical replicates yields
          the best overall rank. Otherwise, all technical replicates are used. Ranking of the combinations of
          technical replicates is based on the average of the following three scores:

          + score 1: peak count / peak count present in n-out-n (e.g. 3-out-of-3)
          + score 2: peak count present in x-out-of-n (e.g. 3-out-of-3) / MAX peak count present in x-out-of-n across
            sets of replicates
          + score 3: RSD categories (0-5 (score=1.0), 5-10 (score=0.9), 10-15 (score=0.8), etc)
        * **rsd\_thres** – Relative standard deviation threshold - a numerical value from 0 upwards that defines the
          acceptable percentage relative standard deviation (otherwise termed the percent coefficient of variation)
          of a peak’s intensity across technical replicates. Peaks are removed from the output ‘replicate-filtered’
          peaklist if this condition is not met. Set to None to skipe this filter.
        * **filelist** –

          A tab-delimited text file containing **filename** and **classLabel** information for each
          experimental sample. There is no need to provide a filelist again if this has been done
          already as part of one of the previous processing steps (i.e. see process scans or replicate filter) -
          except if specific samples need to be excluded. These column headers MUST be included in the first row of the table. For a standard DIMS
          experiment, users are advised to also include the following additional columns:

          + **injectionOrder** - integer values ranging from 1 to i, where i is the total number of independent injections
            performed as part of a DIMS experiment. e.g. if a study included 20 samples, each of which was injected as four
            independent replicates, there would be at least 20 \* 4 injections, so i = 80 and the range for injection
            order would be from 1 to 80 in steps of 1.
          + **replicate** - integer value from 1 to r, indicating the order in which technical replicates of each study
            sample were injected in to the mass spectrometer, e.g. if study samples were analysed in quadruplicate,
            r = 4 and integer values are accordingly 1, 2, 3, 4.
          + **batch** - integer value from 1 to b, where b corresponds to the total number of batches analysed under
            define analysis conditions, for any given experiment. e.g. : if 4 independent plates of polar extracts were
            analysed in the positive ionisation mode, then valid values for batch are 1, 2, 3 and 4.

          This filelist may include additional columns, e.g. additional metadata relating to study samples. Ensure that columns
          names do not conflict with existing column names.
        * **report** – A tab-delimited text file to write measures of quality (e.g. RSD, number of peaks, etc) for each
          processed ‘replicate-filtered’ peaklist.
        * **block\_size** – Number peaks in each centre clustering block.
        * **ncpus** – Number of CPUs for parallel clustering. Default = None, indicating using all CPUs that are available

    Returns
    :   List of peaklist objects

`dimspy.tools.``align_samples`(*source: Union[Sequence[[dimspy.models.peaklist.PeakList](dimspy.models.html#dimspy.models.peaklist.PeakList "dimspy.models.peaklist.PeakList")], str]*, *ppm: float*, *filelist: Optional[str] = None*, *block\_size: int = 5000*, *ncpus: int = None*)[[source]](_modules/dimspy/tools.html#align_samples)[¶](#dimspy.tools.align_samples "Permalink to this definition")
:   Study samples (i.e. PeakList Objects) are aligned to create PeakMatrix object. The PeakMatrix object comprises
    of a table, with samples along one axis and the mass-to-charge ratios of detected mass spectral peaks along the
    opposite axis. At the intersection of sample and mass-to-charge ratio, the intensity is given for a specific peak
    in a specific sample (if no intensity recorded, then ‘nan’ is inserted).

    Parameters
    :   * **source** – A list of processed peaklist objects generated by ‘process\_scans’ and/or ‘replicate\_filter’,
          or path to .hdf5 file.
        * **ppm** – Maximum tolerated m/z deviation in parts per million.
        * **filelist** –

          A tab-delimited text file containing **filename** and **classLabel** information for each
          experimental sample. There is no need to provide a filelist again if this has been done
          already as part of one of the previous processing steps (i.e. see process scans or replicate filter) -
          except if specific samples need to be excluded. These column headers MUST be included in the first
          row of the table.

          This filelist may include additional columns, e.g. additional metadata relating to study samples.
          Ensure that column names do not confl