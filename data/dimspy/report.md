# dimspy CWL Generation Report

## dimspy_process-scans

### Tool Description
Processes raw mass spectrometry scan data to generate peaklists.

### Metadata
- **Docker Image**: quay.io/biocontainers/dimspy:2.0.0--pyhdfd78af_1
- **Homepage**: https://github.com/computational-metabolomics/dimspy
- **Package**: https://anaconda.org/channels/bioconda/packages/dimspy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dimspy/overview
- **Total Downloads**: 27.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/computational-metabolomics/dimspy
- **Stars**: N/A
### Original Help Text
```text
Executing dimspy version 2.0.0.
usage: dimspy process-scans [-h] -i source -o OUTPUT [-l FILELIST] -m
                            {median,mean,mad,noise_packets} -s SNR_THRESHOLD
                            [-p PPM] [-n MIN_SCANS] [-a MIN_FRACTION]
                            [-d RSD_THRESHOLD] [-k] [-r RINGING_THRESHOLD]
                            [-e start end scan_type] [-x start end scan_type]
                            [-z start end] [-u REPORT] [-b BLOCK_SIZE]
                            [-c NCPUS]

optional arguments:
  -h, --help            show this help message and exit
  -i source, --input source
                        Directory (*.raw, *.mzml or tab-delimited peaklist
                        files), single *.mzml/*.raw file or zip archive
                        (*.mzml only)
  -o OUTPUT, --output OUTPUT
                        HDF5 file to save the peaklist objects to.
  -l FILELIST, --filelist FILELIST
                        Tab-delimited file that include the name of the data
                        files (*.raw or *.mzml) and meta data. Column names:
                        filename, replicate, batch, injectionOrder,
                        classLabel.
  -m {median,mean,mad,noise_packets}, --function-noise {median,mean,mad,noise_packets}
                        Select function to calculate noise.
  -s SNR_THRESHOLD, --snr-threshold SNR_THRESHOLD
                        Signal-to-noise threshold
  -p PPM, --ppm PPM     Mass tolerance in Parts per million to group peaks
                        across scans / mass spectra.
  -n MIN_SCANS, --min_scans MIN_SCANS
                        Minimum number of scans required for each m/z range or
                        event.
  -a MIN_FRACTION, --min-fraction MIN_FRACTION
                        Minimum fraction a peak has to be present. Use 0.0 to
                        not apply this filter.
  -d RSD_THRESHOLD, --rsd-threshold RSD_THRESHOLD
                        Maximum threshold - relative standard deviation
                        (Calculated for peaks that have been measured across a
                        minimum of two scans).
  -k, --skip-stitching  Skip the step where (SIM) windows are 'stitched' or
                        'joined' together. Individual peaklists are generated
                        for each window.
  -r RINGING_THRESHOLD, --ringing-threshold RINGING_THRESHOLD
                        Ringing
  -e start end scan_type, --include-scan-events start end scan_type
                        Scan events to select. E.g. 100.0 200.0 sim or 50.0
                        1000.0 full
  -x start end scan_type, --exclude-scan-events start end scan_type
                        Scan events to select. E.g. 100.0 200.0 sim or 50.0
                        1000.0 full
  -z start end, --remove-mz-range start end
                        M/z range(s) to remove. E.g. 100.0 102.0 or 140.0
                        145.0.
  -u REPORT, --report REPORT
                        Summary/Report of processed mass spectra
  -b BLOCK_SIZE, --block-size BLOCK_SIZE
                        The size of each block of peaks to perform clustering
                        on.
  -c NCPUS, --ncpus NCPUS
                        Number of central processing units (CPUs).
```


## dimspy_replicate-filter

### Tool Description
Filters peaklists based on replicate information.

### Metadata
- **Docker Image**: quay.io/biocontainers/dimspy:2.0.0--pyhdfd78af_1
- **Homepage**: https://github.com/computational-metabolomics/dimspy
- **Package**: https://anaconda.org/channels/bioconda/packages/dimspy/overview
- **Validation**: PASS

