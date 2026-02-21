# artfastqgenerator CWL Generation Report

## artfastqgenerator

### Tool Description
ArtificialFastqGenerator generates artificial FASTQ files from a reference genome, simulating coverage biases and quality scores.

### Metadata
- **Docker Image**: biocontainers/artfastqgenerator:v0.0.20150519-3-deb_cv1
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/artfastqgenerator/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
ArtificialFastqGenerator v1.0.0 Copyright (C) 2012 The Institute of Cancer Research (ICR).

This Program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version.

Additional permissions under GNU GPL versions 3 section 7:

This Program is distributed as a service to the research community and is experimental in nature and may have hazardous properties. The Program is distributed WITHOUT ANY WARRANTY, express or implied. In particular all warranties as to SATISFACTORY QUALITY or FITNESS FOR A PARTICULAR PURPOSE are excluded. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program; if not, see <http://www.gnu.org/licenses>.

-------------------------------------------------------------
ArtificialFastqGenerator v1.0.0, <Matthew.Frampton@icr.ac.uk>
-------------------------------------------------------------
-------------------------------------------------------------

usage java -jar ArtificialFastqGenerator.jar -O <outputPath> -R <referenceGenomePath> -S <startSequenceIdentifier> -F1 <fastq1ForQualityScores> -F2 <fastq2ForQualityScores> -CMGCS <coverageMeanGCcontentSpread> -CMP <coverageMeanPeak> -CMPGC <coverageMeanPeakGCcontent> -CSD <coverageSD> -E <endSequenceIdentifier> -GCC <GCcontentBasedCoverage> -GCR <GCcontentRegionSize> -L <logRegionStats> -N <nucleobaseBufferSize> -OF <outputFormat> -RCNF <readsContainingNfilter> -RL <readLength> -SE <simulateErrorInRead> -TLM <templateLengthMean> -TLSD <templateLengthSD> -URQS <useRealQualityScores> -X <xStart> -Y <yStart> 

-h					Print usage help.
-O, <outputPath>			Path for the artificial fastq and log files, including their base name (must be specified).
-R, <referenceGenomePath>		Reference genome sequence file, (must be specified).
-S, <startSequenceIdentifier>		Prefix of the sequence identifier in the reference after which read generation should begin (must be specified).
-F1, <fastq1ForQualityScores>		First fastq file to use for real quality scores, (must be specified if useRealQualityScores = true).
-F2, <fastq2ForQualityScores>		Second fastq file to use for real quality scores, (must be specified if useRealQualityScores = true).
-CMGCS, <coverageMeanGCcontentSpread>	The spread of coverage mean given GC content (default = 0.22).
-CMP, <coverageMeanPeak>		The peak coverage mean for a region (default = 37.7).
-CMPGC, <coverageMeanPeakGCcontent>	The GC content for regions with peak coverage mean (default = 0.45).
-CSD, <coverageSD>			The coverage standard deviation divided by the mean (default = 0.2).
-E, <endSequenceIdentifier>		Prefix of the sequence identifier in the reference where read generation should stop, (default = end of file).
-GCC, <GCcontentBasedCoverage>		Whether nucleobase coverage is biased by GC content (default = true).
-GCR, <GCcontentRegionSize>		Region size in nucleobases for which to calculate GC content, (default = 150).
-L, <logRegionStats>			The region size as a multiple of -NBS for which summary coverage statistics are recorded (default = 2).
-N, <nucleobaseBufferSize>		The number of reference sequence nucleobases to buffer in memory, (default = 5000).
-OF, <outputFormat>			'default': standard fastq output; 'debug_nucleobases(_nuc|read_ids)': debugging.
-RCNF, <readsContainingNfilter>		Filter out no "N-containing" reads (0), "all-N" reads (1), "at-least-1-N" reads (2), (default = 0).
-RL, <readLength>			The length of each read, (default = 76).
-SE, <simulateErrorInRead>		Whether to simulate error in the read based on the quality scores, (default = false).
-TLM, <templateLengthMean>		The mean DNA template length, (default = 210).
-TLSD, <templateLengthSD>		The standard deviation of the DNA template length, (default = 60).
-URQS, <useRealQualityScores>		Whether to use real quality scores from existing fastq files or set all to the maximum, (default = false).
-X, <xStart>				The first read's X coordinate, (default = 1000).
-Y, <yStart>				The first read's Y coordinate, (default = 1000).

BUGS:
Any bugs should be reported to Matthew.Frampton@icr.ac.uk

