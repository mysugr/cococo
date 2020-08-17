# ⚠️ This repository is deprecated

Since we use a different approach this script/repo is deprecated and will no longer be maintained.
I will outline our new approach here since it is probably useful to other people as well.

Instead of using SonarQube's generic code coverage format, we use the `llvm-cov` format which is directly supported. No conversion needed!

-  Merge all .profdata files into one
  - They are located here: `<derived_data>/Build/ProfileData/*/*.profdata`
  - Use: `xcrun llvm-profdata merge <paths to profdata> -output <merged_profdata_file>`
- Collect all relevant binaries to extract code coverage data
  - They are located here: `<derived_data>/Build/Products/Debug-iphonesimulator/`
  - Include the `*.app` binary (includes statically-linked frameworks)
  - Collect remaining dynamic framework binaries (You probably want to exclude external depdencies like pods)
- Iterate over relevant binaries and append code coverage data to a file
  - `xcrun --run llvm-cov show <binary_path> --instr-profile <merged_profdata_file> >> <output_file>`
- The file can then be passed to `sonar-scanner`
  - `sonar.cfamily.llvm-cov.reportPath` (for Obj-C code coverage)
  - `sonar.swift.coverage.reportPaths` (for Swift code coverage)

# cococo - **co**de **co**verage **co**nverter from Xcode 11 to SonarQube

[![mysugr](https://circleci.com/gh/mysugr/cococo.svg?style=svg)](https://circleci.com/gh/mySugr/cococo)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/mysugr/cococo)

cococo is a command line tool to convert Xcode 11's code coverage data to [SonarQube's generic code coverage format](https://docs.sonarqube.org/latest/analysis/generic-test/). It is written in Swift and makes use of multiple threads to speed up the computation. 

## Usage
```
USAGE: cococo <xcresult> [-e <excluded-file-extension1> ...]

OPTIONS:
  --excluded, -e   Multiple file extensions which are excluded from processing
  --help           Display available options
```

## Example
Run the tool for a given `xcresult` archive, exclude `.h` and `.m` files from processing and save the result to `sonarqube-generic-coverage.xml`.
```
cococo myproject.xcresult --excluded .h .m > sonarqube-generic-coverage.xml
```

The Xcode 11's `xcresult` archive can be found in the derived data folder:
```
DerivedData/YourProject/Logs/Test/*.xcresult
```

## Installation

You can download the latest release from [here](https://github.com/mysugr/cococo/releases/latest).