### Original Help Text
```text
Executing dimspy version 2.0.0.
usage: dimspy replicate-filter [-h] -i INPUT -o OUTPUT [-p PPM] -r REPLICATES
                               -m MIN_PEAK_PRESENT [-d RSD_THRESHOLD]
                               [-l FILELIST] [-u REPORT] [-b BLOCK_SIZE]
                               [-c NCPUS]

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        HDF5 file (Peaklist objects) from step 'process-scans'
                        or directory path that contains tab-delimited
                        peaklists.
  -o OUTPUT, --output OUTPUT
                        HDF5 file to save the peaklist objects to.
  -p PPM, --ppm PPM     Mass tolerance in Parts per million to group peaks
                        across scans / mass spectra.
  -r REPLICATES, --replicates REPLICATES
                        Number of technical replicates.
  -m MIN_PEAK_PRESENT, --min-peak-present MIN_PEAK_PRESENT
                        Minimum number of times a peak has to be present
                        (number) across technical replicates.
  -d RSD_THRESHOLD, --rsd-threshold RSD_THRESHOLD
                        Maximum threshold - Relative Standard Deviation.
  -l FILELIST, --filelist FILELIST
                        Tab-delimited file that list all the data files (*.raw
                        or *.mzml) and meta data (filename, technical
                        replicate, class, batch).
  -u REPORT, --report REPORT
                        Summary/Report of processed mass spectra
  -b BLOCK_SIZE, --block-size BLOCK_SIZE
                        The size of each block of peaks to perform clustering
                        on.
  -c NCPUS, --ncpus NCPUS
                        Number of central processing units (CPUs).
```


## dimspy_align-samples

### Tool Description
Aligns samples by grouping peaks across scans/mass spectra based on mass tolerance.

### Metadata
- **Docker Image**: quay.io/biocontainers/dimspy:2.0.0--pyhdfd78af_1
- **Homepage**: https://github.com/computational-metabolomics/dimspy
- **Package**: https://anaconda.org/channels/bioconda/packages/dimspy/overview
- **Validation**: PASS

### Original Help Text
```text
Executing dimspy version 2.0.0.
usage: dimspy align-samples [-h] -i INPUT -o OUTPUT [-p PPM] [-l FILELIST]
                            [-b BLOCK_SIZE] [-c NCPUS]

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        HDF5 file (Peaklist objects) from step 'process-scans
                        / replicate-filter' or directory path that contains
                        tab-delimited peaklists.
  -o OUTPUT, --output OUTPUT
                        HDF5 file to save the peak matrix object to.
  -p PPM, --ppm PPM     Mass tolerance in parts per million to group peaks
                        across scans / mass spectra.
  -l FILELIST, --filelist FILELIST
                        Tab-delimited file that include the name of the
                        samples and meta data.Column names: filename,
                        replicate, batch, injectionOrder, classLabel.
  -b BLOCK_SIZE, --block-size BLOCK_SIZE
                        The size of each block of peaks to perform clustering
                        on.
  -c NCPUS, --ncpus NCPUS
                        Number of central processing units (CPUs).
```


## dimspy_blank-filter

### Tool Description
Filters a peak matrix based on blank samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/dimspy:2.0.0--pyhdfd78af_1
- **Homepage**: https://github.com/computational-metabolomics/dimspy
- **Package**: https://anaconda.org/channels/bioconda/packages/dimspy/overview
- **Validation**: PASS

### Original Help Text
```text
Executing dimspy version 2.0.0.
usage: dimspy blank-filter [-h] -i INPUT -o OUTPUT -l BLANK_LABEL
                           [-m MIN_FRACTION] [-f {mean,median,max}]
                           [-c MIN_FOLD_CHANGE] [-r] [-a LABELS]

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        HDF5 file or tab-delimited file that contains a peak
                        matrix (object).
  -o OUTPUT, --output OUTPUT
                        HDF5 file to save the peak matrix object to.
  -l BLANK_LABEL, --blank-label BLANK_LABEL
                        Class label for blanks.
  -m MIN_FRACTION, --min-fraction MIN_FRACTION
                        Minium fold change blank versus sample.
  -f {mean,median,max}, --function {mean,median,max}
                        Select function to calculate blank intenstiy.
  -c MIN_FOLD_CHANGE, --min-fold-change MIN_FOLD_CHANGE
                        Minium fold change blank versus sample.
  -r, --remove-blank-samples
                        Remove blank samples from peak matrix.
  -a LABELS, --labels LABELS
                        Tab delimited file with at least two columns named
                        'filename' and 'classLabel'.
```


