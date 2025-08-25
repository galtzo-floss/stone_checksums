# Changelog

[![SemVer 2.0.0][📌semver-img]][📌semver] [![Keep-A-Changelog 1.0.0][📗keep-changelog-img]][📗keep-changelog]

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog][📗keep-changelog],
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html),
and [yes][📌major-versions-not-sacred], platform and engine support are part of the [public API][📌semver-breaking].
Please file a bug if you notice a violation of semantic versioning.

[📌semver]: https://semver.org/spec/v2.0.0.html
[📌semver-img]: https://img.shields.io/badge/semver-2.0.0-FFDD67.svg?style=flat
[📌semver-breaking]: https://github.com/semver/semver/issues/716#issuecomment-869336139
[📌major-versions-not-sacred]: https://tom.preston-werner.com/2022/05/23/major-version-numbers-are-not-sacred.html
[📗keep-changelog]: https://keepachangelog.com/en/1.0.0/
[📗keep-changelog-img]: https://img.shields.io/badge/keep--a--changelog-1.0.0-FFDD67.svg?style=flat

## [Unreleased]
### Added
### Changed
### Deprecated
### Removed
### Fixed
### Security

## [1.0.1] - 2025-08-24
- TAG: [v1.0.1][1.0.1t]
- COVERAGE:  98.80% -- 82/83 lines in 5 files
- BRANCH COVERAGE:  96.67% -- 29/30 branches in 5 files
- 38.46% documented
### Fixed
- Support for bundler >= v2.7, which no longer relies on SOURCE_DATE_EPOCH
  - NOTE: Bundler v2.7+ defaults to a constant build date in 1980 to make all builds reproducible.
### Documentation
- Updated README with checksum usage, Bundler version guidance, and env vars.
- Added YARD docstrings for public APIs.
- Expanded RBS signatures for public constants and methods.

## [1.0.0] - 2025-02-23
- TAG: [v1.0.0][1.0.0t]
- COVERAGE:  98.67% -- 74/75 lines in 5 files
- BRANCH COVERAGE:  79.17% -- 19/24 branches in 5 files
- 38.46% documented
### Added
- Initial release

[Unreleased]: https://gitlab.com/galtzo-floss/stone_checksums/-/compare/v1.0.0...HEAD
[1.0.1]: https://gitlab.com/galtzo-floss/stone_checksums/-/compare/v1.0.0...v1.0.1
[1.0.1t]: https://gitlab.com/galtzo-floss/stone_checksums/-/tags/v1.0.1
[1.0.0]: https://gitlab.com/galtzo-floss/stone_checksums/-/compare/1fd75630d9d3c4a1ef8fed384fda98755ae01d5e...v1.0.0
[1.0.0t]: https://gitlab.com/galtzo-floss/stone_checksums/-/tags/v1.0.0
