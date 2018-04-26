[Semantic Versioning (semver)](https://semver.org/)
===

Given a version number MAJOR.MINOR.PATCH, increment the:

1. MAJOR version when you make incompatible API changes,
2. MINOR version when you add functionality in a backwards-compatible manner, and
3. PATCH version when you make backwards-compatible bug fixes.

Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.

## [Semver: A Primer](https://nodesource.com/blog/semver-a-primer/)

### Tilde & Caret Shorthand

- Prefixing a single semver version string with the `~` character defines a *range* of acceptable versions that include all **patch** versions from the one specified up to, but not including, the next minor version. `"~1.2.3"` can be approximately expanded as `">=1.2.3 <1.3.0"`.
- Prefixing a single semver version string with the `^` character defines a *range* of acceptable versions that include all patch and minor versions from the ones specified up to, but not including, the next version. So `"^1.2.3"` can be approximately expanded as `">=1.2.3 <2.0.0"`.
