Package ‘PepsNMRData’

February 17, 2026

Type Package

Title Datasets for the PepsNMR package

Version 1.28.0

Suggests knitr, markdown, rmarkdown, BiocStyle

Contact Manon Martin <manon.martin@uclouvain.be>, Bernadette Govaerts

<bernadette.govaerts@uclouvain.be> or Benoît Legat

<benoit.legat@gmail.com>

Description This package contains all the datasets used in the PepsNMR package.

License GPL-2 | file LICENSE

Encoding UTF-8

LazyData true

Depends R (>= 3.5)

BugReports https://github.com/ManonMartin/PepsNMRData/issues

biocViews ExperimentData, OrganismData, Homo_sapiens_Data

git_url https://git.bioconductor.org/packages/PepsNMRData

git_branch RELEASE_3_22

git_last_commit 52f9bd5

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-17

Author Manon Martin [aut, cre],

Bernadette Govaerts [aut, ths],
Pascal de Tullio [dtc]

Maintainer Manon Martin <manon.martin@uclouvain.be>

Contents

PepsNMRData-package .
.
Data_HS_sp .
.
.
Data_HU_sp .
.
.
FidData_HS .
.
.
FidData_HU .

.
.
.
.

.
.
.
.

.
.
.
.

.
.
.
.

.
.
.
.
.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2
3
4
5
6

1

2

PepsNMRData-package

.

.

.
FidInfo_HS .
.
.
FidInfo_HS_sp .
.
.
FidInfo_HU .
FidInfo_HU_sp .
.
FinalSpectra_HS .
FinalSpectra_HU .
.
.
Group_HS .
Group_HU .
.
RawFidData_HS .

.
.

.
.

.
.
.
.
.
.
.
.
.

.
.
.
.
.
.
.
.
.

.
.
.
.
.
.
.
.
.

.
.
.
.
.
.
.
.
.

7
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
8
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
9
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 10
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 11
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 11
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 12
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 13
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 14

Index

15

PepsNMRData-package

Raw and (partially) pre-processed metabolomic datasets supporting
the PepsNMR package

Description

This package provides RData and Bruker files of raw and (partially) pre-processed metabolomic 1H
NMR datasets from human urine and serum.

The raw Bruker files of the Human Serum are stored in the extdata directory of this package. They
are refered as the RawFidData_HS dataset.

The (partially) pre-processed metabolomic 1H NMR datasets are in the form of RData files with the
following elements:

Data_HS_sp 4 first FIDs and spectra of the Human Serum database after each preprocessing step.

Data_HU_sp 4 first FIDs and spectra of the Human Urine database after each preprocessing step.

FidData_HS Matrix containing the raw Free Induction Decays of the Human Serum database.

FidData_HU Matrix containing the raw Free Indiction Decays of the Human Urine database.

FidInfo_HS_sp Matrix containing acquisition parameters for the 4 first Human Serum FIDs.

FidInfo_HS Matrix containing acquisition parameters of the Human Serum FIDs.

FidInfo_HU_sp Matrix containing acquisition parameters for the 4 first Human Urine FIDs.

FidInfo_HU Matrix containing acquisition parameters of the Human Urine FIDs.

FinalSpectra_HS Matrix containing the Human Serum spectra after the full pre-treatment pro-

cess.

FinalSpectra_HU Matrix containing the Human Urine spectra after the full pre-treatment process.

Group_HS Provides the group (1|2|3|4) to which belongs each signal/spectrum of the Human Serum

database.

Group_HU Provides the group (1/2/3) to which belongs each signal/spectrum of the Human Urine

database.

RawFidData_HS Raw Bruker files for the Human Serum datase t.

Data_HS_sp

Details

3

PepsNMRData
Package:
Package
Type:
Version:
0.99.0
License: GPLv2

2 different datasets are provided: Human Urine and Human Serum 1H NMR

Author(s)

Benoît Legat, Bernadette Govaerts & Manon Martin

Maintainer: Manon Martin <manon.martin@uclouvain.be>

References

Rousseau, R. (2011). Statistical contribution to the analysis of metabonomics data in 1H NMR
spectroscopy (Doctoral dissertation, PhD thesis. Institut de statistique, biostatistique et sciences
actuarielles, Université catholique de Louvain, Belgium).

