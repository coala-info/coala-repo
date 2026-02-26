---
name: rtax
description: The rtax tool facilitates the compilation of custom AsusWrt-based firmware for the RT-AX89U router by managing environment setup and toolchain configuration. Use when user asks to build custom router firmware, set up a cross-compilation environment for RT-AX89U, or link Qualcomm toolchains for AsusWrt development.
homepage: https://github.com/SWRT-dev/rtax89x
---


# rtax

## Overview

The rtax skill provides a specialized workflow for building custom AsusWrt-based firmware for the RT-AX89U router. It guides the user through setting up a compatible Ubuntu-based build environment, installing necessary cross-compilation dependencies, linking the required Qualcomm (QCA) toolchains, and executing the final build process. This is essential for developers looking to modify router functionality or integrate Softcenter components.

## Environment Setup

The build system is sensitive to the host environment. Use the following specifications for a successful compilation:

- **Recommended OS**: Ubuntu 18.04 LTS x64 or Linux Mint 19.1.
- **User Permissions**: Do **NOT** use the `root` user for cloning the repository or running the compilation process.
- **Shell Requirement**: The system shell must be set to Bash.
  ```bash
  chsh -s /bin/bash
  sudo ln -sf /bin/bash /bin/sh
  ```

### Required Dependencies

Install the following packages before attempting to build:

```bash
sudo apt-get update
sudo apt-get -y install build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev libz-dev patch python3.5 python2.7 unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex uglifyjs git-core gcc-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev autoconf automake libtool autopoint device-tree-compiler g++-multilib antlr3 gperf wget libncurses5:i386 libelf1:i386 lib32z1 lib32stdc++6 gtk-doc-tools intltool binutils-dev cmake lzma liblzma-dev lzma-dev uuid-dev liblzo2-dev xsltproc dos2unix libstdc++5 docbook-xsl-* sharutils autogen shtool gengetopt libltdl-dev libtool-bin
```

## Toolchain Configuration

The rtax89x project requires a specific QCA toolchain located in a standard system path.

1. Clone the toolchain repository:
   ```bash
   git clone https://github.com/SWRT-dev/qca-toolchains
   ```
2. Create the target directory and symlink the ARM compiler:
   ```bash
   cd qca-toolchains
   sudo mkdir -p /opt/toolchains/
   sudo ln -sf $(pwd)/openwrt-gcc463.arm /opt/toolchains/
   ```

## Compilation Workflow

Once the environment and toolchains are prepared, follow these steps to build the firmware:

1. **Clone the Source**:
   ```bash
   git clone https://github.com/SWRT-dev/rtax89x
   ```
2. **Navigate to the Build Directory**:
   ```bash
   cd rtax89x/release/src-qca-ipq806x
   ```
3. **Execute Build**:
   ```bash
   make rt-ax89u
   ```

The resulting firmware image will be located at:
`rtax89x/release/src-qca-ipq806x/image`

## Expert Tips

- **Network Connectivity**: If compiling from a region with restricted GitHub access, ensure a proxy is configured in your terminal environment, as the build process may fetch additional resources.
- **Clean Builds**: If you encounter unexpected errors after modifying source files, try running `make clean` before re-running the build command, though note this will significantly increase the next build time.
- **Version Tracking**: Check the `README.md` or commit history to identify the current base GPL version (e.g., 388.33812) to ensure compatibility with existing ASUS configurations.

## Reference documentation
- [rtax89x Main Repository](./references/github_com_SWRT-dev_rtax89x.md)