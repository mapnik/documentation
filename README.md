# Mapnik Documentation

The home for Mapnik documentation. Currently this only builds Node Mapnik documentation. Here's how it works:

1. A TravisCI cron job runs every day and runs the scripts/generate.sh script
1. This clones the Node Mapnik repository from master, which has all sorts of JSDoc comments in it
1. determines which minor version we are building docs for (i.e. 3.5, 3.6)
1. Runs `documentation` to generate an HTML file from the JSDoc comments and puts it into a folder named after the minor version
1. Runs the scripts/deploy.sh script to put these changes to the gh-pages branch which can be viewed from mapnik.org/documentation

## How do we build for different versions?

The scripts/generate.sh script takes the version from the master branch of mapnik and determines the minor version to build.

## Need to rebuild an old version?

You can update the `REPO` variable within scripts/generate.sh with a specific git tag to install from. Here's an example: `git@github.com:mapnik/node-mapnik.git#v3.4.19` - once you reinstall mapnik you can run `./scripts/generate.sh` and it will out put into a new folder or replace a currently existing folder for that minor version. Merge into master and this will be caught by TravisCI and merged into the gh-pages branch.

# Theme

The documentation theme used by DocumentationJS is located in the /theme directory. This theme is passed as a parameter `--theme` in /scripts/generate.sh. Since we are building the documentation from within a repository different than the source Node Mapnik repository, there is a custom handler called `mapnik_gitsha` to manage the proper GitSha to point to the Node Mapnik source lines on GitHub. 