## dimspy_sample-filter

### Tool Description
Apply sample filter to a peak matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/dimspy:2.0.0--pyhdfd78af_1
- **Homepage**: https://github.com/computational-metabolomics/dimspy
- **Package**: https://anaconda.org/channels/bioconda/packages/dimspy/overview
- **Validation**: PASS

### Original Help Text
```text
Executing dimspy version 2.0.0.
usage: dimspy sample-filter [-h] -i INPUT -o OUTPUT [-p MIN_FRACTION] [-w]
                            [-d RSD_THRESHOLD] [-q QC_LABEL] [-a LABELS]

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        HDF5 file or tab-delimited file that contains a peak
                        matrix.
  -o OUTPUT, --output OUTPUT
                        HDF5 file to save the peak matrix object to.
  -p MIN_FRACTION, --min-fraction MIN_FRACTION
                        Minimum percentage of samples a peak has to be
                        present.
  -w, --within          Apply sample filter within each sample class.
  -d RSD_THRESHOLD, --rsd-threshold RSD_THRESHOLD
                        Peaks where the associated QC peaks are above this
                        threshold will be removed.
  -q QC_LABEL, --qc-label QC_LABEL
                        Class label for QCs
  -a LABELS, --labels LABELS
                        Tab delimited file with at least two columns named
                        'filename' and 'classLabel'.
```


## dimspy_remove-samples

### Tool Description
Removes samples from a peak matrix or peaklist object.

### Metadata
- **Docker Image**: quay.io/biocontainers/dimspy:2.0.0--pyhdfd78af_1
- **Homepage**: https://github.com/computational-metabolomics/dimspy
- **Package**: https://anaconda.org/channels/bioconda/packages/dimspy/overview
- **Validation**: PASS

### Original Help Text
```text
Executing dimspy version 2.0.0.
usage: dimspy remove-samples [-h] -i source -o OUTPUT -s SAMPLE_NAMES

optional arguments:
  -h, --help            show this help message and exit
  -i source, --input source
                        HDF5 file that contains a peak matrix object or list
                        of peaklist objects from one of the processing steps.
  -o OUTPUT, --output OUTPUT
                        HDF5 file to save the peak matrix object or peaklist
                        objects to.
  -s SAMPLE_NAMES, --sample-names SAMPLE_NAMES
                        Sample name(s)
```


## dimspy_mv-sample-filter

### Tool Description
Filters samples based on the maximum fraction of missing values.

### Metadata
- **Docker Image**: quay.io/biocontainers/dimspy:2.0.0--pyhdfd78af_1
- **Homepage**: https://github.com/computational-metabolomics/dimspy
- **Package**: https://anaconda.org/channels/bioconda/packages/dimspy/overview
- **Validation**: PASS

### Original Help Text
```text
Executing dimspy version 2.0.0.
usage: dimspy mv-sample-filter [-h] -i INPUT -o OUTPUT [-m MAX_FRACTION]

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        HDF5 file file that contains a peak matrix object.
  -o OUTPUT, --output OUTPUT
                        HDF5 file to save the peak matrix object to.
  -m MAX_FRACTION, --max-fraction MAX_FRACTION
                        Maximum percentage of missing values allowed across a
                        sample.
```


## dimspy_merge-peaklists

### Tool Description
Merge peaklists from multiple HDF5 files.

### Metadata
- **Docker Image**: quay.io/biocontainers/dimspy:2.0.0--pyhdfd78af_1
- **Homepage**: https://github.com/computational-metabolomics/dimspy
- **Package**: https://anaconda.org/channels/bioconda/packages/dimspy/overview
- **Validation**: PASS

### Original Help Text
```text
Executing dimspy version 2.0.0.
usage: dimspy merge-peaklists [-h] -i INPUT -o OUTPUT [-l FILELIST]

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Multiple HDF5 files that contain peaklists or peak
                        matrix from one of the processing steps.
  -o OUTPUT, --output OUTPUT
                        Directory (if using multilist column in filelist) or
                        HDF5 file to write to.
  -l FILELIST, --filelist FILELIST
                        Tab-delimited file that list all the data files (*.raw
                        or *.mzml) and meta data (filename, technical
                        replicate, class, batch, multiList).
```


## dimspy_get-peaklists

### Tool Description
Get peaklists from HDF5 files.

