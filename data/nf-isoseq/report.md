# nf-core/isoseq

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| nf-isoseq_isoseq_bcstats | PASS | synthetic data: planted barcodes on real reads; counts match planted counts |
| nf-isoseq_isoseq_cluster | PASS |  |
| nf-isoseq_isoseq_cluster2 | PASS |  |
| nf-isoseq_isoseq_collapse | PASS |  |
| nf-isoseq_isoseq_correct | PASS | synthetic data: planted barcodes on real reads; corrected barcode equals planted barcode for all reads |
| nf-isoseq_isoseq_dedup | Not completed | runs to success on real Iso-Seq reads with planted barcodes, but no duplicates were present, so all 44 reads were kept and the deduplication cannot be confirmed. |
| nf-isoseq_isoseq_groupdedup | Not completed | runs to success on real Iso-Seq reads with planted barcodes, but no duplicates were present, so all 44 reads were kept and the deduplication cannot be confirmed. |
| nf-isoseq_isoseq_refine | PASS |  |
| nf-isoseq_isoseq_summarize | PASS |  |
| nf-isoseq_isoseq_tag | PASS | synthetic data: UMI and barcode bases planted on real Iso-Seq reads; all tags recovered exactly |

## Metadata

- **Homepage:** https://nf-co.re/isoseq/
- **GitHub:** https://github.com/nf-core/isoseq
- **Total Downloads:** NA
- **Last updated:** 2024-09-05
- **GitHub Stars:** NA