USER ERROR:
The path for output files must be specified with the -O argument.
```


## Metadata
- **Skill**: generated

## artfastqgenerator

### Tool Description
ArtificialFastqGenerator generates artificial FASTQ files from a reference genome, simulating coverage biases and quality scores.

### Metadata
- **Docker Image**: biocontainers/artfastqgenerator:v0.0.20150519-3-deb_cv1
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
ArtificialFastqGenerator v1.0.0 Copyright (C) 2012 The Institute of Cancer Research (ICR).

This Program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version.

Additional permissions under GNU GPL versions 3 section 7:

This Program is distributed as a service to the research community and is experimental in nature and may have hazardous properties. The Program is distributed WITHOUT ANY WARRANTY, express or implied. In particular all warranties as to SATISFACTORY QUALITY or FITNESS FOR A PARTICULAR PURPOSE are excluded. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program; if not, see <http://www.gnu.org/licenses>.

-------------------------------------------------------------
ArtificialFastqGenerator v1.0.0, <Matthew.Frampton@icr.ac.uk>
-------------------------------------------------------------
-------------------------------------------------------------

usage java -jar ArtificialFastqGenerator.jar -O <outputPath> -R <referenceGenomePath> -S <startSequenceIdentifier> -F1 <fastq1ForQualityScores> -F2 <fastq2ForQualityScores> -CMGCS <coverageMeanGCcontentSpread> -CMP <coverageMeanPeak> -CMPGC <coverageMeanPeakGCcontent> -CSD <coverageSD> -E <endSequenceIdentifier> -GCC <GCcontentBasedCoverage> -GCR <GCcontentRegionSize> -L <logRegionStats> -N <nucleobaseBufferSize> -OF <outputFormat> -RCNF <readsContainingNfilter> -RL <readLength> -SE <simulateErrorInRead> -TLM <templateLengthMean> -TLSD <templateLengthSD> -URQS <useRealQualityScores> -X <xStart> -Y <yStart> 

-h					Print usage help.
-O, <outputPath>			Path for the artificial fastq and log files, including their base name (must be specified).
-R, <referenceGenomePath>		Reference genome sequence file, (must be specified).
-S, <startSequenceIdentifier>		Prefix of the sequence identifier in the reference after which read generation should begin (must be specified).
-F1, <fastq1ForQualityScores>		First fastq file to use for real quality scores, (must be specified if useRealQualityScores = true).
-F2, <fastq2ForQualityScores>		Second fastq file to use for real quality scores, (must be specified if useRealQualityScores = true).
-CMGCS, <coverageMeanGCcontentSpread>	The spread of coverage mean given GC content (default = 0.22).
-CMP, <coverageMeanPeak>		The peak coverage mean for a region (default = 37.7).
-CMPGC, <coverageMeanPeakGCcontent>	The GC content for regions with peak coverage mean (default = 0.45).
-CSD, <coverageSD>			The coverage standard deviation divided by the mean (default = 0.2).
-E, <endSequenceIdentifier>		Prefix of the sequence identifier in the reference where read generation should stop, (default = end of file).
-GCC, <GCcontentBasedCoverage>		Whether nucleobase coverage is biased by GC content (default = true).
-GCR, <GCcontentRegionSize>		Region size in nucleobases for which to calculate GC content, (default = 150).
-L, <logRegionStats>			The region size as a multiple of -NBS for which summary coverage statistics are recorded (default = 2).
-N, <nucleobaseBufferSize>		The number of reference sequence nucleobases to buffer in memory, (default = 5000).
-OF, <outputFormat>			'default': standard fastq output; 'debug_nucleobases(_nuc|read_ids)': debugging.
-RCNF, <readsContainingNfilter>		Filter out no "N-containing" reads (0), "all-N" reads (1), "at-least-1-N" reads (2), (default = 0).
-RL, <readLength>			The length of each read, (default = 76).
-SE, <simulateErrorInRead>		Whether to simulate error in the read based on the quality scores, (default = false).
-TLM, <templateLengthMean>		The mean DNA template length, (default = 210).
-TLSD, <templateLengthSD>		The standard deviation of the DNA template length, (default = 60).
-URQS, <useRealQualityScores>		Whether to use real quality scores from existing fastq files or set all to the maximum, (default = false).
-X, <xStart>				The first read's X coordinate, (default = 1000).
-Y, <yStart>				The first read's Y coordinate, (default = 1000).

BUGS:
Any bugs should be reported to Matthew.Frampton@icr.ac.uk

USER ERROR:
The path for output files must be specified with the -O argument.
```

