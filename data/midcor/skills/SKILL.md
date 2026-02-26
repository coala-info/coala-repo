---
name: midcor
description: Midcore manages a limited lives mechanic and customizable difficulty settings for Minecraft players. Use when user asks to set starting life counts, link maximum health to remaining lives, configure totem failure chances, or apply difficulty presets like OneHearted and UltraSurvival.
homepage: https://github.com/Sainne/sainne-midcore
---


# midcor

## Overview
Midcore is a specialized Minecraft datapack designed to create a difficulty level between standard Survival and Hardcore modes. It introduces a "limited lives" mechanic where players start with a set number of lives (defaulting to 10). The skill allows for the fine-tuning of death penalties, including the ability to link a player's maximum health directly to their remaining life count and modifying Totem of Undying behavior to include failure chances or void protection.

## Midcore Management and Configuration

### Core Mechanics
When configuring the datapack, focus on these four primary variables:
- **Limited Lives**: Set the starting life pool (typically 1-50).
- **Max HP Sync**: Determine if maximum health should decrease as lives are lost.
- **Totem Failure Chance**: Set a percentage (0-100) for totems to fail. A value of 0 is vanilla behavior; 100+ makes totems non-functional.
- **Totem Void Saving**: Enable or disable the ability for totems to rescue players from the void.

### Recommended Gamerule Pairings
To achieve the intended "Midcore" experience, use the following native Minecraft CLI commands alongside the datapack:
- **For balanced play**: `/gamerule keepInventory true` (Recommended to offset the high stakes of limited lives).
- **For high difficulty**: `/gamerule naturalRegeneration false` (Forces reliance on totems and healing items).

### Scenario Presets
Apply these configurations to quickly set up specific gameplay environments:

| Scenario | Lives | HP Sync | Natural Regen |
| :--- | :--- | :--- | :--- |
| **3 strikes... You're out!** | 3 | False | Enabled |
| **OneHearted** | 1 | True | Enabled |
| **I'm the danger!** | 30 | True | Enabled |
| **That's just UHC** | 1 | False | Disabled |
| **UltraSurvival** | 10 | True | Disabled |

### Best Practices
- **New Player Initialization**: Ensure the datapack is active when new players join, as it triggers an initialization function to grant starting lives and sync attributes.
- **Totem Dependency**: If `naturalRegeneration` is disabled, prioritize obtaining Totems of Undying, as they are the primary defense against permanent life loss.
- **In-Game Configuration**: Access the internal configuration via the datapack's function system (e.g., searching for the `config` function within the `sainne.midcore` namespace) to adjust values without restarting the server.

## Reference documentation
- [Sainne's Midcore README](./references/github_com_Sainne_sainne-midcore.md)