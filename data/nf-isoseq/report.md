# nf-core/isoseq

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| isoseq_bcstats | PASS | synthetic data: planted barcodes on real reads; counts match planted counts |
| isoseq_cluster | PASS |  |
| isoseq_cluster2 | PASS |  |
| isoseq_collapse | PASS |  |
| isoseq_correct | PASS | synthetic data: planted barcodes on real reads; corrected barcode equals planted barcode for all reads |
| isoseq_dedup | Not completed | runs to success on real Iso-Seq reads with planted barcodes, but no duplicates were present, so all 44 reads were kept and the deduplication cannot be confirmed. |
| isoseq_groupdedup | Not completed | runs to success on real Iso-Seq reads with planted barcodes, but no duplicates were present, so all 44 reads were kept and the deduplication cannot be confirmed. |
| isoseq_refine | PASS |  |
| isoseq_summarize | PASS |  |
| isoseq_tag | PASS | synthetic data: UMI and barcode bases planted on real Iso-Seq reads; all tags recovered exactly |

## Metadata

- **Homepage:** https://nf-co.re/isoseq/
- **GitHub:** https://github.com/nf-core/isoseq
- **Total Downloads:** NA
- **Last updated:** 2024-09-05
- **GitHub Stars:** NA