Martin, M., Legat, B., Leenders, J., Vanwinsberghe, J., Rousseau, R., Boulanger, B., & Govaerts, B.
(2018). PepsNMR for 1H NMR metabolomic data pre-processing. Analytica chimica acta, 1019,
1-13.

Examples

# RData file
data("Data_HS_sp")

# Raw Bruker file
path <- system.file("extdata", package = "PepsNMRData")
list.files(path)
list.dirs(path, full.names = FALSE)

Data_HS_sp

FIDs and spectra from the Human Serum database.

Description

4 first FIDs and spectra of the Human Serum database after each preprocessing step. For more
details on this database, use help(FidData_HS).

Usage

data("Data_HS_sp")

4

Format

Data_HU_sp

A list with 14 objects that are complex matrices. 4 observations/object:

FidData_HS_0 Raw FIDs.

FidData_HS_1 FIDs after first order phase correction.

FidData_HS_2 FIDs after solvent residuals suppression.

FidData_HS_3 FIDs after apodization.

Spectrum_data_HS_4 Spectra after fourier transformation.

Spectrum_data_HS_5 Spectra after zero order phase correction.

Spectrum_data_HS_6 Spectra after internal calibration.

Spectrum_data_HS_7 Spectra after baseline correction.

Spectrum_data_HS_8 Spectra after negative values zeroing.

Spectrum_data_HS_9 Spectra after warping.

Spectrum_data_HS_10 Spectra after window selection.

Spectrum_data_HS_11 Spectra after bucketing.

Spectrum_data_HS_12 Spectra after region removal.

Spectrum_data_HS_13 Spectra after normalization.

Source

Data provided by Dr. Pascal de Tullio and coworkers of the Pharmaceutical Chemistry Laboratory
in the Pharmacy Department of the University of Liege (ULg), Belgium.

References

Rousseau, R. (2011). Statistical contribution to the analysis of metabonomics data in 1H NMR
spectroscopy (Doctoral dissertation, PhD thesis. Institut de statistique, biostatistique et sciences
actuarielles, Université catholique de Louvain, Belgium).

Examples

plot(Re(Data_HS_sp$FidData_HS_0[1,]), type="l")

Data_HU_sp

FIDs and spectra from the Human Urine database.

Description

4 first FIDs and spectra of the Human Urine database after each preprocessing step. For more details
on this database, use help(FidData_HU).

Usage

data("Data_HU_sp")

FidData_HS

Format

5

A list with 15 objects that are complex matrices with 4 observations/object:

FidData_HU_0 Raw FIDs.
FidData_HU_1 FIDs after first order phase correction.
FidData_HU_2 FIDs after solvent residuals suppression.
FidData_HU_3 FIDs after apodization.
Spectrum_data_HU_4 Spectra after fourier transformation.
Spectrum_data_HU_6 Spectra after zero order phase correction.
Spectrum_data_HU_5 Spectra after internal calibration.
Spectrum_data_HU_7 Spectra after baseline correction.
Spectrum_data_HU_8 Spectra after negative values zeroing.
Spectrum_data_HU_9 Spectra after warping.
Spectrum_data_HU_10 Spectra after window selection.
Spectrum_data_HU_11 Spectra after bucketing
Spectrum_data_HU_12 Spectra after region removal.
Spectrum_data_HU_13 Spectra after zone aggregation for the citrate peak.
Spectrum_data_HU_14 Spectra after normalization.

Source

Data provided by Dr. Pascal de Tullio and coworkers of the Pharmaceutical Chemistry Laboratory
in the Pharmacy Department of the University of Liege (ULg), Belgium.

References

Rousseau, R. (2011). Statistical contribution to the analysis of metabonomics data in 1H NMR
spectroscopy (Doctoral dissertation, PhD thesis. Institut de statistique, biostatistique et sciences
actuarielles, Université catholique de Louvain, Belgium).

Examples

plot(Re(Data_HU_sp$FidData_HU_0[1,]), type="l")

FidData_HS

Raw FIDs for the Human Serum database.

Description

Matrix containing the raw Free Induction Decays of the Human Serum database. The experimental
design is as follow: serum was collected from 4 blood donors (their class membership is available
in Group_HS). Measurements were performed on 8 different days with replicates. The order of the
measurements were permuted according to a latin hypercube sampling method.

