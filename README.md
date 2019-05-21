# CircleCI Runtime Optimizer
[![CircleCI Status](https://circleci.com/gh/RcKeller/runtime-optimizer/tree/master.svg?style=svg)](https://circleci.com/gh/RcKeller/runtime-optimizer/tree/master)
[![CircleCI Orb Version](https://img.shields.io/badge/endpoint.svg?url=https://badges.circleci.io/orb/rckeller/runtime-optimizer)](https://circleci.com/orbs/registry/orb/rckeller/runtime-optimizer)

`rckeller/runtime-optimizer` is a collection of CircleCI commands used to improve the runtime and efficiency of CI runs. This orb handles complex optimizations such as caching and static analysis of commit histories under the hood, keeping your jobs simple and effective. CircleCI bills based on runtime, making these commands incredibly useful for keeping costs down.

## Commands

### `runtime-optimizer/halt-if-unchanged`
Halts and passes jobs if watched files have not been changed since the last CI job. For example, if you're doing full stack development and only change the files in `server/`, only your server-side tests will run.

### `runtime-optimizer/checkout`
An optimized version of the built-in `checkout` step. Uses caching and git garbage collection to improve the performance of repeated job runs.

## Local testing
Run these commands before pushing commits - prevents changes from being punted back by orb tools.

```bash
# validate source files
yamllint -d .yamllint .circleci src
circleci config validate .circleci
# pack and validate said pack
circleci config pack src > orb.yml
circleci orb validate orb.yml
```
