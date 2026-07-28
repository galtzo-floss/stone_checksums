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

- Documentation linting now has its generated `yard-lint` dependency and severity config available in the local bundle.

- kettle-jem-template-20260726-001 - Projects now include YARD lint
  configuration and documentation dependencies so documentation issues fail
  before generated docs are refreshed.

- kettle-jem-template-20260727-001 - Spec harness documentation now lists the
  RSpec helpers provided by `kettle-test`.

### Changed

- kettle-jem-template-20260728-001 - Generated Ruby workflows now use clearer
  setup-ruby-flash planning and can prepare appraisal-only jobs without
  installing the main Gemfile bundle.

### Deprecated

### Removed

### Fixed

- kettle-jem-template-20260726-002 - Generated version files now document their
  version namespace and constants, reducing warning-only YARD lint output.

- kettle-jem-template-20260726-003 - Coverage upload steps now treat Coveralls,
  QLTY, and Codecov as optional, so provider outages do not fail CI when local
  coverage thresholds still pass.
- kettle-jem-template-20260728-002 - Generated RuboCop configs now ignore the
  same `gemfiles/vendor/bundle` tree as `.gitignore`, so vendored dependency
  installs are not reported as project lint debt.
- kettle-jem-template-20260728-003 - Generated dep-heads workflows now run
  TruffleRuby jobs with current RubyGems and Bundler, avoiding setup failures
  before the test suite starts.

### Security

## [1.0.7] - 2026-07-25

- TAG: [v1.0.7][1.0.7t]
- COVERAGE: 100.00% -- 129/129 lines in 8 files
- BRANCH COVERAGE: 100.00% -- 42/42 branches in 8 files
- 54.17% documented

### Changed

- The `gem_checksums` executable now supports `-v` / `--version` and prints a
  standard startup header on normal runs.

- kettle-jem-template-20260716-001 - Shim gemspec manifests now include
  `LICENSE.md` instead of nonexistent `LICENSE.txt`.
- kettle-jem-template-20260716-002 - Generated gemspec manifests now ship fewer
  repository-only files by default to reduce downstream distro packaging churn.
- kettle-jem-template-20260720-001 - Generated READMEs can now render
  template-managed corporate sponsor logos from project or family config.
- kettle-jem-template-20260720-002 - Generated development Gemfiles now use the
  released `tree_sitter_language_pack` gem 1.13.3 or newer by default.
- kettle-jem-template-20260720-003 - Generated StructuredMerge Git diff driver
  config now uses the installed `smorg-rb` Ruby driver name.
- kettle-jem-template-20260720-004 - Generated multi-engine workflow files now
  omit JRuby and TruffleRuby jobs when project config declares MRI-only engines.
- kettle-jem-template-20260720-005 - Generated README Support & Community rows
  now include a RubyForum help badge.
- kettle-jem-template-20260725-001 - Generated JRuby and TruffleRuby workflow
  files now run when pull request head branches start with `feature/release`,
  so release CI monitoring does not report intentionally skipped engine
  workflows as failures.

- kettle-jem-template-20260725-002 - Generated gemspec templates now include
  `anonymous_loader` as a development dependency, and version specs use it to
  execute generated `version.rb` files for coverage without redefining package
  constants. Managed version specs are removed when `version_gem` is disabled
  or incompatible with the project's runtime Ruby floor.

- The `gem_checksums` executable startup header is now shown only when
  `--verbose` is passed; `-v` and `--version` still print just the executable
  version and exit.

### Fixed

- Checksum generation dry-runs no longer execute Git commands, avoiding
  repository index lock races when specs run in parallel.
- The `gem_checksums` executable now loads its version through Bundler's normal
  load path, keeping locked dependency style checks green.
- Version coverage specs no longer re-emit constant redefinition warnings under
  unlocked dependency runs.
- Spec cleanup is now idempotent across parallel workers, avoiding TruffleRuby
  after-suite file removal races.

- Added coverage for the `StoneChecksums::Version` version-gem shim so the
  release coverage threshold includes both supported namespace entry points.

- Auto-install task specs now use Ruby 2.4-compatible cleanup syntax, keeping
  the minimum supported Ruby CI workflow parseable.

## [1.0.6] - 2026-07-11

- TAG: [v1.0.6][1.0.6t]
- COVERAGE: 98.45% -- 127/129 lines in 8 files
- BRANCH COVERAGE: 94.74% -- 36/38 branches in 8 files
- 54.17% documented

### Changed

