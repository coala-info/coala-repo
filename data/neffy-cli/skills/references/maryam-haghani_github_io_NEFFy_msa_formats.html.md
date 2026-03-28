NEFFy

NEFF Calculator and MSA File Converter

[Edit on GitHub](https://github.com/Maryam-Haghani/Neffy)

Loading...

Searching...

No Matches

MSA Formats

## Table of Contents

* [A2M](#a2m)
* [A3M](#a3m)
* [Fasta](#fasta)
* [STO](#sto)
* [ALN](#aln)
* [CLUSTAL](#clustal)
* [PFAM](#pfam)

## A2M

Each sequence is represented by two lines:

* The first line starts with > followed by the sequence identifier and some other remarks.
* The second line contains the aligned residues; Alignments are shown with:
  + Inserts as lower case characters,
  + Matches as upper case characters,
  + Deletions as ' - ', and
  + Gaps aligned to inserts as ' . '

**Example**

>T1152

MY...TVKPGDT......MWKIAV...K..YQI...GI.....SEIIAANPQIKNPNLIYPGQKINIPNILEHHHHHH

>MTBAKSStandDraft\_2\_1061841.scaffolds.fasta\_scaffold367497\_1

TY...D-KDGYR......HYRTRV...Y..YTL...RR.....NEDNALIA-REVFSQVYKKEAL-CPIA--------

>ETNvirnome\_2\_130\_1030620.scaffolds.fasta\_scaffold104244\_1

G-...EREKGR-......--HSKS...R..QEK...GF.....KEKK---P-TKKPSATNKPVNTAKPAA--------

>tr|A0A235B7N0|A0A235B7N0\_9BACL Uncharacterized protein OS=Paludifilum halophilum OX=1642702

EAsavDRITSDSilenfvQWIFSE...E..KEVeekHT.....EESVQPTPAVKHSPDSSGSSKSSSSD---------

>tr|A0A1E5LFN5|A0A1E5LFN5\_9BACI Uncharacterized protein OS=Bacillus solimangrovi OX=1305675

SA...KVKRGRT......FIPLRSateSfgYDV...IWkenenAVYLKSNPTIKPKDSTQ------------------

---

## A3M

It is almost like A2M format. The only difference is that Gaps aligned to inserts ('.') can be excluded, and one could view the A3M format as a more method method for representing an MSA compared to FASTA or A2M.

**Example**

>T1152

MYTVKPGDTMWKIAVKYQIGISEIIAANPQIKNPNLIYPGQKINIPNILEHHHHHH

>MTBAKSStandDraft\_2\_1061841.scaffolds.fasta\_scaffold367497\_1

TYD-KDGYRHYRTRVYYTLRRNEDNALIA-REVFSQVYKKEAL-CPIA--------

>ETNvirnome\_2\_130\_1030620.scaffolds.fasta\_scaffold104244\_1

G-EREKGR---HSKSRQEKGFKEKK---P-TKKPSATNKPVNTAKPAA--------

>tr|A0A235B7N0|A0A235B7N0\_9BACL Uncharacterized protein OS=Paludifilum halophilum OX=1642702

EAsavDRITSDSilenfvQWIFSEEKEVeekHTEESVQPTPAVKHSPDSSGSSKSSSSD---------

>tr|A0A1E5LFN5|A0A1E5LFN5\_9BACI Uncharacterized protein OS=Bacillus solimangrovi OX=1305675

SAKVKRGRTFIPLRSateSfgYDVIWkenenAVYLKSNPTIKPKDSTQ------------------

---

## Fasta

Sequences are separated by '>'. The remaining lines before next '>' contain the aligned sequence, which:

* lower and upper case are equivalent;
* ' . ' and ' - ' are equivalent. Aligned => Sequences have the same length.

**Example**

>T1152

MY---TVKPGDT------MWKIAV---K--YQI---GI-----SEIIAANPQIKNPNLIYPGQKINIPNILEHHHHHH

>MTBAKSStandDraft\_2\_1061841.scaffolds.fasta\_scaffold367497\_1

TY---D-KDGYR------HYRTRV---Y--YTL---RR-----NEDNALIA-REVFSQVYKKEAL-CPIA--------

>ETNvirnome\_2\_130\_1030620.scaffolds.fasta\_scaffold104244\_1

G----EREKGR---------HSKS---R--QEK---GF-----KEKK---P-TKKPSATNKPVNTAKPAA--------

>tr|A0A235B7N0|A0A235B7N0\_9BACL Uncharacterized protein OS=Paludifilum halophilum OX=1642702

EASAVDRITSDSILENFVQWIFSE---E--KEVEEKHT-----EESVQPTPAVKHSPDSSGSSKSSSSD---------

>tr|A0A1E5LFN5|A0A1E5LFN5\_9BACI Uncharacterized protein OS=Bacillus solimangrovi OX=1305675

SA---KVKRGRT------FIPLRSATESFGYDV---IWKENENAVYLKSNPTIKPKDSTQ------------------

---

## STO (Stockholm)

It consists of:

* A header line containing format and version information.
* Mark-up lines that start with "#=GF," "#=GC," "#=GS," or "#=GR."
* Alignment lines featuring the sequence name and its corresponding aligned sequence. Within these lines:
  + Inserts are represented as lowercase characters,
  + Matches are indicated by uppercase characters, and
  + Gaps are denoted by either ' . ' or ' - '.

Additionally, the "//" line indicates the end of the alignment. Sequences in this format are divided into segments of 200 characters.

**Example**

# STOCKHOLM 1.0

#=GF ID T1152

#=GS T1152

#=GS MTBAKSStandDraft\_2\_1061841.scaffolds.fasta\_scaffold367497\_1

#=GS ETNvirnome\_2\_130\_1030620.scaffolds.fasta\_scaffold104244\_1

#=GS tr|A0A235B7N0|A0A235B7N0\_9BACL Uncharacterized protein OS=Paludifilum halophilum OX=1642702

#=GS tr|A0A1E5LFN5|A0A1E5LFN5\_9BACI Uncharacterized protein OS=Bacillus solimangrovi OX=1305675

T1152 MY---TVKPGDT------MWKIAV---K--YQI---GI-----SEIIAANPQIKNPNLIYPGQKINIPNILEHHHHHH

MTBAKSStandDraft\_2\_1061841.scaffolds.fasta\_scaffold367497\_1 TY---D-KDGYR------HYRTRV---Y--YTL---RR-----NEDNALIA-REVFSQVYKKEAL-CPIA--------

ETNvirnome\_2\_130\_1030620.scaffolds.fasta\_scaffold104244\_1 G----EREKGR---------HSKS---R--QEK---GF-----KEKK---P-TKKPSATNKPVNTAKPAA--------

tr|A0A235B7N0|A0A235B7N0\_9BACL EASAVDRITSDSILENFVQWIFSE---E--KEVEEKHT-----EESVQPTPAVKHSPDSSGSSKSSSSD---------

tr|A0A1E5LFN5|A0A1E5LFN5\_9BACI SA---KVKRGRT------FIPLRSATESFGYDV---IWKENENAVYLKSNPTIKPKDSTQ------------------

//

---

## ALN

It only consists of aligned sequences, each on a separate line, and the initial sequence is gap-free.

**Example**

MYTVKPGDTMWKIAVKYQIGISEIIAANPQIKNPNLIYPGQKINIPNILEHHHHHH

TYD-KDGYRHYRTRVYYTLRRNEDNALIA-REVFSQVYKKEAL-CPIA--------

G-EREKGR---HSKSRQEKGFKEKK---P-TKKPSATNKPVNTAKPAA--------

EADRITSDSQWIFSEEKEVHTEESVQPTPAVKHSPDSSGSSKSSSSD---------

SAKVKRGRTFIPLRSSYDVIWAVYLKSNPTIKPKDSTQ------------------

---

## CLUSTAL

Clustal is commonly associated with the Clustal series of programs for sequence alignment. The Clustal MSA format typically begins with a header line that provides information about the alignment.

Following the header, Clustal format represents each sequence as a pair of columns in a line.

* The first column contains the sequence name or identifier,
* The second column contains the aligned sequence, which:
  + Gaps are shown as '-'
  + Matches are shown as uppercase letters.

Sequences in this format are divided into segments of 60 characters.

**Example**

Generated CLUSTAL format

T1152 MY---TVKPGDT------MWKIAV---K--YQI---GI-----SEIIAANPQIKNPNLIY

MTBAKSStandDraft\_2\_1061841.scaffolds.fasta\_scaffold367497\_1 TY---D-KDGYR------HYRTRV---Y--YTL---RR-----NEDNALIA-REVFSQVY

ETNvirnome\_2\_130\_1030620.scaffolds.fasta\_scaffold104244\_1 G----EREKGR---------HSKS---R--QEK---GF-----KEKK---P-TKKPSATN

tr|A0A235B7N0|A0A235B7N0\_9BACL EASAVDRITSDSILENFVQWIFSE---E--KEVEEKHT-----EESVQPTPAVKHSPDSS

tr|A0A1E5LFN5|A0A1E5LFN5\_9BACI SA---KVKRGRT------FIPLRSATESFGYDV---IWKENENAVYLKSNPTIKPKDSTQ

T1152 PGQKINIPNILEHHHHHH

MTBAKSStandDraft\_2\_1061841.scaffolds.fasta\_scaffold367497\_1 KKEAL-CPIA--------

ETNvirnome\_2\_130\_1030620.scaffolds.fasta\_scaffold104244\_1 KPVNTAKPAA--------

tr|A0A235B7N0|A0A235B7N0\_9BACL GSSKSSSSD---------

tr|A0A1E5LFN5|A0A1E5LFN5\_9BACI ------------------

---

## PFAM

It's similar to Clustal in the sense that it separates sequence identifiers and sequences with a tab, but unlike Clustal, the sequences are not uniformly indented. Additionally, it doesn't split sequences into 60-character segments, as Clustal does. Also, it does not contain header line.

**Example**

T1152 MY---TVKPGDT------MWKIAV---K--YQI---GI-----SEIIAANPQIKNPNLIYPGQKINIPNILEHHHHHH

MTBAKSStandDraft\_2\_1061841.scaffolds.fasta\_scaffold367497\_1 TY---D-KDGYR------HYRTRV---Y--YTL---RR-----NEDNALIA-REVFSQVYKKEAL-CPIA--------

ETNvirnome\_2\_130\_1030620.scaffolds.fasta\_scaffold104244\_1 G----EREKGR---------HSKS---R--QEK---GF-----KEKK---P-TKKPSATNKPVNTAKPAA--------

tr|A0A235B7N0|A0A235B7N0\_9BACL EASAVDRITSDSILENFVQWIFSE---E--KEVEEKHT-----EESVQPTPAVKHSPDSSGSSKSSSSD---------

tr|A0A1E5LFN5|A0A1E5LFN5\_9BACI SA---KVKRGRT------FIPLRSATESFGYDV---IWKENENAVYLKSNPTIKPKDSTQ------------------

---

For further assistance or inquiries, please contact the developer or create an [issue](https://github.com/Maryam-Haghani/Neffy/issues) in the GitHub repository.

Footer

---

Generated by [![doxygen](doxygen.svg)](https://www.doxygen.org/index.html) 1.11.0

© Copyright 2024, Maryam Haghani