Usage

data("FidData_HS")

6

Format

A complex matrix of 32 spectra with 32768 time points.

Source

FidData_HU

Data provided by Dr. Pascal de Tullio and coworkers of the Pharmaceutical Chemistry Laboratory
in the Pharmacy Department of the University of Liege (ULg), Belgium.

References

Rousseau, R. (2011). Statistical contribution to the analysis of metabonomics data in 1H NMR
spectroscopy (Doctoral dissertation, PhD thesis. Institut de statistique, biostatistique et sciences
actuarielles, Université catholique de Louvain, Belgium).

See Also

See also FidInfo_HS for acquisition parameters and Group_HS for the class of FID samples.

Examples

data(FidData_HS)
plot(Re(FidData_HS[1,]), type = "l")

FidData_HU

Raw FIDs for the Human Urine database.

Description

Matrix containing the raw Free Indiction Decays of the Human Urine database. The experimental
design is as follow: urine was collected from 3 donors (their class membership is available in
Group_HU).

Usage

data("FidData_HU")

Format

A complex matrix of 24 spectra with 29411 time points.

Source

Data provided by Dr. Pascal de Tullio and coworkers of the Pharmaceutical Chemistry Laboratory
in the Pharmacy Department of the University of Liege (ULg), Belgium.

References

Rousseau, R. (2011). Statistical contribution to the analysis of metabonomics data in 1H NMR
spectroscopy (Doctoral dissertation, PhD thesis. Institut de statistique, biostatistique et sciences
actuarielles, Université catholique de Louvain, Belgium).

FidInfo_HS

See Also

7

See also FidInfo_HU for acquisition parameters and Group_HU for the class of FID samples.

Examples

data(FidData_HU)
plot(Re(FidData_HU[1,]), type = "l")

FidInfo_HS

Information about the FIDs for the Human Serum database.

Description

Matrix containing acquisition parameters of the Human Serum FIDs.

Usage

data("FidInfo_HS")

Format

A matrix with 32 observations and 9 variables:

TD Time domain size
BYTORDA Determine the endiness of stored data. If 0 -> Little Endian; if 1 -> Big Endian
DIGMOD Digitization mode
DECIM Decimation rate of digital filter
DSPFVS DSP firmware version
SW_h Sweep width in Hz
SW Sweep width in ppm
O1 Spectrometer frequency offset
DT Dwell time in microseconds

Source

Data provided by Dr. Pascal de Tullio and coworkers of the Pharmaceutical Chemistry Laboratory
in the Pharmacy Department of the University of Liege (ULg), Belgium.

References

Rousseau, R. (2011). Statistical contribution to the analysis of metabonomics data in 1H NMR
spectroscopy (Doctoral dissertation, PhD thesis. Institut de statistique, biostatistique et sciences
actuarielles, Université catholique de Louvain, Belgium).

See Also

See also FidData_HS for the FIDs and Group_HS for the class membership of FID samples.

Examples

data(FidInfo_HS)

8

FidInfo_HS_sp

FidInfo_HS_sp

Information about the 4 first Human Serum FIDs.

Description

Matrix containing acquisition parameters for the 4 first Human Serum FIDs.

Usage

data("FidInfo_HS_sp")

Format

A matrix with 4 observations and 9 variables.

Details

Variables are:

TD Time domain size

BYTORDA The endiness of stored data. If 0 -> Little Endian; if 1 -> Big Endian

DIGMOD Digitization mode

DECIM Decimation rate of digital filter

DSPFVS DSP firmware version

SW_h Sweep width in Hz

SW Sweep width in ppm

O1 Spectrometer frequency offset

DT Dwell time in microseconds

Source

Data provided by Dr. Pascal de Tullio and coworkers of the Pharmaceutical Chemistry Laboratory
in the Pharmacy Department of the University of Liege (ULg), Belgium.

References

Rousseau, R. (2011). Statistical contribution to the analysis of metabonomics data in 1H NMR
spectroscopy (Doctoral dissertation, PhD thesis. Institut de statistique, biostatistique et sciences
actuarielles, Université catholique de Louvain, Belgium).

