Targeted Proteomics coming of age – SRM PRM and DIA performance evaluated from a core facility perspective
Tobias Kockmann⋄, Christian Trachsel⋄, Christian Panse⋄, Åsa Wåhlander‡, Nathalie Selevsek⋄, Jonas Grossmann⋄, Witold E. Wolski⋄, Claudia Fortes⋄, Paolo Nanni⋄ and Ralph Schlapbach⋄

1 Introduction

Quantitative mass spectrometry is a rapidly evolving
methodology applied in a large number of - omics type
research projects. During the past years, new de-
signs of mass spectrometers have been developed and
launched as commercial systems while in parallel new
data acquisition schemes and data analysis paradigms
have been introduced. Core facilities provide access
to such technologies, but also actively support the re-
searchers in finding and applying the best-suited ana-
lytical approach.
In order to implement a solid funda-
ment for this decision making process, facilities need
to constantly compare and benchmark the various ap-
proaches. In this work we compare the quantitative ac-
curacy and precision of current label-free targeted pro-
teomics approaches (SRM, PRM and DIA) across multi-
ple liquid chromatography mass spectrometry (LC-MS)
platforms, using a readily available commercial standard
sample.

Figure 1: Accuracy and precision

2 Methods

A pre-digested protein sample (MSQC1; Sigma-Aldrich)
with a priori known analyte quantities (mixture of 6
trypsin-digested human proteins and 14 corresponding
heavy synthetic peptides) was targeted in a complex
yeast matrix on all platforms. In a first part, the quanti-
tative accuracy and precision (see Figure 1) was inves-
tigated at constant analyte quantities. In a second part,
the impact of decreasing analyte quantities on analytical
performance was studied over a concentration range of
three orders of magnitude (dilution series data). Finally,
the human influence on quantitative accuracy was in-
vestigated and contrasted with machine learning solu-
tions (user study).

IT MS2 res.

PCS
20 ms
0.7 Da
0.7 Da
20 ms
2.0 Da 120 ms a 70’000b
45 msc 30’000d
25.0 Da
100 ms 15’000
25.0 Da

-
-

MS system
TSQ Vantage
QTRAP 5500
Q EXACTIVE
Q EXACTIVE HF
TripleTOF 5600

Analysis mode
SRM
SRM
PRM
DIA
SWATH

aor 1e5
bat 200 m/z
cor 3e6
dat 200 m/z

Table 1: Measurement schemes – Summarizes the
measurement schemes compared in this study. PCS:
Precursor selectivity, IT: Injection time, MS2 res.: reolu-
tion of MS2 scan. For Orbitrap type analyzers the max.
injection time and the automated gain control (AGC)
value is given. Filling of the C-trap will end as soon as
one of the two parameters (IT or AGC) is fullfilled.

3 Results

– Good linearity for all targeted peptides across the

tested concentration range was observed.

