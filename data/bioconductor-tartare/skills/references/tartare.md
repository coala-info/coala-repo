# make-data

Tobias Kockmann1\* and Christian Panse1,2\*\*

1Functional Genomics Center Zurich - Swiss Federal Institute of Technology in Zurich
2Swiss Institute of Bioinformatics

\*Tobias.Kockmann@fgcz.ethz.ch
\*\*cp@fgcz.ethz.ch

#### 4 November 2025

#### Abstract

The tartare package provides raw files recorded on different Liquid
Chromatography Mass Spectrometry (LC-MS) instruments. All included MS
instruments are manufactured by Thermo Fisher Scientific and belong to the
Orbitrap Tribrid or Q Exactive Orbitrap family of instruments. Despite their
common origin and shared hardware components (e.g. Orbitrap mass analyser),
the above instruments tend to write data in different “dialects” in a shared
binary file format (.raw) (Shofstahl [2015](#ref-RawfileReader2015)). The intention behind tartare
is to provide complex
but slim real-world files that can be used to make code robust with respect
to this diversity. In other words, it is intended for enhanced unit testing.
The package is considered to be used with the *[rawrr](https://bioconductor.org/packages/3.22/rawrr)*
package (Kockmann and Panse [2021](#ref-Kockmann2021)), *[Spectra](https://bioconductor.org/packages/3.22/Spectra)* and
*[MsBackendRawFileReader](https://bioconductor.org/packages/3.22/MsBackendRawFileReader)*.

#### Package

tartare 1.24.0

# 1 Sample description

Pierce HeLa protein digest standard (#1862824, Thermo Scientific) in 3% ACN,
0.1% FA

# 2 Data recording

## 2.1 Q Exactive HF-X

file name: `20190710_003_PierceHeLaProteinDigestStd.raw`

### 2.1.1 LC

200 ng sample were seperated on a linear gradient from 5 to 35% B in 20 min
using a binary mobile phase composed of A) 0.1% FA in water, B) 0.1% FA in ACN. The stationary phase was …

### 2.1.2 MS

The MS acquision was started 18 min post sample injection and lastet only 4 min. Be aware that spray
voltage and source gas was turned on at 18.5 min (see Tunefiles section of the method).
This means the first 30 s were recorded
without ESI. In summary, 4 different experiments were recorded

* Full MS / dd-MS² (TopN)
* PRM
* Targeted-SIM
* DIA

Experiment 2 and 3 were executed in parrallel! All method details are listed below.

```
Method of Q Exactive HF-X

Overall method settings

Global Settings
Use lock masses                                                         best
Lock mass injection                                                        ―
Chrom. peak width (FWHM)                                                  15 s
Time
Method duration                                                         4.00 min
Customized Tolerances (+/-)
Lock Masses                                                                ―
Inclusion                                                                  ―
Exclusion                                                                  ―
Neutral Loss                                                               ―
Mass Tags                                                                  ―
Dynamic Exclusion                                                          ―

                                  Experiments

Full MS / dd-MS² (TopN)
General
Runtime                                                               0 to 1 min
Polarity                                                            positive
In-source CID                                                            0.0 eV
Default charge state                                                       2
Inclusion                                                                  ―
Exclusion                                                                  ―
Tags                                                                       ―
Full MS
Microscans                                                                 1
Resolution                                                           120,000
AGC target                                                               3e6
Maximum IT                                                               100 ms
Number of scan ranges                                                      1
Scan range                                                       200 to 2000 m/z
Spectrum data type                                                  Centroid
dd-MS² / dd-SIM
Microscans                                                                 1
Resolution                                                            30,000
AGC target                                                               1e5
Maximum IT                                                                50 ms
Loop count                                                                 5
MSX count                                                                  1
TopN                                                                       5
Isolation window                                                         1.4 m/z
Isolation offset                                                         0.0 m/z
Scan range                                                       200 to 2000 m/z
Fixed first mass                                                           ―
(N)CE / stepped (N)CE                                                nce: 30
Spectrum data type                                                  Centroid
dd Settings
Minimum AGC target                                                    8.00e3
Intensity threshold                                                    1.6e5
Apex trigger                                                               ―
Charge exclusion                                    unassigned, 1, 5 - 8, >8
Multiple charge states                                                   all
Peptide match                                                      preferred
Exclude isotopes                                                          on
Dynamic exclusion                                                       10.0 s
If idle ..                                                do not pick others

PRM
General
Runtime                                                               1 to 2 min
Polarity                                                            positive
In-source CID                                                            0.0 eV
Dynamic RT                                                               off
Default charge state                                                       2
Inclusion                                                                 on
MS²
Microscans                                                                 1
Resolution                                                            30,000
AGC target                                                               2e5
Maximum IT                                                               100 ms
Loop count                                                                11
MSX count                                                                  1
MSX isochronous ITs                                                       on
Isolation window                                                         4.0 m/z
Isolation offset                                                         0.0 m/z
Fixed first mass                                                           ―
(N)CE / stepped (N)CE                                                nce: 35
Spectrum data type                                                  Centroid

Full MS — SIM
General
Runtime                                                               1 to 2 min
Polarity                                                            positive
In-source CID                                                            0.0 eV
Full MS — SIM
Microscans                                                                 1
Resolution                                                           120,000
AGC target                                                               3e6
Maximum IT                                                               200 ms
Number of scan ranges                                                      2
Scan range 1                                                     150 to 1000 m/z
Scan range 2                                                    1000 to 2000 m/z
Spectrum data type                                                  Centroid

Targeted-SIM
General
Runtime                                                               2 to 3 min
Polarity                                                            positive
In-source CID                                                            0.0 eV
Inclusion                                                                 on
SIM
Microscans                                                                 1
Resolution                                                           240,000
AGC target                                                               5e4
Maximum IT                                                               200 ms
MSX count                                                                  5
Isolation window                                                         4.0 m/z
Isolation offset                                                         0.0 m/z
Scan range                                                       150 to 2000 m/z
Spectrum data type                                                  Centroid

DIA
General
Runtime                                                               3 to 4 min
Polarity                                                            positive
In-source CID                                                            0.0 eV
Default charge state                                                       2
DIA
Microscans                                                                 1
Resolution                                                            30,000
AGC target                                                               1e6
Maximum IT                                                              auto
Loop count                                                                11
MSX count                                                                  1
MSX isochronous ITs                                                       on
Isolation window                                                        20.0 m/z
Isolation offset                                                         0.0 m/z
Fixed first mass                                                       100.0 m/z
(N)CE / stepped (N)CE                                                nce: 30
Spectrum data type                                                  Centroid

                                     Setup

Tunefiles
General
Switch Count  2
Base Tunefile C:\Xcalibur\methods\nogas_novoltage_nano.mstune
Element 1
At            0.50 min
New Tunefile  C:\Xcalibur\methods\default_nano.mstune
Element 2
At            34.50 min
New Tunefile  C:\Xcalibur\methods\nogas_novoltage_nano.mstune

Contact Closure
General
Used              True
Start in Closed  False
Switch Count         2
Element 1
At                0.50 min
Switches to       Open
Element 2
At               34.50 min
Switches to     Closed

Syringe
General
Used                  False
Start in OFF           True
Stop at end of run    False
Switch Count              0
Pump setup
Syringe type       Hamilton
Flow rate             3.000 µL/min
Inner diameter        2.303 mm
Volume                  250 µL

Divert Valve A
General
Used         False
Start in 1-2  True
Switch Count     0

Divert Valve B
General
Used         False
Start in 1-2  True
Switch Count     0

Lock Masses
    2 entries
     Mass Polarity Start   End Comment
    [m/z]          [min] [min]
371.10124 Positive
445.12002 Positive

Inclusion List
    16 entries
     Mass Formula Species  CS Polarity Start   End (N)CE MSX ID Comment
    [m/z]     [M]         [z]          [min] [min]
487.25671                   2 Positive  1.00  3.00    28        LGGNEQVTR
                                                                (light)
644.82261                   2 Positive  1.00  3.00    28        GAGSSEPVTGLDAK
                                                                (light)
683.82789                   2 Positive  1.00  3.00    28        VEATFGVDESNAK
                                                                (light)
547.29804                   2 Positive  1.00  3.00    28        YILAGVENSK
                                                                (light)
669.83806                   2 Positive  1.00  3.00    28        TPVISGGPYEYR
                                                                (light)
683.85371                   2 Positive  1.00  3.00    28        TPVITGAPYEYR
                                                                (light)
699.33842                   2 Positive  1.00  3.00    28        DGLDAASYYAPVR
                                                                (light)
726.83571                   2 Positive  1.00  3.00    28        ADVTPADFSEWSK
                                                                (light)
622.85351                   2 Positive  1.00  3.00    28        GTFIIDPGGVIR
                                                                (light)
636.86916                   2 Positive  1.00  3.00    28        GTFIIDPAAVIR
                                                                (light)
776.92975                   2 Positive  1.00  3.00    28        LFLQFGAQGSPFLK
                                                                (light)
410.00000                   2 Positive  3.00  4.00    28        window1
430.00000                   2 Positive  3.00  4.00    28        window2
450.00000                   2 Positive  3.00  4.00    28        window3
470.00000                   2 Positive  3.00  4.00    28        window4
490.00000                   2 Positive  3.00  4.00    28        window5

Exclusion List
   (no entries)

Neutral Losses
   (no entries)

Mass Tags
   (no entries)
```

## 2.2 Fusion Lumos

file name: `20190716_004_PierceHeLa.raw`

### 2.2.1 LC

200 ng sample were seperated on a linear gradient from 5 to 35% B in 20 min
using a binary mobile phase composed of A) 0.1% FA in water, B) 0.1% FA in ACN. The stationary phase was …

### 2.2.2 MS

The MS acquision was started directly after sample injection and lastet for 35 min.
In summary, 5 different experiments were recorded:

* Exp. 1 Orbitrap HCD - High Load (greater than 500 ng)
* Exp. 2 ETD Data-Dependent Decision Tree
* Exp. 3 Glycopeptide - Enriched
* Exp. 4 TMT Quan Pierce TKO Standard QC MS3 SPS
* Exp. 5 MS

Exp. #5 (MS) was executed the entire method duration! Method details are listed below.

```
Method Summary

Method Settings
Application Mode:   Peptide
Method Duration (min):   35
Global Parameters
Ion Source
Use Ion Source Settings from Tune:   True
FAIMS Mode:   Not Installed
MS Global Settings
Advanced Peak Determination:   False
Default Charge State:   1
Internal Mass Calibration:   Off

Experiment#1 [Orbitrap HCD - High Load (greater than 500 ng)]

Start Time (min):   20
End Time (min):   21
Cycle Time (sec):   3
Master Scan:
MS OT
Detector Type:   Orbitrap
Orbitrap Resolution:   60000
Mass Range:   Normal
Use Quadrupole Isolation:   True
Scan Range (m/z):   375-1500
RF Lens (%):   30
AGC Target:   4.0e5
Maximum Injection Time (ms):   50
Microscans:   1
Data Type:   Centroid
Polarity:   Positive
Source Fragmentation:   Disabled
Scan Description:
Filters:
MIPS
Monoisotopic Peak Determination:   Peptide
Charge State
Include charge state(s):   2-7
Include undetermined charge states:   False
Include charge states 25 and higher:   False
Dynamic Exclusion
Exclude after n times:   1
Exclusion duration (s):   60
Mass Tolerance:   ppm
Low:   10
High:   10
Exclude Isotopes:   True
Perform dependent scan on single charge state per precursor only:   False
Intensity
Filter Type:   Intensity Threshold
Intensity Threshold:   5.0e4
Data Dependent
Data Dependent Mode:   Cycle Time
Time between Master Scans (sec):   3
Scan Event Type 1:
Scan:
ddMS² OT HCD
Isolation Mode:   Quadrupole
Isolation Window (m/z):   1.6
Isolation Offset:   Off
Activation Type:   HCD
Collision Energy Mode:   Fixed
HCD Collision Energy (%):   30
Detector Type:   Orbitrap
Scan Range Mode:   Auto: m/z Normal
Orbitrap Resolution:   15000
First Mass (m/z):   110
AGC Target:   5.0e4
Inject Ions for All Available Parallelizable Time:   False
Maximum Injection Time (ms):   30
Microscans:   1
Data Type:   Centroid
Use EASY-IC™:   False
Scan Description:

Experiment#2 [ETD Data-Dependent Decision Tree]

Start Time (min):   21
End Time (min):   22
Cycle Time (sec):   3
Master Scan:
MS OT
Detector Type:   Orbitrap
Orbitrap Resolution:   120000
Mass Range:   Normal
Use Quadrupole Isolation:   True
Scan Range (m/z):   350-1500
RF Lens (%):   30
AGC Target:   4.0e5
Maximum Injection Time (ms):   50
Microscans:   1
Data Type:   Centroid
Polarity:   Positive
Source Fragmentation:   Disabled
Scan Description:
Filters:
MIPS
Monoisotopic Peak Determination:   Peptide
Dynamic Exclusion
Exclude after n times:   1
Exclusion duration (s):   60
Mass Tolerance:   ppm
Low:   10
High:   10
Exclude Isotopes:   True
Perform dependent scan on single charge state per precursor only:   False
Exclude Within Cycle:   False
Intensity
Filter Type:   Intensity Threshold
Intensity Threshold:   1.0e4
Data Dependent
Data Dependent Mode:   Cycle Time
Time between Master Scans (sec):   3
Scan Event Type 1:
Charge State
Include charge state(s):   3
Include undetermined charge states:   False
Include charge states 25 and higher:   False
Precursor Selection Range
Mass Range (m/z):   350-650
OR
Charge State
Include charge state(s):   4
Include undetermined charge states:   False
Include charge states 25 and higher:   False
Precursor Selection Range
Mass Range (m/z):   350-900
OR
Charge State
Include charge state(s):   5
Include undetermined charge states:   False
Include charge states 25 and higher:   False
Precursor Selection Range
Mass Range (m/z):   350-950
OR
Charge State
Include charge state(s):   6-8
Include undetermined charge states:   False
Include charge states 25 and higher:   False
Sort by Charge
Precursor Priority:   Highest Charge State
Sort by m/z
Precursor Priority:   Lowest m/z
Scan:
ddMS² IT ETD
Scan Priority:   1
Isolation Mode:   Quadrupole
Isolation Window (m/z):   2
Isolation Offset:   Off
Activation Type:   ETD
Use Calibrated Charge-Dependent ETD Parameters:   True
ETD Supplemental Activation:   False
Detector Type:   Ion Trap
Scan Range Mode:   Auto: m/z Normal
Ion Trap Scan Rate:   Rapid
First Mass (m/z):   120
AGC Target:   1.0e4
Inject Ions for All Available Parallelizable Time:   True
Maximum Injection Time (ms):   100
Microscans:   1
Data Type:   Centroid
Scan Description:
Scan Event Type 2:
Charge State
Include charge state(s):   2
Include undetermined charge states:   False
Include charge states 25 and higher:   False
OR
Charge State
Include charge state(s):   3
Include undetermined charge states:   False
Include charge states 25 and higher:   False
Precursor Selection Range
Mass Range (m/z):   650-1200
OR
Charge State
Include charge state(s):   4
Include undetermined charge states:   False
Include charge states 25 and higher:   False
Precursor Selection Range
Mass Range (m/z):   900-1200
OR
Charge State
Include charge state(s):   5
Include undetermined charge states:   False
Include charge states 25 and higher:   False
Precursor Selection Range
Mass Range (m/z):   950-1200
Scan:
ddMS² IT CID
Scan Priority:   1
Isolation Mode:   Quadrupole
Isolation Window (m/z):   2
Isolation Offset:   Off
Activation Type:   CID
Collision Energy Mode:   Fixed
CID Collision Energy (%):   30
CID Activation Time (ms):   10
Activation Q:   0.25
Multistage Activation:   False
Detector Type:   Ion Trap
Scan Range Mode:   Auto: m/z Normal
Ion Trap Scan Rate:   Rapid
AGC Target:   1.0e4
Inject Ions for All Available Parallelizable Time:   True
Maximum Injection Time (ms):   35
Microscans:   1
Data Type:   Centroid
Scan Description:

Experiment#3 [Glycopeptide - Enriched]

Start Time (min):   22
End Time (min):   23
Cycle Time (sec):   3
Master Scan:
MS OT
Detector Type:   Orbitrap
Orbitrap Resolution:   120000
Mass Range:   Normal
Use Quadrupole Isolation:   True
Scan Range (m/z):   350-1800
RF Lens (%):   30
AGC Target:   4.0e5
Maximum Injection Time (ms):   50
Microscans:   1
Data Type:   Centroid
Polarity:   Positive
Source Fragmentation:   Disabled
Scan Description:
Filters:
MIPS
Monoisotopic Peak Determination:   Peptide
Charge State
Include charge state(s):   2-8
Include undetermined charge states:   False
Include charge states 25 and higher:   False
Dynamic Exclusion
Exclude after n times:   1
Exclusion duration (s):   60
Mass Tolerance:   ppm
Low:   10
High:   10
Exclude Isotopes:   True
Perform dependent scan on single charge state per precursor only:   False
Intensity
Filter Type:   Intensity Threshold
Intensity Threshold:   5.0e4
Data Dependent
Data Dependent Mode:   Cycle Time
Time between Master Scans (sec):   3
Scan Event Type 1:
Sort by Charge
Precursor Priority:   Highest Charge State
Sort by m/z
Precursor Priority:   Lowest m/z
Scan:
ddMS² OT EThcD
Isolation Mode:   Quadrupole
Isolation Window (m/z):   3
Isolation Offset:   Off
Activation Type:   ETD
Use Calibrated Charge-Dependent ETD Parameters:   True
ETD Supplemental Activation:   True
SA Collision Energy Type:   EThcD
SA Collision Energy (%):   15
Detector Type:   Orbitrap
Scan Range Mode:   Auto: m/z Normal
Orbitrap Resolution:   60000
First Mass (m/z):   120
AGC Target:   5.0e4
Inject Ions for All Available Parallelizable Time:   False
Maximum Injection Time (ms):   118
Microscans:   1
Data Type:   Centroid
Use EASY-IC™:   False
Scan Description:

Experiment#4 [TMT Quan Pierce TKO Standard QC MS3 SPS]

Start Time (min):   23
End Time (min):   24
Cycle Time (sec):   2
Master Scan:
MS OT
Detector Type:   Orbitrap
Orbitrap Resolution:   120000
Mass Range:   Normal
Use Quadrupole Isolation:   False
Scan Range (m/z):   375-1500
RF Lens (%):   30
AGC Target:   4.0e5
Maximum Injection Time (ms):   50
Microscans:   1
Data Type:   Centroid
Polarity:   Positive
Source Fragmentation:   Disabled
Scan Description:
Filters:
MIPS
Monoisotopic Peak Determination:   Peptide
Charge State
Include charge state(s):   2-6
Include undetermined charge states:   False
Include charge states 25 and higher:   False
Dynamic Exclusion
Exclude after n times:   1
Exclusion duration (s):   60
Mass Tolerance:   ppm
Low:   10
High:   10
Exclude Isotopes:   True
Perform dependent scan on single charge state per precursor only:   True
Exclude Within Cycle:   True
Intensity
Filter Type:   Intensity Threshold
Intensity Threshold:   5.0e3
Data Dependent
Data Dependent Mode:   Cycle Time
Time between Master Scans (sec):   2
Scan Event Type 1:
Charge State
Include charge state(s):   2
Include undetermined charge states:   False
Include charge states 25 and higher:   False
Scan:
ddMS² IT CID
Scan Priority:   1
Isolation Mode:   Quadrupole
Isolation Window (m/z):   1.2
Isolation Offset:   Off
Activation Type:   CID
Collision Energy Mode:   Fixed
CID Collision Energy (%):   35
CID Activation Time (ms):   10
Activation Q:   0.25
Multistage Activation:   False
Detector Type:   Ion Trap
Scan Range Mode:   Auto: m/z Normal
Ion Trap Scan Rate:   Turbo
AGC Target:   1.0e4
Inject Ions for All Available Parallelizable Time:   False
Maximum Injection Time (ms):   50
Microscans:   1
Data Type:   Centroid
Scan Description:
Filters:
Precursor Selection Range
Selection Range Mode:   Mass Range
Mass Range (m/z):   400-1200
Isobaric Tag Loss Exclusion
Reagent:   TMT
Precursor Ion Exclusion
Exclusion mass width:   m/z
Low:   50
High:   5
Data Dependent
Data Dependent Mode:   Scans Per Outcome
Scan Event Type 1:
Scan:
ddMS³ OT HCD
MSⁿ Level:   3
Synchronous Precursor Selection:   True
Number of SPS Precursors:   5
MS Isolation Window (m/z):   1.3
MS2 Isolation Window (m/z):   2
Isolation Offset:   Off
Activation Type:   HCD
HCD Collision Energy (%):   65
Detector Type:   Orbitrap
Scan Range Mode:   Define m/z range
Orbitrap Resolution:   50000
Scan Range (m/z):   100-500
AGC Target:   1.0e5
Inject Ions for All Available Parallelizable Time:   False
Maximum Injection Time (ms):   105
Microscans:   1
Data Type:   Centroid
Use EASY-IC™:   False
Scan Description:
Number of Dependent Scans:   5
Scan Event Type 2:
Charge State
Include charge state(s):   3
Include undetermined charge states:   False
Include charge states 25 and higher:   False
Scan:
ddMS² IT CID
Scan Priority:   1
Isolation Mode:   Quadrupole
Isolation Window (m/z):   0.7
Isolation Offset:   Off
Activation Type:   CID
Collision Energy Mode:   Fixed
CID Collision Energy (%):   35
CID Activation Time (ms):   10
Activation Q:   0.25
Multistage Activation:   False
Detector Type:   Ion Trap
Scan Range Mode:   Auto: m/z Normal
Ion Trap Scan Rate:   Turbo
AGC Target:   1.0e4
Inject Ions for All Available Parallelizable Time:   False
Maximum Injection Time (ms):   50
Microscans:   1
Data Type:   Centroid
Scan Description:
Filters:
Precursor Selection Range
Selection Range Mode:   Mass Range
Mass Range (m/z):   400-1200
Isobaric Tag Loss Exclusion
Reagent:   TMT
Precursor Ion Exclusion
Exclusion mass width:   m/z
Low:   50
High:   5
Data Dependent
Data Dependent Mode:   Scans Per Outcome
Scan Event Type 1:
Scan:
ddMS³ OT HCD
MSⁿ Level:   3
Synchronous Precursor Selection:   True
Number of SPS Precursors:   10
MS Isolation Window (m/z):   0.7
MS2 Isolation Window (m/z):   2
Isolation Offset:   Off
Activation Type:   HCD
HCD Collision Energy (%):   65
Detector Type:   Orbitrap
Scan Range Mode:   Define m/z range
Orbitrap Resolution:   50000
Scan Range (m/z):   100-500
AGC Target:   1.0e5
Inject Ions for All Available Parallelizable Time:   False
Maximum Injection Time (ms):   105
Microscans:   1
Data Type:   Centroid
Use EASY-IC™:   False
Scan Description:
Number of Dependent Scans:   10
Scan Event Type 3:
Charge State
Include charge state(s):   4-6
Include undetermined charge states:   False
Include charge states 25 and higher:   False
Scan:
ddMS² IT CID
Scan Priority:   1
Isolation Mode:   Quadrupole
Isolation Window (m/z):   0.5
Isolation Offset:   Off
Activation Type:   CID
Collision Energy Mode:   Fixed
CID Collision Energy (%):   35
CID Activation Time (ms):   10
Activation Q:   0.25
Multistage Activation:   False
Detector Type:   Ion Trap
Scan Range Mode:   Auto: m/z Normal
Ion Trap Scan Rate:   Turbo
AGC Target:   1.0e4
Inject Ions for All Available Parallelizable Time:   False
Maximum Injection Time (ms):   50
Microscans:   1
Data Type:   Centroid
Scan Description:
Filters:
Precursor Selection Range
Selection Range Mode:   Mass Range
Mass Range (m/z):   400-1200
Isobaric Tag Loss Exclusion
Reagent:   TMT
Precursor Ion Exclusion
Exclusion mass width:   m/z
Low:   50
High:   5
Data Dependent
Data Dependent Mode:   Scans Per Outcome
Scan Event Type 1:
Scan:
ddMS³ OT HCD
MSⁿ Level:   3
Synchronous Precursor Selection:   True
Number of SPS Precursors:   10
MS Isolation Window (m/z):   0.5
MS2 Isolation Window (m/z):   2
Isolation Offset:   Off
Activation Type:   HCD
HCD Collision Energy (%):   65
Detector Type:   Orbitrap
Scan Range Mode:   Define m/z range
Orbitrap Resolution:   50000
Scan Range (m/z):   100-500
AGC Target:   1.0e5
Inject Ions for All Available Parallelizable Time:   False
Maximum Injection Time (ms):   105
Microscans:   1
Data Type:   Centroid
Use EASY-IC™:   False
Scan Description:
Number of Dependent Scans:   10

Experiment#5 [MS]

Start Time (min):   0
End Time (min):   35
Master Scan:
MS OT
Detector Type:   Orbitrap
Orbitrap Resolution:   120000
Mass Range:   Normal
Use Quadrupole Isolation:   True
Scan Range (m/z):   350-2000
RF Lens (%):   30
AGC Target:   2.0e5
Maximum Injection Time (ms):   50
Microscans:   1
Data Type:   Centroid
Polarity:   Positive
Source Fragmentation:   Disabled
Scan Description:
```

# 3 mzXML conversion

The mzXML files were produced by using
proteowizard software using the below-listed wrapper script.

```
"C:\Program Files (x86)\ProteoWizard\ProteoWizard 3.0.10200\msconvert" %1 --mzXML -z -o %~dp1\msconvert_mzXML
```

The software versions are:

| software release | Q Exactive HF-X | Fusion Lumos |
| --- | --- | --- |
| ProteoWizard | 3.0.10200 (2016-11-17) | 3.0.18109-390173050 |
| ProteoWizard MSData | 3.0.10200 (2016-11-17) |  |
| ProteoWizard Analysis | 3.0.10112 (2016-10-19) |  |
| Build date: | Nov 17 2016 10:59:56 |  |

# 4 Uploading to S3

```
cp@fgcz-148:~ > aws --profile AnnotationContributor s3 cp tartare s3://annotation-contributor/tartare --recursive --acl public-read
upload: tartare/20190710_003_PierceHeLaProteinDigestStd.mzXML to s3://annotation-contributor/tartare/20190710_003_PierceHeLaProteinDigestStd.mzXML
upload: tartare/20190710_003_PierceHeLaProteinDigestStd.raw to s3://annotation-contributor/tartare/20190710_003_PierceHeLaProteinDigestStd.raw
upload: tartare/20190716_004_PierceHeLa.mzXML to s3://annotation-contributor/tartare/20190716_004_PierceHeLa.mzXML
upload: tartare/20190716_004_PierceHeLa.raw to s3://annotation-contributor/tartare/20190716_004_PierceHeLa.raw
```

# 5 Usage

Loading *[tartare](https://bioconductor.org/packages/3.22/tartare)* data using Bioconductor *[ExperimentHub](https://bioconductor.org/packages/3.22/ExperimentHub)*

```
(fl <- system.file("extdata", "metadata.csv", package='tartare'))
```

```
## [1] "/tmp/RtmpDmxnru/Rinst8ea291aae69e6/tartare/extdata/metadata.csv"
```

```
metadata <- read.csv(fl, stringsAsFactors=FALSE)
```

| Title | SourceType | RDataPath | Notes |
| --- | --- | --- | --- |
| Q Exactive HF-X mzXML | mzXML | tartare/20190710\_003\_PierceHeLaProteinDigestStd.mzXML | md5=44cdee961107b3e6f755b5401d20b407 |
| Q Exactive HF-X raw | raw | tartare/20190710\_003\_PierceHeLaProteinDigestStd.raw | md5=21becaaa165d8aec00a48a2ace61ee20 |
| Fusion Lumos mzXML | mzXML | tartare/20190716\_004\_PierceHeLa.mzXML | md5=6f7485fc3b5864bac51a215200a52101 |
| Fusion Lumos raw | raw | tartare/20190716\_004\_PierceHeLa.raw | md5=055f6133b2e1c18fd33fa2c08fbaa8da |
| Q Exactive HF Orbitrap raw | raw | tartare/20181113\_010\_autoQC01.raw | md5=a1f5df9627cf9e0d51ec1906776957ab |

query and load *[tartare](https://bioconductor.org/packages/3.22/tartare)* package data from aws s3

```
library(ExperimentHub)

eh <- ExperimentHub();
query(eh, "tartare")
```

```
## ExperimentHub with 5 records
## # snapshotDate(): 2025-10-29
## # $dataprovider: Functional Genomics Center Zurich (FGCZ)
## # $species: NA
## # $rdataclass: Spectra
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH3219"]]'
##
##            title
##   EH3219 | Q Exactive HF-X mzXML
##   EH3220 | Q Exactive HF-X raw
##   EH3221 | Fusion Lumos mzXML
##   EH3222 | Fusion Lumos raw
##   EH4547 | Q Exactive HF Orbitrap raw
```

```
#### code snippets to be continued
# load(query(eh, c("NestLink", "F255744.RData"))[[1]])
# dim(F255744)
# load(query(eh, c("NestLink", "WU160118.RData"))[[1]])
# dim(WU160118)
```

More example code snippets are shown in the package vignette of the *[MsBackendRawFileReader](https://bioconductor.org/packages/3.22/MsBackendRawFileReader)* package.

# 6 Session info

Here is the compiled output of `sessionInfo()`:

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] ExperimentHub_3.0.0 AnnotationHub_4.0.0 BiocFileCache_3.0.0
## [4] dbplyr_2.5.1        BiocGenerics_0.56.0 generics_0.1.4
## [7] knitr_1.50          BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] rappdirs_0.3.3       sass_0.4.10          BiocVersion_3.22.0
##  [4] RSQLite_2.4.3        digest_0.6.37        magrittr_2.0.4
##  [7] evaluate_1.0.5       bookdown_0.45        fastmap_1.2.0
## [10] blob_1.2.4           jsonlite_2.0.0       AnnotationDbi_1.72.0
## [13] DBI_1.2.3            BiocManager_1.30.26  httr_1.4.7
## [16] purrr_1.1.0          Biostrings_2.78.0    httr2_1.2.1
## [19] jquerylib_0.1.4      cli_3.6.5            crayon_1.5.3
## [22] rlang_1.1.6          XVector_0.50.0       Biobase_2.70.0
## [25] bit64_4.6.0-1        withr_3.0.2          cachem_1.1.0
## [28] yaml_2.3.10          tools_4.5.1          memoise_2.0.1
## [31] dplyr_1.1.4          filelock_1.0.3       curl_7.0.0
## [34] vctrs_0.6.5          R6_2.6.1             png_0.1-8
## [37] stats4_4.5.1         lifecycle_1.0.4      Seqinfo_1.0.0
## [40] KEGGREST_1.50.0      S4Vectors_0.48.0     IRanges_2.44.0
## [43] bit_4.6.0            pkgconfig_2.0.3      pillar_1.11.1
## [46] bslib_0.9.0          glue_1.8.0           xfun_0.54
## [49] tibble_3.3.0         tidyselect_1.2.1     htmltools_0.5.8.1
## [52] rmarkdown_2.30       compiler_4.5.1
```

# References

Kockmann, Tobias, and Christian Panse. 2021. “The rawrr R Package: Direct Access to Orbitrap Data and Beyond” 20 (4): 2028–34. <https://doi.org/10.1021/acs.jproteome.0c00866>.

Shofstahl, Jim. 2015. “Reading Files using the C# file reader.” <http://planetorbitrap.com/rawfilereader#.WjkqIUtJmL4>.