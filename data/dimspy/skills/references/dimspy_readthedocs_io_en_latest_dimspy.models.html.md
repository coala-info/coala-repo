[DIMSPy](index.html)

latest

* [Installation](installation.html)
* [API reference](api-reference.html)
  + [tools](dimspy.tools.html)
  + [metadata](dimspy.metadata.html)
  + models
    - [peaklist](#module-dimspy.models.peaklist)
    - [peaklist\_metadata](#module-dimspy.models.peaklist_metadata)
    - [peaklist\_tags](#module-dimspy.models.peaklist_tags)
    - [peak\_matrix](#module-dimspy.models.peak_matrix)
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
* models
* [Edit on GitHub](https://github.com/computational-metabolomics/dimspy/blob/master/docs/source/dimspy.models.rst)

---

# models[¶](#models "Permalink to this headline")

## peaklist[¶](#module-dimspy.models.peaklist "Permalink to this headline")

*class* `dimspy.models.peaklist.``PeakList`(*ID: str*, *mz: Sequence[float]*, *intensity: Sequence[float]*, *\*\*metadata*)[[source]](_modules/dimspy/models/peaklist.html#PeakList)[¶](#dimspy.models.peaklist.PeakList "Permalink to this definition")
:   Bases: `object`

    The PeakList class.

    Stores mass spectrometry peaks list data. It requires an ID, mz values, and intensities. It can store extra peak
    attributes e.g. SNRs, and peaklist tags and metadata. It utilises the automatically managed flags to “remove” or
    “retain” peaks without actually delete them. Therefore the filterings on the peaks are traceable.

    Parameters
    :   * **ID** – The ID of the peaklist data, unique string or integer value is recommended
        * **mz** – Mz values of all the peaks. Must in the ascending order
        * **intensity** – Intensities of all the peaks. Must have the same size as mz
        * **kwargs** – Key-value pairs of the peaklist metadata

    ```
    >>> mz_values = np.random.uniform(100, 1200, size = 100)
    >>> int_values = np.random.normal(60, 10, size = 100)
    >>> peaks = PeakList('dummy', mz_values, int_values, description = 'a dummy peaklist')
    ```

    Internally the peaklist data is stored by using numpy structured array namely the attribute talbe (this may change in the future):

    | mz | intensity | snr | snr\_flag | … | *flags\** |
    | --- | --- | --- | --- | --- | --- |
    | 102.5 | 21.7 | 10.5 | True | … | True |
    | 111.7 | 12.3 | 5.1 | False | False |
    | 126.3 | 98.1 | 31.7 | True | True |
    | 133.1 | 68.9 | 12.6 | True | True |
    | … |  |  |  |  |

    Each column is called an attribute. The first two attributes are fixed as “mz” and “intensity”. They cannot be added or
    removed as the others. The last “attribute” is the “flags”, which is fact stored separately. The “flags” column is
    calculated automatically according to all the manually set flag attributes, e.g., the “snr\_flag”. It can only be changed
    by the class itself. The unflagged peaks are considered as “removed”. They are kept internally mainly for visualization
    and tracing purposes.

    Warning

    Removing a flag attribute may change the “flags” column, and cause the unflagged peaks to be flagged again. As
    most the processes are applied only on the flagged peaks, these peaks, if the others have gone through such process,
    may have incorrect values.

    In principle, setting a flag attribute should be considered as an irreversible process.

    *property* `ID`[¶](#dimspy.models.peaklist.PeakList.ID "Permalink to this definition")
    :   Property of the peaklist ID.

        Getter
        :   Returns the peaklist ID

        Setter
        :   Set the peaklist ID

        Type
        :   Same as input ID

    `add_attribute`(*attr\_name: str*, *attr\_value: Sequence*, *attr\_dtype: Optional[Union[Type, str]] = None*, *is\_flag: bool = False*, *on\_index: Optional[int] = None*, *flagged\_only: bool = True*, *invalid\_value=nan*)[[source]](_modules/dimspy/models/peaklist.html#PeakList.add_attribute)[¶](#dimspy.models.peaklist.PeakList.add_attribute "Permalink to this definition")
    :   Adds an new attribute to the PeakList attribute table.

        Parameters
        :   * **attr\_name** – The name of the new attribute, must be a string
            * **attr\_value** – The values of the new attribute. It’s size must equals to PeakList.size
              (if flagged\_only == True), or PeakList.full\_size (if flagged\_only == False)
            * **attr\_dtype** – The data type of the new attribute. If it is set to None, the PeakList will
              try to detect the data type based on attr\_value. If the detection failed it will take the “object” type. Default = None
            * **is\_flag** – Whether the new attribute is a flag attribute, i.e., will be used in flags calculation. Default = False
            * **on\_index** – Insert the new attribute on a specific column. It can’t be 0 or 1, as the first two
              attributes are fixed as mz and intensity. Setting to None means to put it to the last column. Default = None
            * **flagged\_only** – Whether the attr\_value is set to the flagged peaks or all peaks. Default = True
            * **invalid\_value** – If flagged\_only is set to True, this value will be assigned to the unflagged peaks.
              The actual value depends on the attribute data type. For instance, on a boolean attribute invalid\_value = 0 will
              be converted to False. Default = numpy.nan

        Return type
        :   PeakList object (self)

    *property* `attributes`[¶](#dimspy.models.peaklist.PeakList.attributes "Permalink to this definition")
    :   Property of the attribute names.

        Getter
        :   Returns a tuple of the attribute names

        Type
        :   tuple

    `calculate_flags`()[[source]](_modules/dimspy/models/peaklist.html#PeakList.calculate_flags)[¶](#dimspy.models.peaklist.PeakList.calculate_flags "Permalink to this definition")
    :   Re-calculates the flags according to the flag attributes.

        Return type
        :   numpy array

        Note

        This method will be called automatically every time a flag attribute is added, removed, or changed.

    `cleanup_unflagged_peaks`(*flag\_name: Optional[str] = None*)[[source]](_modules/dimspy/models/peaklist.html#PeakList.cleanup_unflagged_peaks)[¶](#dimspy.models.peaklist.PeakList.cleanup_unflagged_peaks "Permalink to this definition")
    :   Remove unflagged peaks.

        Parameters
        :   **flag\_name** – Remove peaks unflagged by this flag attribute. Setting None means to remove peaks unflagged by
            the overall flags. Default = None

        Return type
        :   PeakList object (self)

        ```
        >>> print(peaks)
        mz, intensity, intensity_flag, snr, snr_flag, flags
        10, 70, True, 10, False, False
        20, 60, True, 20, True, True
        30, 50, False, 30, True, False
        40, 40, False, 40, True, False
        >>> print(peaks.cleanup_unflagged_peaks('snr_flag'))
        mz, intensity, intensity_flag, snr, snr_flag, flags
        20, 60, True, 20, True, True
        30, 50, False, 30, True, False
        40, 40, False, 40, True, False
        >>> print(peaks.cleanup_unflagged_peaks())
        mz, intensity, intensity_flag, snr, snr_flag, flags
        20, 60, True, 20, True, True
        ```

    `copy`()[[source]](_modules/dimspy/models/peaklist.html#PeakList.copy)[¶](#dimspy.models.peaklist.PeakList.copy "Permalink to this definition")
    :   Returns a deep copy of the peaklist.

        Return type
        :   PeakList object

    `drop_attribute`(*attr\_name: str*)[[source]](_modules/dimspy/models/peaklist.html#PeakList.drop_attribute)[¶](#dimspy.models.peaklist.PeakList.drop_attribute "Permalink to this definition")
    :   Drops an existing attribute.

        Parameters
        :   **attr\_name** – The attribute name to drop. It cannot be mz, intensity, or flags

        Return type
        :   PeakList object (self)

    *property* `dtable`[¶](#dimspy.models.peaklist.PeakList.dtable "Permalink to this definition")
    :   Property of the overall attribute table.

        Getter
        :   Returns the original attribute table

        Type
        :   numpy structured array

        Warning

        This property directly accesses the internal attribute table. Be careful when manipulating the data,
        particularly pay attention to the potential side-effects.

    *property* `flag_attributes`[¶](#dimspy.models.peaklist.PeakList.flag_attributes "Permalink to this definition")
    :   Property of the flag attribute names.

        Getter
        :   Returns a tuple of the flag attribute names

        Type
        :   tuple

    *property* `flags`[¶](#dimspy.models.peaklist.PeakList.flags "Permalink to this definition")
    :   Property of the flags.

        Getter
        :   Returns a deep copy of the flags array

        Type
        :   numpy array

    *property* `full_shape`[¶](#dimspy.models.peaklist.PeakList.full_shape "Permalink to this definition")
    :   Property of the peaklist full attributes table shape.

        Getter
        :   Returns the full attibutes table shape, including the unflagged peaks

        Type
        :   tuple

    *property* `full_size`[¶](#dimspy.models.peaklist.PeakList.full_size "Permalink to this definition")
    :   Property of the peaklist full size.

        Getter
        :   Returns the full peaklist size, i.e., including the unflagged peaks

        Type
        :   int

    `get_attribute`(*attr\_name: str*, *flagged\_only: bool = True*)[[source]](_modules/dimspy/models/peaklist.html#PeakList.get_attribute)[¶](#dimspy.models.peaklist.PeakList.get_attribute "Permalink to this definition")
    :   Gets values of an existing attribute.

        Parameters
        :   * **attr\_name** – The attribute to get values
            * **flagged\_only** – Whether to return the values of flagged peaks or all peaks. Default = True

        Return type
        :   numpy array

    `get_peak`(*peak\_index: Union[int, Sequence[int]]*, *flagged\_only: bool = True*)[[source]](_modules/dimspy/models/peaklist.html#PeakList.get_peak)[¶](#dimspy.models.peaklist.PeakList.get_peak "Permalink to this definition")
    :   Gets values of a peak.

        Parameters
        :   * **peak\_index** – The index of the peak to get values
            * **flagged\_only** – Whether the values are taken from the index of flagged peaks or all peaks. Default = True

        Return type
        :   numpy array

    `has_attribute`(*attr\_name: str*)[[source]](_modules/dimspy/models/peaklist.html#PeakList.has_attribute)[¶](#dimspy.models.peaklist.PeakList.has_attribute "Permalink to this definition")
    :   Checks whether there exists an attribute in the table.

        Parameters
        :   **attr\_name** – The attribute name for checking

        Return type
        :   bool

    `insert_peak`(*peak\_value: Sequence*)[[source]](_modules/dimspy/models/peaklist.html#PeakList.insert_peak)[¶](#dimspy.models.peaklist.PeakList.insert_peak "Permalink to this definition")
    :   Insert a new peak.

        Parameters
        :   **peak\_value** – The values of the new peak. Must contain values for all the attributes. It’s position depends
            on the mz value, i.e., the 1st value of the input

        Return type
        :   PeakList object (self)

    *property* `metadata`[¶](#dimspy.models.peaklist.PeakList.metadata "Permalink to this definition")
    :   Property of the peaklist metadata.

        Getter
        :   Returns an access interface to the peaklist metadata object

        Type
        :   PeakList\_Metadata object

    *property* `peaks`[¶](#dimspy.models.peaklist.PeakList.peaks "Permalink to this definition")
    :   Property of the attribute table.

        Getter
        :   Returns a deep copy of the flagged attribute table

        Type
        :   numpy structured array

    `remove_peak`(*peak\_index: Union[int, Sequence[int]]*, *flagged\_only: bool = True*)[[source]](_modules/dimspy/models/peaklist.html#PeakList.remove_peak)[¶](#dimspy.models.peaklist.PeakList.remove_peak "Permalink to this definition")
    :   Remove an existing peak.

        Parameters
        :   * **peak\_index** – The index of the peak to remove
            * **flagged\_only** – Whether the index is for flagged peaks or all peaks. Default = True

        Return type
        :   PeakList object (self)

    `set_attribute`(*attr\_name: str*, *attr\_value: Sequence*, *flagged\_only: bool = True*, *unsorted\_mz: bool = False*)[[source]](_modules/dimspy/models/peaklist.html#PeakList.set_attribute)[¶](#dimspy.models.peaklist.PeakList.set_attribute "Permalink to this definition")
    :   Sets values to an existing attribute.

        Parameters
        :   * **attr\_name** – The attribute to set values
            * **attr\_value** – The new attribute values, It’s size must equals to PeakList.size
              (if flagged\_only == True), or PeakList.full\_size (if flagged\_only == False)
            * **flagged\_only** – Whether the attr\_value is set to the flagged peaks or all peaks. Default = True
            * **unsorted\_mz** – Whether the attr\_value contains unsorted mz values. This parameter is valid only when
              attr\_name == “mz”. Default = False

        Return type
        :   PeakList object (self)

    `set_peak`(*peak\_index: int*, *peak\_value: Sequence*, *flagged\_only: bool = True*)[[source]](_modules/dimspy/models/peaklist.html#PeakList.set_peak)[¶](#dimspy.models.peaklist.PeakList.set_peak "Permalink to this definition")
    :   Sets values to a peak.

        Parameters
        :   * **peak\_index** – The index of the peak to set values
            * **peak\_value** – The new peak values. Must contain values for all the attributes (not including flags)
            * **flagged\_only** – Whether the peak\_value is set to the index of flagged peaks or all peaks. Default = True

        Return type
        :   PeakList object (self)

        ```
        >>> print(peaks)
        mz, intensity, snr, flags
        10, 10, 10, True
        20, 20, 20, True
        30, 30, 30, False
        40, 40, 40, True
        >>> print(peaks.set_peak(2, [50, 50, 50], flagged_only = True))
        mz, intensity, snr, flags
        10, 10, 10, True
        20, 20, 20, True
        30, 30, 30, False
        50, 50, 50, True
        >>> print(peaks.set_peak(2, [40, 40, 40], flagged_only = False))
        mz, intensity, snr, flags
        10, 10, 10, True
        20, 20, 20, True
        40, 40, 40, False
        50, 50, 50, True
        ```

    *property* `shape`[¶](#dimspy.models.peaklist.PeakList.shape "Permalink to this definition")
    :   Property of the peaklist attributes table shape.

        Getter
        :   Returns the attibutes table shape, i.