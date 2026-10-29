# nf-core/sopa

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| nf-sopa_sopa_aggregate | PASS | synthetic data: sopa built-in toy dataset (400 cells); rebuilt table equals the toy table |
| nf-sopa_sopa_convert | Not completed | no small real raw spatial dataset (Xenium, MERSCOPE, CosMx) available; wsi reader also lacks tiffslide in the image |
| nf-sopa_sopa_report | PASS | synthetic data: sopa built-in toy dataset; HTML report lists 400 cells |
| nf-sopa_sopa_scanpy-preprocess | Failed | image problem: python igraph package missing, leiden clustering step raises ImportError |

## Metadata

- **Homepage:** https://nf-co.re/sopa/
- **GitHub:** https://github.com/nf-core/sopa
- **Total Downloads:** NA
- **Last updated:** 2026-03-20
- **GitHub Stars:** NA