### Metadata
- **Docker Image**: quay.io/biocontainers/dimspy:2.0.0--pyhdfd78af_1
- **Homepage**: https://github.com/computational-metabolomics/dimspy
- **Package**: https://anaconda.org/channels/bioconda/packages/dimspy/overview
- **Validation**: PASS

### Original Help Text
```text
Executing dimspy version 2.0.0.
usage: dimspy get-peaklists [-h] -i INPUT -o OUTPUT

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Single or Multiple HDF5 files that contain a peak
                        matrix object from one of the processing steps.
  -o OUTPUT, --output OUTPUT
                        HDF5 file to save the peaklist objects to.
```


## dimspy_get-average-peaklist

### Tool Description
Calculates the average peaklist from input HDF5 files.

### Metadata
- **Docker Image**: quay.io/biocontainers/dimspy:2.0.0--pyhdfd78af_1
- **Homepage**: https://github.com/computational-metabolomics/dimspy
- **Package**: https://anaconda.org/channels/bioconda/packages/dimspy/overview
- **Validation**: PASS

### Original Help Text
```text
Executing dimspy version 2.0.0.
usage: dimspy get-average-peaklist [-h] -i INPUT -o OUTPUT -n NAME_PEAKLIST

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Single or Multiple HDF5 files that contain a peak
                        matrix object from one of the processing steps.
  -o OUTPUT, --output OUTPUT
                        HDF5 file to save the peaklist object to.
  -n NAME_PEAKLIST, --name-peaklist NAME_PEAKLIST
                        Name of the peaklist.
```


## dimspy_hdf5-pm-to-txt

### Tool Description
Converts a HDF5 peak matrix to a text file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dimspy:2.0.0--pyhdfd78af_1
- **Homepage**: https://github.com/computational-metabolomics/dimspy
- **Package**: https://anaconda.org/channels/bioconda/packages/dimspy/overview
- **Validation**: PASS

### Original Help Text
```text
Executing dimspy version 2.0.0.
usage: dimspy hdf5-pm-to-txt [-h] -i INPUT -o OUTPUT [-a {intensity,mz,snr}]
                             [-l CLASS_LABEL_RSD] [-d {tab,comma}]
                             [-s {rows,columns}] [-c]

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        HDF5 file that contains a peak matrix object from one
                        of the processing steps.
  -o OUTPUT, --output OUTPUT
                        Directory (peaklists) or text file (peak matrix) to
                        write to.
  -a {intensity,mz,snr}, --attribute_name {intensity,mz,snr}
                        Type of matrix to print.
  -l CLASS_LABEL_RSD, --class-label-rsd CLASS_LABEL_RSD
                        Class label to select samples for RSD calculatons
                        (e.g. QC).
  -d {tab,comma}, --delimiter {tab,comma}
                        Values on each line of the file are separated by this
                        character.
  -s {rows,columns}, --representation-samples {rows,columns}
                        Should the rows or columns respresent the samples?
  -c, --comprehensive   Comprehensive version of the peak matrix
```


## dimspy_hdf5-pls-to-txt

### Tool Description
Converts HDF5 peaklist objects to text files.

### Metadata
- **Docker Image**: quay.io/biocontainers/dimspy:2.0.0--pyhdfd78af_1
- **Homepage**: https://github.com/computational-metabolomics/dimspy
- **Package**: https://anaconda.org/channels/bioconda/packages/dimspy/overview
- **Validation**: PASS

### Original Help Text
```text
Executing dimspy version 2.0.0.
usage: dimspy hdf5-pls-to-txt [-h] -i INPUT -o OUTPUT [-d {tab,comma}]

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        HDF5 file that contains a list of peaklist objects
                        from one of the processing steps.
  -o OUTPUT, --output OUTPUT
                        Directory to write to.
  -d {tab,comma}, --delimiter {tab,comma}
                        Values on each line of the file are separated by this
                        character.
```


## dimspy_create-sample-list

### Tool Description
Create a sample list from an HDF5 peak matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/dimspy:2.0.0--pyhdfd78af_1
- **Homepage**: https://github.com/computational-metabolomics/dimspy
- **Package**: https://anaconda.org/channels/bioconda/packages/dimspy/overview
- **Validation**: PASS