– Targeted analysis platforms delivered very repro-
intra-assay CVs less than 15%) and
ducible (ie.
consistent quantitative data sets, even between plat-
forms (see Figure 5).

– Expected fold changes were obtained for all dilution
points, however at low peptide concentrations, the ac-
curacy of the measurements were compromised to
different extents depending on the MS platform (see
Figure 6).

– Compared to the automated evaluation of peak-
groups in Skyline a manual curation usually leads to
a higher number of quantified peaks but only expert
user manage to do this without compromising on the
variance (see Figure 4).Each manual peakgroup vali-
dation will introduce a human bias which is not repro-
ducible and therefore automated validation is favored
(see Figure 4).

Figure 2: Target peptides – The scatter-plot displays
the reference L:H ratio versus the on-column amount of
heavy peptide. Note, x and y axis are drawn in log scale.

Figure 4: Human impact on quantitative accuracy
– The scatterplots graph the standard deviation of the
error between measured and reference log2 L:H ratio
against the number of valid ratios (L and H value is
not NA) for each subject. The crossing grey lines indi-
cate the algorithmic proposed start solution of the Sky-
line legacy peak picking. On the Q-trap no automated
peak group selection was trained since no decoy transi-
tions were measured. mProphet and second-best were
trained on the 8 repl. data set and applied with a q-value
cut-off of 0.001.

Figure 6: Ratio stability upon analyte dilution and ac-
curacy – Upper chart: Each scatterplot panel displays
the experimental derived log2 L:H ratios versus the rela-
tive amount. Color grouping was done by instrument.
The LOESS fit curves were added for visualizing the
trend. The SIL value given in each panel legend is valid
for the relative amount of 1. The horizontal black line
indicates the theoretical log2 L:H ratio. On both visual-
izations grey color boxes indicate the one and 2-linear-
fold change, Lower chart: The graph displays in each
panel a sensitivity curves for one relative amount for all
the used workflows.

Figure 3: Chromatography – The graphs compare the
LC gradient of each platform by plotting the normalized
RT values versus the empirical RT values for the 8 repli-
cate (bottom) and dilution series (top) data.

Figure 5: Precision – The violin and box plots display
the distribution of the peptide level coefficient of vari-
ance (CV) computed on the light and heavy peptide sig-
nal of each platform.

(a)

Figure 7: Comparision of precursor and product ion
– Each panel displays the experimentally derived log2
L:H ratios versus the relative amount. The black line in-
dicates the reference log2 L:H value. Dark and light grey
shaded areas mark error margins of 1- and 2-fold on the
linear scale, respectively.

Figure 8: Radarplot of different workflow metrics scaled
on an arbitrary axis with the units 0–10. Values do
not necessarily represent global applicable values but
rather reflect the situation at the FGCZ. For the following
categories the axis reflects 0 = worst, 10 = best: Pep-
tides per injection, Sample throughput, Accuracy, Preci-
sion, Flexibility post acquisition, Sensitivity; 0 = best, 10
= worst: Assay development time, Price per injection,
Data size, Data analysis.

4 Conclusions

The daily operational business of a core facility is nor-
mally not allowing for optimization of each method pa-
rameter, prior to recording a data set. This is reflected
in this study by running the experiments with methods
used on a routine basis in our core facility. Our study
shows that targeted data acquisition (SRM, PRM) out-
performs targeted data extraction strategies (DIA) with
respect to quantitative accuracy and precision, espe-
cially when the analyte concentration are low. But tar-
geted acquisition methods are only suited for monitoring
a limited number of targets, whily for screening experi-
ments targeted data extraction workflows clearly outper-
form targeted data acquisition with respect to the num-
ber of features which can be followed. The question
of whether greater throughput justifies lower sensitiv-
ity/specificity has yet to be answered in the context of
the individual research project. In addition, large-scale
DIA is very resource demanding (e.g. on the compu-
tational side) and especially data analysis needs more
effort due to the high complexity of the raw data. Not
all research environments are equally prepared for such
challenges and should consider these aspects during
experimental design setup.

Acknowledgements We thank Laura Kunz and
Bernd Roschitzki for participating in our user study, and
Bernd Roschitzki for critically reading our manuscript.
We are grateful to Can Türker, Marco Schmidt and Ugur
Gürel for providing the b-fabric information management
system. We thank ETH Zurich and University of Zurich
for their financial support.

References

Kockmann T, Trachsel C, Panse C, Wahlander A, Se-
levsek N, Grossmann J, Wolski WE, Schlapbach R
(2016). “Targeted proteomics coming of age - SRM,
PRM and DIA performance evaluated from a core fa-
cility perspective.” PROTEOMICS, pp. n/a–n/a. ISSN
1615-9861. doi:10.1002/pmic.201500502. URL http:
//dx.doi.org/10.1002/pmic.201500502.

functional genomics center zurichf g c zLow accuracyLow precisionLow accuracyHigh precisionHigh accuracyLow precisionHigh accuracyHigh precisionon column amount [fmol]reference L:H ratio0.8420805000.1611.024.938GGPFSDSYRVLDALQAIKAVQQPDGLAVLGIFLKSADFTNFDPREGHLSPDIVAEQKALIVLAHSERESDTSYVSLKGYSIFSYATKFEDENFILKVSFELFADKTAENFRGAGAFGYFEVTHDITKFSTVAGESGSADTVRNLSVEDAARempirical RTnormalized RT0.00.20.40.60.81.0204060808 replicates0.00.20.40.60.81.0dilution seriesQExactiveQExactiveHFQTRAPTRIPLETOFTSQVantagenumber of valid ratiosStandard deviation of Error1015202530450500550600650QTRAP450500550600650TRIPLETOFbeginnerexpertlegacymProphetsecond_bestcoefficient of variation [%]20010050251052.51QExactiveQExactiveHFQTRAPTRIPLETOFTSQVantagelog2 L:H ratio levelQExactiveQExactiveHFQTRAPTRIPLETOFTSQVantagepeptide levelsigma mix peptide level signallog2 light heavy ratios of 6 dilutions on 5 MS plattformsrelative.amountlog2(Area.light) − log2(Area.heavy)−5050.0250.050.2125Catalase/P04040SIL on column=0.8fmolactual.LH.ratio=49NLSVEDAARCatalase/P04040SIL on column=4fmolactual.LH.ratio=4.9FSTVAGESGSADTVRCRP/P02741SIL on column=4fmolactual.LH.ratio=38GYSIFSYATK−505CRP/P02741SIL on column=20fmolactual.LH.ratio=9.4ESDTSYVSLK−505CAH2/P00918SIL on column=20fmolactual.LH.ratio=55SADFTNFDPRPPIA/Q13427SIL on column=20fmolactual.LH.ratio=0.92TAENFRPPIA/Q13427SIL on column=40fmolactual.LH.ratio=0.54VSFELFADK−505PPIA/Q13427SIL on column=80fmolactual.LH.ratio=0.29FEDENFILK−505DT−Diaphorase(NQO1)/P15559SIL on column=100fmolactual.LH.ratio=0.93ALIVLAHSERCAH2/P00918SIL on column=100fmolactual.LH.ratio=8.4AVQQPDGLAVLGIFLKDT−Diaphorase(NQO1)/P15559SIL on column=200fmolactual.LH.ratio=0.92EGHLSPDIVAEQK−505Catalase/P04040SIL on column=200fmolactual.LH.ratio=0.16GAGAFGYFEVTHDITK−505CAH1/P00915SIL on column=500fmolactual.LH.ratio=2.04VLDALQAIK0.0250.050.2125CAH1/P00915SIL on column=1000fmolactual.LH.ratio=1.02GGPFSDSYRQExactiveQExactiveHFQTRAPTRIPLETOFTSQVantagesensitivity (relative number of data items having a distance to the theoretical log2ratio cutoff)erelative amount correctly quantified replicates0.00.20.40.60.81.01234AUC [0,1]:QExactive = 0.79QExactiveHF = 0.28QTRAP = 0.58TRIPLETOF = 0.32TSQVantage = 0.69 : relative.amount{ 0.025 }AUC [0,1]:QExactive = 0.8QExactiveHF = 0.39QTRAP = 0.67TRIPLETOF = 0.44TSQVantage = 0.61 : relative.amount{ 0.05 }1234AUC [0,1]:QExactive = 0.88QExactiveHF = 0.65QTRAP = 0.8TRIPLETOF = 0.63TSQVantage = 0.82 : relative.amount{ 0.2 }AUC [0,1]:QExactive = 0.87QExactiveHF = 0.84QTRAP = 0.85TRIPLETOF = 0.75TSQVantage = 0.87 : relative.amount{ 1 }1234AUC [0,1]:QExactive = 0.87QExactiveHF = 0.84QTRAP = 0.84TRIPLETOF = 0.71TSQVantage = 0.87 : relative.amount{ 2 }0.00.20.40.60.81.0AUC [0,1]:QExactive = 0.87QExactiveHF = 0.8QTRAP = 0.84TRIPLETOF = 0.67TSQVantage = 0.88 : relative.amount{ 5 }QExactiveQExactiveHFQTRAPTRIPLETOFTSQVantagerelative.amountlog2(Area.light) − log2(Area.heavy)−505100.0250.050.2125NLSVEDAARMS1FSTVAGESGSADTVRMS10.0250.050.2125GYSIFSYATKMS1ESDTSYVSLKMS10.0250.050.2125SADFTNFDPRMS1VSFELFADKMS10.0250.050.2125FEDENFILKMS1ALIVLAHSERMS10.0250.050.2125AVQQPDGLAVLGIFLKMS1EGHLSPDIVAEQKMS10.0250.050.2125GAGAFGYFEVTHDITKMS1VLDALQAIKMS10.0250.050.2125GGPFSDSYRMS1NLSVEDAARproduct.ions0.0250.050.2125FSTVAGESGSADTVRproduct.ionsGYSIFSYATKproduct.ions0.0250.050.2125ESDTSYVSLKproduct.ionsSADFTNFDPRproduct.ions0.0250.050.2125VSFELFADKproduct.ionsFEDENFILKproduct.ions0.0250.050.2125ALIVLAHSERproduct.ionsAVQQPDGLAVLGIFLKproduct.ions0.0250.050.2125EGHLSPDIVAEQKproduct.ionsGAGAFGYFEVTHDITKproduct.ions0.0250.050.2125VLDALQAIKproduct.ions−50510GGPFSDSYRproduct.ionsQExactiveQExactiveHFTRIPLETOF012345678910Peptides perInjectionSample througputAssaydevelopment timeAccuracyPrecisionPrice per injectionFlexibility postacquisitionData SizeSensitivityData analysisTSQ Vantage (SRM)012345678910Peptides perInjectionSample througputAssaydevelopment timeAccuracyPrecisionPrice per injectionFlexibility postacquisitionData SizeSensitivityData analysisQTRAP (SRM)0123456789Peptides perInjectionSample througputAssaydevelopment timeAccuracyPrecisionPrice per injectionFlexibility postacquisitionData SizeSensitivityData analysisQEXACTIVE (PRM)012345678910Peptides perInjectionSample througputAssaydevelopment timeAccuracyPrecisionPrice per injectionFlexibility postacquisitionData SizeSensitivityData analysisQEXACTIVE HF (DIA)012345678910Peptides perInjectionSample througputAssaydevelopment timeAccuracyPrecisionPrice per injectionFlexibility postacquisitionData SizeSensitivityData analysisTRIPLETOF (SWATH)QR code generated on http://qrcode.littleidiot.beContact: ⋄ ETHZ|UZH, Functional Genomics Center Zurich, Winterthurerstr. 190, CH-8057 Zurich, SWITZERLAND, Phone: +41 44 635 39 10, Fax: +41 44 635 39 22, EMail: staffproteomics@fgcz.ethz.ch, URL: http://bioconductor.org/packages/msqc1/; ‡ Åsa Wåhlander, AstraZeneca Nucleotide Bioanalysis, Drug Safety and Metabolism, Innovative Medicines Mölndal, SE-43183, SWEDEN, Phone: +46 (0)725470491.