See Also

See also Data_HS_sp for the FIDs.

Examples

data(FidInfo_HS)

FidInfo_HU

9

FidInfo_HU

Information about the FIDs for the Human Urine database.

Description

Matrix containing acquisition parameters of the Human Urine FIDs.

Usage

data("FidInfo_HU")

Format

A matrix with 24 observations and 10 variables:

TD Time domain size

BYTORDA Determine the endiness of stored data. If 0 -> Little Endian; if 1 -> Big Endian

DIGMOD Digitization mode

DECIM Decimation rate of digital filter

DSPFVS DSP firmware version

SW_h Sweep width in Hz

SW Sweep width in ppm

O1 Spectrometer frequency offset

GPRDLY Group Delay

DT Dwell time in microseconds

Source

Data provided by Dr. Pascal de Tullio and coworkers of the Pharmaceutical Chemistry Laboratory
in the Pharmacy Department of the University of Liege (ULg), Belgium.

References

Rousseau, R. (2011). Statistical contribution to the analysis of metabonomics data in 1H NMR
spectroscopy (Doctoral dissertation, PhD thesis. Institut de statistique, biostatistique et sciences
actuarielles, Université catholique de Louvain, Belgium).

See Also

See also FidData_HU for the FIDs and Group_HU for the class membership of FID samples.

Examples

data(FidInfo_HU)

10

FidInfo_HU_sp

FidInfo_HU_sp

Information about the 4 first Human Urine FIDs.

Description

Matrix containing acquisition parameters for the 4 first Human Urine FIDs.

Usage

data("FidInfo_HU_sp")

Format

A matrix with 4 observations and 10 variables.

Details

Variables are:

TD Time domain size

BYTORDA The endiness of stored data. If 0 -> Little Endian; if 1 -> Big Endian

DIGMOD Digitization mode

DECIM Decimation rate of digital filter

DSPFVS DSP firmware version

SW_h Sweep width in Hz

SW Sweep width in ppm

O1 Spectrometer frequency offset

GPRDLY Group Delay

DT Dwell time in microseconds

Source

Data provided by Dr. Pascal de Tullio and coworkers of the Pharmaceutical Chemistry Laboratory
in the Pharmacy Department of the University of Liege (ULg), Belgium.

References

Rousseau, R. (2011). Statistical contribution to the analysis of metabonomics data in 1H NMR
spectroscopy (Doctoral dissertation, PhD thesis. Institut de statistique, biostatistique et sciences
actuarielles, Université catholique de Louvain, Belgium).

See Also

See also Data_HU_sp for the FIDs.

Examples

data(FidInfo_HU)

FinalSpectra_HS

11

FinalSpectra_HS

Spectra for the Human Serum database after the advised preprocess-
ing workflow.

Description

Matrix containing the Human Serum spectra after the full pre-treatment process. At this stage the
spectra are fully pre-processed. For more details on this database, see help(FidData_HS).

Usage

data("FinalSpectra_HS")

Format

A complex matrix with 32 observations and 500 frequency data points in a ppm scale.

Source

Data provided by Dr. Pascal de Tullio and coworkers of the Pharmaceutical Chemistry Laboratory
in the Pharmacy Department of the University of Liege (ULg), Belgium.

References

Rousseau, R. (2011). Statistical contribution to the analysis of metabonomics data in 1H NMR
spectroscopy (Doctoral dissertation, PhD thesis. Institut de statistique, biostatistique et sciences
actuarielles, Université catholique de Louvain, Belgium).

See Also

See also FidData_HS for the raw FIDs and Group_HS for the samples class.

Examples

data(FinalSpectra_HS)
plot(Re(FinalSpectra_HS[1,]), type="l")

FinalSpectra_HU

Spectra for the Human Urine database after the advised preprocessing
workflow.

Description

Matrix containing the Human Urine spectra after the full pre-treatment process. At this stage the
spectra are fully pre-processed.

Usage

data("FinalSpectra_HU")

12

Format

Group_HS

A complex matrix with 24 observations and 500 frequency data points in a ppm scale.

Source

Data provided by Dr. Pascal de Tullio and coworkers of the Pharmaceutical Chemistry Laboratory
in the Pharmacy Department of the University of Liege (ULg), Belgium.

