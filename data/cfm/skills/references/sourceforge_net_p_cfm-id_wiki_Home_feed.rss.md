xml version="1.0" encoding="utf-8"?
Recent changes to Homehttps://sourceforge.net/p/cfm-id/wiki/Home/Recent changes to HomeenWed, 31 Jul 2019 15:53:57 -0000Home modified by Felicity Allenhttps://sourceforge.net/p/cfm-id/wiki/Home/<div class="markdown\_content"><pre>--- v84
+++ v85
@@ -571,7 +571,9 @@
This sourceforge provides code for CFM-ID 2.0 only. CFM -ID 3.0 has recently been released, and provides a wrapper to the functionality of CFM-ID 2.0 that can be accessed at http://cfmid3.wishartlab.com/. In cases where the spectrum for a molecule has been measured, it uses that, and if it is from one of the 21 classes of lipid listed below then a separate rule-based fragmenter is used, otherwise CFM 2.0 is used. Source code for the rule based fragmenter can be found at https://bitbucket.org/wishartlab/msrb-fragmenter/.
-CFM3.0 is work done by Yannick Djoumbou Feunag, so for assistance with this, please contact him.
+CFM3.0 is work done by Yannick Djoumbou Feunag, so for assistance with this, please contact him or see the related publication:
+
+Djoumbou-Feunang Y, Pon A, Karu N, Zheng J, Li C, Arndt D, Gautam M, Allen F, and Wishart D. "Significantly Improved ESI-MS/MS Prediction and Compound Identification". Metabolites. 2019, 9(4), 72.
\*\*21 lipid classes:\*\*
1-Monoacylglycerols, 2-Monoacylglycerols, 1,2-Diacylglycerols, Triacylglycerols, Phosphatidic acids (or 1,2-diacylglycerol-3-phosphates), Phosphatidylcholines, Phosphatidylethanolamines, Lysophosphatidylcholines, Lysophosphatidic acids, Phosphatidylserines, Ceramides , Sphingomyelins, Cardiolipins, Phosphatidylglycerols, Lysophosphatidylglycerols, 1-alkyl,2-acylglycero-3-phosphocholines, PLasmenyl-PC“ (or 1-(1Z-alkenyl), 2acyl-glycero-3-phosphocholines), 1-Alkanylglycerophosphocholines (or Monoalkylglycerophosphocholines), 1-Alkenylglycerophosphocholines (or 1-(1Z-alkenyl)-glycero-3-phosphocholines), Phosphatidylinositols, Lysophosphatidylinositols
</pre>
</div>Felicity AllenWed, 31 Jul 2019 15:53:57 -0000https://sourceforge.netebd99da45245a6463a4b15f655fa9c5276ab5916Home modified by Felicity Allenhttps://sourceforge.net/p/cfm-id/wiki/Home/<div class="markdown\_content"><pre>--- v83
+++ v84
@@ -574,7 +574,7 @@
CFM3.0 is work done by Yannick Djoumbou Feunag, so for assistance with this, please contact him.
\*\*21 lipid classes:\*\*
-1-Monoacylglycerols, 2-Monoacylglycerols, 1,2-Diacylglycerols, Triacylglycerols, Phosphatidic acids (or 1,2-diacylglycerol-3-phosphates), Phosphatidylcholines, Phosphatidylethanolamines, Lysophosphatidylcholines, Lysophosphatidic acids, Phosphatidylserines” ,”Ceramides” ,”Sphingomyelins, Cardiolipins, Phosphatidylglycerols, Lysophosphatidylglycerols, 1-alkyl,2-acylglycero-3-phosphocholines, PLasmenyl-PC“ (or 1-(1Z-alkenyl), 2acyl-glycero-3-phosphocholines), 1-Alkanylglycerophosphocholines (or Monoalkylglycerophosphocholines), 1-Alkenylglycerophosphocholines (or 1-(1Z-alkenyl)-glycero-3-phosphocholines), Phosphatidylinositols, Lysophosphatidylinositols
+1-Monoacylglycerols, 2-Monoacylglycerols, 1,2-Diacylglycerols, Triacylglycerols, Phosphatidic acids (or 1,2-diacylglycerol-3-phosphates), Phosphatidylcholines, Phosphatidylethanolamines, Lysophosphatidylcholines, Lysophosphatidic acids, Phosphatidylserines, Ceramides , Sphingomyelins, Cardiolipins, Phosphatidylglycerols, Lysophosphatidylglycerols, 1-alkyl,2-acylglycero-3-phosphocholines, PLasmenyl-PC“ (or 1-(1Z-alkenyl), 2acyl-glycero-3-phosphocholines), 1-Alkanylglycerophosphocholines (or Monoalkylglycerophosphocholines), 1-Alkenylglycerophosphocholines (or 1-(1Z-alkenyl)-glycero-3-phosphocholines), Phosphatidylinositols, Lysophosphatidylinositols
[[members limit=20]]
[[download\_button]]
</pre>
</div>Felicity AllenWed, 31 Jul 2019 15:52:03 -0000https://sourceforge.netff54f58c3f01a192c345fc9cd71edafdf66a47e8Home modified by Felicity Allenhttps://sourceforge.net/p/cfm-id/wiki/Home/<div class="markdown\_content"><pre>--- v82
+++ v83
@@ -1,5 +1,3 @@
-\*\*NOTE: [CFM-ID 2.0] now released, and includes some small INTERFACE CHANGES!! For example, an id must be given as input to cfm-id and cfm-annotate, shifting the other input arguments along. If still using earlier versions of CFM-ID, the following will not be exact so please check program inputs by running with no command arguments\*\*.
-
Welcome to the CFM-ID wiki! Here you can find documentation for this project.
Further information can be found in the following publication:
@@ -569,10 +567,14 @@
Allen F., Pon A., Wilson M., Greiner R., Wishart D., "CFM-ID: A web server for annotation, spectrum prediction and metabolite identification from tandem mass spectra", Nucleic Acids Research, 42 (W1): W94-99, 2014.
-
-
-
-
+##CFM-ID 3.0##
+
+This sourceforge provides code for CFM-ID 2.0 only. CFM -ID 3.0 has recently been released, and provides a wrapper to the functionality of CFM-ID 2.0 that can be accessed at http://cfmid3.wishartlab.com/. In cases where the spectrum for a molecule has been measured, it uses that, and if it is from one of the 21 classes of lipid listed below then a separate rule-based fragmenter is used, otherwise CFM 2.0 is used. Source code for the rule based fragmenter can be found at https://bitbucket.org/wishartlab/msrb-fragmenter/.
+
+CFM3.0 is work done by Yannick Djoumbou Feunag, so for assistance with this, please contact him.
+
+\*\*21 lipid classes:\*\*
+1-Monoacylglycerols, 2-Monoacylglycerols, 1,2-Diacylglycerols, Triacylglycerols, Phosphatidic acids (or 1,2-diacylglycerol-3-phosphates), Phosphatidylcholines, Phosphatidylethanolamines, Lysophosphatidylcholines, Lysophosphatidic acids, Phosphatidylserines” ,”Ceramides” ,”Sphingomyelins, Cardiolipins, Phosphatidylglycerols, Lysophosphatidylglycerols, 1-alkyl,2-acylglycero-3-phosphocholines, PLasmenyl-PC“ (or 1-(1Z-alkenyl), 2acyl-glycero-3-phosphocholines), 1-Alkanylglycerophosphocholines (or Monoalkylglycerophosphocholines), 1-Alkenylglycerophosphocholines (or 1-(1Z-alkenyl)-glycero-3-phosphocholines), Phosphatidylinositols, Lysophosphatidylinositols
[[members limit=20]]
[[download\_button]]
</pre>
</div>Felicity AllenWed, 31 Jul 2019 15:51:05 -0000https://sourceforge.net91ccf4a4160ca6e59a0edb5bb8f6b996c8d5e1d8Home modified by Felicity Allenhttps://sourceforge.net/p/cfm-id/wiki/Home/<div class="markdown\_content"><pre>--- v81
+++ v82
@@ -390,7 +390,7 @@
##Installing the Windows Binaries##
-To install the windows binaries, simply download them and run them from a command line as above. Note that lpsolve55.dll must also be included in the same directory as the executables. This file can be found in the development version of LPSolve (e.g. lp\_solve\_5.5.2.0\_dev\_win32.zip), which can be downloaded from https://sourceforge.net/projects/lpsolve.
+To install the windows binaries, simply download them and run them from a command line as above. Note that lpsolve55.dll must also be included in the same directory as the executables. This file can be found in the development version of LPSolve (e.g. lp\_solve\_5.5.2.0\_dev\_win32.zip), which can be downloaded from https://sourceforge.net/projects/lpsolve/.
##Compiling the Source Code##
</pre>
</div>Felicity AllenTue, 01 May 2018 20:05:07 -0000https://sourceforge.net91ec46f91704da3d867f6349de6af004f5306aa5Home modified by Felicity Allenhttps://sourceforge.net/p/cfm-id/wiki/Home/<div class="markdown\_content"><pre>--- v80
+++ v81
@@ -551,6 +551,10 @@
Copy the file https://sourceforge.net/p/cfm-id/code/HEAD/tree/cfm/cfm-code/ISOTOPE.DAT into the directory where you are running the binaries.
+\*\*I'm having trouble compiling the code\*\*
+
+For some extra tips and tricks to get CFM compiling for you, please see: https://sourceforge.net/p/cfm-id/tickets/14/ Many thanks to Anand and Anthony for providing this information.
+
\*\*Other questions/comments/concerns\*\*
Please feel free to contact me.
</pre>
</div>Felicity AllenMon, 26 Jun 2017 21:44:22 -0000https://sourceforge.net206ebe6ddd0105e36352602601be52af511a73fcHome modified by Felicity Allenhttps://sourceforge.net/p/cfm-id/wiki/Home/<div class="markdown\_content"><pre>--- v79
+++ v80
@@ -69,7 +69,7 @@
\*\*Usage\*\*
~~~~~~
-cfm-predict.exe &lt;smiles\_or\_inchi\_or\_file&gt; &lt;prob\_thresh&gt; &lt;param\_file&gt; &lt;config\_file&gt; &lt;annotate\_fragments&gt; &lt;output\_file\_or\_dir&gt; &lt;apply\_postproc&gt;
+cfm-predict.exe &lt;smiles\_or\_inchi\_or\_file&gt; &lt;prob\_thresh&gt; &lt;param\_file&gt; &lt;config\_file&gt; &lt;annotate\_fragments&gt; &lt;output\_file\_or\_dir&gt; &lt;apply\_postproc&gt; &lt;suppress\_exceptions&gt;
~~~~~~
\*smiles\_or\_inchi\_or\_file:\* The smiles or inchi string of the structure whose spectra you want to predict. Or alternatively a .txt file containing a list of space-separated (id, smiles\_or\_inchi) pairs one per line. e.g.
@@ -91,6 +91,8 @@
\*output\_file\_or\_dir:\* (optional) The filename of the output spectra file to write to (if not given, prints to stdout). In case of batch mode using file input above, this is used to specify the name of a directory where the output files (&lt;id&gt;.log) will be written (if not given, uses current directory), OR an msp or mgf file.
\*apply\_postproc:\* (optional) Whether or not to post-process predicted spectra to take the top 80% of energy (at least 5 peaks), or the highest 30 peaks (whichever comes first) (0 = OFF, 1 = ON (default)). If turned off, will output a peak for every possible fragment of the input molecule, as long as the prob\_thresh argument above is set to 0.0.
+
+\*suppress\_exceptions:\* (optional) Suppress most exceptions so that the program returns normally even when it fails to produce a result (0 = OFF (default), 1 = ON).
\*\*Example\*\*
</pre>
</div>Felicity AllenMon, 07 Nov 2016 22:31:02 -0000https://sourceforge.netdcf649c7ad134ddf4d7e5ed00558b8fab3d3d86cHome modified by Felicity Allenhttps://sourceforge.net/p/cfm-id/wiki/Home/<div class="markdown\_content"><pre>--- v78
+++ v79
@@ -543,7 +543,7 @@
All the ESI-MS/MS models are trained on three energy levels. If you have only one energy level, the best thing is probably to repeat that energy level for all three energy levels when you input it to cfm-id.
\*\*Are any of the precomputed spectra available?\*\*
-Yes. You can download predicted spectra for HMDB here: https://sourceforge.net/p/cfm-id/code/HEAD/tree/supplementary\_material/predicted\_spectra/
+Yes. You can download precomputed predicted spectra for HMDB here: https://sourceforge.net/p/cfm-id/code/HEAD/tree/supplementary\_material/predicted\_spectra/
\*\*I get "Error opening ISOTOPE.DAT file"\*\*
</pre>
</div>Felicity AllenTue, 07 Jun 2016 13:02:23 -0000https://sourceforge.net3ff784f0809c6ccfe1cd5e073527942e1786ef75Home modified by Felicity Allenhttps://sourceforge.net/p/cfm-id/wiki/Home/<div class="markdown\_content"><pre>--- v77
+++ v78
@@ -527,6 +527,32 @@
14. Run the programs from a command line as detailed on https://sourceforge.net/p/cfm-id/wiki/Home/
(Note: replace ~ with the paths where you've installed Boost or RDKit or lpsolve respectively.)
+##Frequently Asked Questions##
+
+\*\*Which model should I use?\*\*
+
+There a several pre-trained CFM models available at https://sourceforge.net/p/cfm-id/code/HEAD/tree/supplementary\_material/trained\_models/. Which model to use should be dictated by the MS setup you want to use.
+
+If you are using EI-MS (GC-MS) data, please use the ei\_ms\_model provided.
+If you are using positive mode ESI-MS/MS data, please use either metab\_ce\_cfm or metab\_se\_cfm (and select param\_output0.log). If you are using negative mode ESI-MS/MS data, please use negative\_metab\_se\_cfm (param\_output0.log).
+
+Make sure you take BOTH the param\_output and param\_config file from the corresponding model.
+
+\*\*I have ESI-MS/MS data collected at only one energy level. What should I do?\*\*
+
+All the ESI-MS/MS models are trained on three energy levels. If you have only one energy level, the best thing is probably to repeat that energy level for all three energy levels when you input it to cfm-id.
+
+\*\*Are any of the precomputed spectra available?\*\*
+Yes. You can download predicted spectra for HMDB here: https://sourceforge.net/p/cfm-id/code/HEAD/tree/supplementary\_material/predicted\_spectra/
+
+\*\*I get "Error opening ISOTOPE.DAT file"\*\*
+
+Copy the file https://sourceforge.net/p/cfm-id/code/HEAD/tree/cfm/cfm-code/ISOTOPE.DAT into the directory where you are running the binaries.
+
+\*\*Other questions/comments/concerns\*\*
+
+Please feel free to contact me.
+
##Related Publications##
Allen F., Greiner R., Wishart D., "Computational prediction of electron ionization mass spectra to assist in GC-MS compound identification", submitted, 2016.
@@ -537,33 +563,6 @@
Allen F., Pon A., Wilson M., Greiner R., Wishart D., "CFM-ID: A web server for annotation, spectrum prediction and metabolite identification from tandem mass spectra", Nucleic Acids Research, 42 (W1): W94-99, 2014.
-##Frequently Asked Questions##
-
-\*\*Which model should I use?\*\*
-
-There a several pre-trained CFM models available at https://sourceforge.net/p/cfm-id/code/HEAD/tree/supplementary\_material/trained\_models/. Which model to use should be dictated by the MS setup you want to use.
-
-If you are using EI-MS (GC-MS) data, please use the ei\_ms\_model provided.
-If you are using positive mode ESI-MS/MS data, please use either metab\_ce\_cfm or metab\_se\_cfm (and select param\_output0.log). If you are using negative mode ESI-MS/MS data, please use negative\_metab\_se\_cfm (param\_output0.log).
-
-Make sure you take BOTH the param\_output and param\_config file from the corresponding model.
-
-\*\*I have ESI-MS/MS data collected at only one energy level. What should I do?\*\*
-
-All the ESI-MS/MS models are trained on three energy levels. If you have only one energy level, the best thing is probably to repeat that energy level for all three energy levels when you input it to cfm-id.
-
-\*\*Are any of the precomputed spectra available?\*\*
-Yes. You can download predicted spectra for HMDB here: https://sourceforge.net/p/cfm-id/code/HEAD/tree/supplementary\_material/predicted\_spectra/
-
-\*\*I get "Error opening ISOTOPE.DAT file"\*\*
-
-Copy the file https://sourceforge.net/p/cfm-id/code/HEAD/tree/cfm/cfm-code/ISOTOPE.DAT into the directory where you are running the binaries.
-
-\*\*Other questions/comments/concerns\*\*
-
-Please feel free to contact me.
-
-
</pre>
</div>Felicity AllenTue, 07 Jun 2016 12:53:25 -0000https://sourceforge.net550b21936ca99116324f1b21784650f935ce78c8Home modified by Felicity Allenhttps://sourceforge.net/p/cfm-id/wiki/Home/<div class="markdown\_content"><pre>--- v76
+++ v77
@@ -527,6 +527,16 @@
14. Run the programs from a command line as detailed on https://sourceforge.net/p/cfm-id/wiki/Home/
(Note: replace ~ with the paths where you've installed Boost or RDKit or lpsolve respectively.)
+##Related Publications##
+
+Allen F., Greiner R., Wishart D., "Computational prediction of electron ionization mass spectra to assist in GC