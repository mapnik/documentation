# Mapnik Documentation

The home for Node Mapnik documentation using DocumentationJS. Docs are deployed when anything in this repository is commited to the master branch AND once daily using TravisCI cron jobs. Here's what happens:

1. clone the Node Mapnik repository from master, which has JSDoc comments across the code base
1. determine which minor version we are building docs for (i.e. 3.5, 3.6)
1. run `documentation` to generate an HTML file from the JSDoc comments and puts it into a folder named after the minor version
1. run scripts/deploy.sh to put these changes to the gh-pages branch which can be viewed from mapnik.org/documentation

## How do we build for different versions?

scripts/generate.sh takes the version from the master branch of Node Mapnik and generates documentation within a directory named after the minor version, such as `/3.5`. New minor versions will be built once they are added to Node Mapnik master.

## Need to rebuild an old version?

Old versions must be generated locally and committed to master. Update the `BRANCH` variable within scripts/generate.sh with a specific git tag to install from. Here's an example: `v3.5.14` - run `npm run docs` and it will output into a new folder or replace a currently existing folder for that minor version. Commit this to master and it will be caught by TravisCI and merged into the gh-pages branch.

## Theme

The documentation theme used by DocumentationJS is located in the /theme directory. This theme is passed as a parameter `--theme` in /scripts/generate.sh. Since we are building the documentation from within a repository different than the source Node Mapnik repository, there is a custom handler in /theme/index.js called `mapnik_gitsha` to manage the proper GitSha to point to the Node Mapnik source lines on GitHub.

## Mapnikbot

[Mapnikbot](https://github.com/mapnikbot) is our machine user that actually performs the pushes into the gh-pages branch.
