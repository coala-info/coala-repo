---
name: tvc
description: The TVC skill facilitates the process of getting Tron-based tokens recognized and listed on TRONSCAN's data statistics platform.
homepage: https://github.com/tronscan/tron-tvc-list
---

# tvc

## Overview
The TVC skill facilitates the process of getting Tron-based tokens recognized and listed on TRONSCAN's data statistics platform. This is a community-driven process managed via a public GitHub repository. The skill provides the exact JSON structure required for submissions and the workflow for contributing to the official token list.

## Token Submission Workflow
To list a token, you must interact with the `tronscan/tron-tvc-list` repository. The process follows standard GitHub contribution patterns:

1. **Fork the Repository**: Create a personal copy of `tronscan/tron-tvc-list`.
2. **Modify tokenlist.json**: Append your token information to the existing array in the `tokenlist.json` file.
3. **Submit a Pull Request**: Push your changes to your fork and open a PR against the `main` branch of the original repository.

## JSON Schema Requirements
Every entry in `tokenlist.json` must adhere to the following schema. Ensure all required fields are present to avoid PR rejection.

### Required Fields
- `address`: The smart contract address of the token.
- `symbol`: The ticker symbol (e.g., WIN, USDT).
- `name`: The full name of the token.
- `decimals`: The number of decimal places the token uses (usually 6 or 18).
- `logoURI`: A direct link to the token's logo image (typically hosted on a CDN or official site).
- `homepage`: The official website URL of the project.
- `existingMarkets`: An array of objects defining where the token is traded. Each object requires:
    - `source`: The exchange name (e.g., Binance, Poloniex).
    - `pairs`: A list of trading pairs (e.g., ["WIN/USDT", "WIN/BTC"]).

### Optional Fields
- `MarketCapLink`: The URL to the token's page on CoinMarketCap or CoinGecko.

## Best Practices and Tips
- **Preserve Existing Data**: Never remove or overwrite existing tokens in the `tokenlist.json` file. Always append your entry to the end of the list.
- **Validate JSON**: Before submitting, ensure your JSON syntax is valid. A single missing comma or bracket will break the list and cause CI/CD failures.
- **Logo Quality**: Use high-resolution square images for `logoURI` to ensure the token looks professional on the TRONSCAN UI.
- **Market Verification**: Only include "existingMarkets" that are verifiable. Listing fake or non-existent markets may lead to the PR being flagged or closed.

## Reference documentation
- [Main Repository and Instructions](./references/github_com_tronscan_tron-tvc-list.md)
- [Submission Pull Requests](./references/github_com_tronscan_tron-tvc-list_pulls.md)