References

Rousseau, R. (2011). Statistical contribution to the analysis of metabonomics data in 1H NMR
spectroscopy (Doctoral dissertation, PhD thesis. Institut de statistique, biostatistique et sciences
actuarielles, Université catholique de Louvain, Belgium).

See Also

See also FidData_HU for the raw FIDs and Group_HU for the samples class.

Examples

data(FinalSpectra_HU)
plot(Re(FinalSpectra_HU[1,]), type="l")

Group_HS

Class of Human Serum spectra.

Description

Provides the group (1|2|3|4) to which belongs each signal/spectrum of the Human Serum database.
For more details on this database, see help(FidData_HS).

Usage

data("Group_HS")

Format

A vector of length 32.

Source

Data provided by Dr. Pascal de Tullio and coworkers of the Pharmaceutical Chemistry Laboratory
in the Pharmacy Department of the University of Liege (ULg), Belgium.

References

Rousseau, R. (2011). Statistical contribution to the analysis of metabonomics data in 1H NMR
spectroscopy (Doctoral dissertation, PhD thesis. Institut de statistique, biostatistique et sciences
actuarielles, Université catholique de Louvain, Belgium).

See Also

See also FidInfo_HS for acquisition parameters and FidData_HS for the FIDs.

Group_HU

Examples

data(Group_HS)

13

Group_HU

Class of Human Urine spectra.

Description

Provides the group (1/2/3) to which belongs each signal/spectrum of the Human Urine database.

Usage

data("Group_HU")

Format

A vector of length 24.

Source

Data provided by Dr. Pascal de Tullio and coworkers of the Pharmaceutical Chemistry Laboratory
in the Pharmacy Department of the University of Liege (ULg), Belgium.

References

Rousseau, R. (2011). Statistical contribution to the analysis of metabonomics data in 1H NMR
spectroscopy (Doctoral dissertation, PhD thesis. Institut de statistique, biostatistique et sciences
actuarielles, Université catholique de Louvain, Belgium).

See Also

See also FidInfo_HU for acquisition parameters and FidData_HU for the FIDs.

Examples

data(Group_HU)

14

RawFidData_HS

RawFidData_HS

Raw Bruker files for the Human Serum dataset.

Description

Contains the Bruker files for the 32 spectra of the Human Serum dataset.

Usage

data("RawFidData_HS")

Format

The inst/extdata directory contains a series of sub-directories, one by FID.

Source

Data provided by Dr. Pascal de Tullio and coworkers of the Pharmaceutical Chemistry Laboratory
in the Pharmacy Department of the University of Liege (ULg), Belgium.

References

Martin, M., Legat, B., Leenders, J., Vanwinsberghe, J., Rousseau, R., Boulanger, B., & Govaerts, B.
(2018). PepsNMR for 1H NMR metabolomic data pre-processing. Analytica chimica acta, 1019,
1-13.

Examples

# Raw Bruker file
path <- system.file("extdata", package = "PepsNMRData")
list.files(path)
list.dirs(path, full.names = FALSE)

Index

∗ datasets

Data_HS_sp, 3
Data_HU_sp, 4
FidData_HS, 5
FidData_HU, 6
FidInfo_HS, 7
FidInfo_HS_sp, 8
FidInfo_HU, 9
FidInfo_HU_sp, 10
FinalSpectra_HS, 11
FinalSpectra_HU, 11
Group_HS, 12
Group_HU, 13
RawFidData_HS, 14

∗ package

PepsNMRData-package, 2

Data_HS_sp, 2, 3, 8
Data_HU_sp, 2, 4, 10

FidData_HS, 2, 5, 7, 11, 12
FidData_HU, 2, 6, 9, 12, 13
FidInfo_HS, 2, 6, 7, 12
FidInfo_HS_sp, 2, 8
FidInfo_HU, 2, 7, 9, 13
FidInfo_HU_sp, 2, 10
FinalSpectra_HS, 2, 11
FinalSpectra_HU, 2, 11

Group_HS, 2, 6, 7, 11, 12
Group_HU, 2, 7, 9, 12, 13

PepsNMRData (PepsNMRData-package), 2
PepsNMRData-package, 2

RawFidData_HS, 2, 14

15

