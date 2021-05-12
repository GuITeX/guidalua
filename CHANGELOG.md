# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Added 
- The codename assigned to this realease is `magpie`.
- A new introduction Chapter `Let's start with LuaTeX` explains basic facts on
  running Lua inside a TeX document.
- A new part `Things of LuaTeX` was added as part III. A new first chapter of
  this guide zone, focus on the LuaTeX `node` tecnology was added. As a
  conseguence the Application part became part IV.
- A new CHANGELOG.md file was added to the project from version v0.5 on. For
  versions previous to version v0.5 there has not been any persistent record of
  changes. Please refer to the commit history for details.
- Some other important functions of the `string` Lua standard library now have a
  proper description in the guide.

### Changed
- The Chapters `Calculator` and `Weight Table` was moved as part of the
  application zone. Now the word *tutorial* means the way we present a single
  application in the part IV of the guide and no more a user experiance tracing
  dealing with a specific problem. This is a huge changes. In fact, that
  Chapters are too technical for a first approach to Lua programming in LuaTeX.

### Fixed
- A lot of internal label references was renamed with the rule
  <part roman number><Sec|Ch><Name>. For example a renamed reference would be
  `\label{iiSecStringFormat}` and it immediately told all the story about what a
  section or chapter is.

## [0.5] - 2021-05-30

