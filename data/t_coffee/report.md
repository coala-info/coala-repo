# t_coffee CWL Generation Report

## t_coffee

### Tool Description
T-Coffee is a multiple sequence alignment program. It can be used to align protein and nucleic acid sequences. T-Coffee can also be used to align structural information.

### Metadata
- **Docker Image**: quay.io/biocontainers/t-coffee:13.46.2.7c9e712d--pl5321hb2a3317_0
- **Homepage**: https://github.com/jashkenas/coffee-script-tmbundle
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/t_coffee/overview
- **Total Downloads**: 221.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jashkenas/coffee-script-tmbundle
- **Stars**: N/A
### Original Help Text
```text
#######   Compiling the list of available methods ... (will take a few seconds)

#######   Methods For which an Interface is available in T-Coffee
You must install the packages yourself when required (use the provided address)
Contact us if you need an extra method to be added [cedric.notredame@gmail.com]

****** Pairwise Sequence Alignment Methods:
--------------------------------------------
test_pair            built_in                                                   [pg:        t_coffee is  Installed][built_in]
fast_pair            built_in                                                   [pg:        t_coffee is  Installed][built_in]
exon3_pair           built_in                                                   [pg:        t_coffee is  Installed][built_in]
exon2_pair           built_in                                                   [pg:        t_coffee is  Installed][built_in]
exon_pair            built_in                                                   [pg:        t_coffee is  Installed][built_in]
blastr_pair          built_in                                                   [pg:        t_coffee is  Installed][built_in]
promo_pair           built_in                                                   [pg:        t_coffee is  Installed][built_in]
clean_slow_pair      built_in                                                   [pg:        t_coffee is  Installed][built_in]
slow_pair            built_in                                                   [pg:        t_coffee is  Installed][built_in]
hash_pair            built_in                                                   [pg:        t_coffee is  Installed][built_in]
biphasic_pair        built_in                                                   [pg:        t_coffee is  Installed][built_in]
proba_prfpair        built_in                                                   [pg:        t_coffee is  Installed][built_in]
fs_pair              built_in                                                   [pg:        t_coffee is  Installed][built_in]
proba_pair           built_in                                                   [pg:        t_coffee is  Installed][built_in]
best_pair4prot       built_in                                                   [pg:        t_coffee is  Installed][built_in]
best_pair4rna        built_in                                                   [pg:        t_coffee is  Installed][built_in]
lalign_id_pair       built_in                                                   [pg:        t_coffee is  Installed][built_in]
fs_lalign_id_pair    built_in                                                   [pg:        t_coffee is  Installed][built_in]
seq_pair             built_in                                                   [pg:        t_coffee is  Installed][built_in]
externprofile_pair   built_in                                                   [pg:        t_coffee is  Installed][built_in]
hh_pair              built_in                                                   [pg:        t_coffee is  Installed][built_in]
co_pair              built_in                                                   [pg:        t_coffee is  Installed][built_in]
cwprofile_pair       built_in                                                   [pg:        t_coffee is  Installed][built_in]
cdna_fast_pair       built_in                                                   [pg:        t_coffee is  Installed][built_in]
cdna_cfast_pair      built_in                                                   [pg:        t_coffee is  Installed][built_in]
old_clustalo_pair    http://www.clustal.org/omega/                              [pg:        clustalo is  Installed][/usr/local/bin//clustalo]
mafftsparsecore_pair http://align.bmr.kyushu-u.ac.jp/mafft/online/server/       [pg:           mafft is  Installed][/usr/local/bin//mafft]
dynamic_pair         built_in                                                   [pg:        t_coffee is  Installed][built_in]
3dcoffee_pair        built_in                                                   [pg:        t_coffee is  Installed][built_in]
expresso_pair        built_in                                                   [pg:        t_coffee is  Installed][built_in]
accurate_pair        built_in                                                   [pg:        t_coffee is  Installed][built_in]
psicoffee_pair       built_in                                                   [pg:        t_coffee is  Installed][built_in]
clustaloNF_pair      http://www.clustal.org/omega/                              [pg:        clustalo is  Installed][/usr/local/bin//clustalo]
clustalw2_pair       http://www.clustal.org                                     [pg:       clustalw2 is  Installed][/usr/local/bin//clustalw2]
clustalw_pair        http://www.clustal.org                                     [pg:        clustalw is  Installed][/usr/local/bin//clustalw]
uppNF_pair           http://www.cs.utexas.edu/users/phylo/software/upp/         [pg:             upp is NOT Installed][]
upp_pair             http://www.cs.utexas.edu/users/phylo/software/upp/         [pg:             upp is NOT Installed][]
msa_pair             https://www.ncbi.nlm.nih.gov/CBBresearch/Schaffer/msa.html [pg:             msa is NOT Installed][]
dca_pair             https://bibiserv2.cebitec.uni-bielefeld.de/dca             [pg:             dca is NOT Installed][]
dialigntx_pair       http://dialign-tx.gobics.de/                               [pg:      dialign-tx is  Installed][/usr/local/bin//dialign-tx]
dialignt_pair        http://dialign-tx.gobics.de/                               [pg:       dialign-t is NOT Installed][]
poa_pair             http://www.bioinformatics.ucla.edu/poa/                    [pg:             poa is  Installed][/usr/local/bin//poa]
msaprobs_pair        http://msaprobs.sourceforge.net/homepage.htm#latest        [pg:        msaprobs is NOT Installed][]
probcons_pair        http://probcons.stanford.edu/                              [pg:        probcons is  Installed][/usr/local/bin//probcons]
probconsRNA_pair     http://probcons.stanford.edu/                              [pg:     probconsRNA is  Installed][/usr/local/bin//probconsRNA]
muscle_pair          http://www.drive5.com/muscle/                              [pg:          muscle is  Installed][/usr/local/bin//muscle]
mus4_pair            http://www.drive5.com/muscle/                              [pg:            mus4 is NOT Installed][]
t_coffee_pair        http://www.tcoffee.org                                     [pg:        t_coffee is  Installed][/usr/local/bin//t_coffee]
pcma_pair            http://prodata.swmed.edu/pcma/pcma.php                     [pg:            pcma is NOT Installed][]
kalign_pair          http://msa.cgb.ki.se                                       [pg:          kalign is  Installed][/usr/local/bin//kalign]
amap_pair            http://bio.math.berkeley.edu/amap/                         [pg:            amap is NOT Installed][]
proda_pair           http://proda.stanford.edu                                  [pg:           proda is  Installed][/usr/local/bin//proda]
prank_pair           http://www.ebi.ac.uk/goldman-srv/prank/                    [pg:           prank is  Installed][/usr/local/bin//prank]
fsa_pair             http://fsa.sourceforge.net/                                [pg:             fsa is NOT Installed][]
consan_pair          http://selab.janelia.org/software/consan/                  [pg:           sfold is  Installed][/usr/local/bin//sfold]
famsa_pair           famsa                                                      [pg:           famsa is  Installed][/usr/local/bin//famsa]

****** Pairwise Structural Alignment Methods:
--------------------------------------------
align_pdbpair        built_in                                                   [pg:        t_coffee is  Installed][built_in]
lalign_pdbpair       built_in                                                   [pg:        t_coffee is  Installed][built_in]
extern_pdbpair       built_in                                                   [pg:        t_coffee is  Installed][built_in]
thread_pair          built_in                                                   [pg:        t_coffee is  Installed][built_in]
fugue_pair           http://mizuguchilab.org/fugue/                             [pg:        fugueali is NOT Installed][]
pdb_pair             built_in                                                   [pg:        t_coffee is  Installed][built_in]
sap_pair             https://mathbio.crick.ac.uk/wiki/Software#SAP              [pg:             sap is  Installed][/usr/local/bin//sap]
sara_pair            built_in                                                   [pg:        t_coffee is  Installed][built_in]
daliweb_pair         built_in                                                   [pg:     dalilite.pl is  Installed][built_in]
dali_pair            built_in                                                   [pg:     dalilite.pl is  Installed][built_in]
mustang_pair         http://lcb.infotech.monash.edu.au/mustang/                 [pg:         mustang is  Installed][/usr/local/bin//mustang]
TMalign_pair         http://zhanglab.ccmb.med.umich.edu/TM-align/TMalign.f      [pg:         TMalign is  Installed][/usr/local/bin//TMalign]

****** Multiple Sequence Alignment Methods:
--------------------------------------------
ktup_msa             built_in                                                   [pg:        t_coffee is  Installed][built_in]
blastp_msa           ftp://ftp.ncbi.nih.gov/blast/executables/LATEST            [pg: legacy_blast.pl is NOT Installed][]
old_clustalo_msa     http://www.clustal.org/omega/                              [pg:        clustalo is  Installed][/usr/local/bin//clustalo]
dynamic_msa          built_in                                                   [pg:        t_coffee is  Installed][built_in]
3dcoffee_msa         built_in                                                   [pg:        t_coffee is  Installed][built_in]
expresso_msa         built_in                                                   [pg:        t_coffee is  Installed][built_in]
accurate_msa         built_in                                                   [pg:        t_coffee is  Installed][built_in]
psicoffee_msa        built_in                                                   [pg:        t_coffee is  Installed][built_in]
famsa_msa            https://github.com/refresh-bio/FAMSA                       [pg:           famsa is  Installed][/usr/local/bin//famsa]
clustalo_msa         http://www.clustal.org/omega/                              [pg:        clustalo is  Installed][/usr/local/bin//clustalo]
mafft_msa            http://align.bmr.kyushu-u.ac.jp/mafft/online/server/       [pg:           mafft is  Installed][/usr/local/bin//mafft]
mafftginsi_msa       http://align.bmr.kyushu-u.ac.jp/mafft/online/server/       [pg:           mafft is  Installed][/usr/local/bin//mafft]
mafftfftns1_msa      http://align.bmr.kyushu-u.ac.jp/mafft/online/server/       [pg:           mafft is  Installed][/usr/local/bin//mafft]
mafftfftnsi_msa      http://align.bmr.kyushu-u.ac.jp/mafft/online/server/       [pg:           mafft is  Installed][/usr/local/bin//mafft]
mafftnwnsi_msa       http://align.bmr.kyushu-u.ac.jp/mafft/online/server/       [pg:           mafft is  Installed][/usr/local/bin//mafft]
mafftsparsecore_msa  http://align.bmr.kyushu-u.ac.jp/mafft/online/server/       [pg:           mafft is  Installed][/usr/local/bin//mafft]
mafftsparsecore_msa  http://align.bmr.kyushu-u.ac.jp/mafft/online/server/       [pg:           mafft is  Installed][/usr/local/bin//mafft]
mafftlinsi_msa       http://align.bmr.kyushu-u.ac.jp/mafft/online/server/       [pg:           mafft is  Installed][/usr/local/bin//mafft]
maffteinsi_msa       http://align.bmr.kyushu-u.ac.jp/mafft/online/server/       [pg:           mafft is  Installed][/usr/local/bin//mafft]
maffteinsi_pair      http://align.bmr.kyushu-u.ac.jp/mafft/online/server/       [pg:           mafft is  Installed][/usr/local/bin//mafft]
clustaloNF_msa       http://www.clustal.org/omega/                              [pg:        clustalo is  Installed][/usr/local/bin//clustalo]
clustalw2_msa        http://www.clustal.org                                     [pg:       clustalw2 is  Installed][/usr/local/bin//clustalw2]
clustalw_msa         http://www.clustal.org                                     [pg:        clustalw is  Installed][/usr/local/bin//clustalw]
uppNF_msa            http://www.cs.utexas.edu/users/phylo/software/upp/         [pg:             upp is NOT Installed][]
upp_msa              http://www.cs.utexas.edu/users/phylo/software/upp/         [pg:             upp is NOT Installed][]
msa_msa              https://www.ncbi.nlm.nih.gov/CBBresearch/Schaffer/msa.html [pg:             msa is NOT Installed][]
dca_msa              https://bibiserv2.cebitec.uni-bielefeld.de/dca             [pg:             dca is NOT Installed][]
dialigntx_msa        http://dialign-tx.gobics.de/                               [pg:      dialign-tx is  Installed][/usr/local/bin//dialign-tx]
dialignt_msa         http://dialign-tx.gobics.de/                               [pg:       dialign-t is NOT Installed][]
poa_msa              http://www.bioinformatics.ucla.edu/poa/                    [pg:             poa is  Installed][/usr/local/bin//poa]
msaprobs_msa         http://msaprobs.sourceforge.net/homepage.htm#latest        [pg:        msaprobs is NOT Installed][]
probcons_msa         http://probcons.stanford.edu/                              [pg:        probcons is  Installed][/usr/local/bin//probcons]
probconsRNA_msa      http://probcons.stanford.edu/                              [pg:     probconsRNA is  Installed][/usr/local/bin//probconsRNA]
muscle_msa           http://www.drive5.com/muscle/                              [pg:          muscle is  Installed][/usr/local/bin//muscle]
mus4_msa             http://www.drive5.com/muscle/                              [pg:            mus4 is NOT Installed][]
t_coffee_msa         http://www.tcoffee.org                                     [pg:        t_coffee is  Installed][/usr/local/bin//t_coffee]
pcma_msa             http://prodata.swmed.edu/pcma/pcma.php                     [pg:            pcma is NOT Installed][]
kalign_msa           http://msa.cgb.ki.se                                       [pg:          kalign is  Installed][/usr/local/bin//kalign]
amap_msa             http://bio.math.berkeley.edu/amap/                         [pg:            amap is NOT Installed][]
proda_msa            http://proda.stanford.edu                                  [pg:           proda is  Installed][/usr/local/bin//proda]
fsa_msa              http://fsa.sourceforge.net/                                [pg:             fsa is NOT Installed][]
tblastx_msa          ftp://ftp.ncbi.nih.gov/blast/executables/LATEST            [pg: legacy_blast.pl is NOT Installed][]
tblastpx_msa         ftp://ftp.ncbi.nih.gov/blast/executables/LATEST            [pg: legacy_blast.pl is NOT Installed][]
plib_msa             www.tcoffee.org                                            [pg:        t_coffee is  Installed][/usr/local/bin//t_coffee]
famsa_msa            famsa                                                      [pg:           famsa is  Installed][/usr/local/bin//famsa]

#######   Prediction Methods available to generate Templates
-------------------------------------------------------------
RNAplfold            http://www.tbi.univie.ac.at/RNA/                           [pg:       RNAplfold is  Installed][/usr/local/bin//RNAplfold]
HMMtop               www.enzim.hu/hmmtop/                                       [pg:          hmmtop is NOT Installed][]
GOR4                 http://mig.jouy.inra.fr/logiciels/gorIV/                   [pg:           gorIV is NOT Installed][]
wublast_client       built_in                                                   [pg:      wublast.pl is  Installed][built_in]
blastpgp_client      built_in                                                   [pg:     blastpgp.pl is  Installed][built_in]
local_ncbiblast      ftp://ftp.ncbi.nih.gov/blast/executables/LATEST            [pg: legacy_blast.pl is NOT Installed][]



All these Methods are supported by T-Coffee, but you HAVE to install them yourself [use the provided address]


These methods were selected because they are freeware opensource, easy to install and well supported
Contact us if you need an extra method to be added [cedric.notredame@gmail.com]
```


## Metadata
- **Skill**: generated