### Original Help Text
```text
Executing dimspy version 2.0.0.
usage: dimspy create-sample-list [-h] -i INPUT -o OUTPUT [-d {tab,comma}]

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        HDF5 file that contains a peak matrix object from one
                        of the processing steps.
  -o OUTPUT, --output OUTPUT
                        Text file to write to.
  -d {tab,comma}, --delimiter {tab,comma}
                        Values on each line of the file are separated by this
                        character.
```


## dimspy_unzip

### Tool Description
Unzip a dimspy file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dimspy:2.0.0--pyhdfd78af_1
- **Homepage**: https://github.com/computational-metabolomics/dimspy
- **Package**: https://anaconda.org/channels/bioconda/packages/dimspy/overview
- **Validation**: PASS

### Original Help Text
```text
Executing dimspy version 2.0.0.
usage: dimspy unzip [-h] -i INPUT -o OUTPUT

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        file[.zip]
  -o OUTPUT, --output OUTPUT
                        Directory to write to.
```


## dimspy_licenses

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/dimspy:2.0.0--pyhdfd78af_1
- **Homepage**: https://github.com/computational-metabolomics/dimspy
- **Package**: https://anaconda.org/channels/bioconda/packages/dimspy/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Executing dimspy version 2.0.0.
Namespace(step='licenses')

DIMSpy is licensed under the GNU General Public License v3.0. Copyright © 2017 - 2020 Ralf Weber, Albert Zhou

RawFileReader reading tool. Copyright © 2016 by Thermo Fisher Scientific, Inc. All rights reserved. 

Using DIMSpy software for processing Thermo Fisher Scientific *.raw files implies the acceptance of the RawFileReader license terms.

Anyone receiving RawFileReader as part of a larger software distribution (in the current context, as part of DIMSpy) is considered an "end user" under
section 3.3 of the RawFileReader License, and is not granted rights to redistribute RawFileReader.

This license (see 'SOFTWARE LICENSE AGREEMENT' below) covers the following files which are distributed with the DIMSpy software package:
 - ThermoFisher.CommonCore.BackgroundSubtraction.dll
 - ThermoFisher.CommonCore.BackgroundSubtraction.XML
 - ThermoFisher.CommonCore.Data.dll
 - ThermoFisher.CommonCore.Data.XML
 - ThermoFisher.CommonCore.MassPrecisionEstimator.dll
 - ThermoFisher.CommonCore.MassPrecisionEstimator.XML
 - ThermoFisher.CommonCore.RawFileReader.dll
 - ThermoFisher.CommonCore.RawFileReader.XML

**SOFTWARE LICENSE AGREEMENT ("License") FOR RawFileReader**
----------------------------------------------------------------------
These License terms are an agreement between you and Thermo Finnigan LLC ("Licensor"). They apply to Licensor's MSFileReader software program ("Software"), which includes documentation and any media on which you received it. These terms also apply to any updates or supplements for this Software, unless other terms accompany those items, in which case those terms apply. **If you use this Software, you accept this License. If you do not accept this License, you are prohibited from using this software.  If you comply with these License terms, you have the rights set forth below.**

1. Rights Granted:

1.1. You may install and use this Software on any of your computing devices.

1.2. You may distribute this Software to others, but only in combination with other software components and/or programs that you provide and subject to the distribution requirements and restrictions below.

2.  Use Restrictions:

2.1. You may not decompile, disassemble, reverse engineer, use reflection or modify this Software.

3. Distribution Requirements:

If you distribute this Software to others, you agree to:

3.1. Indemnify, defend and hold harmless the Licensor from any claims, including attorneys&#39; fees, related to the distribution or use of this Software;

3.2. Display the following text in your software's "About"; box: "**RawFileReader reading tool. Copyright © 2016 by Thermo Fisher Scientific, Inc. All rights reserved**.";

3.3. Require your end users to agree to a license agreement that prohibits them from redistributing this Software to others.

4.  Distribution Restrictions:

4.1. You may not use the Licensor&#39;s trademarks in a way that suggests your software components and/or programs are provided by or are endorsed by the Licensor; and

4.2. You may not commercially exploit this Software or products that incorporate this Software without the prior written consent of Licensor. Commercial exploitation includes, but is not limited to, charging a purchase price, license fee, maintenance fee, or subscription fee; or licensing, transferring or redistributing the Software in exchange for consideration of any kind.

