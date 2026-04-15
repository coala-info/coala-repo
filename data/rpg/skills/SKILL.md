---
name: rpg
description: This tool is a framework for creating Jin Yong-style RPG games with extensive modding support. Use when user asks to develop, mod, or play games built with the 'rpg' framework, or when discussing its technical aspects, development plans, or community contributions.
homepage: https://github.com/jynew/jynew
metadata:
  docker_image: "biocontainers/rpg:v1.1.0_cv1"
---

# rpg

This skill provides guidance and best practices for using the 'rpg' tool, a framework for creating Jin Yong-like RPG games with extensive modding support.
  Use this skill when you need to understand how to develop, mod, or play games built with the 'rpg' framework, or when discussing its technical aspects, development plans, or community contributions.
body: |
  ## Overview

  The 'rpg' tool, specifically the `jynew/jynew` project, is a comprehensive open-source framework for developing Jin Yong-style martial arts RPGs. It's built with Unity and aims to be a platform for creating and sharing mods, inspired by the classic "The Deer and the Cauldron" (金庸群侠传). The framework supports a wide range of game development features, from core game mechanics to asset management and modding capabilities.

  ## Core Functionality and Usage

  The `rpg` framework is primarily a game development engine and toolkit. Its usage revolves around game creation, modification, and understanding its technical architecture.

  ### Game Development and Modding

  *   **Framework Overview**: The `jynew/jynew` project provides a robust foundation for building single-player RPGs with a focus on martial arts and Wuxia themes. It includes systems for character development, combat, item management, and narrative scripting.
  *   **Modding Support**: A key feature is its extensive modding support, allowing users to create and share their own game content, scenarios, and even entirely new games based on the framework. This is facilitated through various editors and scripting capabilities.
  *   **Sample Mods**: The project includes several sample mods that demonstrate its capabilities:
      *   **渡城残魂传 (Soul of the City's Remnant)**: A main story-driven experience with multiple endings, companions, and a variety of martial arts.
      *   **无限肉鸽武侠 (Infinite Roguelike Wuxia)**: A roguelike combat demo focused on building teams and facing increasingly difficult challenges.
      *   **金庸群侠传3D重制版 (Jin Yong Wuxia 3D Remastered)**: A turn-based strategy combat, open-world RPG aiming to remake the classic Jin Yong game with modding support.

  ### Technical Aspects and Development

  *   **Engine**: Built using the Unity engine.
  *   **Scripting**: Supports Lua scripting and visual scripting (Blueprints) for game events and logic.
  *   **Configuration**: Utilizes a configuration table mechanism for game data, with a visual editing environment for data management.
  *   **Asset Management**: Includes tools for managing character models, animations, skills, effects, and scenes.
  *   **Development Tools**: Provides in-editor tools such as a Skill Editor, Console, Save Generator, Combat Debugger, and more.
  *   **Cross-Platform**: Aims for multi-platform support (PC, Mac, Mobile).

  ### Community and Contribution

  *   **Open Source**: The project is open-source, encouraging community contributions.
  *   **Contribution Guidelines**: Detailed guidelines are available for those wishing to contribute to the project's development.
  *   **Community Forums and Groups**: Active community forums and QQ groups exist for discussion, support, and collaboration.

  ## Expert Tips and Best Practices

  *   **Refer to the Wiki**: For detailed technical information, development guides, and tutorials, the project's GitHub Wiki is the primary resource. Pay close attention to the "通用篇" (General Section), "游戏内工具篇" (In-Game Tools Section), and "程序篇" (Programming Section) for core concepts.
  *   **Understand the Scripting**: Familiarize yourself with both Lua scripting and the visual scripting (Blueprints) if you plan to create or modify game logic. The documentation on "游戏事件脚本" (Game Event Script) is crucial.
  *   **Utilize In-Game Editors**: Leverage the provided editors (Skill Editor, Console, etc.) for efficient game development and debugging.
  *   **Check the License**: Be mindful of the project's licensing, particularly the "金庸群侠传3D重制版社区素材协议" (Jin Yong Wuxia 3D Remastered Community Asset License), which may have specific terms beyond the MIT license for certain assets.
  *   **Engage with the Community**: For specific questions, troubleshooting, or to share your work, the community forums and groups are invaluable resources.

## Reference documentation
- [jynew/jynew.md](./references/github_com_jynew_jynew.md)
- [jynew/jynew_wiki.md](./references/github_com_jynew_jynew_wiki.md)