- `require "stone_checksums"` and `require "gem_checksums"` no longer load
  `version_gem` by default; require `stone_checksums/version_gem` or
  `gem_checksums/version_gem` for the optional `VersionGem::Basic` extension.

## [1.0.5] - 2026-07-02

- TAG: [v1.0.5][1.0.5t]
- COVERAGE: 99.19% -- 123/124 lines in 6 files
- BRANCH COVERAGE: 94.74% -- 36/38 branches in 6 files
- 54.17% documented

### Fixed

- Package configured license files in gem release file lists.

## [1.0.4] - 2026-06-28

- TAG: [v1.0.4][1.0.4t]
- COVERAGE: 99.19% -- 123/124 lines in 6 files
- BRANCH COVERAGE: 94.74% -- 36/38 branches in 6 files
- 54.17% documented

### Fixed

- documentation
- `gem_checksums` now prefers the built package matching the current project
  gemspec when stale packages for newer versions are present in `pkg/`.
- `gem_checksums` now fails before writing checksum files when the selected
  built gem package does not match the current project gemspec name and version.

## [1.0.2] - 2025-08-26

- TAG: [v1.0.2][1.0.2t]
- COVERAGE: 100.00% -- 97/97 lines in 6 files
- BRANCH COVERAGE: 92.86% -- 26/28 branches in 6 files
- 68.42% documented

### Fixed

- gemspec details that got mangled in the switch from gem_checksums.gemspec to stone_checksums.gemspec
  - spec.required_ruby_version (accidentally bumped from 2.2 to 2.3)
  - spec.summary
  - spec.description
  - spec.homepage

## [1.0.1] - 2025-08-26

- TAG: [v1.0.1][1.0.1t]
- COVERAGE: 100.00% -- 97/97 lines in 6 files
- BRANCH COVERAGE: 92.86% -- 26/28 branches in 6 files
- 68.42% documented

### Added

- Added proper namespace: StoneChecksums
  - Namespace now matches gem name according to RubyGems convention
  - Old Namespace, GemChecksums, will be dropped in next major version

### Changed

- Improve error help text on old bundler, recommend upgrading

### Fixed

- Support for bundler >= v2.7, which no longer relies on SOURCE_DATE_EPOCH
  - NOTE: Bundler v2.7+ defaults to a constant build date in 1980 to make all builds reproducible.

### Documentation

- Updated README with checksum usage, Bundler version guidance, and env vars.
- Added YARD docstrings for public APIs.
- Expanded RBS signatures for public constants and methods.

## [1.0.0] - 2025-02-23

- TAG: [v1.0.0][1.0.0t]
- COVERAGE: 98.67% -- 74/75 lines in 5 files
- BRANCH COVERAGE: 79.17% -- 19/24 branches in 5 files
- 38.46% documented

### Added

- Initial release

[Unreleased]: https://github.com/galtzo-floss/stone_checksums/compare/v1.0.7...HEAD
[1.0.7]: https://github.com/galtzo-floss/stone_checksums/compare/v1.0.6...v1.0.7
[1.0.7t]: https://github.com/galtzo-floss/stone_checksums/releases/tag/v1.0.7
[1.0.6]: https://github.com/galtzo-floss/stone_checksums/compare/v1.0.5...v1.0.6
[1.0.6t]: https://github.com/galtzo-floss/stone_checksums/releases/tag/v1.0.6
[1.0.5]: https://github.com/galtzo-floss/stone_checksums/compare/v1.0.4...v1.0.5
[1.0.5t]: https://github.com/galtzo-floss/stone_checksums/releases/tag/v1.0.5
[1.0.4]: https://github.com/galtzo-floss/stone_checksums/compare/v1.0.2...v1.0.4
[1.0.4t]: https://github.com/galtzo-floss/stone_checksums/releases/tag/v1.0.4
[1.0.2]: https://gitlab.com/galtzo-floss/stone_checksums/-/compare/v1.0.1...v1.0.2
[1.0.2t]: https://github.com/galtzo-floss/stone_checksums/releases/tag/v1.0.2
[1.0.1]: https://gitlab.com/galtzo-floss/stone_checksums/-/compare/v1.0.0...v1.0.1
[1.0.1t]: https://github.com/galtzo-floss/stone_checksums/releases/tag/v1.0.1
[1.0.0]: https://github.com/galtzo-floss/stone_checksums/compare/1fd75630d9d3c4a1ef8fed384fda98755ae01d5e...v1.0.0
[1.0.0t]: https://github.com/galtzo-floss/stone_checksums/releases/tag/v1.0.0
