[DIMSPy](index.html)

latest

* [Installation](installation.html)
* [API reference](api-reference.html)
  + [tools](dimspy.tools.html)
  + [metadata](dimspy.metadata.html)
  + [models](dimspy.models.html)
  + [portals](dimspy.portals.html)
  + process
    - [peak\_alignment](#module-dimspy.process.peak_alignment)
    - [peak\_filters](#module-dimspy.process.peak_filters)
    - [scan\_processing](#module-dimspy.process.replicate_processing)
* [Command Line Interface](cli.html)
* [Credits](credits.html)
* [Bugs and Issues](bugs-and-issues.html)
* [Changelog](changelog.html)
* [Citation](citation.html)
* [License](license.html)

[DIMSPy](index.html)

* [Docs](index.html) »
* [API reference](api-reference.html) »
* process
* [Edit on GitHub](https://github.com/computational-metabolomics/dimspy/blob/master/docs/source/dimspy.process.rst)

---

# process[¶](#process "Permalink to this headline")

## peak\_alignment[¶](#module-dimspy.process.peak_alignment "Permalink to this headline")

`dimspy.process.peak_alignment.``align_peaks`(*peaks: Sequence[[dimspy.models.peaklist.PeakList](dimspy.models.html#dimspy.models.peaklist.PeakList "dimspy.models.peaklist.PeakList")]*, *ppm: float = 2.0*, *block\_size: int = 5000*, *fixed\_block: bool = True*, *edge\_extend: Union[int, float] = 10*, *ncpus: Optional[int] = None*)[[source]](_modules/dimspy/process/peak_alignment.html#align_peaks)[¶](#dimspy.process.peak_alignment.align_peaks "Permalink to this definition")
:   Cluster and align peaklists into a peak matrix.

    Parameters
    :   * **peaks** – List of peaklists for alignment
        * **ppm** – The hierarchical clustering cutting height, i.e., ppm range for each aligned mz value. Default = 2.0
        * **block\_size** – number peaks in each centre clustering block. This can be a exact or approximate number depends
          on the fixed\_block parameter. Default = 5000
        * **fixed\_block** – Whether the blocks contain fixed number of peaks. Default = True
        * **edge\_extend** – Ppm range for the edge blocks. Default = 10
        * **ncpus** – Number of CPUs for parallel clustering. Default = None, indicating using as many as possible

    Return type
    :   PeakMatrix object

    ![_images/alignment.png](_images/alignment.png)

    This function uses hierarchical clustering to align the mz values of the input peaklists. The alignment “width” is
    decided by the parameter of ppm. Due to a large number of peaks, this function splits them into blocks with fixed
    or approximate length, and clusters in a parallel manner on multiple CPUs. When running, the edge blocks are
    clustered first to prevent separating the same peak into two adjacent centre blocks. The size of the edge blocks is
    decided by edge\_extend. The clustering of centre blocks is conducted afterwards.

    After merging the clustering results, all the attributes (mz, intensity, snr, etc.) are aligned into matrix
    accordingly. If multiple peaks from the same sample are clustered into one mz value, their attributes are averaged
    (for real value attributes e.g. mz and intensity) or concatenated (string, unicode, or bool attributes). The flag
    attributes are ignored. The number of these overlapping peaks is recorded in a new intra\_count attribute matrix.

## peak\_filters[¶](#module-dimspy.process.peak_filters "Permalink to this headline")

`dimspy.process.peak_filters.``filter_attr`(*pl: dimspy.models.peaklist.PeakList*, *attr\_name: str*, *max\_threshold: Optional[Union[int*, *float]] = None*, *min\_threshold: [<class 'int'>*, *<class 'float'>*, *None] = None*, *flag\_name: Optional[str] = None*, *flag\_index: Optional[int] = None*)[[source]](_modules/dimspy/process/peak_filters.html#filter_attr)[¶](#dimspy.process.peak_filters.filter_attr "Permalink to this definition")
:   Peaklist attribute values filter.

    Parameters
    :   * **pl** – The target peaklist
        * **attr\_name** – Name of the target attribute
        * **max\_threshold** – Maximum threshold. A peak will be unflagged if the value of it’s attr\_name is larger than the
          threshold. Default = None, indicating no threshold
        * **min\_threshold** – Minimum threshold. A peak will be unflagged if the value of it’s attr\_name is smaller than the
          threshold. Default = None, indicating no threshold
        * **flag\_name** – Name of the new flag attribute. Default = None, indicating using attr\_name + ‘\_flag’
        * **flag\_index** – Index of the new flag to be inserted into the peaklist. Default = None

    Return type
    :   PeakList object

    This filter accepts real value attributes only.

`dimspy.process.peak_filters.``filter_ringing`(*pl: [dimspy.models.peaklist.PeakList](dimspy.models.html#dimspy.models.peaklist.PeakList "dimspy.models.peaklist.PeakList")*, *threshold: float*, *bin\_size: Union[int, float] = 1.0*, *flag\_name: str = 'ringing\_flag'*, *flag\_index: Optional[int] = None*)[[source]](_modules/dimspy/process/peak_filters.html#filter_ringing)[¶](#dimspy.process.peak_filters.filter_ringing "Permalink to this definition")
:   Peaklist ringing filter.

    Parameters
    :   * **pl** – The target peaklist
        * **threshold** – Intensity threshold ratio
        * **bin\_size** – size of the mz chunk for intensity filtering. Default = 1.0 ppm
        * **flag\_name** – Name of the new flag attribute. Default = ‘ringing\_flag’
        * **flag\_index** – Index of the new flag to be inserted into the peaklist. Default = None

    Return type
    :   PeakList object

    This filter will split the mz values into bin\_size chunks, and search the highest intensity value for each chunk.
    All other peaks, if it’s intensity is smaller than threshold x the highest intensity in that chunk, will be unflagged.

`dimspy.process.peak_filters.``filter_mz_ranges`(*pl: [dimspy.models.peaklist.PeakList](dimspy.models.html#dimspy.models.peaklist.PeakList "dimspy.models.peaklist.PeakList")*, *mz\_ranges: Sequence[Tuple[float, float]]*, *flag\_name: str = 'mz\_ranges\_flag'*, *flagged\_only: bool = False*, *flag\_index: Optional[int] = None*)[[source]](_modules/dimspy/process/peak_filters.html#filter_mz_ranges)[¶](#dimspy.process.peak_filters.filter_mz_ranges "Permalink to this definition")
:   Peaklist mz range filter.

    Parameters
    :   * **pl** – The target peaklist
        * **mz\_ranges** – The mz ranges to remove. Must be in the format of [(mz\_min1, mz\_max2), (mz\_min2, mz\_max2), …]
        * **flag\_name** – Name of the new flag attribute. Default = ‘mz\_range\_remove\_flag’
        * **flag\_index** – Index of the new flag to be inserted into the peaklist. Default = None

    Return type
    :   [PeakList](dimspy.models.html#dimspy.models.peaklist.PeakList "dimspy.models.peaklist.PeakList")

    This filter will remove all the peaks whose mz values are within any of the ranges in the mz\_remove\_rngs.

`dimspy.process.peak_filters.``filter_rsd`(*pm: [dimspy.models.peak\_matrix.PeakMatrix](dimspy.models.html#dimspy.models.peak_matrix.PeakMatrix "dimspy.models.peak_matrix.PeakMatrix")*, *rsd\_threshold: Union[int, float]*, *qc\_tag: Any*, *on\_attr: str = 'intensity'*, *flag\_name: str = 'rsd\_flag'*)[[source]](_modules/dimspy/process/peak_filters.html#filter_rsd)[¶](#dimspy.process.peak_filters.filter_rsd "Permalink to this definition")
:   PeakMatrix RSD filter.

    Parameters
    :   * **pm** – The target peak matrix
        * **rsd\_threshold** – Threshold of the RSD of the QC samples
        * **qc\_tag** – Tag (label) to unmask qc samples
        * **on\_attr** – Calculate RSD on given attribute. Default = “intensity”
        * **flag\_name** – Name of the new flag. Default = ‘rsd\_flag’

    Return type
    :   [PeakMatrix](dimspy.models.html#dimspy.models.peak_matrix.PeakMatrix "dimspy.models.peak_matrix.PeakMatrix")

    This filter will calculate the RSD values of the QC samples. A peak with a QC RSD value larger than the
    threshold will be unflagged.

`dimspy.process.peak_filters.``filter_fraction`(*pm: [dimspy.models.peak\_matrix.PeakMatrix](dimspy.models.html#dimspy.models.peak_matrix.PeakMatrix "dimspy.models.peak_matrix.PeakMatrix")*, *fraction\_threshold: float*, *within\_classes: bool = False*, *class\_tag\_type: Any = None*, *flag\_name: str = 'fraction\_flag'*)[[source]](_modules/dimspy/process/peak_filters.html#filter_fraction)[¶](#dimspy.process.peak_filters.filter_fraction "Permalink to this definition")
:   PeakMatrix fraction filter.

    Parameters
    :   * **pm** – The target peak matrix
        * **fraction\_threshold** – Threshold of the sample fractions
        * **within\_classes** – Whether to calculate the fraction array within each class. Default = False
        * **class\_tag\_type** – Tag type to unmask samples within the same class (e.g. “classLabel”). Default = None
        * **flag\_name** – Name of the new flag. Default = ‘fraction\_flag’

    Return type
    :   PeakMatrix object

    This filter will calculate the fraction array over all samples or within each class (based on class\_tag\_type).
    The peaks with a fraction value smaller than the threshold will be unflagged.

`dimspy.process.peak_filters.``filter_blank_peaks`(*pm: [dimspy.models.peak\_matrix.PeakMatrix](dimspy.models.html#dimspy.models.peak_matrix.PeakMatrix "dimspy.models.peak_matrix.PeakMatrix")*, *blank\_tag: Any*, *fraction\_threshold: Union[int, float] = 1*, *fold\_threshold: Union[int, float] = 1*, *method: str = 'mean'*, *rm\_blanks: bool = True*, *flag\_name: str = 'blank\_flag'*)[[source]](_modules/dimspy/process/peak_filters.html#filter_blank_peaks)[¶](#dimspy.process.peak_filters.filter_blank_peaks "Permalink to this definition")
:   PeakMatrix blank filter.

    Parameters
    :   * **pm** – The target peak matrix
        * **blank\_tag** – Tag (label) to mask blank samples. e.g Tag(“blank”, “classLabel”)
        * **fraction\_threshold** – Threshold of the sample fractions. Default = 1
        * **fold\_threshold** – Threshold of the blank sample intensity folds. Default = 1
        * **method** – Method to calculate blank sample intensity array. Valid values include ‘mean’, ‘median’, and ‘max’.
          Default = ‘mean’
        * **rm\_blanks** – Whether to remove (not mask) blank samples after filtering
        * **flag\_name** – Name of the new flag. Default = ‘blank\_flag’

    Return type
    :   PeakMatrix object

    This filter will calculate the intensity array of the blanks using the “method”, and compare with the
    intensities of the other samples. If fraction\_threshold% of the intensity values of a peak are smaller than the
    blank intensities x fold\_threshold, this peak will be unflagged.

## scan\_processing[¶](#module-dimspy.process.replicate_processing "Permalink to this headline")

`dimspy.process.replicate_processing.``remove_edges`(*pls\_sd: Dict*)[[source]](_modules/dimspy/process/replicate_processing.html#remove_edges)[¶](#dimspy.process.replicate_processing.remove_edges "Permalink to this definition")
:   Removes overlapping m/z regions of adjacent (SIM) windows / scan events.

    Parameters
    :   **pls\_sd** – List of peaklist objects

    Returns
    :   List of peaklist objects

`dimspy.process.replicate_processing.``read_scans`(*fn: str*, *function\_noise: str*, *min\_scans: int = 1*, *filter\_scan\_events: Dict = None*)[[source]](_modules/dimspy/process/replicate_processing.html#read_scans)[¶](#dimspy.process.replicate_processing.read_scans "Permalink to this definition")
:   Read, filter, group and sort scans based on the header / filter string
    Helper function for ‘process\_scans (tools module)’

    Parameters
    :   * **fn** – Path to the .mzml or .raw file
        * **function\_noise** –

          Function to calculate the noise from each scan. The following options are available:

          + **median** - the median of all peak intensities within a given scan is used as the noise value.
          + **mean** - the unweighted mean average of all peak intensities within a given scan is used as the noise value.
          + **mad (Mean Absolute Deviation)** - the noise value is set as the mean of the absolute differences between peak
            intensities and the mean peak intensity (calculated across all peak intensities within a given scan).
          + **noise\_packets** - the noise value is calculated using the proprietary algorithms contained in Thermo Fisher
            Scientific’s msFileReader library. This option should only be applied when you are processing .RAW files.
        * **min\_scans** – Minimum number of scans required for each *m/z* window or event within a raw/mzML data file.
        * **filter\_scan\_events** –

          Include or exclude specific scan events, by default all ALL scan events will be
          included. To include or exclude specific scan events use the following format of a dictionary.

          ```
          >>> {"include":[[100, 300, "sim"]]} or {"include":[[100, 1000, "full"]]}
          ```

    Returns
    :   List of peaklist objects

`dimspy.process.replicate_processing.``average_replicate_scans`(*name: str*, *pls: Sequence[[dimspy.models.peaklist.PeakList](dimspy.models.html#dimspy.models.peaklist.PeakList "dimspy.models.peaklist.PeakList")]*, *ppm: float = 2.0*, *min\_fraction: float = 0.8*, *rsd\_thres: float = 30.0*, *rsd\_on: str = 'intensity'*, *block\_size: int = 5000*, *ncpus: int = None*)[[source]](_modules/dimspy/process/replicate_processing.html#average_replicate_scans)[¶](#dimspy.process.replicate_processing.average_replicate_scans "Permalink to this definition")
:   Align, filter and average replicate scans/peaklist
    Helper function for ‘process\_scans (tools module)’

    Parameters
    :   * **name** – Name average peaklist
        * **pls** – List of peaklists
        * **ppm** – Maximum tolerated m/z deviation in parts per million.
        * **min\_fraction** – A numerical value from 0 to 1 that specifies the minimum proportion of scans a given mass
          spectral peak must be detected in, in order for it to be kept in the output peaklist. Here, scans refers to
          replicates of the same scan event type, i.e. if set to 0.33, then a peak would need to be detected in at least
          1 of the 3 replicates of a given scan event type.
        * **rsd\_thres** – Relative standard deviation threshold - A numerical value equal-to or greater-than 0.
          If greater than 0, then peaks whose intensity values have a percent relative standard deviation (otherwise termed
          the percent coefficient of variation) greater-than this value are excluded from the output peaklist.
        * **rsd\_on** – Intensity or SNR
        * **block\_size** – Number peaks in each centre clustering block.
        * **ncpus** – Number of CPUs for parallel clustering. Default = None, indicating using all CPUs that are available

    Returns
    :   List of peaklists

`dimspy.process.replicate_