# Chocolatey Testing Sandbox Environment

A testing environment setup similar to the [package-verifier](https://github.com/chocolatey/package-verifier/wiki) for testing packages, based on [chocolatey-test-environment](https://github.com/chocolatey-community/chocolatey-test-environment). Instead of relying on virtual machines and configure them through _Vagrant_, it uses the built-in "Windows Sandbox" (available from Windows 19H1 / build 18305 onwards).

When creating packages or testing other parts of Chocolatey, this environment provides a good base for an independent testing minus any dependencies you may already have installed. It also allows you to completely destroy an environment and then just tear it down without worry about messing up something on your own system.

When creating packages, please review https://github.com/chocolatey/choco/wiki/CreatePackages

## Requirements

You need a computer with:

- Windows 10 Pro or Enterprise Insider build 18305 or later
- AMD64 architecture
- Virtualization capabilities enabled in BIOS
- At least 4GB of RAM (8GB recommended)
- At least 1 GB of free disk space (SSD recommended)
- At least 2 CPU cores (4 cores with hyperthreading recommended)

## Setup

To get started, ensure you have installed "Windows Sandbox":

> Open Windows Features, and then select Windows Sandbox. Select OK to install Windows Sandbox. You might be asked to restart the computer.

## Running Verification Manually

**NOTE**: The CDN for packages on https://chocolatey.org will only update every 30 minutes. This means if you just pushed an updated version, within 30 minutes from the last access time of the package it will be updated. This is why the validator and verifier wait for 31 minutes prior to testing a package.

### Preparing the Testing Environment

1. Ensure setup above is good on your machine.
2. Fork and Clone this repository
3. Navigate to the root folder of the repository in your file manager of choice
4. Double-click `Chocolatey Test Sandbox.wsb` to start the custom environment.

Within a few seconds, _Windows Sandbox_ should start and configure itself using `cmd` and `powershell`. Without further configuration, no package should be tested; the final exit code should be `0`.

### Testing a Package

For testing a package, you have two avenues. For a locally built package, you can drop the package into the `packages` folder in the root of the cloned repository - it is shared with the box as `C:\Users\WDAGUtilityAccount\Desktop\chocolatey-test-sandbox\packages`, so you can run a command on the box or with the inline provisioner (recommended as it is a closer match to the verifier) using `--source c:\Users\WDAGUtilityAccount\Desktop\chocolatey-test-sandbox\packages` as an argument for installation. If you are trying to reproduce/investigate a problem with a package already up on the website, you can use `--version number` with your install arguments and that will let you install a package that is not listed (in most cases not yet approved).

1. Search the `Run-PackageTest.ps1` for `# THIS IS WHAT YOU CHANGE`. Uncomment and edit the line which best meets the current situation that you are testing.
2. (Re)start the sandbox or re-run `choco-test.bat` inside the running sandbox environment.
3. Watch the output and go to the box for further inspection if necessary.
4. If you need to change output or try something else, restart the process.

### Make Changes and Retest

When you need to investigate making changes and rerunning the tests, you may close the sandboxed environment to remove all changes. Note that upon the next start, the box needs to run all setup tasks again. Currently, it is not possible to create and roll back to a snapshot after installing prerequisites.

## Differences Between This and Package Verifier Service

There are a couple of difference between the [verifier service]() and this environment.

- The verifier is run without the GUI - meaning it is run in a headless state. There is no box to interact with.
- The verifier only runs against Windows 2012 R2 currently. This repo uses your version of _Windows 10_.
- The verifier times out on waiting for a command after 12 minutes.
- Synced folders are different - the verifier syncs the .chocolatey folder to gather the package information files.
- **There might be additional differences.**

## Troubleshooting

Note that this is a proof-of-concept as of now and results may differ from the official [verifier service]() and / or the [chocolatey-test-environment](https://github.com/chocolatey-community/chocolatey-test-environment). _Windows Sandbox_ is not the most stable and reliable way to test packages, e.g. there have been some instances wherein running `powershell` was not possible after installing a certain update on the host.
