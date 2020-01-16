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