4.3. Your rights to this Software do not include any license, right, power or authority to subject this Software in whole or in part to any of the terms of an Excluded License. &quot;Excluded License&quot; means any license that requires as a condition of use, modification and/or distribution of software subject to the Excluded License, that such software or other software combined and/or distributed with such software be (a) disclosed or distributed in source code form; or (b) licensed for the purpose of making derivative works.  Without limiting the foregoing obligation, you are specifically prohibited from distributing this Software with any software that is subject to the General Public License (GPL) or similar license in a manner that would create a combined work.

5.  Additional Terms Applicable to Software:

5.1. This Software is licensed, not sold. This License only gives you some rights to use this Software; the Licensor reserves all other rights. Unless applicable law gives you more rights despite this limitation, you may use this Software only as expressly permitted in this License.

5.2. Licensor has no obligation to fix, update, supplement or support this Software.

5.3. This Software is not designed, manufactured or intended for any use requiring fail-safe performance in which the failure of this Software could lead to death, serious personal injury or severe physical and environmental damage (&quot;High Risk Activities&quot;), such as the operation of aircraft, medical or nuclear facilities. You agree not to use, or license the use of, this Software in connection with any High Risk Activities.

5.4. Your rights under this License terminate automatically if you breach this License in any way. Termination of this License will not affect any of your obligations or liabilities arising prior to termination. The following sections of this License shall survive termination: 2.1, 3.1, 3.2, 3.3, 4.1, 4.2, 4.3, 5.1, 5.2, 5.3, 5.5, 5.6, 5.7, 5.8, and 5.9.

5.5. This Software is subject to United States export laws and regulations. You agree to comply with all domestic and international export laws and regulations that apply to this Software. These laws include restrictions on destinations, end users and end use.

5.6. This License shall be construed and controlled by the laws of the State of California, U.S.A., without regard to conflicts of law. You consent to the jurisdiction of the state and federal courts situated in the State of California in any action arising under this License. The application of the U.N. Convention on Contracts for the International Sale of Goods to this License is hereby expressly excluded. If any provision of this License shall be deemed unenforceable or contrary to law, the rest of this License shall remain in full effect and interpreted in an enforceable manner that most nearly captures the intent of the original language.

5.7. THIS SOFTWARE IS LICENSED &quot;AS IS&quot;. YOU BEAR ALL RISKS OF USING IT. LICENSOR GIVES NO AND DISCLAIMS ALL EXPRESS AND IMPLIED WARRANTIES, REPRESENTATIONS OR GUARANTEES.  YOU MAY HAVE ADDITIONAL CONSUMER RIGHTS UNDER YOUR LOCAL LAWS WHICH THIS LICENSE CANNOT CHANGE. TO THE EXTENT PERMITTED UNDER YOUR LOCAL LAWS, LICENSOR EXCLUDES THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT.

5.8. LICENSOR&#39;S TOTAL LIABILITY TO YOU FOR DIRECT DAMAGES ARISING UNDER THIS LICENSE IS LIMITED TO U.S. $1.00. YOU CANNOT RECOVER ANY OTHER DAMAGES, INCLUDING CONSEQUENTIAL, LOST PROFITS, SPECIAL, INDIRECT OR INCIDENTAL DAMAGES, EVEN IF LICENSOR IS EXPRESSLY MADE AWARE OF THE POSSIBILITY THEREOF OR IS NEGLIGENT. THIS LIMITATION APPLIES TO ANYTHING RELATED TO THIS SOFTWARE, SERVICES, CONTENT (INCLUDING CODE) ON THIRD PARTY INTERNET SITES, OR THIRD PARTY PROGRAMS, AND CLAIMS FOR BREACH OF CONTRACT, BREACH OF WARRANTY, GUARANTEE  OR CONDITION, STRICT LIABILITY, NEGLIGENCE, OR OTHER TORT TO THE EXTENT PERMITTED BY APPLICABLE LAW.

5.9. Use, duplication or disclosure of this Software by the U.S. Government is subject to the restricted rights applicable to commercial computer software (under FAR 52.227019 and DFARS 252.227-7013 or parallel regulations). The manufacturer for this purpose is Thermo Finnigan LLC, 355 River Oaks Parkway, San Jose, California 95134, U.S.A.
```

