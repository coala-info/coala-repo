[DIMSPy](index.html)

latest

* [Installation](installation.html)
* [API reference](api-reference.html)
  + [tools](dimspy.tools.html)
  + [metadata](dimspy.metadata.html)
  + [models](dimspy.models.html)
  + portals
    - [mzml\_portal](#module-dimspy.portals.mzml_portal)
    - [thermo\_raw\_portal](#module-dimspy.portals.thermo_raw_portal)
    - [txt\_portal](#module-dimspy.portals.txt_portal)
    - [hdf5\_portal](#module-dimspy.portals.hdf5_portal)
    - [paths](#module-dimspy.portals.paths)
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
* portals
* [Edit on GitHub](https://github.com/computational-metabolomics/dimspy/blob/master/docs/source/dimspy.portals.rst)

---

# portals[¶](#portals "Permalink to this headline")

## mzml\_portal[¶](#module-dimspy.portals.mzml_portal "Permalink to this headline")

*class* `dimspy.portals.mzml_portal.``Mzml`(*filename: Union[str, \_io.BytesIO]*, *\*\*kwargs*)[[source]](_modules/dimspy/portals/mzml_portal.html#Mzml)[¶](#dimspy.portals.mzml_portal.Mzml "Permalink to this definition")
:   Bases: `object`

    mzML portal

    `headers`() → collections.OrderedDict[[source]](_modules/dimspy/portals/mzml_portal.html#Mzml.headers)[¶](#dimspy.portals.mzml_portal.Mzml.headers "Permalink to this definition")
    :   Get all unique header or filter strings and associated scan ids.
        :return: Dictionary

    `scan_ids`() → collections.OrderedDict[[source]](_modules/dimspy/portals/mzml_portal.html#Mzml.scan_ids)[¶](#dimspy.portals.mzml_portal.Mzml.scan_ids "Permalink to this definition")
    :   Get all scan ids and associated headers or filter strings.
        :return: Dictionary

    `peaklist`(*scan\_id*, *function\_noise='median'*) → [dimspy.models.peaklist.PeakList](dimspy.models.html#dimspy.models.peaklist.PeakList "dimspy.models.peaklist.PeakList")[[source]](_modules/dimspy/portals/mzml_portal.html#Mzml.peaklist)[¶](#dimspy.portals.mzml_portal.Mzml.peaklist "Permalink to this definition")
    :   Create a peaklist object for a specific scan id.
        :param scan\_id: Scan id
        :param function\_noise: Function to calculate the noise from each scan. The following options are available:

        * **median** - the median of all peak intensities within a given scan is used as the noise value.
        * **mean** - the unweighted mean average of all peak intensities within a given scan is used as the noise value.
        * **mad (Mean Absolute Deviation)** - the noise value is set as the mean of the absolute differences between peak
          intensities and the mean peak intensity (calculated across all peak intensities within a given scan).

        Returns
        :   PeakList object

    `peaklists`(*scan\_ids*, *function\_noise='median'*) → Sequence[[dimspy.models.peaklist.PeakList](dimspy.models.html#dimspy.models.peaklist.PeakList "dimspy.models.peaklist.PeakList")][[source]](_modules/dimspy/portals/mzml_portal.html#Mzml.peaklists)[¶](#dimspy.portals.mzml_portal.Mzml.peaklists "Permalink to this definition")
    :   Create a list of peaklist objects for each scan id in the list.
        :param scan\_ids: List of scan ids

        Parameters
        :   **function\_noise** – Function to calculate the noise from each scan. The following options are available:

        * **median** - the median of all peak intensities within a given scan is used as the noise value.
        * **mean** - the unweighted mean average of all peak intensities within a given scan is used as the noise value.
        * **mad (Mean Absolute Deviation)** - the noise value is set as the mean of the absolute differences between peak
          intensities and the mean peak intensity (calculated across all peak intensities within a given scan).
        * **noise\_packets** - the noise value is calculated using the proprietary algorithms contained in Thermo Fisher
          Scientific’s msFileReader library. This option should only be applied when you are processing .RAW files.

        Returns
        :   List of PeakList objects

    `tics`() → collections.OrderedDict[[source]](_modules/dimspy/portals/mzml_portal.html#Mzml.tics)[¶](#dimspy.portals.mzml_portal.Mzml.tics "Permalink to this definition")
    :   Get all TIC values and associated scan ids
        :return: Dictionary

    `ion_injection_times`() → collections.OrderedDict[[source]](_modules/dimspy/portals/mzml_portal.html#Mzml.ion_injection_times)[¶](#dimspy.portals.mzml_portal.Mzml.ion_injection_times "Permalink to this definition")
    :   Get all ion injection time values and associated scan ids
        :return: Dictionary

    `scan_dependents`() → list[[source]](_modules/dimspy/portals/mzml_portal.html#Mzml.scan_dependents)[¶](#dimspy.portals.mzml_portal.Mzml.scan_dependents "Permalink to this definition")
    :   Get a nested list of scan id pairs. Each pair represents a fragementation event.
        :return: List

    `close`()[[source]](_modules/dimspy/portals/mzml_portal.html#Mzml.close)[¶](#dimspy.portals.mzml_portal.Mzml.close "Permalink to this definition")
    :   Close the reader/file object
        :return: None

## thermo\_raw\_portal[¶](#module-dimspy.portals.thermo_raw_portal "Permalink to this headline")

`dimspy.portals.thermo_raw_portal.``mz_range_from_header`(*h: str*) → list[[source]](_modules/dimspy/portals/thermo_raw_portal.html#mz_range_from_header)[¶](#dimspy.portals.thermo_raw_portal.mz_range_from_header "Permalink to this definition")
:   Extract the m/z range from a header or filterstring

    Parameters
    :   **h** – str

    Returns
    :   Sequence[float, float]

*class* `dimspy.portals.thermo_raw_portal.``ThermoRaw`(*filename*)[[source]](_modules/dimspy/portals/thermo_raw_portal.html#ThermoRaw)[¶](#dimspy.portals.thermo_raw_portal.ThermoRaw "Permalink to this definition")
:   Bases: `object`

    ThermoRaw portal

    `headers`() → collections.OrderedDict[[source]](_modules/dimspy/portals/thermo_raw_portal.html#ThermoRaw.headers)[¶](#dimspy.portals.thermo_raw_portal.ThermoRaw.headers "Permalink to this definition")
    :   Get all unique header or filter strings and associated scan ids.
        :return: Dictionary

    `scan_ids`() → collections.OrderedDict[[source]](_modules/dimspy/portals/thermo_raw_portal.html#ThermoRaw.scan_ids)[¶](#dimspy.portals.thermo_raw_portal.ThermoRaw.scan_ids "Permalink to this definition")
    :   Get all scan ids and associated headers or filter strings.
        :return: Dictionary

    `peaklist`(*scan\_id*, *function\_noise='noise\_packets'*) → [dimspy.models.peaklist.PeakList](dimspy.models.html#dimspy.models.peaklist.PeakList "dimspy.models.peaklist.PeakList")[[source]](_modules/dimspy/portals/thermo_raw_portal.html#ThermoRaw.peaklist)[¶](#dimspy.portals.thermo_raw_portal.ThermoRaw.peaklist "Permalink to this definition")
    :   Create a peaklist object for a specific scan id.
        :param scan\_id: Scan id
        :param function\_noise: Function to calculate the noise from each scan. The following options are available:

        * **median** - the median of all peak intensities within a given scan is used as the noise value.
        * **mean** - the unweighted mean average of all peak intensities within a given scan is used as the noise value.
        * **mad (Mean Absolute Deviation)** - the noise value is set as the mean of the absolute differences between peak
          intensities and the mean peak intensity (calculated across all peak intensities within a given scan).
        * **noise\_packets** - the noise value is calculated using the proprietary algorithms contained in Thermo Fisher
          Scientific’s msFileReader library. This option should only be applied when you are processing .RAW files.

        Returns
        :   PeakList object

    `peaklists`(*scan\_ids*, *function\_noise='noise\_packets'*) → Sequence[[dimspy.models.peaklist.PeakList](dimspy.models.html#dimspy.models.peaklist.PeakList "dimspy.models.peaklist.PeakList")][[source]](_modules/dimspy/portals/thermo_raw_portal.html#ThermoRaw.peaklists)[¶](#dimspy.portals.thermo_raw_portal.ThermoRaw.peaklists "Permalink to this definition")
    :   Create a list of peaklist objects for each scan id in the list.
        :param scan\_ids: List of scan ids

        Parameters
        :   **function\_noise** – Function to calculate the noise from each scan. The following options are available:

        * **median** - the median of all peak intensities within a given scan is used as the noise value.
        * **mean** - the unweighted mean average of all peak intensities within a given scan is used as the noise value.
        * **mad (Mean Absolute Deviation)** - the noise value is set as the mean of the absolute differences between peak
          intensities and the mean peak intensity (calculated across all peak intensities within a given scan).
        * **noise\_packets** - the noise value is calculated using the proprietary algorithms contained in Thermo Fisher
          Scientific’s msFileReader library. This option should only be applied when you are processing .RAW files.

        Returns
        :   List of PeakList objects

    `tics`() → collections.OrderedDict[[source]](_modules/dimspy/portals/thermo_raw_portal.html#ThermoRaw.tics)[¶](#dimspy.portals.thermo_raw_portal.ThermoRaw.tics "Permalink to this definition")
    :   Get all TIC values and associated scan ids
        :return: Dictionary

    `ion_injection_times`() → collections.OrderedDict[[source]](_modules/dimspy/portals/thermo_raw_portal.html#ThermoRaw.ion_injection_times)[¶](#dimspy.portals.thermo_raw_portal.ThermoRaw.ion_injection_times "Permalink to this definition")
    :   Get all TIC values and associated scan ids
        :return: Dictionary

    `scan_dependents`() → list[[source]](_modules/dimspy/portals/thermo_raw_portal.html#ThermoRaw.scan_dependents)[¶](#dimspy.portals.thermo_raw_portal.ThermoRaw.scan_dependents "Permalink to this definition")
    :   Get a nested list of scan id pairs. Each pair represents a fragementation event.
        :return: List

    `close`()[[source]](_modules/dimspy/portals/thermo_raw_portal.html#ThermoRaw.close)[¶](#dimspy.portals.thermo_raw_portal.ThermoRaw.close "Permalink to this definition")
    :   Close the reader/file object
        :return: None

## txt\_portal[¶](#module-dimspy.portals.txt_portal "Permalink to this headline")

`dimspy.portals.txt_portal.``save_peaklist_as_txt`(*pkl: [dimspy.models.peaklist.PeakList](dimspy.models.html#dimspy.models.peaklist.PeakList "dimspy.models.peaklist.PeakList")*, *filename: str*, *\*args*, *\*\*kwargs*)[[source]](_modules/dimspy/portals/txt_portal.html#save_peaklist_as_txt)[¶](#dimspy.portals.txt_portal.save_peaklist_as_txt "Permalink to this definition")
:   Saves a peaklist object to a plain text file.

    Parameters
    :   * **pkl** – the target peaklist object
        * **filename** – path to a new text file
        * **args** – arguments to be passed to PeakList.to\_str
        * **kwargs** – keyword arguments to be passed to PeakList.to\_str

`dimspy.portals.txt_portal.``load_peaklist_from_txt`(*filename: str*, *ID: any*, *delimiter: str = ','*, *flag\_names: str = 'auto'*, *has\_flag\_col: bool = True*)[[source]](_modules/dimspy/portals/txt_portal.html#load_peaklist_from_txt)[¶](#dimspy.portals.txt_portal.load_peaklist_from_txt "Permalink to this definition")
:   Loads a peaklist from plain text file.

    Parameters
    :   * **filename** – Path to an exiting text-based peaklist file
        * **ID** – ID of the peaklist
        * **delimiter** – Delimiter of the text lines. Default = ‘,’, i.e., CSV format
        * **flag\_names** – Names of the flag attributes. Default = ‘auto’, indicating all the attribute names ends
          with “\_flag” will be treated as flag attibute. Provide None to indicate no flag attributes
        * **has\_flag\_col** – Whether the text file contains the overall “flags” column. If True, it’s values will be
          discarded. The overall flags of the new peaklist will be calculated automatically. Default = True

    Return type
    :   PeakList object

`dimspy.portals.txt_portal.``save_peak_matrix_as_txt`(*pm: [dimspy.models.peak\_matrix.PeakMatrix](dimspy.models.html#dimspy.models.peak_matrix.PeakMatrix "dimspy.models.peak_matrix.PeakMatrix")*, *filename: str*, *\*args*, *\*\*kwargs*)[[source]](_modules/dimspy/portals/txt_portal.html#save_peak_matrix_as_txt)[¶](#dimspy.portals.txt_portal.save_peak_matrix_as_txt "Permalink to this definition")
:   Saves a peak matrix in plain text file.

    Parameters
    :   * **pm** – The target peak matrix object
        * **filename** – Path to a new text file
        * **args** – Arguments to be passed to PeakMatrix.to\_str
        * **kwargs** – Keyword arguments to be passed to PeakMatrix.to\_str

`dimspy.portals.txt_portal.``load_peak_matrix_from_txt`(*filename: str*, *delimiter: str = '\t'*, *samples\_in\_rows: bool = True*, *comprehensive: str = 'auto'*)[[source]](_modules/dimspy/portals/txt_portal.html#load_peak_matrix_from_txt)[¶](#dimspy.portals.txt_portal.load_peak_matrix_from_txt "Permalink to this definition")
:   Loads a peak matrix from plain text file.

    Parameters
    :   * **filename** – Path to an exiting text-based peak matrix file
        * **delimiter** – Delimiter of the text lines. Default = ‘ ‘, i.e., TSV format
        * **samples\_in\_rows** – Whether or not the samples are stored in rows. Default = True
        * **comprehensive** – Whether the input is a ‘comprehensive’ or ‘simple’ version of the matrix. Default = ‘auto’, i.e., auto detect

    Return type
    :   PeakMatrix object

## hdf5\_portal[¶](#module-dimspy.portals.hdf5_portal "Permalink to this headline")

`dimspy.portals.hdf5_portal.``save_peaklists_as_hdf5`(*pkls: Sequence[[dimspy.models.peaklist.PeakList](dimspy.models.html#dimspy.models.peaklist.PeakList "dimspy.models.peaklist.PeakList")]*, *filename: str*, *compatibility\_mode: bool = False*)[[source]](_modules/dimspy/portals/hdf5_portal.html#save_peaklists_as_hdf5)[¶](#dimspy.portals.hdf5_portal.save_peaklists_as_hdf5 "Permalink to this definition")
:   Saves multiple peaklists in a HDF5 file.

    Parameters
    :   * **pkls** – The target list of peaklist objects
        * **filename** – Path to a new HDF5 file
        * **compatibility\_mode** – Change mode to read previous DIMSpy v1.\* based HDF5 file

    To incorporate with different dtypes in the attribute matrix, this portal converts all the arribute values
    into fix-length strings for HDF5 data tables storage. The order of the peaklists will be retained.

`dimspy.portals.hdf5_portal.``load_peaklists_from_hdf5`(*filename: str*, *compatibility\_mode: bool = False*)[[source]](_modules/dimspy/portals