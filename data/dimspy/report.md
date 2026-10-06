# dimspy CWL Generation Report

## dimspy_process-scans

### Tool Description
Processes raw mass spectrometry scan data to generate peaklists.

### Metadata
- **Docker Image**: quay.io/biocontainers/dimspy:2.0.0--pyhdfd78af_1
- **Homepage**: https://github.com/computational-metabolomics/dimspy
- **Package**: https://anaconda.org/channels/bioconda/packages/dimspy/overview
- **Validation**: PASS
- **manual**: https://dimspy.readthedocs.io/en/latest/

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

## Metadata
- **Skill**: generated
