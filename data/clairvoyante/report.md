# clairvoyante CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| clairvoyante_ExtractVariantCandidates.py | Failed | image problem: samtools is not in the image, so the script fails when it runs samtools faidx (and clairvoyante.py cannot import dataPrepScripts at all). |
| clairvoyante_callVar.py | PASS |  |

## Metadata
- **Skill**: generated

## clairvoyante_ExtractVariantCandidates.py

### Tool Description
Generate variant candidates using alignments (run as python dataPrepScripts/ExtractVariantCandidates.py, because clairvoyante.py cannot import the dataPrepScripts submodules).

### Metadata
- **Docker Image**: quay.io/biocontainers/clairvoyante:1.02--0
- **Homepage**: https://github.com/aquaskyline/Clairvoyante
- **Package**: https://anaconda.org/channels/bioconda/packages/clairvoyante/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ExtractVariantCandidates.py [-h] [--bam_fn BAM_FN] [--ref_fn REF_FN]
                                   [--bed_fn BED_FN] [--can_fn CAN_FN]
                                   [--threshold THRESHOLD]
                                   [--minCoverage MINCOVERAGE] [--minMQ MINMQ]
                                   [--gen4Training [GEN4TRAINING]]
                                   [--candidates CANDIDATES]
                                   [--genomeSize GENOMESIZE]
                                   [--ctgName CTGNAME] [--ctgStart CTGSTART]
                                   [--ctgEnd CTGEND] [--samtools SAMTOOLS]

Generate variant candidates using alignments

optional arguments:
  -h, --help            show this help message and exit
  --bam_fn BAM_FN       Sorted bam file input, default: input.bam
  --ref_fn REF_FN       Reference fasta file input, default: ref.fa
  --bed_fn BED_FN       Call variant only in these regions, works in
                        intersection with ctgName, ctgStart and ctgEnd,
                        optional, default: as defined by ctgName, ctgStart and
                        ctgEnd
  --can_fn CAN_FN       Pile-up count output, use PIPE for standard output,
                        default: PIPE
  --threshold THRESHOLD
                        Minimum allele frequence of the 1st non-reference
                        allele for a site to be considered as a condidate
                        site, default: 0.125000
  --minCoverage MINCOVERAGE
                        Minimum coverage required to call a variant, default:
                        4.000000
  --minMQ MINMQ         Minimum Mapping Quality. Mapping quality lower than
                        the setting will be filtered, default: 0
  --gen4Training [GEN4TRAINING]
                        Output all genome positions as candidate for model
                        training (Set --threshold to 0, --minCoverage to 0),
                        default: False
  --candidates CANDIDATES
                        Use with gen4Training, number of variant candidates to
                        be generated, default: 7000000
  --genomeSize GENOMESIZE
                        Use with gen4Training, default: 3000000000
  --ctgName CTGNAME     The name of sequence to be processed, default: chr17
  --ctgStart CTGSTART   The 1-bsae starting position of the sequence to be
                        processed
  --ctgEnd CTGEND       The inclusive ending position of the sequence to be
                        processed
  --samtools SAMTOOLS   Path to the 'samtools', default: samtools
```


## clairvoyante_callVar.py

### Tool Description
Call variants using a trained Clairvoyante model and tensors of candididate variants

### Metadata
- **Docker Image**: quay.io/biocontainers/clairvoyante:1.02--0
- **Homepage**: https://github.com/aquaskyline/Clairvoyante
- **Package**: https://anaconda.org/channels/bioconda/packages/clairvoyante/overview
- **Validation**: PASS

### Original Help Text
```text
usage: callVar.py [-h] [--tensor_fn TENSOR_FN] [--chkpnt_fn CHKPNT_FN]
                  [--call_fn CALL_FN] [--qual QUAL] [--sampleName SAMPLENAME]
                  [--showRef [SHOWREF]] [--ref_fn REF_FN] [--threads THREADS]
                  [--v3 [V3]] [--v2 [V2]] [--slim [SLIM]]

Call variants using a trained Clairvoyante model and tensors of candididate
variants

optional arguments:
  -h, --help            show this help message and exit
  --tensor_fn TENSOR_FN
                        Tensor input, use PIPE for standard input
  --chkpnt_fn CHKPNT_FN
                        Input a checkpoint for testing or continue training
  --call_fn CALL_FN     Output variant predictions
  --qual QUAL           If set, variant with equal or higher quality will be
                        marked PASS, or LowQual otherwise, optional
  --sampleName SAMPLENAME
                        Define the sample name to be shown in the VCF file
  --showRef [SHOWREF]   Show reference calls, optional
  --ref_fn REF_FN       Reference fasta file input, optional, print contig
                        tags in the VCF header if set
  --threads THREADS     Number of threads, optional
  --v3 [V3]             Use Clairvoyante version 3
  --v2 [V2]             Use Clairvoyante version 2
  --slim [SLIM]         Train using the slim version of Clairvoyante, optional
```


